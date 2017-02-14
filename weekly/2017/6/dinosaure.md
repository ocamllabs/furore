#### Work on the implementation in Decompress

I continue  to implement the  compression.  Good news,  the  dynamic compression
works with the dbuenzli's interface and  the static compression should work too.
The first  layer (Lz77  compression) is done  - the  question is,  it's  good to
functorize the implementation  of the Lz77 or not  ? I need to fix  a bug in the
flat compression  - but it's  very easy,  may be one  or two hours  to fix that.
Then, I will polish the interface. So, the second layer (Zlib compression) is
most done.

Now, we have a complete interface for Decompress (with differents flush methods,
like  `partial`  for SSH,  `full`  and  `sync`).  It's  possible  to  change the
frequencies before than Decompress computes a canonic Huffman tree.  That means,
it's   possible   to    specialize   the   canonic   Huffman    tree   with   an
external database of frequencies.

After polishing,  I will  do some benchmark with `landmarks`  and try to compare
with `zlib`.  And, I will make the new release of Decompress (tagged 1.0). Then,
I will attack the serialization to a PACK file.

UPDATE:  I finish  to fix  the flat compression  bug,  I will  make a  good test
suites.

UPDATE: I just add a test suites and `decompress.ml` works!

#### Encoding and Mr. MIME

I don't have internet for now (for two  weeks) so I can't see the database about
the translation between an encoding and utf-8. But when I can get this database,
I will start  the  new  library  (the  name  will  be  `uuuu`) and normalize all
output of Mr. MIME to utf-8.

----

May be, I will push (I can't for the moment because I don't have internet) my
work in `dinosaure/sirodepac` repository in few days.
