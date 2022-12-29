return Funk.curry(function(fn, acc, tbl)
  if Funk.is_list(tbl) then
    for i, v in ipairs(tbl) do
      acc = fn(acc, v, i, tbl)
    end
  else
    for k, v in pairs(tbl) do
      acc = fn(acc, v, k, tbl)
    end
  end
  return acc
end)
