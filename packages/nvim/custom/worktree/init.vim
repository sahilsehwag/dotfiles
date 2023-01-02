function! RunCommand(cmd)
	if len($TMUX) > 0
		execute 'T lh.h20% ' . a:cmd
	elseif v:true
		execute 'AsyncRun -mode=term ' . a:cmd
	else
		call system(a:cmd)
	endif
endfunction

function! GitWorktreeGetAll()
	let list = system('git worktree list')
	return map(split(list, '\n'), 'split(v:val, "")[0]')
endfunction

function! GitWorktreeGetRoot()
	return GitWorktreeGetAll()[0]
endfunction

function! GitSelectWorktree()
	let worktrees = GitWorktreeGetAll()

	for i in range(len(worktrees))
		echo i . ': ' . worktrees[i]
	endfor

	let index = input('Select worktree: ')

	if index == ""
		return v:null
	endif

	return worktrees[index]
endfunction

function! GitWorktreeAdd()
	let branch = input('Enter branch name: ', '', 'customlist,GitGetBranches')
	if branch == ""
		return v:null
	endif

	let cdToRoot = 'cd ' . GitWorktreeGetRoot()
	let deleteBranch = 'git branch -d ' . branch
	let addWorktree = 'git worktree add branches/' . branch . ' ' . branch

	call RunCommand(cdToRoot . ' && '. deleteBranch . ' ; ' . addWorktree)
endfunction

function! GitWorktreeAddNew()
	let localBranch = input('Enter local branch name: ', '', 'customlist,GitGetBranches')
	if localBranch == ""
		return v:null
	endif

	let remoteBranch = input('Enter remote branch name: ', '', 'customlist,GitGetBranches')
	if remoteBranch == ""
		return v:null
	endif

	let cdToRoot = 'cd ' . GitWorktreeGetRoot()
	let deleteBranch = 'git branch -d ' . a:localBranch
	let addWorktree = 'cd ' . GitWorktreeGetRoot() . ' && git worktree add -b ' . a:localBranch . ' branches/' . a:localBranch . ' ' . a:remoteBranch

	call RunCommand(cdToRoot . ' && '. deleteBranch . ' ; ' . addWorktree)
endfunction

function! GitGetBranches(query, ...)
	return filter(map(split(system('git branch'), '\n'), 'trim(v:val)'), 'v:val =~? "' . a:query . '"')
endfunction

function! GitWorktreeRemove(force)
	let worktree = GitSelectWorktree()
	if worktree == v:null
		return
	endif

	let cdToRoot = 'cd ' . GitWorktreeGetRoot()
	let removeWorktree = 'git worktree remove branches/' . split(worktree, 'branches/')[1]
	if a:force == v:true
		let removeWorktree = removeWorktree . ' --force'
	end
	call RunCommand(cdToRoot . ' && ' . removeWorktree)
endfunction

function! GitWorktreeList()
	call RunCommand('git worktree list')
endfunction

function! GitWorktreeSwitch()
	let worktree = GitSelectWorktree()
	if worktree == v:null
		return
	endif

	execute 'cd ' . worktree
endfunction

"nnoremap <Leader>gwa :call GitWorktreeAdd()<CR>
nnoremap <Leader>gwA :call GitWorktreeAddNew()<CR>
"nnoremap <Leader>gwr :call GitWorktreeRemove(v:false)<CR>
"nnoremap <Leader>gwR :call GitWorktreeRemove(v:true)<CR>
"nnoremap <Leader>gwl :call GitWorktreeList()<CR>
"nnoremap <Leader>gws :call GitWorktreeSwitch()<CR>
