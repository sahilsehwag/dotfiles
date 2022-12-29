return function(fn)
  return debug.getinfo(fn).nparams
end
