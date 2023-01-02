local deep_clone = nil

local function deep_clone_list(list)
  local clone = {}
  for i, v in ipairs(list) do
    if Funk.is_table(v) then
      clone[i] = deep_clone(v)
    else
      clone[i] = v
    end
  end
  return clone
end

local function deep_clone_dict(list)
  local clone = {}
  for k, v in pairs(list) do
    if Funk.is_table(v) then
      clone[k] = deep_clone(v)
    else
      clone[k] = v
    end
  end
  return clone
end

deep_clone = Funk.if_else(
  Funk.is_list,
  deep_clone_list,
  deep_clone_dict
)

return deep_clone
