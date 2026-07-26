import { spawn } from "node:child_process";
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/** Open the configured external editor and put the saved text back in the prompt. */
export default function editorCommand(pi: ExtensionAPI): void {
  pi.registerCommand("editor", {
    description: "Edit the prompt in your external editor",
    handler: async (_args, ctx) => {
      const content = ctx.ui.getEditorText();
      const edited = await ctx.ui.custom<string | undefined>(
        (tui, _theme, _kb, done) => {
          tui.stop();
          void (async () => {
            const directory = mkdtempSync(join(tmpdir(), "pi-editor-"));
            const filePath = join(directory, "prompt.md");
            try {
              writeFileSync(filePath, content, "utf8");
              const command =
                process.env.VISUAL ||
                process.env.EDITOR ||
                (process.platform === "win32" ? "notepad" : "nano");
              const [editor, ...args] = command.split(" ");
              if (!editor) {
                done(undefined);
                return;
              }
              const exitCode = await new Promise<number | null>((resolve) => {
                const child = spawn(editor, [...args, filePath], {
                  stdio: "inherit",
                  shell: process.platform === "win32",
                });
                child.on("error", () => resolve(null));
                child.on("close", resolve);
              });
              done(
                exitCode === 0
                  ? readFileSync(filePath, "utf8").replace(/\n$/, "")
                  : undefined,
              );
            } finally {
              rmSync(directory, { recursive: true, force: true });
              tui.start();
              tui.requestRender(true);
            }
          })();
          return { render: () => [], invalidate: () => { } };
        },
      );
      if (edited !== undefined) ctx.ui.setEditorText(edited);
    },
  });
}
