let g:axring_rings = [
\ ]

let g:axring_rings_cpp = [
	\ ['&&', '||'],
	\ ['&', '|', '^'],
	\ ['&=', '|=', '^='],
	\ ['>>', '<<'],
	\ ['>>=', '<<='],
	\ ['==', '!='],
	\ ['>', '<', '>=', '<='],
	\ ['++', '--'],
	\ ['true', 'false'],
\ ]

let g:axring_rings_javascript = [
	\ ['==', '!=', '===', '!=='],
	\ ['>', '<', '>=', '<='],
	\ ['true', 'false'],
	\ ['&&', '||', '??'],
	\ ['.', '.?'],
	\ ['if', 'else'],
	\ ['const', 'let', 'var'],
	\ ['+', '-', '*', '/'],
	\ ['interface', 'type'],
	\ ['null', 'undefined'],
\]

let g:axring_rings_javascriptreact = g:axring_rings_javascript
let g:axring_rings_typescript = g:axring_rings_javascript
let g:axring_rings_typescriptreact = g:axring_rings_javascript

let g:axring_rings_lua = [
	\ ['==', '~='],
	\ ['>', '<', '>=', '<='],
	\ ['true', 'false'],
	\ ['and', 'or', 'not'],
	\ ['nil', 'string', 'function', 'table', 'number'],
	\ ['if', 'elseif', 'else', 'end'],
	\ ['pairs', 'ipairs'],
	\ ['then', 'do'],
	\ ['+', '-', '*', '/'],
\]

