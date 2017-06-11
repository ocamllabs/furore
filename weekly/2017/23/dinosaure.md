#### ocaml-git / sirodepac

I continue to integrate my work in ocaml-git. I decided to do a change
*bottom-to-top* replacement: that means, I keep the interface of the Git module
but I create a new implementation. Why ? ocaml-git is based on a stop the world
serialization and we can see this constraint for the File System interface
(which implements `read` and `write` but not on a non-blocking interface).

I believe is that why ocaml-git consumes a lot memory because it does not work
on a fixed size buffer. So I decide to add a non-blocking interface to the File
System signature required.

Then, I provide an Angstrom parser and a top layer to de-serialize a
non-blocking input from an Angstrom parser. We have a limitation but I explain
precisely why this limitation exists.

So, I re-implement the loose file firstly and I will add my work then. It's a
deep work, so when I have a result, I will notice. Another point is about the
Hash. At this moment, we store the hash inside a bigarray (located directly in
the major heap). May be we need to change this to a bytes to optimize the memory
consumption (because the client should use a lot of hashes).

Voilà, not so much this week to show but a deep work :) !
