require'cool-substitute'.setup({
  setup_keybindings = true,
  mappings = {
    start                     = 'Gm',    -- Mark word / region
    start_and_edit            = 'GM',    -- Mark word / region and also edit
    start_and_edit_word       = 'G!M',   -- Mark word / region and also edit.  Edit only full word.
    start_word                = 'G!m',   -- Mark word / region. Edit only full word
    apply_substitute_and_next = 'M',     -- Start substitution / Go to next substitution
    apply_substitute_and_prev = '<C-b>', -- same as M but backwards
    apply_substitute_all      = 'Ga',    -- Substitute all
  }
})
