#### Work on the implementation in Decompress

I finish  to polish Decompress (test  and documentation).  So all is  ok and the
new version  of Decompress (0.5) is  ready.  I choose to create  the 0.5 version
(and not  the 1.0) because I  insert an experimental  thing in  API and  I would
like to create a  new  test  and  prove  that  is  more  reliable to get the 1.0
version.

Indeed,  I inserted the flush methods (`partial`, `full` and `sync`) and you use
Decompress without these flush methods.  After,  all code is in OCaml (`alder32`
compute and `memcpy` implementation).

Apparently, Decompress works with solo5, so it's a good news!

May be,  I  will push the  new version in the  hackathon because I  don't have a
good internet for the moment.

#### `ocaml-git` and `sirodepac`

I continue to  work on the `sirodepac`  at the same time.  I just  create a mini
non-blocking decoder.  May be  I  will  implement  a  little  fun interface with
`ocaml-d3`.  So I have  a full deserialization of  PACK and IDX git  file and we
can make easily the glue between `sirodepac` and `ocaml-git`.

So,  I will create a  mini non-blocking encoder now and after  I will attack the
main purpose of my mission, the create of the PACK file - to fix the `git push`.
Thomas point me some bug, so I will focus now on this :) !

#### Mr. MIME and the buffer

When I  create the mini  non-blocking decoder,  I find  a new way  to handle the
buffer and  let the user  to grow the  buffer.  It's the best  choice (about the
security) to let the user to grow the buffer.  For the moment, it's Mr.  MIME to
grow the buffer and you can observe that but not precisely.

So,  I push this big  thing in my TODO.  It's not complex  but this idea changes
the API a lot.

Voilà!
