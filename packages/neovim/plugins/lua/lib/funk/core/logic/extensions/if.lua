return Funk.curry(function(predicate, if_true)
  return Funk.curry_with(
    if_true,
    Funk.switch({ predicate, if_true })
  )
end)
