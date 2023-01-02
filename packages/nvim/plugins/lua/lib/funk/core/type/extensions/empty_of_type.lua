return Funk.switch(
  { Funk.is_bool,   Funk.always(false) },
  { Funk.is_string, Funk.always('')    },
  { Funk.is_table,  Funk.always({})    },
  { Funk.T,         Funk.always(nil)   }
)
