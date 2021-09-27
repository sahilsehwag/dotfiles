complete -c diffsitter -n "__fish_use_subcommand" -s t -l file-type -d 'Manually set the file type for the given files' -r
complete -c diffsitter -n "__fish_use_subcommand" -s c -l config -d 'Use the config provided at the given path' -r
complete -c diffsitter -n "__fish_use_subcommand" -l color -d 'Set the color output policy. Valid values are: "auto", "on", "off"' -r
complete -c diffsitter -n "__fish_use_subcommand" -s h -l help -d 'Print help information'
complete -c diffsitter -n "__fish_use_subcommand" -s V -l version -d 'Print version information'
complete -c diffsitter -n "__fish_use_subcommand" -s d -l debug -d 'Print debug output'
complete -c diffsitter -n "__fish_use_subcommand" -s n -l no-config -d 'Ignore any config files and use the default config'
complete -c diffsitter -n "__fish_use_subcommand" -f -a "list" -d 'List the languages that this program was compiled for'
complete -c diffsitter -n "__fish_use_subcommand" -f -a "dump-default-config" -d 'Dump the default config to stdout'
complete -c diffsitter -n "__fish_use_subcommand" -f -a "build-info" -d 'Print extended build information'
complete -c diffsitter -n "__fish_use_subcommand" -f -a "gen-completion" -d 'Generate shell completion scripts for diffsitter'
complete -c diffsitter -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c diffsitter -n "__fish_seen_subcommand_from list" -s h -l help -d 'Print help information'
complete -c diffsitter -n "__fish_seen_subcommand_from dump-default-config" -s h -l help -d 'Print help information'
complete -c diffsitter -n "__fish_seen_subcommand_from build-info" -s h -l help -d 'Print help information'
complete -c diffsitter -n "__fish_seen_subcommand_from gen-completion" -s h -l help -d 'Print help information'
