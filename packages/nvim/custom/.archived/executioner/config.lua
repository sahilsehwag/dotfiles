return {
	languages = require('executioner.languages').languages,
	cmds = {
		--vim interface command like tab/split ..
		internal = 'e',
		--terminal command like "split|terminal" or "!" which accepts external command as argument
		--if function, command will be passed as the argument
		external = 'terminal',
	},
}
