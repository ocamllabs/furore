#### Decompress

I fix a bug about the window bits.  Indeed,  the zlib format only allow a window
bits between 8  and 15.  Then,  I launched a  test about that and we  have a big
bug,  I put  this in  my TODO.  In  fact,  when we work  on a  zlib flow  with a
specific window bits  (<> 15),  the inflater (the decompression)  does not works
with  my  deflater  (the compression).  But  (and  it's  why  it's  very weird),
`camlzip` works with  my input - so  the bug is only available  for the inflater
and we need to keep the size of the window  to `1 << 15` bytes and not to the `1
<< window_bits` (with  `window_bits` is a value from  the zlib header).  So it's
about the window inside the inflater.

Another  weird things  is with  this change,  the  inflate for  a flat  flow (no
compression,  so no distance,  so no need to use the window) does not work.  So,
yes,  it's w.t.f and I  need to focus on that one big time  - because the bug is
very deep.

But, I did a release of Decompress now.  It's stable and I integrate this change
in Canopy!

I test by my  hand the window size/level/flush method with  my alcotest to avoid
any write  in any file.  So  I launched like  35 000  tests with  Decompress and
compare with camlzip and all is ok. I think Decompress is robust :) .

#### `ocaml-git`/`sirodepac`

I find an another serious bug about `ocaml-git` and `sirodepac`.  It's about the
size of  the pack-file.  In fact,  the offset  delivered by the IDX  file can be
stored inside a  int64 variable.  That means the  offset can be huge  and can be
upper than what OCaml can store inside a bigstring/string.

I found this problem  in `cohttp` when it's possible to send  a huge file by the
HTTP protocol (like a video of Game Of Thrones).  So,  by this constraint,  it's
mandatory (if we want to compute all PACK file)  to work on a flow of chunk of a
PACK   file  -   because  the   PACK   file   can   be   (easily)   bigger  than
[Sys.max_string_length] and in  this case,  we need to compute  the PACK to some
chunk of [Sys.max_string_length].

But `sirodepac` handles that!  When we compute a PACK file,  we can compute this
by some chunk.  However, it's about the delta-fied object. In this case, we need
to compute  entirely the PACK  file because the  offset can be  absolute (if the
hunks refer to a hash) but in the main case,  the offset is relative and we need
to know if this relative offset can't be bigger than [Sys.max_string_length].

It's a  complexe problem  and I  will discuss  in the  hackaton about  that with
Thomas to know what is the best way to compute an huge PACK file.

About the Merkle tree,  I  don't find a good case to use  that so ...  I go away
from that.

About `ocaml-d3`, no time.

I  fix   the  bug   with  SHA1  and   I  verify   my  implementation   with  the
encoder/decoder.  All is  ok and I  test `sirodepac` with  a big PACK  file from
linux.  That means  the decoder and  the encoder are  good -  we produce  a good
output from a  good input and the SHA  produced is correct,  another thing,  the
offset of the  SHA1 (from the IDX  file) correspond to the offset  of my parser.
So, my program is reliable :) !

I will retake  an old project,  `Digestif` to implement  the digest function for
the new  Hash of `git`.  I spoke  with Thomas about that  and we find  a mail to
explain what happens for  `git` after we can break the SHA1  and the new hash is
BLAKE2b.  So,  for the hackathon, I will implement that.  I spoke with hannes to
know if it's  cool to insert this new  hash in Nocrypto but we  think it's a bad
idea (and, obviously, I don't find any BLAKE2b implementation in OCaml).

#### Farfadet

I spoke with Seliopou and we fixed somethings in `Farfadet`.  It's an high level
interface of `Faraday`.  So we decided to  create a new repository about that in
top of `Faraday`.

You can look the project at: https://github.com/oklm-wsh/Farfadet

#### Mr. MIME

Nothing about that.  I  spoke with rgrinberg about the interface  and I keep all
things of my TODO.
