return F.pipe(
  F.rt('git_workspace.cmds').list_projects,
  F.sh.run_and_split
)
