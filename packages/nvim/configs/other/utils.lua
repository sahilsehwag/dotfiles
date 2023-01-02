return {
	variants = function(variationName, variations, targets)
		local result = {}
		for _, target in ipairs(targets) do
			if string.find(target.target, "{" .. variationName .. "}") then
				for _, variation in ipairs(variations) do
					result[#result + 1] = {
						target = string.gsub(target.target, "{" .. variationName .. "}", variation),
						context = target.context,
					}
				end
			else
				result[#result + 1] = target
			end
		end
		return result
	end,
}
