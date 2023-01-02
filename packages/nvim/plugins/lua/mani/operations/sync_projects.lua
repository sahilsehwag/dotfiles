return F.pipe(
  require('mani.cmds').sync_projects,
  F.sh.run
)
