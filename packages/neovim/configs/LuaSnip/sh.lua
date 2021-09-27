local luasnip				= require('luasnip')
local snippet				= luasnip.snippet
local snippet_node	= luasnip.snippet_node
local text_node			= luasnip.text_node
local insert_node		= luasnip.insert_node
local function_node = luasnip.function_node
local choice_node		= luasnip.choice_node
local dynamic_node	= luasnip.dynamic_node
local lambda				= require('luasnip.extras').lambda
local rep						= require('luasnip.extras').rep
local partial				= require('luasnip.extras').partial

return {
	--definitions
	--functions

	--operators
	snippet('operator.pipe.overwrite', {
		text_node('>'),
	}),
	snippet('operator.pipe.append', {
		text_node('>>'),
	}),

	--variables
	snippet('variable.directory.script', {
		text_node('script_directory="$( cd "$( dirname "$0" )" && pwd )"'),
	}),

	--conditionals
	snippet('conditional.executable', {
		text_node('-x '),
		insert_node(1),
	}),
	snippet('conditional.file', {
		text_node('-f '),
		insert_node(1),
	}),
	snippet('conditional.directory', {
		text_node('-d '),
		insert_node(1),
	}),
	snippet('conditional.link', {
		text_node('-L '),
		insert_node(1),
	}),
	snippet('conditional.type', {
		text_node('type '),
		insert_node(1),
		text_node(' &> /dev/null'),
	}),
	snippet('conditional.argument.quoted.substring', {
		text_node('$@ =~ "'),
		insert_node(1),
		text_node('"'),
	}),
	snippet('conditional.argument.unquoted.substring', {
		text_node('$* =~ "'),
		insert_node(1),
		text_node('"'),
	}),
	snippet('conditional.os.linux', {
		text_node('"$OSTYPE" == "linux-gnu"*'),
	}),
	snippet('conditional.os.freebsd', {
		text_node('"$OSTYPE" == "freebsd"*'),
	}),
	snippet('conditional.os.mac', {
		text_node('"$OSTYPE" == "darwin"*'),
	}),
	snippet('conditional.os.cygwin', {
		text_node('"$OSTYPE" == "cygwin"*'),
	}),
	snippet('conditional.os.mingw', {
		text_node('"$OSTYPE" == "msys"*'),
	}),
	snippet('conditional.os.win32', {
		text_node('"$OSTYPE" == "win32"*'),
	}),
	snippet('conditional.mkdir', {
		text_node('mkdir -p '),
		insert_node(1),
		text_node(' && '),
		insert_node(2),
	}),
	snippet('conditional.type.statement', {
		text_node('type '),
		insert_node(1),
		text_node(' &> /dev/null && '),
		insert_node(2),
	}),
	snippet('conditional.executable.statement', {
		text_node('[[ -x '),
		insert_node(1),
		text_node(' ]] && '),
		insert_node(2),
	}),
	snippet('conditional.file.statement', {
		text_node('[[ -f '),
		insert_node(1),
		text_node(' ]] && '),
		insert_node(2),
	}),
	snippet('conditional.directory.statement', {
		text_node('[[ -d '),
		insert_node(1),
		text_node(' ]] && '),
		insert_node(2),
	}),
	snippet('conditional.link.statement', {
		text_node('[[ -L '),
		insert_node(1),
		text_node(' ]] && '),
		insert_node(2),
	}),

	--api
	snippet('api.link.soft.file', {
		text_node('ln -sv '),
		insert_node(1),
		text_node(' '),
		insert_node(2),
	}),
	snippet('api.link.soft.directory', {
		text_node('ln -sv '),
		insert_node(1),
		text_node('/ '),
		insert_node(2),
	}),
	snippet('api.bang', {
		text_node('#!usr/bin/env bash'),
	}),
	snippet('api.lists.row', {
		text_node('sed -n '),
		insert_node(1),
		text_node('p'),
	}),
	snippet('api.lists.column', {
		text_node('cut -d"'),
		insert_node(1),
		text_node('" -f'),
		insert_node(2),
	}),
	snippet('api.comparison.string', {
		text_node('echo '),
		insert_node(1),
		text_node('"'),
		insert_node(2),
		text_node('"'),
		insert_node(3),
		text_node(' | bc -l'),
	}),
	snippet('api.cp.files.all', {
		text_node('cp -a '),
		insert_node(1),
		text_node('/. '),
		insert_node(2),
		text_node('/'),
	}),
	snippet('api.file.prepend', {
		text_node('echo -e "'),
		insert_node(1),
		text_node('\\n$(cat '),
		insert_node(2),
		text_node(')" > '),
		rep(2),
	}),

	snippet('operations.dotfiles.link', {
		text_node('F_isSymlink ~/.config/'),
		insert_node(1),
		text_node(' || ln -sv $script_directory/ ~/.config/'),
		rep(2),
	}),
}
