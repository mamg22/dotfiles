// ==UserScript==
// @name           Terna.net tweaks
// @namespace      mamg22's userscripts
// @match          *://uptamca.terna.net/*
// @run-at         document-start
// ==/UserScript==

function remove_yt(ev) {
    console.log(ev.type);

    var src_regex = /^https:\/\/www\.youtube\.com\/embed.*/;
    var iframes = document.getElementsByTagName('iframe');

    for (var iframe of iframes) {
        if (src_regex.test(iframe.src)) {
            console.log(iframe);
            iframe.remove();
        }
    }
}

function remove_jq(ev) {
    console.log(ev.type);
    var src_regex = /.*jquery.*/;
    var scripts = document.getElementsByTagName('script');

    /*
    for (var script of scripts) {
        if (src_regex.test(script.src)) {
            console.log(script);
            script.remove();
        }
    }
    */
}

function remove_header(ev) {
    console.log(ev.type);
    var header = document.querySelector('.logo-cliente-bold');
    header.remove();
}

window.addEventListener('DOMContentLoaded', remove_yt);
window.addEventListener('DOMContentLoaded', remove_jq);
window.addEventListener('DOMContentLoaded', remove_header);
