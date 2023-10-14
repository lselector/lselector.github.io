// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

// Define the constructor. 
// Note how it initializes the object referred to by "this".
function Rectangle(w, h)
{
    this.width = w;
    this.height = h;
}

// Invoke the constructor to create two rectangle objects.
// Notice that we pass the width and height to the constructor, so it
// can initialize each new object appropriately.
var rect1 = new Rectangle(2, 4);
var rect2 = new Rectangle(8.5, 11);
