**Monday**
- Rewrote a lot of the code as I was using quite a bit of mutable state. For example, using an array to store the current input. Now storing it as two int lists (ints as characters are unicode), the first representing the input before the cursor (stored in reverse), and the second representing the input after the cursor. Lots of other changes as well.
**Tuesday**
- Some more rewriting. Code a lot terser and almost no mutability.
- Managed to get Notty working with scrolling etc by disabling canonical mode myself then passing the input from stdin into the notty module to filter escape sequences. A bit of a hack but it means I can use notty and have proper scrolling etc, and don't have to redraw everything each time.
- Still a few things that are only half working. For example tab completion is kind of there but not actually 'wired up'.
**Wednesday**
- Not much to log, just starting to get the shell working with ocaml-9p, rather than just the couple of small examples I've been using so far.
- I've written the shell to be synchronous at the moment, which won't work well with things like ocaml-9p, so I'm going to change it to use Lwt throughout.
