return F.pipe(
  F.rt('fasd.cmds').files,
  F.sh.run_and_split
)
