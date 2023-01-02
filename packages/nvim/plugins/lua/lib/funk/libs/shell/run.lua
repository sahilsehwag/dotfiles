local run = function(cmd)
	local stream = io.popen(cmd)
	local output = stream:read('*all')
	stream:close()
	return output
end

return Funk.sh.run_with(run)
