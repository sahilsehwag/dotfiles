return {
	setup = F.rf('mani.setup'),

	edit_config   = F.rf('mani.operations.edit_config'),
	sync_projects = F.rf('mani.operations.sync_projects'),

	switch_project   = F.rf('mani.operations.switch_project'),
	switch_workspace = F.rf('mani.operations.switch_workspace'),

	run_task = F.rf('mani.operations.run_task'),
	exec_cmd = F.rf('mani.operations.exec_cmd'),

	cd_workspace_root = F.rf('mani.operations.cd_workspace_root'),
}
