local function clone_list(list)
  local clone = {}
  for i, v in ipairs(list) do
    clone[i] = v
  end
  return clone
end

local function clone_dict(list)
  local clone = {}
  for k, v in pairs(list) do
    clone[k] = v
  end
  return clone
end

return Funk.if_else(
  Funk.is_list,
  clone_list,
  clone_dict
)
