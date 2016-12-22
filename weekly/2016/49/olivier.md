**Compiler**

* The compiler "without placeholders" (and thus without useless static
  dependencies) now broadly works, i.e. I was able to bootstrap (necessary
  because adding an argument to one constructor of `Path.t` changed the cmi
  format) and compile `re` (a regexp library that previously didn't compile
  because of dependency issues).
* Fixed some tests, including `warnings/w53.ml` and other easy things. My
  changes appear to have broken recursive modules again (assertion failed in
  `CamlinternalMod`).
* Fixed some tests involving recursives modules, but not all of them, by fixing
  the `init_shape` function.
* Changed the lifting symbol to `~` (which unlike `^` should be non-breaking) in
  order to break less Opam packages.
* Fixed various issues and bugs with the new system of coercion. It seems quite
  robust, all tests are passed (except `no-alias-deps/aliases.cmo` but that's
  for a completely different reason, and was expected), and a lot of code from
  Opam compiles fine.
* Fixed priority of "illegal quoting" errors over phase errors after drup's
  remarks

**Examples using macros**  
* I try to make a fork of camlp4 compile again, but I encountered a bug that
  wasn't caught by the tests.
* A segfault occurs when running static code for the main source file of camlp4.
  Investigating on the issue.
* Started to look at the Flick network DSL, and its OCaml implementation Motto,
  and whether it can benefit from compile-time metaprogramming.
* Menhir is a dependency of motto, and doesn't compile because of wrong
  dependency tree — can be fixed by not translating type extensions into static
  code
* Talked with Mort about networking examples. It would be nice to be able to
  optimize a packet stream processor like POF or P4 using staging (maybe trying
  to use or get inspiration from strymonas).
