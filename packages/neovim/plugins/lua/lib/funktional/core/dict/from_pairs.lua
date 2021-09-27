return F.fold(function(acc, tuple)
  acc[tuple[1]] = tuple[2]
  return acc
end, {})
