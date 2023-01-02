return Funk.curry(function(pre, fn)
  return function(...)
    local args = {...}
    return fn(pre(unpack(args)))
  end
end)
