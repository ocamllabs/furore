* I optimized the Base64 decoder but MrMime is slow with QuotedPrintable (but I have an idea to fix that)
* MrMime is more resilient with bad email (like an email without Fromand Dateinformation)
* I fixed some little bug (infinite loop, order of meta-data, multipart inception, unstructured data, and raised exception)
* I retrieved a regression with my test (so, I have a good tests suite) and I fixed this regression - it's a specific problem with a wrong example from the standard RFC 822
* I started the implementation of pretty-printing, so I continue the prototype (I am inspired by the Format module from OCaml standard lib to respect the 80 characters rules)
* I will use an archive from the caml-list (from daniel) to have a good tests suit about the parsing of email (it's a huge example about the old/bad emails)
* So this week, it's just some fixes and a minimal prototype about the pretty-printing :s
