return Funk.switch(
  { Funk.eq('boolean') , Funk.always(false) },
  { Funk.eq('string')  , Funk.always('')    },
  { Funk.eq('table')   , Funk.always({})    },
  { Funk.T             , Funk.always(nil)   }
)
