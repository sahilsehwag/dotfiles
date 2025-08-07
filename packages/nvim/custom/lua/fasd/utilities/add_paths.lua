return F.pipe(
  F.rt('fasd.cmds').add,
  F.sh.run
)
