return function(name, fns, parents)
  local Typeclass = Funk.class(name, parents)
  for _, fn in ipairs(fns) do
    Typeclass[fn] = function()
      error('Interface function "' .. fn .. '" not implemented')
    end
  end
  return Typeclass
end
