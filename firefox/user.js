user_pref("browser.download.dir", "C:\\Users\\martijn\\Downloads\\Browser");


// gamepad API: what is W3C smoking??? Seriously, there is a unhealthy passion
// for doing everything in a browser
// concerns: again, UI elements though here they pose far less a privacy threat
// than e.g sensors/battery/location/speech
// ref: http://www.w3.org/TR/gamepad/
user_pref("dom.gamepad.enabled", false);

// VR devices: ditto, currently off merely due to experimental status and may
// become on by default soon, which we don't want
// ref: https://developer.mozilla.org/en-US/Firefox/Releases/36#Interfaces.2FAPIs.2FDOM
user_pref("dom.vr.enabled", false);

// Default search engine
// I use duckduckgo as it is reasonably complete and the least invasive as far
// as we know
// Replace by your favorite
user_pref("browser.search.defaultenginename", "DuckDuckGo");
user_pref("browser.search.geoSpecificDefaults", false);
user_pref("browser.search.order.1", "DuckDuckGo");
user_pref("browser.search.order.2", "Wikipedia");
user_pref("browser.search.order.3", "Bing");
user_pref("browser.search.order.4", "Google");

//Show browser history above search results
user_pref("browser.urlbar.matchBuckets", "general:5,suggestion:Infinity");

// Permanently disable Flash; no comment needed.
// Can't believe that Firefox still enables this for all the poor legacy
// websites out there
// Note it is redundant on good Linux distros (e.g Arch/Debian) as they don't
// install it by default
// ref: too many to count!
user_pref("plugin.state.flash", 0);

// Remove universally loathed Pocket integration
// ref: https://support.mozilla.org/en-US/kb/save-web-pages-later-pocket-firefox
user_pref("browser.pocket.enabled", false);
// Since Firefox 45 or so need to do some more chicanery
user_pref("extensions.pocket.enabled", false);

//This is not the first runr
user_pref("app.normandy.first_run", false);

//Remove google from pinned
user_pref("browser.newtabpage.pinned", "[]");

//Obvious
user_pref("browser.tabs.warnOnClose", false);

// devtools as a new window
user_pref("devtools.toolbox.host", "window");

// userChrome editing
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.debugger.remote-enabled", true);