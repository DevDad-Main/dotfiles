# Emacs (dadmacs config) Cheat Sheet

## Cancel / Escape
| Key | Action |
|---|---|
| `C-g` | **Cancel everything** (your escape hatch) |

## Movement (Evil mode — vim keys in normal mode)
| Key | Action |
|---|---|
| `j` / `k` | down / up |
| `h` / `l` | left / right |
| `w` / `b` | word forward / backward |
| `e` | end of word |
| `0` / `$` | start / end of line |
| `gg` / `G` | start / end of buffer |
| `^` | first non-whitespace |
| `{` / `}` | paragraph up / down |
| `C-d` / `C-u` | half page down / up |
| `C-f` / `C-b` | full page down / up

## Editing (normal mode)
| Key | Action |
|---|---|
| `i` / `a` / `o` | insert / append / open line below |
| `I` / `A` | insert at start / end of line |
| `dd` | delete line |
| `yy` | yank (copy) line |
| `p` / `P` | paste below / above |
| `x` | delete char |
| `dw` / `cw` | delete / change word |
| `ciw` / `ci(` / `ci"` | change inside word / parens / quotes |
| `diw` / `da(` | delete inside word / around parens |
| `u` / `C-r` | undo / redo |
| `.` | repeat last action |

## Selection (visual mode)
| Key | Action |
|---|---|
| `v` | character-wise visual |
| `V` | line-wise visual |
| `C-v` | block visual (like rectangle) |
| `y` | yank (copy) selected |
| `d` | delete selected |
| `c` | change selected |
| `>` / `<` | indent / dedent |
| `~` | toggle case |

## Files
| Key | Action |
|---|---|
| `C-x C-f` | open file |
| `C-x C-s` | save |
| `C-x C-w` | save as |
| `C-x C-c` | quit (prompts `y-or-n`) |
| `M-x revert-buffer` | reload file from disk |

## Buffers
| Key | Action |
|---|---|
| `C-x b` | switch buffer (ido) |
| `C-x C-b` | list buffers (ibuffer) |
| `C-x k` | kill buffer |
| `C-x s` | save all buffers |

## Windows (splits)
| Key | Action |
|---|---|
| `C-x 2` | split horizontal |
| `C-x 3` | split vertical |
| `C-x 0` | close current window |
| `C-x 1` | close other windows (keep current) |
| `C-x o` | next window |
| `C-x O` | previous window |
| `C-x ^` | enlarge window vertically |
| `C-x }` | widen window horizontally |
| `M-x winner-mode` | then `C-c left` / `C-c right` to undo/redo window changes |

## Search
| Key | Action |
|---|---|
| `C-s` | search forward (incremental) |
| `C-r` | search backward |
| `C-s C-s` | repeat last search |
| `M-%` | query replace |
| `M-x replace-string` | simple replace |

## Completion menu (company — pops up as you type)
| Key | Action |
|---|---|
| `C-M-i` | manually trigger completion |
| `C-n` / `C-p` or `M-n` / `M-p` | move through list |
| `TAB` or `RET` | select |
| `C-g` | cancel |

## Ido navigation (`C-x C-f`, `C-x b`, etc.)
| Key | Action |
|---|---|
| `C-n` / `C-p` | next / previous option |
| `C-h` / `C-l` | next / previous option (alternative) |
| `C-f` | fallback to normal find-file |
| `C-b` / `C-d` | go up directory / delete backward |
| `TAB` | complete |
| `RET` | select |

## LSP / Eglot (pyright for Python)
| Key | Action |
|---|---|
| `M-.` | go to definition |
| `M-,` | find references |
| `C-c r` | rename symbol |
| `M-g M-n` | next flymake error |
| `M-g M-p` | previous flymake error |
| `M-x eglot-code-actions RET` | show available fixes on error line |
| `M-x eglot-format RET` | format code |
| `M-x flymake-show-project-diagnostics RET` | list all errors in project |
| `M-x eglot RET` | manually start eglot (if auto-start fails) |

Pro tip: place cursor on a red-underlined line and run `M-x eglot-code-actions` for auto-fixes.

## Navigation (programming)
| Key | Action |
|---|---|
| `C-c i m` | imenu — jump to function/class/def |
| `M-g g` | go to line number |
| `C-s` `func_name` | search for text |
| `C-a` / `C-e` | start / end of line |
| `M-f` / `M-b` | word forward / backward |
| `C-u C-space` | jump back to previous position |

## Custom: Helm (file finding)
| Key | Action |
|---|---|
| `C-c h f` | find file (with preview) |
| `C-c h r` | recent files |

Helm navigation: `C-n`/`C-p` or `M-n`/`M-p` to move, `TAB` to preview, `RET` to open.

## Custom: Magit (git)
| Key | Action |
|---|---|
| `C-c m s` | magit status |
| `C-c m l` | magit log |

## Custom: Multiple cursors
| Key | Action |
|---|---|
| `C->` | mark next like this |
| `C-<` | mark previous like this |
| `C-c C-<` | mark all like this |
| `C-S-c C-S-c` | edit lines |

## Dired (file manager)
| Key | Action |
|---|---|
| `C-x d` | open dired |
| `q` | quit (back to previous buffer) |
| `RET` / `e` | open file/dir |
| `^` | up to parent dir |
| `n` / `p` | next / previous line |
| `m` / `u` | mark / unmark |
| `d` | flag for delete |
| `x` | execute flagged |
| `g` | refresh |

## M-x (smex — fuzzy command palette)
- Just type to filter
- `C-n`/`C-p` or `M-n`/`M-p` to move through results
- `RET` to run
- Works even for commands you don't know the key for

## Naviation (word-level)
| Key | Action |
|---|---|
| `M-f` / `M-b` | forward / backward word (to start of word) |
| `C-c e` | end of current word (like vim `e`) |

## Misc extras
| Key | Action |
|---|---|
| `M-x calc` | built-in calculator |
| `C-x C-g` | find file at point |
| `C-c M-q` | unfill paragraph |
| `C-x p d` | insert timestamp |
| `C-x p s` | grep selected text |
| `M-x compile RET` | run compile command |
