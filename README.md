# Synth Zed

A **local-first, commercial-free** fork of [Zed](https://github.com/zed-industries/zed), the high-performance code editor from the creators of [Atom](https://github.com/atom/atom) and [Tree-sitter](https://github.com/tree-sitter/tree-sitter).

This fork removes Zed Pro / billing UI and telemetry sinks, and unwires hosted zed.dev collaboration and AI (`collab` / `collab_ui` stay in-tree but are never loaded). The editor, SSH remotes, extensions, and BYOK / Copilot / Ollama / ACP agents remain.

**Package ID:** `io.github.synthet.Zed`  
**Upstream:** [zed-industries/zed](https://github.com/zed-industries/zed) · **Fork source:** [synthet/zed](https://github.com/synthet/zed)

---

### What this fork is (and is not)

| Included | Not included |
|----------|--------------|
| Local editor, LSP, terminal, git | Zed Pro / trial / upgrade UI |
| SSH remote development | Hosted collab (channels, calls, live share) |
| BYOK LLMs, Copilot, Ollama, ACP | Hosted Zed AI / Zeta / Zed web search |
| Public extension index | Telemetry / crash upload to Zed |
| GPL + Apache licensing preserved | Official auto-update from cloud.zed.dev |

Cloud features are **removed or unwired**, not unlocked against Zed’s servers.

### Developing Synth Zed

- [Building for macOS](./docs/src/development/macos.md)
- [Building for Linux](./docs/src/development/linux.md)
- [Building for Windows](./docs/src/development/windows.md)

### Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for contribution guidelines inherited from upstream. Prefer opening changes against this fork’s goals (local-first, no monetization chrome).

### Licensing

Source is licensed primarily under GPL-3.0-or-later, with Apache-2.0 components where marked (same as upstream Zed).

License information for third party dependencies must be correctly provided for CI to pass. See `script/licenses/zed-licenses.toml` and [`cargo-about`](https://github.com/EmbarkStudios/cargo-about).
