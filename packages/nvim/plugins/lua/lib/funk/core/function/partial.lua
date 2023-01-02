---@diagnostic disable-next-line: unused-vararg
return Funk.curry(function(fn, ...)
  return Funk.pipe(
    Funk.of,
    Funk.concat({...}),
    Funk.apply(fn)
  )
end)
