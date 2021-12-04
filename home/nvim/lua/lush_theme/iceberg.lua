--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is lua file, vim will append your file to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local hsl = lush.hsl

local colors = {
  bg = hsl("#000000");
  fg = hsl("#c6c8d1");

  black = hsl("#161821");
  light_black = hsl("#2f313c");
  grey = hsl("#c6c8d1");

  red = hsl("#e27878");
  light_red = hsl("#e98989");

  green = hsl("#b4be82");
  light_green = hsl("#c0ca8e");

  orange = hsl("#e2a478");
  light_orange = hsl("#e9b189");

  blue = hsl("#84a0c6");
  light_blue = hsl("#91acd1");

  magenta = hsl("#a093c7");
  light_magenta = hsl("#ada0d3");

  cyan = hsl("#89b8c2");
  light_cyan = hsl("#95c4ce");

  white = hsl("#d2d4de");
  yellow = hsl("#ebcb8b");
  purple = hsl("#b48ead");
  error = hsl("#bf616a");
}

local theme = lush(function()
  return {
    -- The following are all the Neovim default highlight groups from the docs
    -- as of 0.5.0-nightly-446, to aid your theme creation. Your themes should
    -- probably style all of these at a bare minimum.
    --
    -- Referenced/linked groups must come before being referenced/lined,
    -- so the order shown ((mostly) alphabetical) is likely
    -- not the order you will end up with.
    --
    -- You can uncomment these and leave them empty to disable any
    -- styling for that group (meaning they mostly get styled as Normal)
    -- or leave them commented to apply vims default colouring or linking.

    Comment      { fg=colors.light_black }, -- any comment
    ColorColumn  { fg=colors.fg, bg=colors.black }, -- used for the columns set with 'colorcolumn'
    Conceal      { fg=colors.light_black }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor       { fg=colors.fg }, -- character under the cursor
    -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn { fg=colors.fg, bg=colors.black }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine   { fg=colors.fg, bg=colors.black }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory    { fg=colors.blue }, -- directory names (and other special names in listings)
    DiffAdd      { fg=colors.black, bg=colors.green }, -- diff mode: Added line |diff.txt|
    DiffChange   { fg=colors.yellow, bg=colors.bg }, -- diff mode: Changed line |diff.txt|
    DiffDelete   { fg=colors.black, bg=colors.red }, -- diff mode: Deleted line |diff.txt|
    DiffText     { fg=colors.black, bg=colors.yellow }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer  { fg=colors.black }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    -- TermCursor   { }, -- cursor in a focused terminal
    -- TermCursorNC { }, -- cursor in an unfocused terminal
    ErrorMsg     { fg=colors.error }, -- error messages on the command line
    VertSplit    { fg=colors.black }, -- the column separating vertically split windows
    Folded       { fg=colors.light_black }, -- line used for closed folds
    FoldColumn   { fg=colors.black }, -- 'foldcolumn'
    SignColumn   { fg=colors.black }, -- column where |signs| are displayed
    IncSearch    { fg=colors.yellow, bg=colors.black}, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    LineNr       { fg=colors.light_black }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { fg=colors.white }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen   { fg=colors.light_blue }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    -- MoreMsg      { }, -- |more-prompt|
    NonText      { fg=colors.light_black }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal       { fg=colors.fg, bg=colors.bg }, -- normal text
    -- NormalFloat  { }, -- Normal text in floating windows.
    -- NormalNC     { }, -- normal text in non-current windows
    Pmenu        { fg=colors.white, bg=colors.black }, -- Popup menu: normal item.
    PmenuSel     { fg=colors.black, bg=colors.blue }, -- Popup menu: selected item.
    PmenuSbar    { fg=colors.white, bg=colors.black }, -- Popup menu: scrollbar.
    PmenuThumb   { fg=colors.black, bg=colors.white }, -- Popup menu: Thumb of the scrollbar.
    Question     { fg=colors.magenta }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine { fg=colors.black, bg=colors.yellow }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search       { fg=colors.black, bg=colors.yellow }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    SpecialKey   { fg=colors.light_black }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad     { fg=colors.error }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap     { fg=colors.yellow }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal   { fg=colors.yellow }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare    { fg=colors.yellow }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine   { fg=colors.white, bg=colors.black }, -- status line of current window
    StatusLineNC { fg=colors.light_black }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine      { fg=colors.light_black }, -- tab pages line, not active tab page label
    TabLineFill  { bg=colors.bg }, -- tab pages line, where there are no labels
    TabLineSel   { fg=colors.white }, -- tab pages line, active tab page label
    Title        { fg=colors.blue }, -- titles for output from ":set all", ":autocmd" etc.
    Visual       { bg=colors.light_black }, -- Visual mode selection
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg   { fg=colors.yellow }, -- warning messages
    Whitespace   { fg=colors.black }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu     { fg=colors.black, bg=colors.blue }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant       { fg=colors.blue }, -- (preferred) any constant
    String         { fg=colors.green }, --   a string constant: "this is a string"
    Character      { fg=colors.green }, --  a character constant: 'c', '\n'
    Number         { fg=colors.orange }, --   a number constant: 234, 0xff
    Boolean        { fg=colors.light_orange }, --  a boolean constant: TRUE, false
    Float          { fg=colors.red }, --    a floating point constant: 2.3e10

    Identifier     { fg=colors.light_blue }, -- (preferred) any variable name
    Function       { fg=colors.light_red }, -- function name (also: methods for classes)

    Statement      { fg=colors.purple }, -- (preferred) any statement
    Conditional    { fg=colors.purple }, --  if, then, else, endif, switch, etc.
    Repeat         { fg=colors.purple }, --   for, do, while, etc.
    Label          { fg=colors.purple }, --    case, default, etc.
    Operator       { fg=colors.purple }, -- "sizeof", "+", "*", etc.
    Keyword        { fg=colors.fg }, --  any other keyword
    Exception      { fg=colors.purple }, --  try, catch, throw

    PreProc        { fg=colors.light_orange }, -- (preferred) generic Preprocessor
    Include        { fg=colors.light_orange }, --  preprocessor #include
    Define         { fg=colors.light_orange }, --   preprocessor #define
    Macro          { fg=colors.light_orange }, --    same as Define
    PreCondit      { fg=colors.light_orange }, --  preprocessor #if, #else, #endif, etc.

    Type           { fg=colors.light_blue }, -- (preferred) int, long, char, etc.
    StorageClass   { fg=colors.light_blue }, -- static, register, volatile, etc.
    Structure      { fg=colors.light_blue }, --  struct, union, enum, etc.
    Typedef        { fg=colors.light_blue }, --  A typedef

    Special        { fg=colors.fg }, -- (preferred) any special symbol
    SpecialChar    { fg=colors.fg }, --  special character in a constant
    Tag            { fg=colors.red }, --    you can use CTRL-] on this
    Delimiter      { fg=colors.fg }, --  character that needs attention
    SpecialComment { fg=colors.fg }, -- special things inside a comment
    -- Debug          { }, --    debugging statements

    Underlined { gui="underline" }, -- (preferred) text that stands out, HTML links
    Bold       { gui="bold" },
    Italic     { gui="italic" },

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|
    Error          { fg=colors.error }, -- (preferred) any erroneous construct
    Todo           { fg=colors.magenta }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.

    LspReferenceText                     { fg=colors.fg }, -- used for highlighting "text" references
    LspReferenceRead                     { fg=colors.fg }, -- used for highlighting "read" references
    LspReferenceWrite                    { fg=colors.fg }, -- used for highlighting "write" references

    LspDiagnosticsDefaultError           { fg=colors.error }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultWarning         { fg=colors.yellow }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultInformation     { fg=colors.fg }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultHint            { fg=colors.light_black }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)

    LspDiagnosticsVirtualTextError       { fg=colors.error }, -- Used for "Error" diagnostic virtual text
    LspDiagnosticsVirtualTextWarning     { fg=colors.yellow }, -- Used for "Warning" diagnostic virtual text
    LspDiagnosticsVirtualTextInformation { fg=colors.fg }, -- Used for "Information" diagnostic virtual text
    LspDiagnosticsVirtualTextHint        { fg=colors.light_black }, -- Used for "Hint" diagnostic virtual text

    LspDiagnosticsUnderlineError         { fg=colors.error }, -- Used to underline "Error" diagnostics
    LspDiagnosticsUnderlineWarning       { fg=colors.yellow }, -- Used to underline "Warning" diagnostics
    LspDiagnosticsUnderlineInformation   { fg=colors.fg }, -- Used to underline "Information" diagnostics
    LspDiagnosticsUnderlineHint          { fg=colors.light_black }, -- Used to underline "Hint" diagnostics

    LspDiagnosticsFloatingError          { fg=colors.error }, -- Used to color "Error" diagnostic messages in diagnostics float
    LspDiagnosticsFloatingWarning        { fg=colors.yellow }, -- Used to color "Warning" diagnostic messages in diagnostics float
    LspDiagnosticsFloatingInformation    { fg=colors.fg }, -- Used to color "Information" diagnostic messages in diagnostics float
    LspDiagnosticsFloatingHint           { fg=colors.light_black }, -- Used to color "Hint" diagnostic messages in diagnostics float

    LspDiagnosticsSignError              { fg=colors.error }, -- Used for "Error" signs in sign column
    LspDiagnosticsSignWarning            { fg=colors.yellow }, -- Used for "Warning" signs in sign column
    LspDiagnosticsSignInformation        { fg=colors.fg }, -- Used for "Information" signs in sign column
    LspDiagnosticsSignHint               { fg=colors.light_black }, -- Used for "Hint" signs in sign column

    -- These groups are for the neovim tree-sitter highlights.
    -- As of writing, tree-sitter support is a WIP, group names may change.
    -- By default, most of these groups link to an appropriate Vim group,
    -- TSError -> Error for example, so you do not have to define these unless
    -- you explicitly want to support Treesitter's improved syntax awareness.

    TSAnnotation         { fg=colors.fg };    -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    TSAttribute          { fg=colors.cyan };    -- (unstable) TODO: docs
    TSBoolean            { fg=colors.light_orange };    -- For booleans.
    TSCharacter          { fg=colors.green };    -- For characters.
    TSComment            { fg=colors.light_black };    -- For comment blocks.
    TSConstructor        { fg=colors.fg };    -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
    TSConditional        { fg=colors.purple };    -- For keywords related to conditionnals.
    TSConstant           { fg=colors.blue };    -- For constants
    TSConstBuiltin       { fg=colors.blue };    -- For constant that are built in the language: `nil` in Lua.
    TSConstMacro         { fg=colors.blue };    -- For constants that are defined by macros: `NULL` in C.
    TSError              { fg=colors.error };    -- For syntax/parser errors.
    TSException          { fg=colors.purple };    -- For exception related keywords.
    TSField              { fg=colors.blue };    -- For fields.
    TSFloat              { fg=colors.red };    -- For floats.
    TSFunction           { fg=colors.light_blue };    -- For function (calls and definitions).
    TSFuncBuiltin        { fg=colors.magenta };    -- For builtin functions: `table.insert` in Lua.
    TSFuncMacro          { fg=colors.magenta };    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    TSInclude            { fg=colors.light_cyan };    -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    TSKeyword            { fg=colors.blue };    -- For keywords that don't fall in previous categories.
    TSKeywordFunction    { fg=colors.blue };    -- For keywords used to define a fuction.
    TSLabel              { fg=colors.fg };    -- For labels: `label:` in C and `:label:` in Lua.
    TSMethod             { fg=colors.light_blue };    -- For method calls and definitions.
    -- TSNamespace          { };    -- For identifiers referring to modules and namespaces.
    -- TSNone               { };    -- TODO: docs
    TSNumber             { fg=colors.orange };    -- For all numbers
    TSOperator           { fg=colors.white };    -- For any operator: `+`, but also `->` and `*` in C.
    TSParameter          { fg=colors.light_cyan };    -- For parameters of a function.
    TSParameterReference { fg=colors.light_cyan };    -- For references to parameters of a function.
    TSProperty           { fg=colors.fg };    -- Same as `TSField`.
    TSPunctDelimiter     { fg=colors.fg };    -- For delimiters ie: `.`
    TSPunctBracket       { fg=colors.fg };    -- For brackets and parens.
    TSPunctSpecial       { fg=colors.white };    -- For special punctutation that does not fall in the catagories before.
    TSRepeat             { fg=colors.purple };    -- For keywords related to loops.
    TSString             { fg=colors.light_green };    -- For strings.
    TSStringRegex        { fg=colors.light_green };    -- For regexes.
    TSStringEscape       { fg=colors.light_green };    -- For escape characters within a string.
    TSSymbol             { fg=colors.fg };    -- For identifiers referring to symbols or atoms.
    TSType               { fg=colors.light_cyan };    -- For types.
    TSTypeBuiltin        { fg=colors.blue };    -- For builtin types.
    TSVariable           { fg=colors.cyan };    -- Any variable name that does not have another highlight.
    TSVariableBuiltin    { fg=colors.cyan };    -- Variable names that are defined by the languages, like `this` or `self`.

    TSTag                { fg=colors.fg };    -- Tags like html tag names.
    TSTagDelimiter       { fg=colors.fg };    -- Tag delimiter like `<` `>` `/`
    TSText               { fg=colors.fg };    -- For strings considered text in a markup language.
    TSEmphasis           { fg=colors.fg };    -- For text to be represented with emphasis.
    TSUnderline          { fg=colors.fg };    -- For text to be represented with an underline.
    TSStrike             { fg=colors.fg };    -- For strikethrough text.
    TSTitle              { fg=colors.blue };    -- Text that is part of a title.
    TSLiteral            { fg=colors.green };    -- Literal text.
    TSURI                { fg=colors.fg };    -- Any URI like a link or email.

    NvimTreeRootFolder    { fg=colors.cyan };
    NvimTreeSpecialFile   { Normal };
    NvimTreeFileDirty     { fg=colors.orange };
    NvimTreeFileStaged    { fg=colors.magenta };
    NvimTreeFileMerge     { fg=colors.fg };
    NvimTreeFileRenamed   { fg=colors.light_cyan };
    NvimTreeFileNew       { fg=colors.green };
    NvimTreeFileDeleted   { fg=colors.red };
    NvimTreeGitDirty      { fg=colors.orange };
    NvimTreeGitStaged     { fg=colors.magenta };
    NvimTreeGitMerge      { fg=colors.fg };
    NvimTreeGitRenamed    { fg=colors.light_cyan };
    NvimTreeGitNew        { fg=colors.green };
    NvimTreeGitDeleted    { fg=colors.red };

    diffAdded     { fg = colors.green };
    diffRemoved   { fg = colors.red };
    diffChanged   { fg = colors.blue };
    diffOldFile   { fg = colors.fg };
    diffNewFile   { fg = colors.fg };
    diffFile      { fg = colors.cyan };
    diffLine      { fg = colors.magenta };
    diffIndexLine { fg = colors.purple };

    GitGutterAdd          { fg=colors.green };
    GitGutterChange       { fg=colors.yellow };
    GitGutterDelete       { fg=colors.red };
    GitGutterChangeDelete { fg=colors.magenta };

    GitSignsAdd      { fg=colors.green };
    GitSignsChange   { fg=colors.yellow };
    GitSignsDelete   { fg=colors.red };
    GitSignsAddNr    { fg=colors.green };
    GitSignsChangeNr { fg=colors.yellow };
    GitSignsDeleteNr { fg=colors.red };

    TelescopeBorder         {fg=colors.light_black};
    TelescopePromptBorder   {fg=colors.blue};
    TelescopeMatching       {fg=colors.red};
    TelescopeSelection      {fg=colors.blue};
    TelescopeSelectionCaret {fg=colors.blue};
    TelescopeMultiSelection {fg=colors.cyan};

    CmpItemAbbr { fg = colors.grey };
    CmpItemAbbrMatch { fg = colors.yellow };
  }
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
