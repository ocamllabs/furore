#### OCaml Git

Focus on the test of OCaml Git (the common part). So, I put some
constraints to prove the equality of the type Value.t between 2
implementation of the Git repository with the same Hash module.

I added some conveniences functions again (like Git.Ref.exists or
Reference.head_contents).

I fixed 2 bugs:
- one about the semantic of `Mem.read_inflated` which differ from the
  `FS.read_inflated`, the first one put the header and the last one
  not. But we expect the last semantic.
- A deep bug about the abstract serialization of a value

Then, I test the Git.Pack.make function and add a returned value which
is a protected variable to get the IDX tree - only available when we
consume all of the stream.

I implemented the push function for the Sync_http module (so the Smart
HTTP protocol) but not test it yet. And finally put some /easy-to-use/
functions on the provided CoHTTP implementation of the Smart HTTP
protocol (for Camelus).

Louis reported to me a bug about fetch, I will fix it.
