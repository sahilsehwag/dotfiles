return function(dict)
  local values = {}
  for _, value in pairs(dict) do
    values[#values+1] = value
  end
  return values
end
