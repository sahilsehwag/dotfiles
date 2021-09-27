return function(fn)
  local result = nil
  return function(...)
    if not result then
      result = fn(...)
    end
    return result
  end
end
