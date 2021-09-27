return function(...)
  local conditions = {...}
  return function(...)
    for _, condition in ipairs(conditions) do
      if condition[1](...) then
        return condition[2](...)
      end
    end
  end
end
