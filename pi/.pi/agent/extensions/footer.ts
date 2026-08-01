import { isAbsolute, relative, resolve, sep } from "node:path";
import type {
	ExtensionAPI,
	ExtensionContext,
	ReadonlyFooterDataProvider,
	Theme,
} from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

function formatTokens(count: number): string {
	if (count < 1000) return count.toString();
	if (count < 10000) return `${(count / 1000).toFixed(1)}k`;
	if (count < 1000000) return `${Math.round(count / 1000)}k`;
	if (count < 10000000) return `${(count / 1000000).toFixed(1)}M`;
	return `${Math.round(count / 1000000)}M`;
}

function formatCwdForFooter(cwd: string): string {
	const home = process.env.HOME || process.env.USERPROFILE;
	if (!home) return cwd;

	const resolvedCwd = resolve(cwd);
	const resolvedHome = resolve(home);
	const relativeToHome = relative(resolvedHome, resolvedCwd);
	const isInsideHome =
		relativeToHome === "" ||
		(relativeToHome !== ".." &&
			!relativeToHome.startsWith(`..${sep}`) &&
			!isAbsolute(relativeToHome));

	if (!isInsideHome) return cwd;
	return relativeToHome === "" ? "~" : `~${sep}${relativeToHome}`;
}

function sanitizeStatusText(text: string): string {
	return text
		.replace(/[\r\n\t]/g, " ")
		.replace(/ +/g, " ")
		.trim();
}

function getSessionCost(ctx: ExtensionContext): number {
	let cost = 0;

	for (const entry of ctx.sessionManager.getEntries()) {
		if (entry.type === "message") {
			if (
				entry.message.role === "assistant" ||
				entry.message.role === "toolResult"
			) {
				cost += entry.message.usage?.cost.total ?? 0;
			}
		} else if (
			(entry.type === "compaction" || entry.type === "branch_summary") &&
			entry.usage
		) {
			cost += entry.usage.cost.total;
		}
	}

	return cost;
}

function getContextDisplay(
	ctx: ExtensionContext,
	autoCompactEnabled: boolean,
	theme: Theme,
): string {
	const usage = ctx.getContextUsage();
	const contextWindow = usage?.contextWindow ?? ctx.model?.contextWindow ?? 0;
	const contextPercent = usage?.percent;
	const display =
		contextPercent === null || contextPercent === undefined
			? `?/${formatTokens(contextWindow)}`
			: `${contextPercent.toFixed(1)}%/${formatTokens(contextWindow)}`;
	const withAutoIndicator = `${display}${autoCompactEnabled ? " (auto)" : ""}`;

	if ((contextPercent ?? 0) > 90) return theme.fg("error", withAutoIndicator);
	if ((contextPercent ?? 0) > 70) return theme.fg("warning", withAutoIndicator);
	return withAutoIndicator;
}

type FooterRenderOptions = {
	ctx: ExtensionContext;
	pi: ExtensionAPI;
	width: number;
	theme: Theme;
	footerData: ReadonlyFooterDataProvider;
};

function renderFooter({
	ctx,
	pi,
	width,
	theme,
	footerData,
}: FooterRenderOptions): string[] {
	const safeWidth = Math.max(width, 0);
	if (safeWidth === 0) return [""];

	let path = formatCwdForFooter(ctx.cwd);
	const branch = footerData.getGitBranch();
	if (branch) path += ` (${branch})`;
	const sessionName = ctx.sessionManager.getSessionName();
	if (sessionName) path += ` • ${sessionName}`;

	const model = ctx.model;
	const modelName = model?.id ?? "no-model";
	const thinkingLevel = pi.getThinkingLevel() || "off";
	const thinkingText = model?.reasoning ? thinkingLevel : undefined;
	const modelText = theme.fg("dim", modelName);
	const rightSide = thinkingText
		? `${modelText}${theme.fg("dim", " • ")}${theme.getThinkingBorderColor(thinkingLevel)(thinkingText)}`
		: modelText;

	const usingSubscription = model
		? model.provider === "kimi-coding" || ctx.modelRegistry.isUsingOAuth(model)
		: false;
	const cost = getSessionCost(ctx);
	const leftParts: string[] = [];
	if (cost || usingSubscription) {
		leftParts.push(
			theme.fg(
				"dim",
				`$${cost.toFixed(3)}${usingSubscription ? " (sub)" : ""}`,
			),
		);
	}
	leftParts.push(getContextDisplay(ctx, true, theme));
	const leftSide = leftParts.join(" ");

	const minPadding = 2;
	const leftWidth = visibleWidth(leftSide);
	const rightWidth = visibleWidth(rightSide);
	let secondLine: string;
	if (leftWidth + minPadding + rightWidth <= safeWidth) {
		secondLine =
			leftSide + " ".repeat(safeWidth - leftWidth - rightWidth) + rightSide;
	} else {
		const availableForRight = safeWidth - leftWidth - minPadding;
		secondLine =
			availableForRight > 0
				? leftSide +
					" ".repeat(minPadding) +
					truncateToWidth(rightSide, availableForRight, "")
				: truncateToWidth(leftSide, safeWidth, "");
	}

	const lines = [
		truncateToWidth(theme.fg("dim", path), safeWidth, theme.fg("dim", "...")),
		truncateToWidth(secondLine, safeWidth, ""),
	];

	const statuses = Array.from(footerData.getExtensionStatuses().entries())
		.sort(([a]: [string, string], [b]: [string, string]) => a.localeCompare(b))
		.map(([, text]: [string, string]) => sanitizeStatusText(text))
		.filter((text: string) => text.length > 0);
	if (statuses.length > 0) {
		lines.push(
			truncateToWidth(statuses.join(" "), safeWidth, theme.fg("dim", "...")),
		);
	}

	return lines;
}

export default function footerExtension(pi: ExtensionAPI): void {
	pi.on("session_start", (_event, ctx) => {
		if (ctx.mode !== "tui") return;

		let requestFooterRender: (() => void) | undefined;
		pi.on("thinking_level_select", (_event, eventCtx) => {
			if (eventCtx === ctx) requestFooterRender?.();
		});
		pi.on("model_select", (_event, eventCtx) => {
			if (eventCtx === ctx) requestFooterRender?.();
		});

		ctx.ui.setFooter((tui, theme, footerData) => {
			requestFooterRender = () => tui.requestRender();
			const unsubscribeBranchChange = footerData.onBranchChange(() =>
				tui.requestRender(),
			);
			return {
				invalidate() {},
				render(width: number): string[] {
					return renderFooter({ ctx, pi, width, theme, footerData });
				},
				dispose: () => {
					requestFooterRender = undefined;
					unsubscribeBranchChange();
				},
			};
		});
	});
}
