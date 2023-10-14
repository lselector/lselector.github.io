// First, define some functions that will be used as methods.
function Rectangle_area() { return this.width * this.height; }
function Rectangle_perimeter() { return 2*this.width + 2*this.height; }
function Rectangle_set_size(w,h) { this.width = w; this.height = h; }
function Rectangle_enlarge() { this.width *= 2; this.height *= 2; }
function Rectangle_shrink() { this.width /= 2; this.height /= 2; }

// Then define a constructor method for our Rectangle objects.
// The constructor initializes properties and also assigns methods.
function Rectangle(w, h)
{
    // Initialize object properties.
    this.width = w;
    this.height = h;

    // Define methods for the object.
    this.area = Rectangle_area;
    this.perimeter = Rectangle_perimeter;
    this.set_size = Rectangle_set_size;
    this.enlarge = Rectangle_enlarge;
    this.shrink = Rectangle_shrink;
}
// Now, when we create a rectangle, we can immediately invoke methods on it:
var r = new Rectangle(2,2);
var a = r.area();
r.enlarge();
var p = r.perimeter();
