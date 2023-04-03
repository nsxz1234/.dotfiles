----------------------
-- Styles
----------------------

as.ui.palette = {
  green = '#98c379',
  dark_green = '#10B981',
  blue = '#82AAFE',
  dark_blue = '#4e88ff',
  bright_blue = '#51afef',
  teal = '#15AABF',
  pale_pink = '#b490c0',
  magenta = '#c678dd',
  pale_red = '#E06C75',
  light_red = '#c43e1f',
  dark_red = '#be5046',
  dark_orange = '#FF922B',
  bright_yellow = '#FAB005',
  light_yellow = '#e5c07b',
  whitesmoke = '#9E9E9E',
  light_gray = '#626262',
  comment_grey = '#5c6370',
  grey = '#3E4556',
}

as.ui.border = {
  line = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏' },
  rectangle = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
}

as.ui.icons = {
  separators = {
    left_thin_block = '▏',
    right_thin_block = '▕',
    vert_bottom_half_block = '▄',
    vert_top_half_block = '▀',
    right_block = '🮉',
    light_shade_block = '░',
  },
  lsp = {
    error = '',
    warn = '',
    info = '',
    hint = '',
  },
  git = {
    add = '', -- '',
    mod = '',
    remove = '', -- '',
    ignore = '',
    rename = '',
    diff = '',
    repo = '',
    logo = '',
    branch = '',
  },
  documents = {
    file = '',
    files = '',
    folder = '',
    open_folder = '',
  },
  misc = {
    up = '⇡',
    down = '⇣',
    line = 'ℓ', -- ''
    indent = 'Ξ',
    tab = '⇥',
    bug = '', -- 'ﴫ'
    question = '',
    clock = '',
    lock = '',
    circle = '',
    project = '',
    dashboard = '',
    history = '',
    comment = '',
    robot = 'ﮧ',
    lightbulb = '',
    search = '',
    code = '',
    telescope = '',
    gear = '',
    package = '',
    list = '',
    sign_in = '',
    check = '',
    fire = '',
    note = '',
    bookmark = '',
    pencil = '',
    tools = '',
    chevron_right = '',
    double_chevron_right = '»',
    table = '',
    calendar = '',
    block = '▌',
  },
}

as.ui.lsp = {
  colors = {
    error = as.ui.palette.pale_red,
    warn = as.ui.palette.dark_orange,
    hint = as.ui.palette.light_yellow,
    info = as.ui.palette.teal,
  },
  highlights = {
    Text = 'String',
    Method = 'Method',
    Function = 'Function',
    Constructor = 'TSConstructor',
    Field = 'Field',
    Variable = 'Variable',
    Class = 'Class',
    Interface = 'Constant',
    Module = 'Include',
    Property = 'Property',
    Unit = 'Constant',
    Value = 'Variable',
    Enum = 'Type',
    Keyword = 'Keyword',
    File = 'Directory',
    Reference = 'PreProc',
    Constant = 'Constant',
    Struct = 'Type',
    Snippet = 'Label',
    Event = 'Variable',
    Operator = 'Operator',
    TypeParameter = 'Type',
  },
}

----------------------------------------------------------------------------------------------------
-- Global style settings
----------------------------------------------------------------------------------------------------
-- Some styles can be tweaked here to apply globally i.e. by setting the current value for that style

-- The current styles for various UI elements
as.ui.current = { border = as.ui.border.rectangle }
