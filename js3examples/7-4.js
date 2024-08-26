// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

function checkargs() {
    // arguments.caller.callee is the Function object that called us.
    // Its arity property is the number of arguments that were expected.
    var expected = arguments.caller.callee.arity;
    // arguments.caller is the arguments object of the function that
    // called us. Its length property is the number of actual args passed.
    var passed = arguments.caller.length;

    // If they don't match, do some fancy regular expression work to get
    // the name of the calling function, and display a warning.
    if (passed != expected) {
      var funcname = arguments.caller.callee.toString().match(/function (\w*)/)[1];
      alert("WARNING:\n" +
          funcname + "() " + "was invoked with wrong number of arguments!\n" +
          "Expected " + expected + " arguments, but passed " + passed);
    }
}

// Here is a test function that uses checkargs().
function f(x,y,z) { checkargs(); return x+y+z; }
f(1,2,3);        // Passed the right number of arguments
f(1,2);          // Passed too few arguments; checkargs() displays a warning.
