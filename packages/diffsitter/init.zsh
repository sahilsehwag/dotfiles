#compdef diffsitter

autoload -U is-at-least

_diffsitter() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-t+[Manually set the file type for the given files]:FILE_TYPE: ' \
'--file-type=[Manually set the file type for the given files]:FILE_TYPE: ' \
'-c+[Use the config provided at the given path]:CONFIG: ' \
'--config=[Use the config provided at the given path]:CONFIG: ' \
'--color=[Set the color output policy. Valid values are: "auto", "on", "off"]:COLOR_OUTPUT: ' \
'-h[Print help information]' \
'--help[Print help information]' \
'-V[Print version information]' \
'--version[Print version information]' \
'-d[Print debug output]' \
'--debug[Print debug output]' \
'-n[Ignore any config files and use the default config]' \
'--no-config[Ignore any config files and use the default config]' \
'::OLD -- The first file to compare against:' \
'::NEW -- The file that the old file is compared against:' \
":: :_diffsitter_commands" \
"*::: :->diffsitter" \
&& ret=0
    case $state in
    (diffsitter)
        words=($line[3] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:diffsitter-command-$line[3]:"
        case $line[3] in
            (list)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(dump-default-config)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(build-info)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
&& ret=0
;;
(gen-completion)
_arguments "${_arguments_options[@]}" \
'-h[Print help information]' \
'--help[Print help information]' \
':shell -- The shell to generate completion scripts for:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'*::subcommand -- The subcommand whose help message to display:' \
&& ret=0
;;
        esac
    ;;
esac
}

(( $+functions[_diffsitter_commands] )) ||
_diffsitter_commands() {
    local commands; commands=(
'list:List the languages that this program was compiled for' \
'dump-default-config:Dump the default config to stdout' \
'build-info:Print extended build information' \
'gen-completion:Generate shell completion scripts for diffsitter' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'diffsitter commands' commands "$@"
}
(( $+functions[_diffsitter__build-info_commands] )) ||
_diffsitter__build-info_commands() {
    local commands; commands=()
    _describe -t commands 'diffsitter build-info commands' commands "$@"
}
(( $+functions[_diffsitter__dump-default-config_commands] )) ||
_diffsitter__dump-default-config_commands() {
    local commands; commands=()
    _describe -t commands 'diffsitter dump-default-config commands' commands "$@"
}
(( $+functions[_diffsitter__gen-completion_commands] )) ||
_diffsitter__gen-completion_commands() {
    local commands; commands=()
    _describe -t commands 'diffsitter gen-completion commands' commands "$@"
}
(( $+functions[_diffsitter__help_commands] )) ||
_diffsitter__help_commands() {
    local commands; commands=()
    _describe -t commands 'diffsitter help commands' commands "$@"
}
(( $+functions[_diffsitter__list_commands] )) ||
_diffsitter__list_commands() {
    local commands; commands=()
    _describe -t commands 'diffsitter list commands' commands "$@"
}

_diffsitter "$@"
