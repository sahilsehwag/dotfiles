return function(f1, f2)
  return function(arg)
    return f1(f2(arg))
  end
end
