# Emacs (dadmacs config) Cheat Sheet

## Cancel / Escape
| Key | Action |
|---|---|
| `C-g` | **Cancel everything** (your escape hatch) |

## Movement
| Key | Action |
|---|---|
| `C-j` / `C-k` | next / previous line |
| `C-n` / `C-p` | newline / kill-line (Emacs default swapped) |
| `C-f` / `C-b` | forward / backward char |
| `M-f` / `M-b` | forward / backward word |
| `C-a` / `C-e` | start / end of line |
| `M-a` / `M-e` | sentence backward / forward |
| `M-}` / `M-{` | paragraph forward / backward |
| `C-v` / `M-v` | scroll down / up |
| `M-<` / `M->` | start / end of buffer |

## Editing
| Key | Action |
|---|---|
| `C-d` | delete char forward |
| `M-d` | kill word |
| `C-k` | kill to end of line |
| `C-y` | yank (paste) |
| `M-y` | cycle through yank history (after C-y) |
| `C-/` or `C-x u` | undo |
| `C-?` | redo |
| `C-w` | kill region (cut) |
| `M-w` | copy region |
| `C-o` | open line below |
| `C-x C-o` | delete blank lines around point |
| `M-\\` | delete whitespace around point |

## Selection
| Key | Action |
|---|---|
| `C-space` | start selection (set mark) |
| `C-x C-x` | exchange point and mark |
| `M-@` | mark next word |
| `M-h` | mark paragraph |
| `C-x h` | select all |

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
