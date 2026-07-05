#!/usr/bin/env bash
# We deliberately return 1 (meaning "not yet configed") on every check.
# This causes config.sh to execute on *every* F_install invocation for this package.
#
# Why? The main install.sh is skipped (by design) once F_isInstalled succeeds,
# which makes subsequent F_install calls completely silent and "instant".
# Running config.sh every time gives immediate, visible feedback like
# "✓ codebase-memory-mcp ready (version)" so it never feels like it did nothing.
return 1
