local llen = function(l)
  return #l
end

local dlen = function(l)
  return Funk.fold(Funk.add(1), 0)
end

return Funk.fn(
	Funk.add, { llen, dlen }
)
