import netscape.javascript.*

public void init()
{
    // Get the JSObject representing the applet's browser window.
    JSObject win = JSObject.getWindow(this);

    // Run JavaScript with eval(). Careful with those nested quotes!
    win.eval("alert('The CPUHog applet is now running on your computer. " +
             "You may find that your system slows down a bit.');");
}
