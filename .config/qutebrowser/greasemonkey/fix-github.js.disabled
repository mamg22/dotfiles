// ==UserScript==
// @name           Github fix for QtWebEngine 5.9.5
// @namespace      something
// @match          http://*.github.com/*
// @match          https://*.github.com/*
// @run-at         document-start
// ==/UserScript==

// This creates a dummy AbortController that makes modern versions of
// github work with QtWebEngine 5.9.*

class AbortController {
    constructor() {
    }
    
    abort() {
    }
}

Object.defineProperty(self, 'AbortController', {
writable: true,
enumerable: false,
configurable: true,
value: AbortController
});
