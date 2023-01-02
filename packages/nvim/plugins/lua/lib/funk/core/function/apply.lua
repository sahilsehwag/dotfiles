return Funk.curry(function(fn, args)
  return fn(unpack(args))
end)
