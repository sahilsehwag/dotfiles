return function(...)
  local args = {...}
  return function(fn)
    return fn(unpack(args))
  end
end
