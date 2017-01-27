**Monday**

Setting up Angstrom: I follow the readme instructions, ignoring the initial opam install as the package is not yet released.

 `opam pin add -n angstrom .
  opam install --deps-only angstrom`

Which goes fine.

I want to use vim to explore the source but it complains that it doesn't have alcotest, so I fix that:
```
 opam install alcotest
  [...]
  Building fmt.0.8.0:
  ocaml pkg/pkg.ml build --pinned false --with-base-unix true --with-cmdliner true
  Installing fmt.0.8.0.
  [ERROR] 'pinned' has type bool, but a env element of type string was expected`
```

Messing around with versions settles on alcotest.0.4.1 as one that works. I run the config and make commands without incident.

Spent the rest of the day surveying Angstrom, OCaml internals and practising more Vim.

**Tuesday**

Wrote simple test parser for balanced parentheses using Angstrom. Went surprisingly smoothly - my previous experimentation with parser combinators and monads earlier in the year has clearly paid off.

Wrote initial version of ANSIparse - first test results in out-of-memory from infinite loop somewhere. !!

Rewrote the grammar and the code, still need to rewrite testing code and do the tests.

**Wednesday**

Continued rewrite a few times. Became apparent during testing that I had misread the format codes and fixed that. Got a working parser from string -> (style list * string) list, eg

```
`"Hello, \x1b[1mBrave, \x1b[4;31mNew \x1b[0mWorld!"`

to

`[ ( []                    , "Hello, " );
  ( [Bold]                , "Brave, " );
  ( [Underline; Fore Red] , "New "    );
  ( [Reset]               , "World!"  ); ]`
```

Now I need to work on the structuring, i.e. converting to HTML. There is already implicit structure; (styles, str) :: rest applies styles in order to str AND, implicitly, rest. However, the presence of Reset turns things off. I wonder how useful it would be to try and extract some tree structure from this data by e.g. matching styles and Resets.

**Thursday**

Today, worked on making the parser incremental, in that it works a line at a time given its intended use. Ran into some more unpleasant infinite-loop bugs; one of which was of the form

```
`Items --> Item*
Item --> Escape | Text
Text --> char*`
```

So we can derive "HELLO" as

```
Items --> Item* --> Text* --> Text --> "HELLO", or
Items --> Item* --> Text* --> Text Text* --> "HELLO" "", or "HELLO" "" "", etc... and never finishing
```

So I had to add lookahead whereby the parser for Text fails if it will read the empty string (because it's at the end of input).

**Friday**

Split into concrete (text) and abstract (tree) modules for later use. Had a look at TyXml.
