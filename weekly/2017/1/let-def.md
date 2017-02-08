
* OCaml compiler work (that affects Reason and OCaml): migrating the parse tree - with Alain Frisch and Jeremie Diminio - different solution. Useful for JS via ppx and FB via Reason.

* Merlin:
  - Stateless frontend: Happy with it as it stands, has not optimised performance, but what is currently there works. Planning to spend some time at JS working on integration as it is quite a deep change - after POPL.

Merlin TODO:
- Stateless wrapper for Windows: started, more difficult than expected. The current design is not portable, so needs to work on that and then implement it. Needs Windows box - arriving next week.
- Logging: Logging is made possible by the stateless frontend. Has a prototype but doesn't match - will progress quickly once started - likely early January.
- Parsing: Meeting Francois to discuss features/direction
