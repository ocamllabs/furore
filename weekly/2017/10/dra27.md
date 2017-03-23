** OCaml 4.05 **
- Fixed the FlexDLL bootstrap allowing ocamlmklib to work correctly (GPR#1023). The
  fix is targeted for 4.04.1 and required a separate version for 4.05/trunk owing to
  the (very welcome) build system alterations. Lots of test cases...
- Spent arguably too much time working on a test-case for the Unix.stat bug in GPR#1057.
  Interesting foray into kernel trickery on Windows (polite way of referring to disgusting
  code injection and re-writing tricks...)
