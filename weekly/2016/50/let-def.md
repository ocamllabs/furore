* Distributed witnesses, https://github.com/let-def/distwit (with @samoht )
  - Solve the problem of marshalling exceptions / extensible type by externalizing the equality.
* HyperLogLog, https://github.com/let-def/grenier/blob/master/hll/hll.mli
  - Cardinality estimation in constant space. I made a p-o-c implementation a while ago, now there is one user.
  - I added serializability, improved memory representation and fixed a bug causing small biases in estimations
* Macho support for Owee, https://github.com/let-def/owee, WIP
  - Loading Macho would be useful for supporting macOS binaries in spacetime.
  - This would also a cheap lwt instrumentation tool for monitoring and backtraces. I discussed with @antron, maybe we will look at providing the necessary hooks in the future.
* OCaml meeting (monday last week, some notes about stuff I want to look at)
  - Namespace: Didier Remy worried about specification of build (clumsy, not part of the langage)
  - Interested by bytecode/native interoperability (mentioned by @dim, @stedolan)
  - About release process: too much GPR, not enough testing & code review, quality not satisfying
* Eliom presentation (yesterday) & talk with @drup
  - Seems feasible to add eliom support to Merlin.

