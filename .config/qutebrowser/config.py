# Silence some linting/LSP warnings and errors
# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401
config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103

from os.path import expanduser

config.load_autoconfig(True)

services = {
    "invidious": "https://vid.puffyan.us",
    "nitter": "https://nitter.net",
}

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
    'file://' + expanduser('~/any/startpage/index.html'),
]

c.confirm_quit = ["multiple-tabs", "downloads"]

c.content.headers.accept_language = 'es-VE,es,en-US,en'
c.content.autoplay = False
c.content.prefers_reduced_motion = True

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
c.qt.chromium.low_end_device_mode = 'always'
c.qt.chromium.process_model = 'process-per-site'

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
    'nt':      services["nitter"] + '/search?q={}',
    # Nitter handle
    'nth':     services["nitter"] + '/{unquoted}',
    'iv':      services["invidious"] + '/search?q={}',

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

c.window.title_format = '{private}{perc}{current_title}{title_sep}qutebrowser'

# Disable mouse wheel zoom
c.zoom.mouse_divider = 0

# Always prefer english content for specific sites
# TODO: Somehow redirect already localized urls to en-US
config.set('content.headers.accept_language', 'en-US,en;q=0.9', 'developer.mozilla.org')

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
config.bind('xs', 'open qute://back')

# Use google search
config.bind('<Alt-o>', 'set-cmd-text -s :open g')
config.bind('<Alt-Shift-o>', 'set-cmd-text -s :open -t g')

# Yank github repo as "user/repo"
config.bind('yg', 'spawn --output-messages --userscript yank-github-repo')
config.bind('yG', 'spawn --output-messages --userscript yank-github-repo --primary')

# Clear selection highlight
config.bind('<Ctrl-l>', 'jseval --quiet window.getSelection().removeAllRanges()')

for res in [100, 200, 300, 400]:
    config.bind(f";v{str(res)[0]}", 
                f"hint links spawn --output-messages --userscript video-queue {{hint-url}} {res}")
    config.bind(f";V{str(res)[0]}", 
                f"hint --rapid links spawn --output-messages --userscript video-queue {{hint-url}} {res}")

config.source("colors.py")
