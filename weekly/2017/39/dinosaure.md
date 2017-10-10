#### Decompress

Simple afl test finished, I will start a complex test which test
level, window size and others parameters of decompress.

#### Digestif

I push a mlilib branch to explain to thomas what is the problem to
have a `digestif` library which contains only the mli file.

#### OCaml Git

So from the last discussion we show a problem about the minimal API
and how to store a PACK file for the memory back-end and the
file-system back-end.

From a discussion with @samoht, we decide to abstract the PACK file
for the shared interface as a stream. In the file-system back-end, we
took the stream, do some computation (like if the PACK file is a
/thin/ PACK file or not) and, produce the IDX file and save it in the
.git/objects/pack/ directory.

This is a big change from the previous API which populate the git
repository with /loose/ files.

From this big change, I reorganize the PACK engine which takes care
about how to handle available PACK files of the git repository in the
file-system back-end. I optimized the memory consumption when we need
to undelta-ify an object.

The process now is more clear and documented:
* Firstly, we load only the IDX file to know which Git objects are
  available in which PACK file
* Then, when the user request a Git project stored in a PACK file, we
  start to compute some informations - like the biggest object, the
  max depth, how many bytes we need to store hunks, etc.

  From these informations, we grow the state-defined buffer to allow
  to undelta-ify any object from the specific PACK file without any
  allocation.

  However, we continue to have a _memory leak_ (it's not but the
  memory consumption is not predictable at this point) we the pack
  file need an external ressource (so, a thin pack).
* Finally, we can do a second pass to know if the pack file is a thin
  pack or not (and grow the state-defined buffer in consequence)

In memory back-end, we continue to populate from the pack stream, the
git repository. We don't have yet an abstraction of the pack file in
the memory back-end.

However, and it's the purpose of the new API, because we abstract a
PACK file received by the external world as a stream, we let the
back-end to choose the best way to store the pack file (in memory, it
will be a [Cstruct.t] and in file-system, it's a file).

I switched the [Sync_http] protocol to use this abstraction and now
it's more easy to handle a PACK file in the protocol - because, now,
the back-end handles the pack file and not the protocol.

I will switch the [Sync] protocol too but it will be easy.

Finally, for the file-system back-end, when it receives a PACK file,
it tries to know if the pack file is thin or not. In the first case,
we generate a new non-thin pack file (as git) and in the second case,
we just generate the IDX file and move from the temporary directory
the pack file to the git repository.

However, about all, I catched a bug about the CRC-32 checksum and try
now to fix the bug. I did not push my change because I want to fix
this weird bug because.
