// We define some simple functions here.
function add(x,y) { return x + y; }
function subtract(x,y) { return x - y; }
function multiply(x,y) { return x * y; }
function divide(x,y) { return x / y; }

// Here's a function that takes one of the above functions
// as an argument and invokes it on two operands.
function operate(operator, operand1, operand2)
{
    return operator(operand1, operand2);
}

// We could invoke this function like this to compute the value (2+3) + (4*5):
var i = operate(add, operate(add, 2, 3), operate(multiply, 4, 5));

// For the sake of example, we implement the functions again, this time
// using function literals. We store the functions in an associative array.
var operators = new Object();
operators["add"] = function(x,y) { return x+y; };
operators["subtract"] = function(x,y) { return x-y; };
operators["multiply"] = function(x,y) { return x*y; };
operators["divide"] = function(x,y) { return x/y; };
operators["pow"] = Math.pow;  // works for predefined functions too.

// This function takes the name of an operator, looks up that operator
// in the array, and then invokes it on the supplied operands. Note 
// the syntax used to invoke the operator function.
function operate2(op_name, operand1, operand2)
{
    if (operators[op_name] == null) return "unknown operator";
    else return operators[op_name](operand1, operand2);
}

// We could invoke this function as follows to compute
// the value ("hello" + " " + "world"):
var j = operate2("add", "hello", operate2("add", " ", "world"))
// Using the predefined Math.pow() function
var k = operate2("pow", 10, 2)
