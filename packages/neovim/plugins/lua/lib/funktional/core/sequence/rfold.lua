return Funk.curry(function(fn, acc, tbl)
  if Funk.is_list(tbl) then
    for i = #tbl, 1, -1 do
      acc = fn(acc, tbl[i], i, tbl)
    end
  else
    for i, v in ipairs(tbl) do
      acc = fn(acc, v, i, tbl)
    end
  end
  return acc
end)
