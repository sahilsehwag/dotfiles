local function merge_deep(t1, t2)
  local t3 = {}
  for k, v in pairs(t1) do
    if type(v) == "table" then
      t3[k] = merge_deep(v, t2[k] or {})
    else
      t3[k] = v
    end
  end
  for k, v in pairs(t2) do
    if type(v) == "table" and not t3[k] then
      t3[k] = merge_deep({}, v)
    --elseif not t3[k] then
    else
      t3[k] = v
    end
  end
  return t3
end

return merge_deep
