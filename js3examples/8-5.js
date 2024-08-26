// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

function Circle(radius) {   // The constructor defines the class itself.
    // r is an instance variable; defined and initialized in the constructor.
    this.r = radius;
}

// Circle.PI is a class variable--it is a property of the constructor function.
Circle.PI = 3.14159;
 
// Here is a function that computes a circle area.
function Circle_area() { return Circle.PI * this.r * this.r; }
// Here we make the function into an instance method by assigning it
// to the prototype object of the constructor. Remember that, for
// compatibility with Navigator 3, we have to create and discard 
// one object before the prototype object exists.
new Circle(0);
Circle.prototype.area = Circle_area;

// Here's another function. It takes two circle objects as arguments and
// returns the one that is larger (has the larger radius). 
function Circle_max(a,b) {
    if (a.r > b.r) return a;
    else return b;
}

// Since this function compares two circle objects, it doesn't make sense as 
// an instance method operating on a single circle object. But we don't want
// it to be a standalone function either, so we make it into a class method
// by assigning it to the constructor function:
Circle.max = Circle_max;

// Here is some code that uses each of these fields:
var c = new Circle(1.0);      // Create an instance of the Circle class.
c.r = 2.2;                    // Set the r instance variable.
var a = c.area();             // Invoke the area() instance method. 
var x = Math.exp(Circle.PI);  // Use the PI class variable in our own computation.
var d = new Circle(1.2);      // Create another Circle instance.
var bigger = Circle.max(c,d); // Use the max() class method.
