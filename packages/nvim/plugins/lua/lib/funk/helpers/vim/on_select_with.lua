return function(runner)
  return Funk.if_else(
    Funk.is_nil,
    Funk.noop,
    runner
  )
end
