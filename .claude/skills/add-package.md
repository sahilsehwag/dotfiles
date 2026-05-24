---
name: Add Package
description: Scaffold a new package under packages/ and wire it into the dotfiles system
---

## Add Package

Create a new package directory under `packages/` with the appropriate scripts based on what the user describes.

### Steps

1. **Gather info** — ask the user (or infer from context) for:
   - Package name (the folder name, e.g. `ripgrep`)
   - Install method: does it need a custom `install.sh`, or is a `metadata.sh`-only approach enough?
   - Does it need shell init (aliases, env vars, sourcing)? → `init.sh`
   - Does it need config (dotfile symlinks, post-install setup)? → `config.sh` + `is_configed.sh`
   - Does it have cross-platform name differences (e.g. `bat` on Debian is `batcat`)? → `meta_<pacman>` overrides
   - OS restrictions (`meta_os`)? Cask install on macOS (`meta_cask`)? Requires sudo (`meta_sudo`)?

2. **Create the directory**: `packages/<name>/`

3. **Always create `metadata.sh`** with the fields the user supplies. Omit fields that are irrelevant — don't emit empty lines. Minimum useful template:
   ```bash
   #!/usr/bin/env bash
   meta_display="<Human Name>"
   meta_description="<one-line description>"
   meta_tags="<space-separated tags>"
   meta_brew="<brew package name if different from folder name>"
   # meta_apt="<apt name>"  # only if it differs
   # meta_os="macos"        # only if not cross-platform
   # meta_cask="yes"        # only if brew --cask
   # meta_sudo="yes"        # only if sudo needed
   # meta_binary="<bin>"    # only if binary name differs from folder name
   # meta_depends="<pkg1> <pkg2>"  # only if deps exist
   ```

4. **Create `install.sh`** only when the install is non-trivial (custom logic, git clones, curl, etc.). Skip it when `metadata.sh` + `F_meta_install` is sufficient. Template:
   ```bash
   #!/usr/bin/env bash
   F_pkg_install <package>
   ```

5. **Create `init.sh`** if the package needs shell setup (aliases, env vars, sourcing a shell integration). Template:
   ```bash
   #!/usr/bin/env bash
   script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})
   
   # aliases, env vars, or source lines here
   ```

6. **Create `config.sh` + `is_configed.sh`** if the package has dotfiles to symlink or one-time post-install config. Templates:
   ```bash
   # config.sh
   #!/usr/bin/env bash
   script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
   
   if ! F_isSoftlink "$HOME/.config/<name>"; then
       ln -sv "$script_directory/dotfiles/" "$HOME/.config/<name>"
   fi
   ```
   ```bash
   # is_configed.sh
   #!/usr/bin/env bash
   F_isSoftlink "$HOME/.config/<name>" && return 0 || return 1
   ```

7. **Create a `dotfiles/` subdirectory** if config files need to be symlinked.

8. **Wire into a preset** — ask the user which preset file to add `F_install <name>` to (e.g. `presets/install.sahilsehwag.sh`), or skip if they just want the scaffold.

### Decision tree

```
Has custom install logic (git clone, curl, build)?
  YES → write install.sh
  NO  → metadata.sh only (F_meta_install handles it)

Needs shell init (aliases, PATH, source integration)?
  YES → write init.sh

Has dotfiles to symlink?
  YES → write config.sh, is_configed.sh, dotfiles/

Has deps on other packages?
  YES → add meta_depends="..." in metadata.sh  (or write deps.sh for complex cases)
```

### Package file reference

| file | purpose |
|------|---------|
| `metadata.sh` | display name, tags, per-pacman overrides — always create this |
| `install.sh` | custom install logic; skip when `metadata.sh` is enough |
| `init.sh` | shell init sourced on every session start |
| `config.sh` | one-time post-install config (dotfile links, etc.) |
| `is_configed.sh` | idempotency check for `config.sh`; must return 0 if already done |
| `is_installed.sh` | custom install check; skip when binary-on-PATH check suffices |
| `deps.sh` | install dependencies before this package; skip when `meta_depends` is enough |
| `update.sh` | custom update logic |
| `uninstall.sh` | custom uninstall logic |
| `deconfig.sh` | undo config.sh (remove symlinks, etc.) |
| `health.sh` | health check; exit 0 = healthy |
| `dotfiles/` | config files to be symlinked into `~/.config/<name>/` |
