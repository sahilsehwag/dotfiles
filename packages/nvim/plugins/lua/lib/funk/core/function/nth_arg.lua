return function(n)
  return function(...)
    local arg = {...}
    return arg[n]
  end
end
