--refernces
--fp-ts
--purify | purifree
--object way
--module way
-- constructors
-- conversions
-- fromNullable
-- toUndefined
-- instances
-- Functor
-- getSemigroup
-- combinators?
-- lifting
-- mapping
-- filtering
-- folding
-- traversing
-- refinements
-- error-handling
-- matchers
-- utils
-- unsafe
-- predicates
-- Do

local Number = function(value)
	return {
		__TYPE = 'Number',
		value = value,
	}
end

local Rectangle = function(length, height)
	return {
		__TYPE = 'Rectangle',
		value = {
			length = length,
			height = height,
		}
	}
end

local Shape = function(value)
	return {
		__TYPE = 'Shape',
		value = value,
	}
end

--/*Functor*/
--/*Monad*/

local List = function(value)
	return {
		__TYPE = 'List',
		map = function(fn)
			return F.map(fn, value)
		end,
		filter = function(fn)
			return F.filter(fn, value)
		end,
		extract = function()
			return value
		end,
	}
end

local Dict = function(value)
	return {
		__TYPE = 'Dict',
		map = function(fn)
			return F.map(fn, value)
		end,
		filter = function(fn)
			return F.filter(fn, value)
		end,
		extract = function()
			return value
		end,
	}
end

local Left = function(value)
	return {
		__TYPE = 'Left',
		map = function(fn)
			return Left(value)
		end,
		fold = function(lfn, _)
			return lfn(value)
		end,
	}
end

local Right = function(value)
	return {
		__TYPE = 'Right',
		map = function(fn)
			return Right(fn(value))
		end,
		fold = function(_, rfn)
			return rfn(value)
		end,
	}
end

local fromNullable = function(v)
	return v == nil and Left() or Right(v)
end

local Just = function(value)
	return {
		__TYPE = 'Just',
		value = value,
		map = function(fn)
			return Just(fn(value))
		end,
		fold = function(_, rfn)
			return rfn(value)
		end,
	}
end

local None = function()
	return {
		__TYPE = 'None',
		map = function(fn)
			return None()
		end,
		fold = function(lfn, _)
			return lfn()
		end,
	}
end

local method = function(fn)
	return function(...)
		local args = unpack(...)
		return function(o)
			return o[fn](args)
		end
	end
end

local map = function(...)
	local args = unpack(...)
	return function(o)
		return o.map(args)
	end
end

local map = F.method('map')

local O = require 'func.Option'

O.fromNullable(nil)
	.map(add1)
	.filter(gt10)

local res = pipe(
	nil,
	O.fromNullable,
	F.map(add1),
	F.filter(gt10),
	F.method('map')(add1),
	F.fold(lfn, rfn)
)

--local map, filter = spread(O, { map, filter })

--local Either = function(value)
--  return {
--    __TYPE = 'Either',

--    fold = function(lfn, rfn)
--      return match({
--        Left = lfn,
--        Right = rfn,
--      })(value)
--    end,

--    map = function(fn)
--      return left_or_right.map(fn)
--    end,
--    map = function(fn)
--      return value.is_left and value or Right(fn(value))
--    end,
--  }
--end

local Type = function(name, fields)
	return function(...)
		local values = unpack(...)
		return {
			__TYPE = name,
			value = F.fold(
				function(obj, field, ix)
					obj[field] = values[ix]
					return obj
				end,
				{}
			)(fields),
		}
	end
end

local Rectangle = Type(
	'Rectangle', {
		'length',
		'height',
	}
)

local Job = Type(
	'Job', {
		'profile',
		'company',
	}
)

local Person = Type(
	'Person', {
		'name',
		'height',
		'job',
	}
)

local Person = Type(
	'Person', {
		'name',
		'height',
		job = {
			'profile',
			'company',
		},
	}
)

local Person = Type(
	'Person', List(
		'name',
		'height'
	)
)

local Person = Type(
	'Person', Or(
		'name',
		'height'
	)
)

local Person = Type(
	'Person', Or({
		name = 'String',
		height = 'Number',
	})
)

local Person = Type(
	'Person', List(
		{ name = 'name', type = 'String' },
		{ name = 'height', type = 'Number' }
	)
)

local Shape = Type(
	'Shape', Dict({
		Square = List('side'),
		Rectangle = List('length', 'breadth'),
	})
)

local Shape = Type(
	'Shape', And({
		Square = Or('side'),
		Rectangle = Or('length', 'breadth'),
	})
)

local Shape = Type(
	'Shape', And({
		Square = Or({
			side = 'Number',
		}),
		Rectangle = Or({
			length = 'Number',
			breadth = 'Number',
		}),
	})
)

local RemoteData = Type(
	'RemoteData', Dict({
		NotAsked = List(),
		Loading  = List(),
		Error    = List('error'),
		Success  = List('data'),
	})
)

-- NOTE: generates CONSTRUCTORS | MATCH | EQUALS | OPTICS ....?

--local Option = Type(
--  'Option', Dict({
--    Just = List('value'),
--    None = List('value'),
--  })
--)

local person = Person(
	'Sahil',
	175,
	Job(
		'SDE',
		'MindTickle'
	)
)

local person = Person({
	name = 'Sahil Sehwag',
	height = 175,
	job = Job({
		profile = 'SDE',
		compnay = 'MindTickle',
	})
})

local person = Person({
	name = 'Sahil Sehwag',
	height = 175,
	job = Job(
		'SDE',
		'MindTickle'
	)
})

local typeOf = function(value)
	if type(value) == 'dict' and value.__TYPE then
		return value.__TYPE
	end
	return type(value)
end

local match = function(TYPE_X_FN)
	return function(value)
		return TYPE_X_FN[typeOf(value)](value)
	end
end

local area = match({
	Square = function(shape)
		return shape.side * shape.side
	end,
	Rectangle = function(shape)
		return shape.length * shape.height
	end
})

local person = Person()
local square = Shape.Square()
local square = Shape.Rectangle()

pipe(
	person,
	get('job'),
	match({
		Square = function()
		end,
		Rectangle = function()
		end,
	}),
	area,
	map(fn)
)

--Types
--  Primitive
--  And
--  Or
--Containers

--Polymorphism
--  Function
--    map = o.map
--  Type
--    Or
--      match()


compose(fns)
compose({ fns })

compose(f1, f2)

fold(compose, id, fns)

fold(compose, id)(fns)

fold(add)(0, nums)
fold(add)(nums, 0)


local decorate = function(before, after)
	return function(fn)
		return function(...)
			before(...)
			local result = fn(...)
			after(...)
			return result
		end
	end
end

local after = decorate(id)
local before = flip(decorate)(id)

local propmap = function(before, after)
	return function(fn)
		return function(...)
			return compose(before, fn, after)
		end
	end
end

--combinators
--logging
--error handling
--argument manipulation (handle element or an array)
--caching | memoization
--async | throttle debounce
--resource management | allocation + deallocation


--Fn ADT
--history
--arbitary combinators to provide app wide functionality


local APIResponse =
	SumType('APIResponse', {
		Loading = {},
		Error = {
			'status',
			'status',
		},
		Data = {
			'users',
			'users',
			'users',
		},
	})

local APIResponse =
	ProductType('Peron', {
		'name',
		job = {
			'profile',
			'company',
		},
	})

-- ts-adt makeMatch()
-- https://www.youtube.com/watch?v=o91UKmLwBOk
matchError()



-- Form Monad --in progress
-- think about in reactive environments like react, to avoid re-rendering
-- value: Both<E[], V>,
--const form = new Form({
--  username: [value, validator],
--  username: { value, validator },
--}, config)
--
--const Form = fields => ({
--  fields
--  map
--  mapValues
--  mapValidators
--  mapBoth
--  chain
--  concat
--  tap
--  of
--  --no args means validate everything, otherwise validate list of fields
--  validate
--  validateWith
--  fromStruct
--  fromTuple
--  values
--  get
--  set
--})
--
--pipe(
--  form
--  F.map((fields, config) => fields),
--  F.chain,
--  F.validate,
--  F.tap(fields => )
--)
--
--const handleSubmit = () => pipe(
--  form
--  F.mapValues(adaptForAPI)
--  F.mapValidators(validators)
--  F.mapBoth({ values, validators } => ({ values, validators })
--  F.map(fields => ({
--    ...fields,
--    username: {
--      value: username.value,
--      validator:
--    }
--  }))
--  F.validate,
--  F.tap(values => sendToAPI(fields)
--  F.tap(flow(adaptForAPI, sendToAPI))
--)
--
--const onChange = e => pipe(
--  form,
--  F.mapValues(set('username', e.target.value))
--  setForm
--)

-- https://github.com/calmm-js/partial.lenses
-- https://github.com/xgrommx/awesome-functional-programming#tutorials-and-articles
