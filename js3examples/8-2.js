// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

// This function uses the this keyword, so it doesn't make sense to
// invoke it by itself; it needs instead to be made a method of some
// object that has "width" and "height" properties defined.
function compute_area()
{
    return this.width * this.height;
}

// Create a new Rectangle object, using the constructor defined earlier.
var page = new Rectangle(8.5, 11);

// Define a method by assigning the function to a property of the object.
page.area = compute_area;

// Invoke the new method like this:
var a = page.area();    // a = 8.5*11 = 93.5
