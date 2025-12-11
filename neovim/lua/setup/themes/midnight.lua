-- Custom Midnight Theme - A blend of Nord, Gruvbox, and Kanagawa
-- Dark theme with excellent syntax differentiation

local M = {}

-- Color palette inspired by Nord, Gruvbox, Kanagawa, and Ayu
local colors = {
  -- Background colors (Nord-inspired)
  bg = "#2E3440",           -- Nord background
  bg_dark = "#242933",       -- Darker background
  bg_highlight = "#3B4252",  -- Highlighted background
  bg_popup = "#2E3440",      -- Popup background (same as main bg)

  -- Foreground colors
  fg = "#BFBDB6",            -- Main foreground (Ayu)
  fg_dark = "#707A8C",       -- Dimmed foreground
  fg_light = "#E0E6FF",      -- Light foreground

  -- Accent colors (Ayu-inspired)
  blue = "#39BAE6",          -- Blue (Ayu)
  blue_dark = "#274364",     -- Dark blue (Ayu selection)
  cyan = "#5CCFE6",          -- Cyan (Ayu)
  green = "#AAD94C",         -- Green (Ayu)
  magenta = "#D2A6FF",       -- Magenta/Purple (Ayu)
  orange = "#FFB454",        -- Orange (Ayu)
  red = "#F07178",           -- Red (Ayu)
  yellow = "#FFCC66",        -- Yellow (Ayu)

  -- Semantic colors (simplified with consistent clay color)
  comment = "#636A72",       -- Comments (subtle)
  constant = "#D8DEE9",      -- Constants (light grey)
  string = "#A3BE8C",        -- Strings (subtle green)
  variable = "#D8DEE9",      -- Variables (same as constants)
  function_name = "#D08770", -- Functions (subtle orange)
  keyword = "#D08770",       -- Keywords (subtle orange)
  type_name = "#8FBCBB",     -- Types (subtle cyan)
  number = "#D8DEE9",        -- Numbers (same as variables)
  boolean = "#D8DEE9",       -- Booleans (same as variables)
  special = "#EBCB8B",       -- Special (subtle yellow)

  -- Simplified colors for properties and members
  property = "#D8DEE9",      -- Properties (same as variables)
  member = "#D8DEE9",        -- Object members (same as variables)
  parameter = "#D8DEE9",     -- Parameters (same as variables)
  
  -- Additional subtle orange for operators
  operator = "#D08770",       -- Operators (subtle orange)

  -- UI colors
  border = "#304357",        -- Borders (Ayu)
  selection = "#1B3A5B",     -- Selection (Ayu)
  visual = "#1B3A5B",        -- Visual selection
  line_nr = "#454B55",       -- Line numbers (Ayu)
  cursor_line = "#3B4252",   -- Cursor line (Nord highlight)
}

-- Setup function
function M.setup()
    -- Set the colorscheme
    vim.o.background = "dark"
    
    -- Clear existing highlights
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    
    -- Set colorscheme name
    vim.g.colors_name = "midnight"
    
    -- Define highlights
    local highlights = {
        -- Basic highlights
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalDark = { fg = colors.fg_dark, bg = colors.bg_dark },
        NormalFloat = { fg = colors.fg, bg = colors.bg_popup },
        FloatBorder = { fg = colors.border, bg = colors.bg_popup },
        FloatTitle = { fg = colors.fg_light, bg = colors.bg_popup, bold = true },
        
        -- Cursor and selection
        Cursor = { fg = colors.bg, bg = colors.fg },
        CursorLine = { bg = colors.cursor_line },
        CursorColumn = { bg = colors.cursor_line },
        CursorLineNr = { fg = colors.fg_light, bg = colors.cursor_line, bold = true },
        Visual = { bg = colors.visual },
        VisualNOS = { bg = colors.visual },
        
        -- Line numbers
        LineNr = { fg = colors.line_nr },
        SignColumn = { fg = colors.line_nr, bg = colors.bg },
        
        -- Search
        Search = { fg = colors.bg, bg = colors.yellow, bold = true },
        IncSearch = { fg = colors.bg, bg = colors.orange, bold = true },
        CurSearch = { fg = colors.bg, bg = colors.orange, bold = true },
        Substitute = { fg = colors.bg, bg = colors.green, bold = true },
        
        -- Folding
        Folded = { fg = colors.fg_dark, bg = colors.bg },
        FoldColumn = { fg = colors.line_nr, bg = colors.bg },
        
        -- Diff
        DiffAdd = { fg = colors.green, bg = colors.bg_highlight },
        DiffChange = { fg = colors.blue, bg = colors.bg_highlight },
        DiffDelete = { fg = colors.red, bg = colors.bg_highlight },
        DiffText = { fg = colors.yellow, bg = colors.bg_highlight },
        
        -- Messages
        ErrorMsg = { fg = colors.red, bold = true },
        WarningMsg = { fg = colors.yellow, bold = true },
        MoreMsg = { fg = colors.blue, bold = true },
        ModeMsg = { fg = colors.fg, bold = true },
        
        -- Status line
        StatusLine = { fg = colors.fg, bg = colors.bg_highlight },
        StatusLineNC = { fg = colors.fg_dark, bg = colors.bg_dark },
        
        -- Tab line
        TabLine = { fg = colors.fg_dark, bg = colors.bg_dark },
        TabLineFill = { fg = colors.fg_dark, bg = colors.bg_dark },
        TabLineSel = { fg = colors.fg, bg = colors.blue, bold = true },
        
        -- Wild menu
        WildMenu = { fg = colors.bg, bg = colors.blue, bold = true },
        
        -- Menu
        Pmenu = { fg = colors.fg, bg = colors.bg_popup },
        PmenuSel = { fg = colors.bg, bg = colors.blue, bold = true },
        PmenuSbar = { bg = colors.bg_highlight },
        PmenuThumb = { bg = colors.blue_dark },
        
        -- Spelling
        SpellBad = { fg = colors.red, underline = true },
        SpellCap = { fg = colors.yellow, underline = true },
        SpellLocal = { fg = colors.cyan, underline = true },
        SpellRare = { fg = colors.magenta, underline = true },
        
        -- Question
        Question = { fg = colors.green, bold = true },
        
        -- Directory
        Directory = { fg = colors.blue, bold = true },
        
        -- Title
        Title = { fg = colors.fg_light, bold = true },
        
        -- Syntax highlighting (Treesitter)
        ["@variable"] = { fg = colors.variable },
        ["@variable.builtin"] = { fg = colors.magenta, bold = true },
        ["@variable.parameter"] = { fg = colors.parameter, italic = true },
        ["@variable.member"] = { fg = colors.member },
        
        ["@constant"] = { fg = colors.constant, bold = true },
        ["@constant.builtin"] = { fg = colors.constant, bold = true },
        ["@constant.macro"] = { fg = colors.special, bold = true },
        
        ["@module"] = { fg = colors.blue, bold = true },
        ["@module.builtin"] = { fg = colors.blue, bold = true },
        
        ["@label"] = { fg = colors.yellow, bold = true },
        
        ["@string"] = { fg = colors.string, italic = true },
        ["@string.documentation"] = { fg = colors.string, italic = true },
        ["@string.regex"] = { fg = colors.special, italic = true },
        ["@string.escape"] = { fg = colors.magenta, bold = true },
        ["@string.special"] = { fg = colors.special, bold = true },
        ["@string.special.symbol"] = { fg = colors.magenta },
        ["@string.special.url"] = { fg = colors.blue, underline = true },
        ["@string.special.path"] = { fg = colors.green },
        
        ["@character"] = { fg = colors.green, bold = true },
        ["@character.special"] = { fg = colors.special, bold = true },
        
        ["@boolean"] = { fg = colors.boolean, bold = true },
        ["@number"] = { fg = colors.number, bold = true },
        ["@number.float"] = { fg = colors.number, bold = true },
        
        ["@type"] = { fg = colors.type_name, bold = true },
        ["@type.builtin"] = { fg = colors.type_name, bold = true },
        ["@type.definition"] = { fg = colors.type_name, bold = true },
        ["@type.qualifier"] = { fg = colors.keyword, italic = true },
        
        ["@attribute"] = { fg = colors.parameter, italic = true },
        ["@property"] = { fg = colors.property, italic = true },
        
        ["@function"] = { fg = colors.function_name, bold = true },
        ["@function.builtin"] = { fg = colors.function_name, bold = true },
        ["@function.call"] = { fg = colors.function_name },
        ["@function.macro"] = { fg = colors.special, bold = true },
        
        ["@function.method"] = { fg = colors.function_name, italic = true },
        ["@function.method.call"] = { fg = colors.function_name, italic = true },
        
        ["@constructor"] = { fg = colors.blue, bold = true },
        ["@operator"] = { fg = colors.keyword, bold = true },
        
        ["@keyword"] = { fg = colors.keyword, italic = true },
        ["@keyword.coroutine"] = { fg = colors.keyword, italic = true }, -- async/await
        ["@keyword.function"] = { fg = colors.keyword, italic = true },
        ["@keyword.operator"] = { fg = colors.keyword, italic = true },
        ["@keyword.import"] = { fg = colors.keyword, italic = true }, -- import/export/from
        ["@keyword.type"] = { fg = colors.keyword, italic = true },
        ["@keyword.modifier"] = { fg = colors.keyword, italic = true },
        ["@keyword.repeat"] = { fg = colors.keyword, italic = true },
        ["@keyword.return"] = { fg = colors.keyword, italic = true },
        ["@keyword.debug"] = { fg = colors.keyword, italic = true },
        ["@keyword.exception"] = { fg = colors.keyword, italic = true }, -- try/catch
        
        ["@keyword.conditional"] = { fg = colors.keyword, italic = true },
        ["@keyword.conditional.ternary"] = { fg = colors.keyword, italic = true },
        
        ["@conditional"] = { fg = colors.keyword, italic = true },
        ["@repeat"] = { fg = colors.keyword, italic = true },
        
        ["@punctuation.delimiter"] = { fg = colors.fg_dark },
        ["@punctuation.bracket"] = { fg = colors.fg_dark },
        ["@punctuation.special"] = { fg = colors.keyword, bold = true },
        
        ["@markup"] = { fg = colors.fg },
        ["@markup.strong"] = { fg = colors.fg, bold = true },
        ["@markup.emphasis"] = { fg = colors.fg, italic = true },
        ["@markup.strikethrough"] = { fg = colors.fg_dark, strikethrough = true },
        ["@markup.underline"] = { fg = colors.fg, underline = true },
        
        ["@markup.heading"] = { fg = colors.blue, bold = true },
        ["@markup.heading.1"] = { fg = colors.blue, bold = true },
        ["@markup.heading.2"] = { fg = colors.blue, bold = true },
        ["@markup.heading.3"] = { fg = colors.blue, bold = true },
        ["@markup.heading.4"] = { fg = colors.blue, bold = true },
        ["@markup.heading.5"] = { fg = colors.blue, bold = true },
        ["@markup.heading.6"] = { fg = colors.blue, bold = true },
        
        ["@markup.quote"] = { fg = colors.fg_dark, italic = true },
        ["@markup.math"] = { fg = colors.special, bold = true },
        ["@markup.environment"] = { fg = colors.blue, bold = true },
        ["@markup.environment.name"] = { fg = colors.type_name, bold = true },
        
        ["@markup.link"] = { fg = colors.blue, underline = true },
        ["@markup.link.label"] = { fg = colors.blue },
        ["@markup.link.url"] = { fg = colors.cyan, underline = true },
        
        ["@markup.raw"] = { fg = colors.green },
        ["@markup.raw.block"] = { fg = colors.green, bg = colors.bg_highlight },
        
        ["@markup.list"] = { fg = colors.orange, bold = true },
        ["@markup.list.checked"] = { fg = colors.green, bold = true },
        ["@markup.list.unchecked"] = { fg = colors.fg_dark, bold = true },
        
        ["@diff.plus"] = { fg = colors.green },
        ["@diff.minus"] = { fg = colors.red },
        ["@diff.delta"] = { fg = colors.blue },
        
        ["@tag"] = { fg = colors.blue, bold = true },
        ["@tag.attribute"] = { fg = colors.orange, italic = true },
        ["@tag.delimiter"] = { fg = colors.fg_dark },
        
        ["@none"] = { fg = colors.fg },
        
        ["@comment"] = { fg = colors.comment, italic = true },
        ["@comment.documentation"] = { fg = colors.comment, italic = true },
        ["@comment.error"] = { fg = colors.red, bold = true },
        ["@comment.warning"] = { fg = colors.yellow, bold = true },
        ["@comment.todo"] = { fg = colors.magenta, bold = true },
        ["@comment.note"] = { fg = colors.blue, bold = true },
        
        ["@error"] = { fg = colors.red, bold = true, underline = true },
        
        -- LSP semantic tokens
        ["@lsp.type.comment"] = { link = "@comment" },
        ["@lsp.type.enum"] = { link = "@type" },
        ["@lsp.type.enumMember"] = { link = "@constant" },
        ["@lsp.type.function"] = { link = "@function" },
        ["@lsp.type.interface"] = { link = "@type" },
        ["@lsp.type.keyword"] = { link = "@keyword" },
        ["@lsp.type.macro"] = { link = "@function.macro" },
        ["@lsp.type.method"] = { link = "@function.method" },
        ["@lsp.type.namespace"] = { link = "@module" },
        ["@lsp.type.parameter"] = { link = "@variable.parameter" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.struct"] = { link = "@type" },
        ["@lsp.type.type"] = { link = "@type" },
        ["@lsp.type.typeParameter"] = { link = "@type.definition" },
        ["@lsp.type.variable"] = { link = "@variable" },
        
        -- LSP diagnostics
        DiagnosticError = { fg = colors.red, bold = true },
        DiagnosticWarn = { fg = colors.yellow, bold = true },
        DiagnosticInfo = { fg = colors.blue, bold = true },
        DiagnosticHint = { fg = colors.cyan, bold = true },
        
        DiagnosticUnderlineError = { underline = true, sp = colors.red },
        DiagnosticUnderlineWarn = { underline = true, sp = colors.yellow },
        DiagnosticUnderlineInfo = { underline = true, sp = colors.blue },
        DiagnosticUnderlineHint = { underline = true, sp = colors.cyan },
        
        DiagnosticVirtualTextError = { fg = colors.red, italic = true },
        DiagnosticVirtualTextWarn = { fg = colors.yellow, italic = true },
        DiagnosticVirtualTextInfo = { fg = colors.blue, italic = true },
        DiagnosticVirtualTextHint = { fg = colors.cyan, italic = true },
        
        DiagnosticSignError = { fg = colors.red, bg = colors.bg },
        DiagnosticSignWarn = { fg = colors.yellow, bg = colors.bg },
        DiagnosticSignInfo = { fg = colors.blue, bg = colors.bg },
        DiagnosticSignHint = { fg = colors.cyan, bg = colors.bg },
        
        -- Git signs
        GitSignsAdd = { fg = colors.green, bg = colors.bg },
        GitSignsChange = { fg = colors.blue, bg = colors.bg },
        GitSignsDelete = { fg = colors.red, bg = colors.bg },
        
        -- Indent guides
        IndentBlanklineChar = { fg = colors.blue_dark, nocombine = true },
        IndentBlanklineSpaceChar = { fg = colors.blue_dark, nocombine = true },
        IndentBlanklineSpaceCharBlankline = { fg = colors.blue_dark, nocombine = true },
        IndentBlanklineContextChar = { fg = colors.orange, nocombine = true },
        IndentBlanklineContextStart = { bg = colors.bg_highlight, sp = colors.orange, underline = true },
        
        -- Mini plugins
        MiniIndentscopeSymbol = { fg = colors.blue_dark, nocombine = true },
        MiniIndentscopeSymbolOff = { fg = colors.red, nocombine = true },
        
        -- TreeSitter context
        TreesitterContext = { bg = colors.bg_highlight },
        TreesitterContextLineNumber = { fg = colors.line_nr, bg = colors.bg_highlight },
        
        -- Which key
        WhichKey = { fg = colors.blue, bold = true },
        WhichKeyGroup = { fg = colors.magenta },
        WhichKeySeparator = { fg = colors.fg_dark },
        WhichKeyDesc = { fg = colors.fg },
        WhichKeyFloat = { fg = colors.fg, bg = colors.bg_popup },
        WhichKeyValue = { fg = colors.orange },
        
        -- Telescope
        TelescopeNormal = { fg = colors.fg, bg = colors.bg_popup },
        TelescopeBorder = { fg = colors.border, bg = colors.bg_popup },
        TelescopeTitle = { fg = colors.fg_light, bg = colors.bg_popup, bold = true },
        TelescopeSelection = { fg = colors.bg, bg = colors.blue, bold = true },
        TelescopeSelectionCaret = { fg = colors.orange, bg = colors.blue, bold = true },
        TelescopeMultiSelection = { fg = colors.magenta, bg = colors.bg_popup },
        TelescopeMatching = { fg = colors.yellow, bold = true },
        TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_popup },
        TelescopePromptBorder = { fg = colors.border, bg = colors.bg_popup },
        TelescopePromptTitle = { fg = colors.blue, bg = colors.bg_popup, bold = true },
        TelescopePreviewNormal = { fg = colors.fg, bg = colors.bg_popup },
        TelescopePreviewBorder = { fg = colors.border, bg = colors.bg_popup },
        TelescopePreviewTitle = { fg = colors.green, bg = colors.bg_popup, bold = true },
        TelescopeResultsNormal = { fg = colors.fg, bg = colors.bg_popup },
        TelescopeResultsBorder = { fg = colors.border, bg = colors.bg_popup },
        TelescopeResultsTitle = { fg = colors.magenta, bg = colors.bg_popup, bold = true },
        
        -- LSP Hover Documentation (fix grey background)
        LspInfoBorder = { fg = colors.border, bg = colors.bg_popup },
        LspInfoTitle = { fg = colors.fg_light, bg = colors.bg_popup, bold = true },
        LspInfoList = { fg = colors.fg, bg = colors.bg_popup },
        LspInfoTip = { fg = colors.fg_dark, bg = colors.bg_popup, italic = true },
        LspInfoFiletype = { fg = colors.blue, bg = colors.bg_popup, bold = true },
        
        -- LSP Hover (the actual hover window)
        LspHoverNormal = { fg = colors.fg, bg = colors.bg_popup },
        LspHoverBorder = { fg = colors.border, bg = colors.bg_popup },
        
        -- Additional LSP UI elements
        LspSignatureActiveParameter = { fg = colors.bg, bg = colors.orange, bold = true },
        LspInlayHint = { fg = colors.fg_dark, bg = colors.bg_popup },
        
        -- Float windows (general)
        FloatNormal = { fg = colors.fg, bg = colors.bg_popup },
        FloatBorder = { fg = colors.border, bg = colors.bg_popup },
        
        -- Documentation windows
        Documentation = { fg = colors.fg, bg = colors.bg_popup },
        DocumentationBorder = { fg = colors.border, bg = colors.bg_popup },
        
        -- Additional hover/documentation highlights
        Pmenu = { fg = colors.fg, bg = colors.bg_popup },
        PmenuSel = { fg = colors.bg, bg = colors.blue, bold = true },
        PmenuSbar = { bg = colors.bg_highlight },
        PmenuThumb = { bg = colors.blue_dark },
        
        -- Signature help
        SignatureHelpBorder = { fg = colors.border, bg = colors.bg_popup },
        SignatureHelpDocumentation = { fg = colors.fg, bg = colors.bg_popup },
        
        -- Hover window specific
        HoverNormal = { fg = colors.fg, bg = colors.bg_popup },
        HoverBorder = { fg = colors.border, bg = colors.bg_popup },
        
        -- NvimTree
        NvimTreeNormal = { fg = colors.fg, bg = colors.bg },
        NvimTreeNormalNC = { fg = colors.fg, bg = colors.bg },
        NvimTreeRootFolder = { fg = colors.blue, bold = true },
        NvimTreeFolderName = { fg = colors.blue },
        NvimTreeFolderIcon = { fg = colors.blue },
        NvimTreeEmptyFolderName = { fg = colors.blue_dark },
        NvimTreeOpenedFolderName = { fg = colors.blue },
        NvimTreeFileIcon = { fg = colors.orange },
        NvimTreeFileDeleted = { fg = colors.red },
        NvimTreeFileDirty = { fg = colors.yellow },
        NvimTreeFileMerge = { fg = colors.magenta },
        NvimTreeFileNew = { fg = colors.green },
        NvimTreeFileRenamed = { fg = colors.blue },
        NvimTreeFileStaged = { fg = colors.green },
        NvimTreeGitDeleted = { fg = colors.red },
        NvimTreeGitDirty = { fg = colors.yellow },
        NvimTreeGitIgnored = { fg = colors.fg_dark },
        NvimTreeGitMerge = { fg = colors.magenta },
        NvimTreeGitNew = { fg = colors.green },
        NvimTreeGitRenamed = { fg = colors.blue },
        NvimTreeGitStaged = { fg = colors.green },
        NvimTreeIndentMarker = { fg = colors.line_nr },
        NvimTreeSymlink = { fg = colors.cyan },
        NvimTreeVertSplit = { fg = colors.border, bg = colors.bg },
        NvimTreeEndOfBuffer = { fg = colors.bg },
        NvimTreeCursorLine = { bg = colors.cursor_line },
        NvimTreeCursorColumn = { bg = colors.cursor_line },
    }
    
    -- Apply highlights
    for group, hl in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, hl)
    end
    
    -- Terminal colors
    vim.g.terminal_color_0 = colors.bg
    vim.g.terminal_color_1 = colors.red
    vim.g.terminal_color_2 = colors.green
    vim.g.terminal_color_3 = colors.yellow
    vim.g.terminal_color_4 = colors.blue
    vim.g.terminal_color_5 = colors.magenta
    vim.g.terminal_color_6 = colors.cyan
    vim.g.terminal_color_7 = colors.fg
    vim.g.terminal_color_8 = colors.bg_dark
    vim.g.terminal_color_9 = colors.red
    vim.g.terminal_color_10 = colors.green
    vim.g.terminal_color_11 = colors.yellow
    vim.g.terminal_color_12 = colors.blue
    vim.g.terminal_color_13 = colors.magenta
    vim.g.terminal_color_14 = colors.cyan
    vim.g.terminal_color_15 = colors.fg_light
end

return M