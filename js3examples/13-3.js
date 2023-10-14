// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

/*
 * File: browser.js
 * Include with: <SCRIPT SRC="browser.js"></SCRIPT>
 * 
 * A simple "sniffer" that determines browser version and vendor.
 * It creates an object named "browser" that is easier to use than
 * the "navigator" object.
 */
// Create the browser object.
var browser = new Object();

// Figure out the browser major version.
browser.version = parseInt(navigator.appVersion);

// Now figure out if the browser is from one of the two
// major browser vendors. Start by assuming it is not.
browser.isNavigator = false;
browser.isIE = false;
if (navigator.appName.indexOf("Netscape") != -1) 
    browser.isNavigator = true;
else if (navigator.appName.indexOf("Microsoft") != -1)
    browser.isIE = true;
