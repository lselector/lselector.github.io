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
