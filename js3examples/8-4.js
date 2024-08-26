// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

// Define a constructor method for our class.
// Use it to initialize properties that will be different for
// each individual circle object.
function Circle(x, y, r)
{
    this.x = x;  // The X-coordinate of the center of the  circle
    this.y = y;  // The Y-coordinate of the center of the circle
    this.r = r;  // The radius of the circle
}

// Create and discard an initial Circle object.
// This forces the prototype object to be created in Navigator 3.
new Circle(0,0,0);

// Define a constant: a property that will be shared by
// all circle objects. Actually, we could just use Math.PI,
// but we do it this way for the sake of example.
Circle.prototype.pi = 3.14159;

// Define a method to compute the circumference of the circle.
// First declare a function, then assign it to a prototype property.
// Note the use of the constant defined above.
function Circle_circumference() { return 2 * this.pi * this.r; }
Circle.prototype.circumference = Circle_circumference;

// Define another method. This time we use the Function()
// constructor to define the function and assign it to a prototype
// property all in one step.
Circle.prototype.area = new Function("return this.pi * this.r * this.r;");

// The Circle class is defined.
// Now we can create an instance and invoke its methods.
var c = new Circle(0.0, 0.0, 1.0);
var a = c.area();
var p = c.circumference();
