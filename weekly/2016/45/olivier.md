* Monday (2016-11-07)  
: Laptop still in repair, spent all day trying to get a desktop PC as a
  replacement. Will use one of the lab shared computers from now on.  
* Tuesday  
: Added a new `value_kind` for macros and made the typechecker tag macros with
  it.
* Wednesday  
: Stopped keeping track of cross-stage identifiers in the typing environment.
  Instead, iterate through the typed tree to find them in a expression when
  needed.  
During the Compiler hacking event at Pembroke, paired with Maxime to work on
signatured opens (https://github.com/ocamllabs/compiler-hacking/wiki/Things-to-work-on#signatured-open-command); we're about halfway through it.
* Thursday  
: Add support (parser and typechecker) for macros in signatures.
* Friday  
: Add a closure argument to macros, yet unused.
