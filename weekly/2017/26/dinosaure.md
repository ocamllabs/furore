#### ocaml-git / sirodepac

##### Encoder

I finish to integrate the core part of sirodepac inside ocaml-git. In the
previous week, I explained that the couple Angstrom/Faraday is good about the
serialization/deserialization. However, I have some bit problem with Faraday.
The context of the serialization in ocaml-git is not the same than httpaf. The
first difference is about where we serialize a Git object.

Faraday was thinked to write directly to a file descriptor/socket. It was
thinked to be share between 2 process, one to write in the internal buffer, the
next to write to the file descriptor. But, in ocaml-git, we use the
serialization of a Git object in a other case. One of this case is about the
serialization to feed a context and get, at the end, an hash. So, the target of
the serialization is not a file descriptor but an internal buffer.

So, I decided to create a mini non blocking encoder with a fixed size memory
fingerprint. And I finished in few day. It's used to produce the same as Faraday
but with some news constraints. This is work perfectly and we keep a control
about the memory consumption.

##### Write a PACK file

Then, we can write a PACK file now but I need to polish deeply the API. This is
the end thing to do. Before, I want to try my PACK file in the real world.

##### Smart Git Protocol

To test my deserialization/serialization of the PACK file, I decided to interact
with a Git server with the Smart Git Protocol. I saw the Sync.ml module, which
implements all things about the communication. However, this module was thinked
in the same way as the previous implementation of ocaml-git.

So, I fund the same problem before and I decided to take down all. I
re-implement the Smart Git Protocol in same way than ocaml-imap. I described why
in a long comment (and why I don't choose Angstrom/Faraday). So, I can clone now
and for this week I'm focus about the negociation with a Git server.
