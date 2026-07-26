import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/**
 * Review the current repository changes without modifying the workspace.
 * Usage: /review [focus]
 */
export default function reviewCommand(pi: ExtensionAPI): void {
	pi.registerCommand("review", {
		description: "Review current git changes without editing files",
		handler: async (args, ctx) => {
			if (!ctx.isIdle()) {
				ctx.ui.notify(
					"The agent is busy. Wait for it to finish before starting a review.",
					"warning",
				);
				return;
			}

			const tokens = args.trim().split(/\s+/).filter(Boolean);
			const piArgs = ["--print"];
			const focusTokens: string[] = [];
			for (let i = 0; i < tokens.length; i++) {
				if (tokens[i] === "--provider" || tokens[i] === "--model") {
					if (tokens[i + 1]) piArgs.push(tokens[i], tokens[++i]);
				} else focusTokens.push(tokens[i]);
			}
			const focus = focusTokens.join(" ");
			const focusInstruction = focus
				? `Pay particular attention to: ${focus}`
				: "Cover correctness, security, regressions, tests, performance, and maintainability.";
			const prompt = [
				"Review the current repository changes as an expert code reviewer.",
				"Inspect git status and the relevant diff (including staged and unstaged changes).",
				"Do not modify files, run formatters, or apply fixes.",
				"Review specifically for bugs and logic errors, security issues, and error handling gaps.",
				"Report actionable findings ordered by severity (blocker, high, medium, low).",
				"For every finding include the file and line, the problem, why it matters, and a concrete fix.",
				"Separate findings from a short summary. If there are no findings, say so explicitly.",
				focusInstruction,
			].join("\n");

			const result = await pi.exec("pi", [...piArgs, prompt]);
			if (result.code !== 0) {
				ctx.ui.notify(
					`Review sub-agent failed: ${result.stderr || `exit code ${result.code}`}`,
					"error",
				);
				return;
			}
			pi.sendMessage({
				customType: "review-result",
				content:
					result.stdout.trim() || "The review sub-agent returned no findings.",
				display: true,
			});
		},
	});
}
