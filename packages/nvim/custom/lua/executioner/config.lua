return {
	languages = require('executioner.languages').languages,
	-- TODO: rename to runners
	cmds = {
		command = '',
		--vim interface command like tab/split ..
		window = 'e',
		--terminal command like "split|terminal" or "!" which accepts external command as argument
		--if function, command will be passed as the argument
		terminal = 'terminal',
	},
}
