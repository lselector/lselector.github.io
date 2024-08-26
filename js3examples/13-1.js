// This example is from JavaScript: The Definitive Guide, 3rd Edition.
// That book and this example were Written by David Flanagan.
// They are Copyright (c) 1996, 1997, 1998 O'Reilly & Associates.
// This example is provided WITHOUT WARRANTY either expressed or implied.
// You may study, use, modify, and distribute it for any purpose,
// as long as this notice is retained.

// Here's a function that uses the alert() method to tell the user
// that form submission will take some time, and that the user should
// be patient. It would be suitable for use in the onSubmit event handler
// of an HTML form. 
// Note that all formatting is done with spaces, newlines, and underscores.
function warn_on_submit()
{
    alert("\n__________________________________________________\n\n" +
          "                   Your query is being submitted...\n"    +
          "__________________________________________________\n\n"   +
          "Please be aware that complex queries such as yours\n"     +
          "     can require a minute or more of search time.\n\n"    +
          "                         Please be patient.");
}

// Here is a use of the confirm() method to ask if the user really
// wants to visit a web page that takes a long time to download. Note that
// the return value of the method indicates the user response. Based
// on this response, we reroute the browser to an appropriate page.

var msg = "\nYou are about to experience the most\n\n" +
          "                -=| AWESOME |=-\n\n" +
          "Web page you have ever visited!!!!!!\n\n" +
          "This page takes an average of 15 minutes to\n" +
          "download over a 28.8K modem connection.\n\n" +
          "Are you ready for a *good* time, Dude????";

if (confirm(msg)) 
    location.replace("awesome_page.html");
else
    location.replace("lame_page.html");

// Here's some very simple code that uses the prompt() method to get
// a user's name, and then uses that name in dynamically generated HTML.
n = prompt("What is your name?", "");
document.write("<hr><h1>Welcome to my home page, " + n + "</h1><hr>");
