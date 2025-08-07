return Funk.curry(function(pre, post, fn)
  return function(...)
    local args = {...}
    return post(fn(pre(unpack(args))))
  end
end)
