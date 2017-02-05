#### Work on the implementation in Decompress

Move the  implementation of  the compression (deflate)  in the  same way  of the
decompression.  With the work of Yallop, the implementation of _blosclz_ and the
advises of Thomas,  I  try to use a  pure state for the  Lz77 compression (first
layer of Decompress) and the Zlib compression  (second layer of Decompress) to use
this implementation in `ocaml-git` to pack a git state.

For the  moment,  I have a  non-blocking implementation of  the Lz77 compression
with theses changes:
* pure state
* non-blocking computation
* remove a  compute  of  a  window  -  that  means  when  the algorithm search a
pattern,  we limit to  the  input  of  the  user.  So,  if  the user compute the
compression with a chunk of 4096  bytes (for example),  we search a pattern only
on this chunk  (but  theorically,  we  can  keep  ~  28671  bytes) and the ratio
between the literal and the distance for this compression will be bad.  But,  in
a practical world,  we compute  the compression with a chunk of  32K bytes - and
in this way, we have an optimal compression.

Finally,  for a file  (like  an  executable),  we  have  a  ratio  about 1/3 for
literals  and  2/3  for  matches  -   so  2/3  of  compression  without  Huffman
compression.

Now,  I attack  the Zlib (Huffman) compression  in the same way  (pure state and
non-blocking) to get the new release of Decompress.

#### ocaml.org

I try to  find a bug inside  ocaml.org about the feed  generator (OCaml Planet).
In the same time,  I found lot of website with a bad or unaccesible feed.  So, I
sent an e-mail  to advise some persons  about that - like the  website of Mirage
or ocaml.io.

Chris00 fixed the bug (server side bug).

#### Encoding and Mr. MIME

It's about the UTF-7.  Some e-mails don't  respect the encoding described by the
standard (RFC  6532).  The point is to  create a library (but  I already discuss
about that with Daniel) to convert any encoding to UTF-8.

Mr.  MIME has this  problem,  we  respect  the  standard  but  not the practical
e-mail, we need to be more resilient about that.
