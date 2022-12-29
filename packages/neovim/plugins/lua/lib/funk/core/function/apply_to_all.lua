return function(arg_list)
  return function(fn)
    return Funk.map(
      Funk.apply(fn),
      arg_list
    )
  end
end
