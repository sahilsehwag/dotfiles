return F.pipe(
  F.rt('fasd.cmds').dirs,
  F.sh.run_and_split
)
