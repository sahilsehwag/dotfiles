return Funk.curry(function(opts, cmd)
  return Funk.pipe(
    Funk.append(opts.autoclose and '' or ';read'),
    Funk.sh.quote,
    Funk.append_to({
      'tmux',
      'split-window -v',
      '-c ' .. (opts.pwd or vim.fn.getcwd()),
    }),
    Funk.join(' '),
    Funk.sh.run
  )(cmd)
end)
