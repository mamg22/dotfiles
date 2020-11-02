# Iceberg colorscheme

c.aliases = {
    'w': 'session-save',
    'q': 'quit',
    'wq': 'quit --save',
}

c.backend = 'webengine'

c.completion.delay = 1000

c.confirm_quit = ["multiple-tabs", "downloads"]

c.content.headers.accept_language = 'es-VE,es'

c.editor.command = ['st', '-e', 'nvim', '{file}', '-c', 'normal {line}G{column0}l']

c.fonts.default_size = '9pt'
c.fonts.web.family.sans_serif = 'Liberation Sans'
c.fonts.web.family.standard = 'Liberation Sans'
c.fonts.web.size.default = 15

c.hints.border = '1px solid #6b7089'
c.hints.chars = 'asdfghjkl'
c.hints.mode = 'letter'
c.hints.uppercase = True

c.qt.low_end_device_mode = 'always'

c.scrolling.smooth = False

c.session.lazy_restore = True

c.statusbar.position = 'bottom'
c.statusbar.show = 'always'

c.tabs.background = True
c.tabs.indicator.padding = {
    'top': 2,
    'bottom': 2,
    'left': 0,
    'right': 4
}
c.tabs.indicator.width = 2
c.tabs.last_close = 'default-page'
c.tabs.mousewheel_switching = False
c.tabs.padding = {
    'top': 0,
    'bottom': 0,
    'left': 4,
    'right': 4
}
c.tabs.position = 'top'
c.tabs.show = 'multiple'
c.tabs.title.alignment = 'left'
c.tabs.title.format = '{audio}{index}: {current_title}'
c.tabs.width = '5%'

c.url.default_page = '~/any/startpage/index.html'
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'd':       'https://duckduckgo.com/?q={}',
    'aw':      'https://wiki.archlinux.org/?search={}',
    'w':       'https://es.wikipedia.org/?search={}',
    'ew':      'https://en.wikipedia.org/?search={}',
    'g':       'https://www.google.com/search?&q={}',
    # Go to given subreddit
    'sr':      'https://reddit.com/r/{unquoted}',
    'r':       'https://www.reddit.com/search?q={}',
    'yt':      'https://www.youtube.com/results?search_query={}',
    'gh':      'https://github.com/search?q={}',
    'ud':      'https://www.urbandictionary.com/define.php?term={}',
    'kym':     'https://knowyourmeme.com/search?q={}',
    'cpp':     'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={}',
    'iv':      'https://invidious.snopyta.org/search?q={}',
    'fd':      'https://search.f-droid.org/?q={}',
    'nt':      'https://nitter.net/search?q={}',
    # Nitter handle
    'nth':      'https://nitter.net/{unquoted}',
    # Jump to github repo or user
    'ghr':     'https://github.com/{unquoted}',
}
c.url.start_pages = '~/any/startpage/index.html'

# Disable mouse wheel zoom
c.zoom.mouse_divider = 0

tab_rotate = [
    'config-cycle tabs.position top right',
    'config-cycle tabs.title.format "{audio}{index}: {current_title}" "{aligned_index}"',
    'config-cycle tabs.title.alignment left center',
    'set tabs.position?',
]

tab_show_cycle = [
    'config-cycle tabs.show multiple switching never',
    'set tabs.show?',
]

bar_show_toggle = [
    'config-cycle statusbar.show never always',
    'set statusbar.show?',
]

def join_commands(command_list):
    return ' ;; '.join(command_list)

config.bind('xr', join_commands(tab_rotate))
config.bind('xt', join_commands(tab_show_cycle))
config.bind('xb', join_commands(bar_show_toggle))

config.source("colors.py")
