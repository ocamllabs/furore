**Monday**
- Experimenting with Notty to make the shell interactive, for things like tab completion.
- Notty doesn't seem to support applications that aren't full screen terminal when capturing key presses. For example utop allows tab completion while still being scrollable. Notty generally seems to be more for graphics. lambda-term should support this but also has a lot of stuff that I probably don't need.
- Notty also doesn't appear to clean up the terminal after ctrl + c, leaves mouse interaction on etc. And ctrl c can't be intercepted.
- Actually it does allow capturing scrolling events and mouse position, so maybe I can implement scrolling manually instead, but not ideal.

**Tuesday**
- Would be good to handle unterminated input - e.g. if string doesn't have a closing quote or if the line ends in a backslash then go to the next line. Requires some support in the lexer.
- Notty assumes unicode throughout so I will too. Supporting unicode by storing input as an int list and using that when lexing and printing back to the terminal.
- I'm currently lexing and parsing the entire input on each keystroke, as I need to know the meaning of the input to be able to do prediction. Not really ideal but usually commands are so short that it might not matter. I might have a go at making it more efficient anyway.

**Wednesday**
- I spent today trying to figure out a better way of supporting completions by trying to only lex the part of the input that changes and swap out the affected tokens. I got it sort of working but it was buggy and had lots of mutable state so I gave up on it, at least for now.

**Thursday**
- Notty will only capture input events when using a single screen (not scrollable) terminal application, so using print doesn't work as it's quickly overwritten when redrawing the screen. This would be fine as I could just return a string and handle printing elsewhere, but as a lot of the stuff with ocaml-9p is asynchronous I might want to print during executing the command to let the user know what's happening. Which means I might have to take another look at Lambda-term.
- In terms of supporting completions, I had a look at Cmdliner as it parses the arguments and automatically checks if an arg is a file or an int etc, which would be useful information for prediction. Would be cool to be able to pass the Cmdliner data to this shell and have prediction done automatically, but unfortunately not really possible.
- I can add a small amount of stuff to add prediction to an existing program that uses Cmdliner (or something else). Basically just two functions (one for named args and one for positional args) that map a prefix to a list of possibilities.

**Friday**
- Got most things working together today, commands now work properly. Still haven't actually got the actual interface working yet though...
