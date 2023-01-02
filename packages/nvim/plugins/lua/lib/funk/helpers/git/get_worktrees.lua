return Funk.thunk(
  Funk.pipe(
    Funk.sh.run_and_split,
    Funk.split_each(" "),
    Funk.map(Funk.nth(1))
  )
)('git worktree list')
