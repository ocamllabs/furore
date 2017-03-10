Many multicore yaks now bald.

  - Atomics module exists! (or part thereof)
  - Got the multicore test suite running properly, and integrated with Travis. Fixed a bunch of issues with the testsuite and the runtime.
  - Added GC stats in multicore (functions in `Gc` now work, and account properly for every word of the shared major heap). Found a bug in trunk OCaml while doing this, now fixed in trunk and 4.05.
  - Fixed heap verification in multicore (in particular, debug mode now checks at runtime that the GC stats aren't lies)
  - Got some pull requests to trunk OCaml merged (#1088, #1069, #973)
