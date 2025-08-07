return F.pipe(
  F.rt('mani.cmds').list_tasks,
  F.sh.run_and_split,
  F.map(F.trim)
)
