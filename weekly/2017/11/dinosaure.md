#### Decompress

I fix the distribution of Decompress noticed by @hannes.

#### BLAKE2B / Digestif

I just  finish the implementation  of BLAKE2B in  C.  I did  not received  yet a
response of  David about  `nocrypto` and  where is  the best  place to  find the
implementation of BLAKE2B (inside `nocrypto`,  in a new library and if we choose
this case,  may be it's better to extract the Hash function of `nocrypto` in the
new library).

So,  the implementation works.  I did not do  any benchmark but may be it's good
to put this thing in my TODO.  May  be,  if I have a time,  I will implement the
same hash  but in  pure OCaml  (to compile to  JavaScript) and  let the  user to
choose the C stub or the OCaml code.

And, in my TODO, I keep the SSE implementation.

If I have no response of David for the next month,  I will release `Digestif` as
a common  library for the hash  function.  I will  keep obsiously  the Copyright
Header inside `Digestif`  for David (and Vincent Hanquez) for  some parts of the
code.  But, for me, this project can be a redundant project. I prefer to discuss
before but ...

#### sirodepac / ocaml-git

I  put  an  exhaustive  explanation  of   a  the  previous  big  problem  inside
`sirodepac`/`ocaml-git` about  the limitation of  OCaml for the  mapped file and
how to  fix that and  how `git` fix  this problem.  But  ...  the comment  is in
french - it's hard for me to  explain that in english.  The most important point
is to keep in my mind the problem for a long time (because,  I think, if we want
to fix that, we need to implement a complexe cache system).

I fix the implementation about the endianess too.

And I start the serialization of the IDX file.  I will create a test between the
encoder and the decoder to check if my implementation is good.

The next  goal is to  implement a patience diff  and look how  `git` produce (in
the detail) a PACK file.

#### Farfadet

@Drup looked  the code and  developped a new  (seems good) API  for Farfadet.  I
wait the release of  @seliopou to look the code of @Drup  and decide to merge or
not  -  but I  think  I will  merge.  In  the  same  moment,  I  will  write the
documentation as KC expected.

So same as the previous week.

#### Mr. MIME

Nothing to do.
