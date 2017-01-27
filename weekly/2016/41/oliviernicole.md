: I finished merging branch `4.04` into `macros`, but the repo is not functional
  yet: I get a segfault on `utils/clflags.ml` when bootstrapping. Strangely,
  printf-debugging pointed the segfault to happen on a call to `open_in_bin`
  inside `Bytelink.load_object`, although several successful calls have been
  made to `open_in_bin` during the execution. This suggests that the global data
  containing the Pervasives module has been somehow corrupt.
* Tuesday  
: A lot of time spent fighting with the built system and trying to find the
  cause of my bug(s), without success.
* Wednesday  
: Since `macros` was based on `trunk`, I shouldn't have used `merge` to rebase
  it on `4.04`, since changes from `trunk` have been introduced on `4.04`.
  In order to rebase macros on `4.04` without having to resolve conflicts on
  each commit (which would be necessary to keep the commit history), I had to
  squash all the macro-related commits into one commit, and cherry-pick that
  commit onto `4.04`.
* Thursday  
: Conflicts solved and `.depend` files updated. `make coreall` works but the
  segfault on `open_in_bin` is back. What's more, when trying to compile some
  dummy file with a static printf in it, the compiler segfaults in
  `Symtable.update_global_data`, more specifically on the operation:
  `glob.(slot) <- transl_const cst`
  where `glob` is `Meta.global_data ()`. I checked, it's not an out-of-bounds
  segfault.
  Another segfault I'm currently tracking is on a call to
  `Pervasives.output_string` (or `output_char`, one of the two).
* Friday  
: Today, meeting with Mort and Anil to check the progress of macros. I need to
  start writing down ideas of applications.
  The runtime segfaults on the following line while executing the instruction
  APPTERM2: `pc = Code_val(accu);`
  Where `accu` has been set by the previous instruction: `PUSHGETGLOBALFIELD Pervasives, 48`
