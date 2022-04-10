// ==UserScript==
// @name           Terna.net tweaks
// @namespace      mamg22's userscripts
// @match          *://uptamca.terna.net/*
// @run-at         document-start
// ==/UserScript==

function remove_yt(ev) {
    var src_regex = /^https:\/\/www\.youtube\.com\/embed.*/;
    var iframes = document.getElementsByTagName('iframe');

    for (var iframe of iframes) {
        if (src_regex.test(iframe.src)) {
            console.log(iframe);
            iframe.remove();
        }
    }
}

function remove_header(ev) {
    var header = document.querySelector('.logo-cliente-bold');
    header.remove();
}

window.addEventListener('DOMContentLoaded', remove_yt);
window.addEventListener('DOMContentLoaded', remove_header);
