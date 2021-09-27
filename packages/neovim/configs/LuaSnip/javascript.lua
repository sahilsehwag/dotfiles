local luasnip				= require('luasnip')
local snippet				= luasnip.snippet
local snippet_node	= luasnip.snippet_node
local text_node			= luasnip.text_node
local insert_node		= luasnip.insert_node
local function_node = luasnip.function_node
local choice_node		= luasnip.choice_node
local dynamic_node	= luasnip.dynamic_node
local lambda				= require("luasnip.extras").lambda
local rep						= require('luasnip.extras').rep
local partial				= require("luasnip.util.functions").partial

return {
	--syntax.definitions
	snippet('definition.variable.generator', {
		choice_node(4, {
			text_node(''),
			text_node('export '),
		}),
		choice_node(3, {
			text_node('const'),
			text_node('let'),
			text_node('var'),
		}),
		text_node(' '),
		insert_node(1, 'identifier'),
		text_node(' = '),
		insert_node(2, 'expresion'),
	}),

	snippet('definition.function.generator', {
	}),
	snippet('definition.function.definition', {
	}),
	snippet('definition.function.expression', {
	}),
	snippet('definition.function.keyword', {
	}),
	snippet('definition.function.arrow', {
	}),

	snippet('definition.class.generator', {
	}),
	snippet('definition.class.constructor', {
	}),
	snippet('definition.class.getter', {
	}),
	snippet('definition.class.setter', {
	}),
	snippet('definition.class.method', {
	}),

	--syntax.module
	snippet('module.import.generator', {
		text_node('import '),
		choice_node(2, {
			snippet_node(nil, {
				text_node({'{', '\t'}),
				insert_node(1, 'identifier'),
				text_node({',', '', '}'}),
			}),
			snippet_node(nil, {
				insert_node(1, '*'),
			}),
			snippet_node(nil, {
				insert_node(1, '*'),
				text_node({', {', '\t'}),
				insert_node(2, 'identifier'),
				text_node({',', '', '}'}),
			}),
		}),
		text_node(' from \''),
		insert_node(1, 'module'),
		text_node('\''),
	}),

	--syntax.iteration
	snippet('iteration.for.generator', {
	}),
	snippet('iteration.for.normal', {
	}),
	snippet('iteration.for.in', {
	}),
	snippet('iteration.for.of', {
	}),
	snippet('iteration.for.await', {
	}),

	--syntax.conditional
	snippet('conditional.if', {
		text_node('if ('),
		insert_node(1, 'condition'),
		text_node({') {', '\t'}),
		insert_node(2),
		text_node({'', '}'}),
	}),
	snippet('conditional.elseif', {
		text_node(' else if ('),
		insert_node(1, 'condition'),
		text_node({') {', '\t'}),
		insert_node(2),
		text_node({'', '}'}),
	}),
	snippet('conditional.else', {
		text_node({' else {', '\t'}),
		insert_node(1),
		text_node({'', '}'}),
	}),
	snippet('conditional.if.else', {
		text_node('if ('),
		insert_node(1, 'condition'),
		text_node({') {', '\t'}),
		insert_node(2),
		text_node({'', '} else {', '\t'}),
		insert_node(3),
		text_node({'', '}'}),
	}),
	snippet('conditional.switch', {
		text_node('switch ('),
		insert_node(1),
		text_node({') {', '\t'}),
		insert_node(2),
		text_node({'', '\tdefault:'}),
		insert_node(3),
		text_node({'', '\t\tbreak'}),
		text_node({'', '}'}),
	}),
	snippet('conditional.switch.case', {
		text_node('case '),
		insert_node(1, 'value'),
		text_node({':', '\t'}),
		insert_node(2),
		choice_node(3, {
			text_node({'', '\tbreak'}),
			text_node(''),
		})
	}),

	--testing.jest
	snippet('jest.describe', {
		text_node('describe(\''),
		insert_node(1, 'description'),
		text_node('\', '),
		choice_node(5, {
			text_node('('),
			text_node('async ('),
		}),
		insert_node(3),
		text_node({') => {', '\t'}),
		insert_node(2),
		text_node({'', '})'}),
	}),
	snippet('jest.test', {
		choice_node(4, {
			text_node('test'),
			text_node('it'),
		}),
		text_node('(\''),
		insert_node(1, 'description'),
		text_node('\', '),
		choice_node(5, {
			text_node('('),
			text_node('async ('),
		}),
		insert_node(3),
		text_node({') => {', '\t'}),
		insert_node(2),
		text_node({'', '})'}),
	}),
	snippet('jest.mock', {
		choice_node(3, {
			text_node('jest.mock(\''),
			text_node('jest.doMock(\''),
		}),
		insert_node(1, 'module'),
		text_node('\', () => '),
		choice_node(2, {
			snippet_node(nil, {
				text_node({'{', '\t'}),
				insert_node(1),
				text_node({'', '}'}),
			}),
			snippet_node(nil, {
				text_node('({'),
				text_node({'', '\t'}),
				choice_node(2, {
					text_node(''),
					text_node({'__esModule: true,', '\t'}),
				}),
				insert_node(1),
				text_node({'', '})'}),
			}),
		}),
		text_node(')'),
	}),
	snippet('jest.expect', {
		text_node('expect('),
		insert_node(1, 'input'),
		text_node(').to'),
		insert_node(2, 'Be'),
		text_node('('),
		insert_node(3, 'output'),
		text_node(')'),
	}),

	--api
	snippet('api.console.log', {
		text_node('console.log('),
		insert_node(1),
		text_node(')'),
	}),

	--frameworks.react
	snippet('react.hooks.useState', {
		text_node('const '),
		insert_node(1, 'state'),
		text_node({' = useState('}),
		choice_node(2, {
			snippet_node(nil, {
				insert_node(1)
			}),
			snippet_node(nil, {
				text_node('() => '),
				insert_node(1),
			}),
			snippet_node(nil, {
				text_node({'() => {', '\t'}),
				insert_node(1),
				text_node({'', '\treturn '}),
				insert_node(2, 'state'),
				text_node({'', '}'}),
			}),
		}),
		text_node({')'}),
	}),
	snippet('react.hooks.useEffect', {
		text_node({'useEffect(() => {', '\t'}),
		insert_node(1),
		text_node({'', ''}),
		choice_node(2, {
			snippet_node(nil, {
				text_node('}, ['),
				insert_node(1),
				text_node('])'),
			}),
			text_node('})'),
		})
	}),
	snippet('react.hooks.useCallback', {
		text_node('const '),
		insert_node(1, 'cb'),
		text_node(' = useCallback(('),
		insert_node(2),
		text_node({') => {', '\t'}),
		insert_node(3),
		text_node({'', ''}),
		choice_node(4, {
			snippet_node(nil, {
				text_node('}, ['),
				insert_node(1),
				text_node('])'),
			}),
			text_node('})'),
		})
	}),
	snippet('react.hooks.useMemo', {
		text_node('const '),
		insert_node(1, 'memo'),
		text_node({' = useMemo(() => {', '\t'}),
		insert_node(2),
		text_node({'', ''}),
		choice_node(3, {
			snippet_node(nil, {
				text_node('}, ['),
				insert_node(1),
				text_node('])'),
			}),
			text_node('})'),
		})
	}),
	snippet('react.jsx.prop', {
		insert_node(1, 'prop'),
		text_node('={'),
		insert_node(2, 'value'),
		text_node('}'),
	}),
	snippet('react.jsx.return', {
		text_node({'return (', '\t'}),
		insert_node(1),
		text_node({'', ')'}),
	}),
}
