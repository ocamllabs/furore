#### Decompress

I released the new 0.7 version of decompress. I currently work on a
good API about javascript. I found some API in the npm repository but
these API seems to be imperative - and it's not the case decompress.

NOTE: I think, it's imperative because it's just a FFI with zlib
directly (without convenience computation).

#### Digestif

I just finish to implement the BLAKE2S function and test it and merge
it. I currently look about benchmark with Louis and provide something
to test and compare with ocp-sha.

About the test, I just look what is it exactly and we have lot of
litterature to test SHA-*, BLAKE2{b,s} and RIPEMD160 implementation.
So, I will integrate all.

#### Callipyge

cfcs catched a bug about Callipyge, it does not work. So, I think, I
will re-implement it from the reference implementation.

#### OCaml Git

I just implemented the fetch command on the HTTP protocol. Now, I can
start to implement the push command on the HTTP protocol. Louis asks
me about the current implementation of my PR and he tried to test it.

Obviously, I did not work yet on the polishement of opam file and we
need to pin digestif and a specific version of angstrom (which has my
fix). Then, he compiled ocaml-git without error but it's not easy, I
started to figure about opam file.

Again, I fixed some bugs specifically about reference (between
absolute path of the reference and relative path) and the PACK decoder
which handles an empty PACK file now.

I cleaned the smart decoder and delete the redundant code and
understand what is specifically the diff between the Smart protocol
and the Smart HTTP protocol - because, in the Git documentation, we
don't have any explanation about that.
