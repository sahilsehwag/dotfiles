local luasnip				= require('luasnip')
local snippet				= luasnip.snippet
local snippet_node	= luasnip.snippet_node
local text_node			= luasnip.text_node
local insert_node		= luasnip.insert_node
local function_node = luasnip.function_node
local choice_node		= luasnip.choice_node
local dynamic_node	= luasnip.dynamic_node
local lambda				= require("luasnip.extras").lambda
local rep						= require("luasnip.util.functions").rep
local partial				= require("luasnip.util.functions").partial

return {
	--default
	snippet('basic.word.not', {
		text_node('((?!'),
		insert_node(1),
		text_node(').)'),
	}),

	--blob
	snippet('glob.directory', {
		text_node('**/'),
		insert_node(1),
		text_node('/**'),
	}),

	--vim
}
