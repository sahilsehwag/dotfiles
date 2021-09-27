return F.pipe(
  F.rt('fasd.cmds').paths,
  F.sh.run_and_split
)
