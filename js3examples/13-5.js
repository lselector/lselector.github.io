// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

/*
 * This function parses comma-separated name=value argument pairs from
 * the query string of the URL. It stores the name=value pairs in 
 * properties of an object and returns that object.
 */
function getArgs() {
    var args = new Object();
    var query = location.search.substring(1);  // Get query string.
    var pairs = query.split(",");              // Break at comma.
    for(var i = 0; i < pairs.length; i++) {
	var pos = pairs[i].indexOf('=');       // Look for "name=value".
	if (pos == -1) continue;               // If not found, skip.
	var argname = pairs[i].substring(0,pos);  // Extract the name.
	var value = pairs[i].substring(pos+1); // Extract the value.
	args[argname] = unescape(value);          // Store as a property.
    }
    return args;                               // Return the object.
}

/*
 * We could have used getArgs() in the previous bouncing window example
 * to parse optional animation parameters from the URL.
 */
var args = getArgs();                 // Get arguments.
if (args.x) x = parseInt(args.x);     // If arguments are defined...
if (args.y) y = parseInt(args.y);     // ... override default values.
if (args.w) w = parseInt(args.w);
if (args.h) h = parseInt(args.h);
if (args.dx) dx = parseInt(args.dx);
if (args.dy) dy = parseInt(args.dy);
if (args.interval) interval = parseInt(args.interval);
