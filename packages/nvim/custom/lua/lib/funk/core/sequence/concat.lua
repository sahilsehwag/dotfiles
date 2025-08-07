local concat_list = function(l1, l2)
  local output = {}
  for _, v in ipairs(l1) do
    output[#output + 1] = v
  end
  for _, v in ipairs(l2) do
    output[#output + 1] = v
  end
  return output
end

local concat_dict = function(d1, d2)
  local output = {}
  for k, v in pairs(d1) do
    output[k] = v
  end
  for k, v in pairs(d2) do
    output[k] = v
  end
  return output
end

local concat_str = function(s1, s2)
  return s1 .. s2
end

return Funk.switch(
  { Funk.is_list, Funk.curry(concat_list) },
  { Funk.is_dict, Funk.curry(concat_dict) },
  { Funk.is_string, Funk.curry(concat_str) }
)
