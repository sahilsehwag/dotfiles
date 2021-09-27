return Funk.curry(function(runner, cmds)
  return Funk.pipe(
    Funk.map(Funk.sh.quote),
    Funk.join(' '),
    Funk.concat('mprocs '),
    Funk.sh.run_with(runner)
  )(cmds)
end)
