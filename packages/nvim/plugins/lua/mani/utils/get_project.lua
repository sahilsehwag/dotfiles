local get_project_cmd = F.rt('mani.cmds').get_project

return F.pipe(
  get_project_cmd,
	F.sh.run_and_split,
	F.map(F.split(': ')),
	F.from_pairs
)
