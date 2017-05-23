## OCaml
- Various exchanges regarding the GPR#1127/GPR#1168/GPR#1172 build system changes
- 4.05 testing leading to a few tweaks (GPR#1177)
- Fixes pushed to trunk and 4.05 fixing Inria CI (MacOS, mingw32/64, ppc32/64)

## opam
- Oozing towards being able to run the make win-zips test on Azure.
  * Various build system tweaks required, especially dealing with Warning 58
    (-opaque not used) in third party libs
  * msvs-tools needs updating for VS2017 and integrating - turns out that's
    not just a simple meta-data change (there's a new tool called vswhere
    which needs to be integrated with msvs-detect)
- PR#2935 merged; various work rebasing and keeping up with the others
- Complete sweep of open opam issues (now subscribed to all changes)
