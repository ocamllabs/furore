#### Decompress

Decompress is  released in version 0.5.  So,  it  seems work (no  issue for this
moment).  I have a bug  about the opam file and hannes  just fixed that.  I will
report this change in opam-repository.

Finally, I decided to let 6 months to get the new release (1.0) of Decompress.

#### `sirodepac`/`ocaml-git`

I started the implementation of the  BLAKE2B hash function.  I send a message to
david to know if  it's the best to integrate this  hash function inside nocrypto
or outside (and if  the best is to create a new library,  may  be the best is to
locate all common hash function inside a new library).

So,  fortunately,  Eyyub  (a  friend) created  a  projet  inside  the `oklm-wsh`
repository to aggregate the common hash function (like SHA1, SHA256, etc.).  So,
I will reuse this project to provide the BLAKE2B hash function.

For this  moment,  I look the reference  implementation of  BLAKE2B and  the SSE
implementation (to compute the hash  fastly).  So,  I think,  I can do a release
this next week.

Nothing else about `ocaml-git`.  I  met in the hackthon a manager  of a dev team
for a  git project in  go.  So I explained  what is git  and why is  the best to
store a data, a commercial job :p .

#### Farfadet

So,  I created the new repository `Farfadet`.  I spoke with Spiros about the API
and we fixed together the API.

Another good news is from @Drup.  In  fact,  I improved the API after my release
and it seems good.  So,  I need to read the code and write the documentation now
(and provide  a good example -  asked by KC) but  I'm focus on  the BLAKE2B hash
now.

#### Mr. MIME

Nothing to do.
