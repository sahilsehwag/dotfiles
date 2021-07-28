"SETUP
  call wilder#enable_cmdline_enter()
"MAPPINGS
  set wildcharm=<Tab>
  cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
  cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
"MODES
  call wilder#set_option('modes', ['/', '?', ':'])
"PIPELINE
  call wilder#set_option('pipeline', [
    \wilder#branch(
      \wilder#python_file_finder_pipeline({
        \'file_command': {_, arg -> stridx(arg, '.') != -1 ? ['fd', '-tf', '-H'] : ['fd', '-tf']},
        \'dir_command': ['fd', '-td'],
        \'filters': ['fuzzy_filter', 'difflib_sorter'],
      \}),
      \wilder#substitute_pipeline({
        \'pipeline': wilder#python_search_pipeline({
          \'skip_cmdtype_check': 1,
          \'pattern': wilder#python_fuzzy_pattern({
            \'start_at_boundary': 0,
          \}),
        \}),
      \}),
      \wilder#cmdline_pipeline({
        \'fuzzy': 1,
        \'fuzzy_filter': wilder#vim_fuzzy_filter(),
      \}), 
      \[
        \wilder#check({_, x -> empty(x)}),
        \wilder#history(),
      \],
      \wilder#python_search_pipeline({
        \'pattern': wilder#python_fuzzy_pattern({
          \'start_at_boundary': 0,
        \}),
        \'sorter': wilder#python_difflib_sorter(),
        \'engine': 're',
      \}),
      \wilder#vim_search_pipeline(),
      \wilder#search_pipeline(),
    \)
  \])
"RENDERER
  let s:highlighters = [
    \wilder#basic_highlighter(),
  \]
  let accent = wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}])
  
  let s:wildmenu_renderer = wilder#wildmenu_renderer({
    \'highlighter' : s:highlighters,
    \'highlights': {
      \'accent': accent,
    \},
    \'separator'   : '  ',
    \'left'        : [' ', wilder#wildmenu_spinner(), ' '],
    \'right'       : [' ', wilder#wildmenu_index()],
  \})
  
  "border = single|double|rounded|solid|[8-characters]
  let s:floating_renderer = wilder#popupmenu_renderer(
    \wilder#popupmenu_border_theme({
      \'highlighter' : s:highlighters,
      \'highlights': {
        \'border': 'Normal',
        \'accent': accent,
      \},
      \'border': 'rounded',
      \'max_width': '100%',
      \'max_height': '50%',
      \'reverse': 0,
      \'empty_message': wilder#popupmenu_empty_message_with_spinner(),
      \'left': [
        \' ',
        \wilder#popupmenu_devicons(),
        \wilder#popupmenu_buffer_flags({
          \'flags': ' a + ',
          \'icons': {'+': '', 'a': '', 'h': ''},
        \}),
      \],
      \'right': [' ', wilder#popupmenu_scrollbar()],
    \})
  \)
  
  call wilder#set_option('renderer', wilder#renderer_mux({
    \':': s:floating_renderer,
    \'/': s:wildmenu_renderer,
    \'?': s:wildmenu_renderer,
    \'substitute': s:wildmenu_renderer,
  \}))
  
