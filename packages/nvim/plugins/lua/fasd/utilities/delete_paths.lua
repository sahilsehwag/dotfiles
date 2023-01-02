return F.pipe(
  F.rt('fasd.cmds').delete,
  F.sh.run
)
