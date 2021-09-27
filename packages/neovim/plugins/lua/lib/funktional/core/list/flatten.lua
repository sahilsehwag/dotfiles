return function(values)
  local function flatten(list)
    local result = {}
    for _, v in ipairs(list) do
      if Funk.is_list(v) then
        for _, v2 in ipairs(flatten(v)) do
          table.insert(result, v2)
        end
      else
        table.insert(result, v)
      end
    end
    return result
  end
  
  return flatten(values)
end
