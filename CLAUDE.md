# Dotfiles — Claude Reference

Personal dotfiles for macOS/Linux covering nvim, tmux, zsh, and other tools.

## Project skills

Load these when the task matches — they contain step-by-step workflows tailored to this repo.

| skill | file | when to use |
|---|---|---|
| add-package | `.claude/skills/add-package.md` | scaffolding a new package under `packages/` |

## On-demand references

Load these when working on a specific area. They document conventions, plugin systems, and patterns that would otherwise require reading the full config files.

| topic | file |
|---|---|
| core/ — full system reference | `.claude/references/core/system.md` |
| nvim — adding a plugin | `.claude/references/nvim/adding-plugin.md` |
| tmux — adding a plugin | `.claude/references/tmux/adding-plugin.md` |
| zsh — adding a plugin | `.claude/references/zsh/adding-plugin.md` |

## Package layout

```
packages/
├── nvim/    custom plugman setup (meta manager on top of vim-plug)
├── tmux/    TPM-based config + local plugins in plugins/
├── zsh/     Oh My Zsh config, custom abbreviations in plugins/
├── alacritty/
├── lazygit/
└── vscode/
```

## Conventions

- Key bindings: always check existing mappings before claiming a key — conflicts resolve by load order with no warning.
- nvim project namespace: `<Leader>p*` for project/file-finder commands.
- Config files live alongside their package (not scattered in home).

<!-- code-review-graph MCP tools -->
## MCP Tools: code-review-graph

**IMPORTANT: This project has a knowledge graph. ALWAYS use the
code-review-graph MCP tools BEFORE using Grep/Glob/Read to explore
the codebase.** The graph is faster, cheaper (fewer tokens), and gives
you structural context (callers, dependents, test coverage) that file
scanning cannot.

### When to use graph tools FIRST

- **Exploring code**: `semantic_search_nodes` or `query_graph` instead of Grep
- **Understanding impact**: `get_impact_radius` instead of manually tracing imports
- **Code review**: `detect_changes` + `get_review_context` instead of reading entire files
- **Finding relationships**: `query_graph` with callers_of/callees_of/imports_of/tests_for
- **Architecture questions**: `get_architecture_overview` + `list_communities`

Fall back to Grep/Glob/Read **only** when the graph doesn't cover what you need.

### Key Tools

| Tool | Use when |
|------|----------|
| `detect_changes` | Reviewing code changes — gives risk-scored analysis |
| `get_review_context` | Need source snippets for review — token-efficient |
| `get_impact_radius` | Understanding blast radius of a change |
| `get_affected_flows` | Finding which execution paths are impacted |
| `query_graph` | Tracing callers, callees, imports, tests, dependencies |
| `semantic_search_nodes` | Finding functions/classes by name or keyword |
| `get_architecture_overview` | Understanding high-level codebase structure |
| `refactor_tool` | Planning renames, finding dead code |

### Workflow

1. The graph auto-updates on file changes (via hooks).
2. Use `detect_changes` for code review.
3. Use `get_affected_flows` to understand impact.
4. Use `query_graph` pattern="tests_for" to check coverage.
