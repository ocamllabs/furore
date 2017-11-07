#### OCaml Git

Continue to integrate the test suit of ocaml-git with the new API.
Again, it's about move `git_object option Lwt.t` to `(git_object,
error) result Lwt.t`. However, I put lof of constraints now to prove
the equivalence of Value.t type like:

```ocaml
module V1 = Git.Value.Make(SHA1)(C_inflate)(C_deflate)
module V2 = Git.Value.Make(SHA1)(OCaml_inflate)(OCaml_deflate)

V1.t = V2.t
```

So, it's very cool for the end user because, in this way, he can use a
`Mem.Value.t` (memory back-end) in a Store function (file-system
back-end) which expects a `Store.Value.t` only if we prove the
constraints and use the same Hash module implementation.a

Then, I implemented, as Thomas asks, the index decoder whichs works. I
tested ot and the main decoder and the extension works fine - however,
it's not well-tested.

Finally, I helped Louis to integrate OCaml Git in Camelus. Then,
Thomas asks me to implement and easy library to clone/fetch a git
repository. The fetch function has lot of argument, so I implemented
git-cohttp-lwt-unix which is a specialized implementation of git-http
with cohttp-lwt-unix.

In this library, I provided `fetch_all` which is more easy to use than
`fetch` and apply all functor needed to make the HTTP Smart protocol
implementation.
