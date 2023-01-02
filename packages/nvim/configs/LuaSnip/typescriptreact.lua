local luasnip = require("luasnip")
local snippet = luasnip.snippet
local snippet_node = luasnip.snippet_node
local text_node = luasnip.text_node
local insert_node = luasnip.insert_node
local function_node = luasnip.function_node
local choice_node = luasnip.choice_node
local dynamic_node = luasnip.dynamic_node
local lambda = require("luasnip.extras").lambda
local repeat_node = require("luasnip.extras").rep
local partial = require("luasnip.util.functions").partial

return {
	--definitions
	--variables
	--functions
	--classes
	--methods
	--types
	--type
	--interface

	--api

	--components
	snippet("react.component.functional", {
		text_node("type "),
		insert_node(1, "Identifier"),
		text_node({ "Props = {", "\t" }),
		insert_node(2, "propName"),
		text_node(": "),
		insert_node(3, "propType"),
		text_node({ ",", "" }),
		text_node({ "}", "", "" }),
		text_node("export const "),
		repeat_node(1),
		text_node({ " = ({", "\t" }),
		repeat_node(2),
		text_node({ ",", "" }),
		text_node("}: "),
		repeat_node(1),
		text_node({ "Props): JSX.Element => {", "\t" }),
		text_node({ "return (", "\t\t" }),
		insert_node(4),
		text_node({ "", "\t)", "" }),
		text_node({ "}", "" }),
	}),
	snippet("react.component.functional.type", {
		text_node("type "),
		insert_node(1, "Identifier"),
		text_node({ "Props = {", "\t" }),
		insert_node(2, "propName"),
		text_node(": "),
		insert_node(3, "propType"),
		text_node({ ",", "" }),
		text_node({ "}", "" }),
	}),

	--hooks
}
