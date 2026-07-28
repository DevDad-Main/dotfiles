config.load_autoconfig()

# hint images and yank the URL
config.bind(';y', 'hint images yank')

# caret mode: cursor movement (selection extends in selection mode)
config.bind('j', 'move-to-next-line', mode='caret')
config.bind('k', 'move-to-prev-line', mode='caret')

# caret mode: scroll viewport without moving cursor
config.bind('J', 'scroll down', mode='caret')
config.bind('K', 'scroll up', mode='caret')

# Ctrl+j/k for cycling completion items (like emacs/nvim)
config.bind('<Ctrl+j>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl+k>', 'completion-item-focus prev', mode='command')

# Ctrl+j/k for cycling prompt dialogs (save/yes/no etc.)
config.bind('<Ctrl+j>', 'prompt-item-focus next', mode='prompt')
config.bind('<Ctrl+k>', 'prompt-item-focus prev', mode='prompt')

