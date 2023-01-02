return function(fn)
  return function(...)
    local args = {...}
    return function()
      return fn(unpack(args))
    end
  end
end
