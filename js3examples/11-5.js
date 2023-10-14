// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

// Return true if object o is an instance of class (constructor) c.
function instanceOf(o, c) {
    var p = o.__proto__;
    while(p != null) {
        if (p == c.prototype) return true;
        p = p.__proto__;
    }
    return false;
}
