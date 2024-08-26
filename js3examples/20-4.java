// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

import netscape.javascript.*

public void init()
{
    // Get the JSObject representing the applet's browser window.
    JSObject win = JSObject.getWindow(this);

    // Run JavaScript with eval(). Careful with those nested quotes!
    win.eval("alert('The CPUHog applet is now running on your computer. " +
             "You may find that your system slows down a bit.');");
}
