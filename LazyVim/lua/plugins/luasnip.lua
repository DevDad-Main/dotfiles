return {
  "L3MON4D3/LuaSnip",
  enabled = true,
  opts = function(_, opts)
    local ls = require("luasnip")

    -- Add prefix ";" to each one of my snippets using the extend_decorator
    -- I use this in combination with blink.cmp. This way I don't have to use
    -- the transform_items function in blink.cmp that removes the ";" at the
    -- beginning of each snippet. I added this because snippets that start with
    -- a symbol like ```bash aren't having their ";" removed
    -- https://github.com/L3MON4D3/LuaSnip/discussions/895
    -- NOTE: THis extend_decorator works great, but I also tried to add the ";"
    -- prefix to all of the snippets loaded from friendly-snippets, but I was
    -- unable to do so, so I still have to use the transform_items in blink.cmp
    local extend_decorator = require("luasnip.util.extend_decorator")
    -- Create trigger transformation function
    local function auto_semicolon(context)
      if type(context) == "string" then
        --WARN: Removed the ; from inside the quotes as it was interfering with my JS, put it back if we have issues
        return { trig = "" .. context }
      end
      --WARN: Removed the ; from inside the quotes as it was interfering with my JS, put it back if we have issues
      return vim.tbl_extend("keep", { trig = "" .. context.trig }, context)
    end
    -- Register and apply decorator properly
    extend_decorator.register(ls.s, {
      arg_indx = 1,
      extend = function(original)
        return auto_semicolon(original)
      end,
    })
    local s = extend_decorator.apply(ls.s, {})

    -- local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local rep = require("luasnip.extras").rep

    -- Helper function to create code block snippets
    local function create_code_block_snippet(lang)
      return s({
        trig = lang,
        name = "Codeblock",
        desc = lang .. " codeblock",
      }, {
        t({ "```" .. lang, "" }),
        i(1),
        t({ "", "```" }),
      })
    end

    -- Define languages for code blocks
    local languages = {
      "txt",
      "lua",
      "sql",
      "go",
      "regex",
      "bash",
      "markdown",
      "markdown_inline",
      "yaml",
      "json",
      "jsonc",
      "cpp",
      "csv",
      "java",
      "javascript",
      "python",
      "dockerfile",
      "html",
      "css",
      "templ",
      "php",
      "ejs",
      "javascriptreact",
    }

    -- Generate snippets for all languages
    local snippets = {}

    for _, lang in ipairs(languages) do
      table.insert(snippets, create_code_block_snippet(lang))
    end

    table.insert(
      snippets,
      s({
        trig = "prettierignore",
        name = "Add prettier ignore start and end headings",
        desc = "Add prettier ignore start and end headings",
      }, {
        t({
          " ",
          "<!-- prettier-ignore-start -->",
          " ",
          "> ",
        }),
        i(1),
        t({
          " ",
          " ",
          "<!-- prettier-ignore-end -->",
        }),
      })
    )

    -- Basic Python script template
    table.insert(
      snippets,
      s({
        trig = "pythonex",
        name = "Basic Python script example",
        desc = "Simple Python script template",
      }, {
        t({
          "```python",
          "#!/usr/bin/env python3",
          "",
          "def main():",
          "    print('helix dizpython')",
          "",
          "if __name__ == '__main__':",
          "    main()",
          "```",
          "",
        }),
      })
    )

    ls.add_snippets("markdown", snippets)

    -- We can use the tab to jump from the one input to the other
    local js_snippets = {}

    table.insert(
      js_snippets,
      s({
        trig = "helloworld",
        name = "Hello World JS",
        desc = "JS Hello World Arrow Function",
      }, {
        t("const helloWorld = ("),
        i(1, "param"),
        t({ ") => {", "  return 'hello ' + " }),
        rep(1), -- Dynamically reuses the input from node 1
        t({ ";", "};", "console.log(hello(" }),
        i(2),
        t("));"),
      })
    )

    ls.add_snippets("javascript", js_snippets)

    local react_snippets = {}

    table.insert(
      react_snippets,
      s({
        trig = "{",
        name = "React Comment",
        desc = "React component comment",
      }, {
        t("{/* "),
        i(1, "Comment"),
        t(" */}"),
      })
    )

    ls.add_snippets("javascriptreact", react_snippets)

    local ejs_snippets = {}

    table.insert(
      ejs_snippets,
      s({
        trig = "<%=",
        name = "EJS Variable",
        desc = "Displays the value of the variable in your .ejs file",
      }, {
        t("<%= "),
        i(1, "var"),
        t(" %>"),
      })
    )
    table.insert(
      ejs_snippets,
      s({
        trig = "<%",
        name = "EJS expression",
        desc = "Allows for the use of expressions, loops and conditionals.",
      }, {
        t("<% "),
        i(1, "var"),
        t(" %>"),
      })
    )
    table.insert(
      ejs_snippets,
      s({
        trig = "<%-",
        name = "EJS template",
        desc = "Includes a template EJS file for re-usability.",
      }, {
        t("<%- include("),
        i(1),
        t(") %>"),
      })
    )

    table.insert(
      ejs_snippets,
      s({
        trig = "<%#",
        name = "EJS Comment",
        desc = "Allows the use of comments, seperating the end closing %>  on another line allows for multine comments.",
      }, {
        t("<%# "),
        i(1, "comment goes here"),
        t(" %>"),
      })
    )
    ls.add_snippets("html", ejs_snippets)
    return opts
  end,
}
