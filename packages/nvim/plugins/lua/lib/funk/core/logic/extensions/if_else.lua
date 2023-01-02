return Funk.curry(function(predicate, if_true, if_false)
  return Funk.curry_with(
    if_true,
    Funk.switch(
      { predicate, if_true  },
      { Funk.T,    if_false }
    )
  )
end)
