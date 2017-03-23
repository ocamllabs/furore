** OPAM **
- First attempt at rebasing onto Beta 2 (stuck at lib-pkg merge)

** OCaml 4.05**
- Reviewing fix for GPR#861 relating to a DST-bug in Unix.stat on Windows.
  Far too much time spent reading MSDN and grep'ing source code of old CRTs...
- Cygwin-32 fork crash. Moving mmap functions from Bigarray to Unix has broken
  Cygwin fork (reliable test case). Far too much time spent reading Cygwin
  source code - it's not yet clear whether this is a Cygwin bug, a FlexDLL bug
  or an OCaml bug...
