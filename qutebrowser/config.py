config.load_autoconfig()

# hint images and yank the URL
config.bind(';y', 'hint images yank')

# caret mode: cursor movement (selection extends in selection mode)
config.bind('j', 'move-to-next-line', mode='caret')
config.bind('k', 'move-to-prev-line', mode='caret')

# caret mode: scroll viewport without moving cursor
config.bind('J', 'scroll down', mode='caret')
config.bind('K', 'scroll up', mode='caret')

