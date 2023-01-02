return {
	setup = F.rf('git_workspace.setup'),

	switch_project = F.rf('git_workspace.operations.switch_project'),
	switch_workspace = F.rf('git_workspace.operations.switch_workspace'),
	cd_workspace_root = F.rf('git_workspace.operations.cd_workspace_root'),
}
