# For compatibility with newer versions
try:
    config.load_autoconfig(False)
except:
    pass

c.aliases = {
    'w': 'session-save',
    'q': 'quit',
    'wq': 'quit --save',
}

# c.completion.delay = 1000
c.completion.web_history.exclude = [
    '*://duckduckgo.com/*',
    '*://www.google.com/*',
    'https://www.reddit.com/*/search',
    'qute://pdfjs/*',
]

c.confirm_quit = ["multiple-tabs", "downloads"]

c.content.headers.accept_language = 'es-VE,es,en'

c.editor.command = ['st', '-e', 'nvim', '{file}', '-c', 'normal {line}G{column0}l']

c.fonts.default_size = '9pt'
c.fonts.web.family.sans_serif = 'Liberation Sans'
c.fonts.web.family.standard = 'Liberation Sans'
c.fonts.web.size.default = 15

c.hints.border = '1px solid #6b7089'
# Reddit expando
c.hints.selectors['expando'] = ['.expando-button']
# Reddit and Hacker News comment toggles
c.hints.selectors['comment'] = ['.expand', '.togg']
c.hints.selectors['any'] = ['*']
c.hints.uppercase = True

c.qt.low_end_device_mode = 'always'
c.qt.process_model = 'process-per-site'

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
    'sr':      'https://www.reddit.com/r/{unquoted}',
    'r':       'https://www.reddit.com/search?q={}',
    'ru':      'https://www.reddit.com/user/{unquoted}',
    'yt':      'https://www.youtube.com/results?search_query={}',
    'gh':      'https://github.com/search?q={}',
    'ud':      'https://www.urbandictionary.com/define.php?term={}',
    'kym':     'https://knowyourmeme.com/search?q={}',
    'cpp':     'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={}',
    'iv':      'https://invidious.snopyta.org/search?q={}',
    'fd':      'https://search.f-droid.org/?q={}',
    'nt':      'https://nitter.net/search?q={}',
    # Nitter handle
    'nth':     'https://nitter.net/{unquoted}',
    # Jump to github repo or user
    'ghr':     'https://github.com/{unquoted}',
    'wf':      'https://www.wolframalpha.com/input/?i={}',
    'hn':      'https://hn.algolia.com/?q={}',
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

# Toggle GUI parts
config.bind('xr', join_commands(tab_rotate))
config.bind('xt', join_commands(tab_show_cycle))
config.bind('xb', join_commands(bar_show_toggle))

# Hints
config.bind(';e', 'hint expando')
config.bind(';E', 'hint --rapid expando')
config.bind(';c', 'hint comment')
config.bind(';C', 'hint --rapid comment')

# Suspend tabs
config.bind('xs', 'spawn --userscript suspend')

config.source("colors.py")
