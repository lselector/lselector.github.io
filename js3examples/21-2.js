// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

// This function requests the UniversalBrowserRead privilege to enable
// it to read the array elements of the History object.
function openHistoryWindow() {
    // Open a new window.
    var w = window.open("", "historyWindow", 
                        "width=500,height=300,menubar,resizable");
    var d = w.document;

    // Request a privilege.
    netscape.security.PrivilegeManager.enablePrivilege("UniversalBrowserRead");

    // Output the browsing history of this window as links in the new window.
    for(var i = 0; i < history.length; i++) {
        d.write('<A TARGET="new" HREF="' + history[i] + '">');
        d.write(history[i]);
        d.writeln('</A>');
    }
    d.close();

    // Return the new window.
    return w;

    // The privilege is automatically disabled when this function returns.
}
