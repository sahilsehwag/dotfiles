return F.pipe(
  F.rt('mani.cmds').list_projects,
  F.sh.run_and_split,
  F.map(F.trim)
)
