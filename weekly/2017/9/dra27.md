_Ill for most of the week :( _

** OCaml Labs **
- Preliminary discussions with @avsm, @gemmag on moving the CI into the lab.

** OCaml 4.05 **
- Cygwin fork issue fixed! Patch accepted upstream to the Cygwin DLL. Issue was
  that when DLLs are dlopen'd using FlexDLL, the dependencies between them are not
  known to Cygwin/Windows. Cygwin contained a dependency-based topological sort which
  was unstable for DLLs with no dependencies: the effect was that even calls to fork
  would work (as the list is reversed each time). DLL rebasing meant that the problem
  wasn't apparent on Cygwin64, but with correctly based DLLs, the same problem occurred.
  OCaml docs will be updated once the new Cygwin DLL has been released to note that the
  minimum version.
