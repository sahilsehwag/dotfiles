# core/ — system reference

The `core/` directory is the shared runtime library for all dotfiles scripts. Source `core/install.sh` to get everything.

## Entry point

```bash
source "$DOTFILES_CORE/install.sh"
```

`core/install.sh` sets environment variables and sources all libs in order:

```
libs/script.sh → libs/logging.sh → libs/fs.sh → libs/os.sh → libs/pacman.sh
variables.sh → paths.sh → pacman.sh → ui.sh
```

## Environment variables

| var | value |
|---|---|
| `$DOTFILES_CORE` | path to `core/` |
| `$DOTFILES_ROOT` | repo root |
| `$DOTFILES_REPOS` | `~/.cache/dotfiles/repos` |
| `$DOTFILES_CONFIG` | `~/.config/dotfiles` |
| `$platform` | `mac`, `linux`, `freebsd`, `windows`, `windows.cygwin`, `windows.mingw` |

## Naming conventions

| pattern | meaning |
|---|---|
| `F_name` | public function |
| `_name` | private/internal function |
| `F__name` | private data (e.g. `F__pacmans` associative array) |
| `__F_name` | private internal variable |

## Function index by file

### `core/libs/logging.sh` — structured logging

```bash
F_log "msg"          # alias for F_log_info
F_log_info "msg"
F_log_warn "msg"
F_log_error "msg"
F_log_debug "msg"
```

Writes to stderr: `[timestamp] [I|W|E|D] [file:line:func] - msg`

---

### `core/libs/os.sh` — OS detection (boolean returns)

```bash
F_isMac        F_isLinux     F_isWindows
F_isCygwin     F_isWSL       F_isDebian
F_isRedhat     F_isUbuntu    F_isBSD
F_isFreeBSD    F_isSolaris
```

---

### `core/libs/fs.sh` — filesystem checks and operations

**Boolean checks** (return 0/1):
```bash
F_isFile file       F_isDir dir         F_isLink file
F_isSoftlink file   F_isHardlink file   F_isExecutable file
F_isReadable file   F_isWritable file   F_isMounted path
F_isBinFile file    F_isTextFile file   F_isFileEmpty file
F_isDirEmpty dir    F_isRoot            F_isSudo
F_isRunning svc     F_isEnabled svc     F_isBinaryInstalled cmd
F_hasExt ext file   F_hasPerm perm file F_hasOwner owner file
F_hasGrp grp file   F_isPortOpen port   F_isPortListening port
```

**File info** (echo value):
```bash
F_getFileSize file       F_getFileOwner file    F_getFileGrp file
F_getFilePerm file       F_getFileModTime file   F_getFileInode file
F_getFileHash file       F_getFileHashSHA256 file   # md5, sha1, sha256, sha512
```

**File operations:**
```bash
F_readFile file
F_readLine N file
F_readLines from to file
F_appendToFile file text
F_prependToFile file text
F_delLines pattern file          # deletes lines matching pattern
```

**Directory operations:**
```bash
F_createDir dir
F_deleteDir dir
F_listDir dir
F_listDirRecursive dir
F_getDirSize dir
```

**Links:**
```bash
F_createSoftLink src dst
F_createHardLink src dst
```

---

### `core/libs/script.sh` — script utilities

```bash
F_getScriptDir "$0"    # resolves symlinks, returns absolute dir of the given script path
```

---

### `core/libs/pacman.sh` — cross-platform package manager

Tries all available package managers in order (brew → apt → pacman → yay → dnf → yum → apk → rpm → cargo → go → pip → npm → …).

```bash
F_pkg_install pkg [pkg …]    # install if not present; skips already-installed
F_pkg_update pkg [pkg …]
F_pkg_uninstall pkg [pkg …]
F_pkg_search pkg [pkg …]
F_pkg_show pkg [pkg …]
```

---

### `core/libs/require.sh` — dependency guard

```bash
require cmd                        # prompt to install if missing; exit 1 if declined
require cmd --hint "brew install X" # show custom hint when auto-install can't help
require cmd --no-exit              # return 1 instead of exit (use inside functions)
```

`require` is not prefixed with `F_` — it's a standalone command intended to read like a keyword at the top of scripts.

---

### `core/pacman.sh` — dotfiles package lifecycle

A "package" here is a subdirectory under `packages/`. Each can have:
- `install.sh` or `scripts/install.sh` — run once to install
- `init.sh` or `scripts/init.sh` — sourced on every shell start (appended to `$DOTFILES_CONFIG/init.sh`)
- `config.sh` or `scripts/config.sh` — run after install for configuration
- `is_installed.sh` or `scripts/is_installed.sh` — custom install check (fallback: binary check)

```bash
F_isInstalled pkg    # checks is_installed.sh → packages.txt → binary presence
F_install pkg …      # runs install.sh, registers init.sh, runs config.sh
F_uninstall pkg …    # uninstalls and removes init.sh entry
F_init pkg           # appends init.sh to $DOTFILES_CONFIG/init.sh (idempotent)
F_config pkg         # sources config.sh for pkg
```

`$DOTFILES_CONFIG/packages.txt` — newline list of installed package names.
`$DOTFILES_CONFIG/init.sh` — auto-generated; sourced by the shell on start.

---

### `core/ui.sh` — gum UI wrappers (requires `gum`)

**Output / styled text:**
```bash
F_ui_header "text"     # rounded border, bold, pink (212)
F_ui_success "text"    # bold green (42)
F_ui_warn "text"       # orange (214)
F_ui_error "text"      # red (196)
F_ui_info "text"       # blue (39)
F_ui_dim "text"        # gray (240)
F_ui_accent "text"     # bold pink (212)
```

**Logging (gum log, goes to stderr with level prefix):**
```bash
F_ui_log_info "msg" [key val …]
F_ui_log_warn "msg" [key val …]
F_ui_log_error "msg" [key val …]
F_ui_log_debug "msg" [key val …]
```

**Prompts:**
```bash
F_ui_confirm "Are you sure?"          # returns 0 = yes, 1 = no
F_ui_input "Prompt" [placeholder] [default]   # single-line; prints entered text
F_ui_password "Prompt"                         # masked; prints entered text
F_ui_write [header] [placeholder]              # multi-line editor; prints result
```

**Selection:**
```bash
F_ui_pick "Header" opt1 opt2 …        # choose one; prints chosen
F_ui_pick_many "Header" opt1 opt2 …   # choose many; prints newline-separated
F_ui_filter "Header" opt1 opt2 …      # fuzzy-filter one (also accepts stdin)
F_ui_filter_many "Header" opt1 opt2 … # fuzzy-filter many
F_ui_file [dir]                        # file picker; prints chosen path (default: .)
```

**Async / spinner:**
```bash
F_ui_spin "Loading…" cmd [args…]
F_ui_spin_step index total "Title" cmd [args…]   # e.g. F_ui_spin_step 1 5 "Cloning" git clone …
```

**Content display:**
```bash
F_ui_pager [file]      # scroll through file or stdin
F_ui_table             # render CSV from stdin as a table (header row required)
F_ui_markdown "text"   # render markdown
F_ui_code "text" [lang]  # render fenced code block
```

## Typical script structure

```bash
#!/usr/bin/env bash
source "$DOTFILES_CORE/install.sh"

require gum

F_ui_header "My Script"

if F_isMac; then
  F_ui_info "Running on macOS"
fi

if ! F_isInstalled mytool; then
  F_install mytool
fi
```
