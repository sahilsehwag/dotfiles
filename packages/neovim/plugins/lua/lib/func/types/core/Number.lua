local Number = Funk.class('Number', {
	Funk.pure.Ord,
	Funk.pure.Num,
	Funk.pure.Functor,
})

function Number:new (value)
	local o = { value = value }
	setmetatable(o, self)
	self.__index = self
	return o
end

return Number
