return function(fn)
  return function(...)
    fn(...)
    return ...
  end
end
