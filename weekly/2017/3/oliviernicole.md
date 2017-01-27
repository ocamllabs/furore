* Work done on lambda quoting: combinators are in place, now Translquote has to
  use them properly, i.e. the path arguments given to macros must become
  `lambda` instances (and not `Longident.t` instances).

* After the last fixes on module type discovery, it seems that the compiler is
  now fully (except for syntax) backward-compatible, in the sense that projects
  that don't use macros should have the same dependency tree in 4.04 and in
  4.04+macros.

* My fork of Camlp4 now compiles on the macro switch.

* Some reflexion on Flick and looking at the code of motto.

* Flick: added a few elements in the DSL for channel declarations. For now,
  channels are implemented as a `'i option ref * 'o option ref` in the
  interpreter (i.e. a 1-capacity channel). Trying to replicate the program
  (https://github.com/NaaS/motto/blob/master/tests/runtime/factorial.ml)[factorial.ml].

* Flick: add operations on channels, temporarily implement channels in terms of
  two references on lists (for incoming and outgoing data) and write my first
  "embedded" Flick program using the unstaged interpreter. This program doesn't
  use processes.

* Macros: Introduced a new constructor `Lescape` to denote when a piece of
  lambda code should not be lifted when constructing a lambda quote. My current
  problem is: how to construct Parsetree quotes and lambda quotes in the same
  recursion without doing a lot of pairing/unpairing?
