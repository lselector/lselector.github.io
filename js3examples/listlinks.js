// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

/*
 * FILE: listlinks.js
 * List all links in the specified document in a new window.
 */
function listlinks(d) {
    var newwin = window.open("", "linklist", 
                    "menubar,scrollbars,resizable,width=600,height=300");

    for (var i = 0; i < d.links.length; i++) {
        newwin.document.write('<A HREF="' + d.links[i].href + '">')
	newwin.document.write(d.links[i].href);
	newwin.document.writeln("</A><BR>");
    }
    newwin.document.close();
}
