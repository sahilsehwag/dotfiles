return function(path)
  local module = {}
  setmetatable(module, {
    __index = function(_, k)
      module = Funk.req(path)
      return module[k]
    end
  })
  return module
end
