# Emacs (rexim config) Cheat Sheet

## Cancel / Escape
| Key | Action |
|---|---|
| `C-g` | **Cancel everything** (your escape hatch) |

## Movement (CUSTOM — swapped from defaults)
| Key | Action |
|---|---|
| `C-j` | **down** (was `C-n`) |
| `C-k` | **up** (was `C-p`) |
| `C-f` / `C-b` | forward / backward char |
| `C-n` | newline-and-indent (was `C-j`) |
| `C-p` | kill line (was `C-k`) |
| `M-f` / `M-b` | forward / backward word |
| `M-}` / `M-{` | forward / backward paragraph |
| `C-v` / `M-v` | page down / page up |
| `M-<` / `M->` | start / end of buffer |
| `M-g g` | go to line number |
| `C-l` | recenter screen |
| `C-a` / `C-e` | start / end of line |
| `M-m` | first non-whitespace on line |

## Editing
| Key | Action |
|---|---|
| `C-d` | delete char forward |
| `M-d` | delete word forward |
| `C-p` | kill to end of line (kill-line) |
| `M-k` | kill to end of sentence |
| `C-w` | cut (kill region) |
| `M-w` | copy |
| `C-y` | paste (yank) |
| `M-y` | cycle yank history (after `C-y`) |
| `C-_` (or `C-/`) | undo |
| `C-u C-space` | jump back to previous position |
| `M-p` / `M-n` | move line up / down |
| `C-,` | duplicate line |
| `C-t` | transpose chars |
| `M-t` | transpose words |
| `M-u` / `M-l` | uppercase / lowercase word |

## Selection (visual mode equivalent)
| Key | Action |
|---|---|
| `C-space` (or `C-@`) | set mark (start selection) |
| *then move cursor* | selection extends |
| `C-x C-x` | exchange point and mark (like `o` in vim) |
| `C-x h` | select all |
| `M-h` | select paragraph |
| `C-w` | cut selected |
| `M-w` | copy selected |
| `C-g` | cancel selection |

Rectangle / block selection (like vim `C-v`): `M-x rectangle-mark-mode` or `C-x SPC`

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
| `C-n` / `C-p` | move through list (or `M-n` / `M-p`) |
| `TAB` or `RET` | select |
| `C-g` | cancel |

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
