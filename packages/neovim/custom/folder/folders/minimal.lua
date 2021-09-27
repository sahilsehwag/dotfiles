local get_expansion_string = require('folder.helpers').get_expansion_string

return function(components)
  local buffer = get_expansion_string(#components.line, ' ')
  return components.line .. buffer
end
