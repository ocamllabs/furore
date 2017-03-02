#### Decompress

I rework on  the interface and add some conveniences  functions to manipulate an
integer (`int16`,  `int32`, `int64`) with a string or a bigstring.  And I put in
the  interface  the  definition  of  the   type  `st`  and  `bs`  to  prove  the
exhaustivness of the GADT `B.t` outside the library.

#### `sirodepac` and `ocaml-git`

I start the encoding  of the meta-data,  so I find a way  to serialize the data,
so I start to serialize the user,  the commit, etc.  But I don't have a relevant
result  for  the moment.  I  think  a lot  about  the  optimization  and  try to
implement an amortized data structure.

I create a  mini-encoder in the same  way as `faraday` but with  my GADT between
`string` and `bigstring`.  Then,  I create a little library like a `printf-like`
for `faraday` where is possible to specify an optimized `blitter`.

I need to explain, for example a tag data can be described by a format for the deserialization, like that:

```ocaml
let binding ~key ~value = string key *> sp *> value <* lf
and tag =
  binding ~key:"object" ~value:hash
  >>= fun obj -> binding ~key:"type" ~value:kind
  ...
```

So I would like  the same for the encoder.  I looked the  article about the GADT
from @drup and  I create an convenience  interface with GADT to  describe how to
serialize a data with `faraday` and for the same example, we have:

```ocaml
let tag =
  (Const.string "object") ** sp ** string **! lf **
  (Const.string "type") ** sp ** string **! lf **
  ... nil
```

This  formatter  expect somes  arguments  and you  can  decide  to  write  or to
schedule the  writing in the  buffer.  Another fix is  to specify a  fast `blit`
function to  my GADT if  you want - but  I don't find  a relevant example.  It's
like `printf` but for `faraday`.

I informed Spiros about that  but he does not talk to me yet  so I don't know if
I extract this module in  a new library (I can) or if I  let this as an internal
things for `sirodepac`/`ocaml-git`.

I *optimize* `sirodepac`  and use only a  `bigstring`,  may be a good  way is to
test with spacetime to know how many `bigstring` I use.  But,  I found a bug,  I
can't reach  a valid SHA1  hash when I  deserialize the pack  file.  So,  I will
inspect that and I  inform Thomas about that to know more  precisely how to hash
a git  object.  But a good  things is that  I start the  encoding of `sirodepac`
know.

In the same time,  I  look about the Merkle tree.  It's a  structure used by Git
and the P2P protocol to provide a reliable data.  I look a C implementation, and
containers to propose an implementation.

About `ocaml-d3`,  I don't have any work  about that but it's just for fun.  May
be in hackathon, I will play with that but not for this moment.

#### Mr. MIME

Nothing this week about Mr. MIME, I continue to keep in my head the TODO.

#### Next things

Now,  I will create  a test suites for  `sirodepac` to prove that it  works :) !
And,  if I have a time,  I will create a test suit for Decompress,  specifically
about the flush method.
