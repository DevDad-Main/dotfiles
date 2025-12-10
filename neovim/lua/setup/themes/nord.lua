-- Configure Nord theme with better variable differentiation
vim.g.nord_contrast = false
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = true
vim.g.nord_bold = true


-- Custom highlights for better variable differentiation
local nord = {
    -- Nord color palette (from the theme source)
    nord0 = "#2E3440",  -- dark background
    nord1 = "#3B4252",  -- slightly lighter background
    nord2 = "#434C5E",  -- selection background
    nord3 = "#4C566A",  -- comments
    nord4 = "#D8DEE9",  -- foreground
    nord5 = "#E5E9F0",  -- lighter foreground
    nord6 = "#ECEFF4",  -- brightest foreground
    nord7 = "#8FBCBB",  -- cyan
    nord8 = "#88C0D0",  -- ice blue
    nord9 = "#81A1C1",  -- blue
    nord10 = "#5E81AC", -- darker blue
    nord11 = "#BF616A", -- red
    nord12 = "#D08770", -- orange
    nord13 = "#EBCB8B", -- yellow
    nord14 = "#A3BE8C", -- green
    nord15 = "#B48EAD", -- purple
}

-- Apply custom highlights using autocmd
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "nord",
    callback = function()
        -- Enhanced variable differentiation
        vim.api.nvim_set_hl(0, "@variable", { fg = nord.nord4, bold = false })           -- Regular variables - standard foreground
        vim.api.nvim_set_hl(0, "@variable.builtin", { fg = nord.nord15, bold = true })   -- Built-in variables - purple, bold
        vim.api.nvim_set_hl(0, "@parameter", { fg = nord.nord12, italic = true })         -- Function parameters - orange, italic
        vim.api.nvim_set_hl(0, "@field", { fg = nord.nord10, italic = true })             -- Object fields - original dark blue, italic
        vim.api.nvim_set_hl(0, "@property", { fg = nord.nord10, italic = true })         -- Properties - original dark blue, italic
        
        -- Enhanced function differentiation
        vim.api.nvim_set_hl(0, "@function", { fg = "#7A9E9D", bold = true })            -- Functions - darker cyan, bold
        vim.api.nvim_set_hl(0, "@function.builtin", { fg = "#7A9E9D", bold = true })    -- Built-in functions - darker cyan, bold
        vim.api.nvim_set_hl(0, "@method", { fg = "#7A9E9D", italic = true })           -- Methods - darker cyan, italic
        vim.api.nvim_set_hl(0, "@method.call", { fg = "#7A9E9D", italic = true })       -- Method calls - darker cyan, italic
        vim.api.nvim_set_hl(0, "@constructor", { fg = nord.nord9, bold = true })         -- Constructors - blue, bold
        
        -- Enhanced type differentiation
        vim.api.nvim_set_hl(0, "@type", { fg = nord.nord9, bold = true })                -- Types - blue, bold
        vim.api.nvim_set_hl(0, "@type.builtin", { fg = nord.nord9, bold = true })        -- Built-in types - blue, bold
        vim.api.nvim_set_hl(0, "@type.definition", { fg = nord.nord9, bold = true })      -- Type definitions - blue, bold
        
        -- Enhanced keyword differentiation
        vim.api.nvim_set_hl(0, "@keyword", { fg = nord.nord9, italic = true })           -- Keywords - blue, italic
        vim.api.nvim_set_hl(0, "@keyword.function", { fg = nord.nord9, italic = true })  -- Function keywords - blue, italic
        vim.api.nvim_set_hl(0, "@keyword.operator", { fg = nord.nord9, italic = true })  -- Operator keywords - blue, italic
        vim.api.nvim_set_hl(0, "@keyword.return", { fg = nord.nord9, italic = true })   -- Return keywords - blue, italic
        vim.api.nvim_set_hl(0, "@conditional", { fg = nord.nord9, italic = true })       -- Conditionals - blue, italic
        vim.api.nvim_set_hl(0, "@repeat", { fg = nord.nord9, italic = true })            -- Loops - blue, italic
        
        -- Enhanced constant differentiation
        vim.api.nvim_set_hl(0, "@constant", { fg = nord.nord13, bold = true })           -- Constants - yellow, bold
        vim.api.nvim_set_hl(0, "@constant.builtin", { fg = nord.nord13, bold = true })   -- Built-in constants - yellow, bold
        vim.api.nvim_set_hl(0, "@constant.macro", { fg = nord.nord13, bold = true })     -- Macro constants - yellow, bold
        vim.api.nvim_set_hl(0, "@number", { fg = nord.nord15, bold = true })             -- Numbers - purple, bold
        vim.api.nvim_set_hl(0, "@float", { fg = nord.nord15, bold = true })             -- Floats - purple, bold
        vim.api.nvim_set_hl(0, "@boolean", { fg = nord.nord9, bold = true })             -- Booleans - blue, bold
        
        -- Enhanced string differentiation
        vim.api.nvim_set_hl(0, "@string", { fg = nord.nord14, italic = true })           -- Strings - green, italic
        vim.api.nvim_set_hl(0, "@string.regex", { fg = nord.nord13, italic = true })     -- Regex - yellow, italic
        vim.api.nvim_set_hl(0, "@string.escape", { fg = nord.nord15, bold = true })      -- Escape sequences - purple, bold
        vim.api.nvim_set_hl(0, "@character", { fg = nord.nord14, bold = true })          -- Characters - green, bold
        
        -- Enhanced operator differentiation
        vim.api.nvim_set_hl(0, "@operator", { fg = nord.nord9, bold = true })            -- Operators - blue, bold
        
        -- Enhanced punctuation differentiation
        vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = nord.nord6 })             -- Delimiters - bright foreground
        vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = nord.nord6 })              -- Brackets - bright foreground
        vim.api.nvim_set_hl(0, "@punctuation.special", { fg = nord.nord9, bold = true }) -- Special punctuation - blue, bold
        
        -- Enhanced comment differentiation
        vim.api.nvim_set_hl(0, "@comment", { fg = nord.nord3, italic = true })           -- Comments - gray, italic
        
        -- Enhanced namespace/module differentiation
        vim.api.nvim_set_hl(0, "@namespace", { fg = nord.nord10, italic = true })        -- Namespaces - dark blue, italic
        vim.api.nvim_set_hl(0, "@module", { fg = nord.nord10, bold = true })             -- Modules - dark blue, bold
        
        -- Enhanced tag differentiation
        vim.api.nvim_set_hl(0, "@tag", { fg = nord.nord9, bold = true })                 -- Tags - blue, bold
        vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = nord.nord6 })                    -- Tag delimiters - bright foreground
        vim.api.nvim_set_hl(0, "@tag.attribute", { fg = nord.nord12, italic = true })     -- Tag attributes - orange, italic
        
        -- Enhanced label differentiation
        vim.api.nvim_set_hl(0, "@label", { fg = nord.nord13, bold = true })              -- Labels - yellow, bold
        
        -- Enhanced error differentiation
        vim.api.nvim_set_hl(0, "@error", { fg = nord.nord11, bold = true, underline = true }) -- Errors - red, bold, underlined
        
        -- Enhanced text differentiation
        vim.api.nvim_set_hl(0, "@text", { fg = nord.nord4 })                             -- Text - standard foreground
        vim.api.nvim_set_hl(0, "@text.strong", { fg = nord.nord4, bold = true })         -- Strong text - bold
        vim.api.nvim_set_hl(0, "@text.emphasis", { fg = nord.nord4, italic = true })     -- Emphasis text - italic
        vim.api.nvim_set_hl(0, "@text.underline", { fg = nord.nord4, underline = true }) -- Underlined text
        vim.api.nvim_set_hl(0, "@text.strike", { fg = nord.nord4, strikethrough = true }) -- Strikethrough text
        vim.api.nvim_set_hl(0, "@text.title", { fg = nord.nord9, bold = true })          -- Titles - blue, bold
        vim.api.nvim_set_hl(0, "@text.literal", { fg = nord.nord14 })                     -- Literal text - green
        vim.api.nvim_set_hl(0, "@text.uri", { fg = nord.nord14, underline = true })      -- URIs - green, underlined
        vim.api.nvim_set_hl(0, "@text.math", { fg = nord.nord13, bold = true })          -- Math - yellow, bold
        vim.api.nvim_set_hl(0, "@text.reference", { fg = nord.nord15, bold = true })     -- References - purple, bold
        vim.api.nvim_set_hl(0, "@text.environment", { fg = nord.nord10, bold = true })   -- Environments - dark blue, bold
        vim.api.nvim_set_hl(0, "@text.environment.name", { fg = nord.nord9, bold = true }) -- Environment names - blue, bold
        vim.api.nvim_set_hl(0, "@text.note", { fg = nord.nord10, bold = true })         -- Notes - dark blue, bold
        vim.api.nvim_set_hl(0, "@text.warning", { fg = nord.nord13, bold = true })       -- Warnings - yellow, bold
        vim.api.nvim_set_hl(0, "@text.danger", { fg = nord.nord11, bold = true })       -- Danger - red, bold
        
        -- Enhanced symbol differentiation
        vim.api.nvim_set_hl(0, "@symbol", { fg = nord.nord15, bold = true })             -- Symbols - purple, bold
        
        -- Enhanced attribute differentiation
        vim.api.nvim_set_hl(0, "@attribute", { fg = nord.nord12, italic = true })         -- Attributes - orange, italic
    end,
})


-- Load the colorscheme
vim.cmd("colorscheme nord")
