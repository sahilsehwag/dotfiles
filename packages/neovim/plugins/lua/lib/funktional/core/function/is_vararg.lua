return function(fn)
  return debug.getinfo(fn).isvararg
end
