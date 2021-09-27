return function(dict)
  local keys = {}
  for key, _ in pairs(dict) do
    keys[#keys+1] = key
  end
  return keys
end
