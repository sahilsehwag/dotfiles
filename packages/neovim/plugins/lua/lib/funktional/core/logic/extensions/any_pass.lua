return function(...)
  local fns = {...}
  return function(...)
    for _, fn in ipairs(fns) do
      if fn(...) then
        return true
      end
    end
    return false
  end
end
