#!/usr/bin/env python3

# Based on the script at
# https://github.com/qutebrowser/qutebrowser/issues/4242#issuecomment-424402174
#
# Updated to fix a changed key in the query and made it standalone instead
# of a userscript using qutebrowser's api

import sqlite3
from os.path import expanduser
from sys import argv

home_dir = expanduser('~')
data_dir = home_dir + '/.local/share/qutebrowser'

# Use custom path if provided as argument
if len(argv) > 1:
    data_dir = argv[1]

cookies_path = data_dir + "/webengine/Cookies"
export_cookies_txt_path = data_dir + "/webengine/Cookies.txt"

with sqlite3.connect(cookies_path) as conn:
    conn = sqlite3.connect(cookies_path)
    c = conn.cursor()

    print("Opened database ({%s) successfully" % cookies_path)

    cursor = c.execute("select host_key, path, is_secure, expires_utc, name, value from cookies")
    with open(export_cookies_txt_path, "w") as cookies:
        ftstr = ["FALSE", "TRUE"]

        cookies.write("""\
# Netscape HTTP Cookie File
# http://www.netscape.com/newsref/std/cookie_spec.html
# This is a generated file!  Do not edit.  """)

        for item in cursor.fetchall():
            item_3_3 = int(item[3])
            item_3 = ""
            if item_3_3 == 0:
                item_3 = "0"
            else:
                item_3 = str(round(int(item[3]) / 1000000 - 1164473600))

            cookies.write("%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % (
                item[0], ftstr[item[0].startswith('.')],
                item[1], ftstr[item[2]], item_3, item[4], item[5]))
