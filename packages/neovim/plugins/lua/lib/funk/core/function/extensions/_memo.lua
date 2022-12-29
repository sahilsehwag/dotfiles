local function has_tbl_key(key, dict)
  for k, _ in pairs(dict) do
    if Funk.equals(k, key) then
      return true
    end
  end
  return false
end

local has_key = Funk.if_else(
  Funk.is_table,
  has_tbl_key,
  Funk.has_key
)

return function(fn)
  local cache = {}
  return function(...)
    local arg = {...}
    
    if #arg == 0 then
      cache = {}
      return nil
    end
    
    if not has_key(arg, cache) then
      cache[arg] = fn(...)
      Funk.p(cache)
    end
    return cache[arg]
  end
end
