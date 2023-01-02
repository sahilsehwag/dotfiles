"TODO:ECHOES
	"TODO:USE vim.notify
	"TODO:FIX HIGHLIGHTS
	function! PEcho(msg)
		echohl WildMenu
		echom "INFO: " . a:msg
		call getchar()
		echohl None
	endfunction

	function! PEchoSuccess(msg)
		echohl MoreMsg
		echom "SUCCESS: " . a:msg
		call getchar()
		echohl None
	endfunction

	function! PEchoWarning(msg)
		echohl WildMenu
		echom "WARNING: " . a:msg
		call getchar()
		echohl None
	endfunction

	function! PEchoError(msg)
		echohl ErrorMsg
		echomsg "ERROR: " . a:msg
		call getchar()
		echohl None
	endfunction
