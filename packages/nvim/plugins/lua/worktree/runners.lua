return {
	bang      = F.sh.run_with('!'),
	term      = F.sh.run_with('terminal'),
	async_run = F.sh.run_with('AsyncRun -mode=term'),
	tmux      = F.sh.run_with('T lh.h20%'),
}
