#### Decompress

From the last complete afl fuzzer (which add the level and the windows
bits argument), all looks fine. I catched a bug but it seems this bug
is come from afl (and not decompress) which described by the issue #8.

I talk with Mindy about that, she already know this bug and ask me to
try the fuzzer with an other version of afl-persistent.

So, I wait the end of the fuzzer to make a release as I said but
nothing to declare about bugs in decompress for the moment!

#### Digestif

So, the implementation of BLAKE2s appeared in the PR #14, it should
works from some local tests. @cfcs ask me to add some tests from the
reference implementation of BLAKE2s, some tests about RIPEMD160 and
others useful inputs. However, he found a *bug* about the build
system. Indeed, the test can not be automated easily if we want to
test with the C implementation and the OCaml implementation. He
suggere in the PR #16 to test the OCaml implementation.

So, I will figure about this when jbuilder#136 is done.

Then, @samoht found a way to provide a mli library and use it to link
with a library (like ocaml-git). Then, the git library need to be
linked with `digestif.c` or `digestif.ocaml` to provide the
implementation.

This PR waits the jbuilder#136 issue again.

#### Farfadet

Update to the new API of Faraday and add a constraint in the opam repository.

#### TypeBeat

Update to the new API of Angstrom.

#### OCaml Git

I added the fold function (come from the Irmin implementation) to
traverse a Git repository and complete an accumulator (specially to
generate a list of entries to pack then). So, it's a function provided
in the minimal API - the implementation is the same between the
file-system back-end and the memory back-end to avoid any semantic
diff between back-end and this function.

Then, I tested the `git-bomb` repository with ocaml-git. I fixed some
bugs about the URI and we can clone, read, write in this repository
without memory leak. I generated a dot file of this git repository
then. So, no problem about this repo for ocaml-git!

I added the ogit-cat-file and the ogit-http-ls binary as ogit did
previously and clear some module like the Revision module and the Sync
module to use the minimal interface instead the file-system back-end.
