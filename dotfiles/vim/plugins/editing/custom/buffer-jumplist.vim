"https://stackoverflow.com/questions/7066456/how-to-prevent-leaving-the-current-buffer-when-traversing-the-jump-list-in-vim
function! JumpWithinFile(back, forw)
	let [n, i] = [bufnr('%'), 1]
	let p = [n] + getpos('.')[1:]
	sil! exe 'norm!1' . a:forw
	while 1
		let p1 = [bufnr('%')] + getpos('.')[1:]
		if n == p1[0] | break | endif
		if p == p1
			sil! exe 'norm!' . (i-1) . a:back
			break
		endif
		let [p, i] = [p1, i+1]
		sil! exe 'norm!1' . a:forw
	endwhile
endfunction

command! BufferJumplistNext call JumpWithinFile("\<c-i>", "\<c-o>")
command! BufferJumplistPrevious call JumpWithinFile("\<c-o>", "\<c-i>")

