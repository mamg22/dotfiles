config.load_autoconfig(True)

c.aliases = {
    'w': 'session-save',
    'q': 'quit',
    'wq': 'quit --save',
    'h': 'help --tab',
}

# c.completion.delay = 1000
c.completion.web_history.exclude = [
    '*://duckduckgo.com/*',
    '*://www.google.com/*',
    'https://www.reddit.com/*/search',
    'qute://pdfjs/*',
    '*://uptamca.terna.net/index.php',
    'https://invidious.kavin.rocks/videoplayback',
]

c.confirm_quit = ["multiple-tabs", "downloads"]

c.content.headers.accept_language = 'es-VE,es,en'
c.content.autoplay = False

c.editor.command = ['st', '-e', 'nvim', '{file}', '-c', 'normal {line}G{column0}l']

c.fonts.default_size = '9pt'
c.fonts.web.family.sans_serif = 'Liberation Sans'
c.fonts.web.family.standard = 'Liberation Sans'
c.fonts.web.size.default = 15

c.hints.border = '1px solid #928374'
# Reddit expando
c.hints.selectors['expando'] = ['.expando-button']
# Reddit and Hacker News comment toggles
c.hints.selectors['comment'] = ['.expand', '.togg']
c.hints.selectors['any'] = ['*']
c.hints.uppercase = True

c.qt.force_software_rendering = 'qt-quick'
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
searchengines = {
    # General search engines
    'd':       'https://duckduckgo.com/?q={}',
    'g':       'https://www.google.com/search?&q={}',

    # Wikis and reference sites
    'aw':      'https://wiki.archlinux.org/?search={}',
    'w':       'https://es.wikipedia.org/?search={}',
    'ew':      'https://en.wikipedia.org/?search={}',
    'cpp':     'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={}',
    'ud':      'https://www.urbandictionary.com/define.php?term={}',
    'kym':     'https://knowyourmeme.com/search?q={}',
    'mdn':     'https://developer.mozilla.org/en-US/search?q={}',

    # Reddit
    'r':       'https://www.reddit.com/search?q={}',
    # Go to specified subreddit (allows passing /new, ?t=all, and others
    'sr':      'https://www.reddit.com/r/{unquoted}',
    'ru':      'https://www.reddit.com/user/{unquoted}',

    # Github
    'gh':      'https://github.com/search?q={}',
    # Jump to github repo or user
    'ghr':     'https://github.com/{unquoted}',

    # Nitter & invidious
    'nt':      'https://nitter.kavin.rocks/search?q={}',
    # Nitter handle
    'nth':     'https://nitter.kavin.rocks/{unquoted}',
    'iv':      'https://invidious.kavin.rocks/search?q={}',

    # Other
    'yt':      'https://www.youtube.com/results?search_query={}',
    'fd':      'https://search.f-droid.org/?q={}',
    'wf':      'https://www.wolframalpha.com/input/?i={}',
    'hn':      'https://hn.algolia.com/?q={}',
    # Fedora packages (and more) sources
    'fsr':     'https://src.fedoraproject.org/search?term={}',
    'ml':      'https://listado.mercadolibre.com.ve/{}',
}
searchengines['DEFAULT'] = searchengines['g']
c.url.searchengines = searchengines
c.url.start_pages = '~/any/startpage/index.html'

# Disable mouse wheel zoom
c.zoom.mouse_divider = 0

tab_rotate = [
    'config-cycle --temp --print tabs.position top right',
    'config-cycle --temp tabs.title.format "{audio}{index}: {current_title}" "{aligned_index}"',
    'config-cycle --temp tabs.title.alignment left center',
]

def join_commands(command_list):
    return ' ;; '.join(command_list)

# Toggle GUI parts
config.bind('xr', join_commands(tab_rotate))
config.bind('xt', 'config-cycle --temp --print tabs.show multiple switching never')
config.bind('xb', 'config-cycle --temp --print statusbar.show never always')

# Hints
config.bind(';e', 'hint expando')
config.bind(';E', 'hint --rapid expando')
config.bind(';c', 'hint comment')
config.bind(';C', 'hint --rapid comment')

# Suspend tabs
#config.bind('xs', 'spawn --userscript suspend')
config.bind('xs', 'open qute://back')

# Use google search
config.bind('<Alt-o>', 'set-cmd-text -s :open g')
config.bind('<Alt-Shift-o>', 'set-cmd-text -s :open -t g')

# Yank github repo as "user/repo"
config.bind('yg', 'spawn --output-messages --userscript yank-github-repo')
config.bind('yG', 'spawn --output-messages --userscript yank-github-repo --primary')

config.source("colors.py")
