--TODO:
local deep_equals

local function are_lists_equal(l1, l2)
  if #l1 ~= #l2 then
    return false
  end
  for i = 1, #l1 do
    if Funk.is_table(l1[i]) and Funk.is_table(l2[i]) then
      return deep_equals(l1[i], l2[i])
    elseif l1[i] ~= l2[i] then
      return false
    end
  end
  return true
end

local function are_dicts_equal(d1, d2)
  if Funk.len(d1) ~= Funk.len(d2) then
    return false
  end
  for k, v in pairs(d1) do
    if Funk.is_table(v) and Funk.is_table(d2[k]) then
      return deep_equals(v, d2[k])
    end
    if d2[k] ~= v then
      return false
    end
  end
  return true
end

deep_equals = Funk.if_else(
  Funk.is_list,
  Funk.curry(are_lists_equal),
  Funk.curry(are_dicts_equal)
)

return deep_equals
