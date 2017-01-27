My work this summer is about providing approximate programming tools for OCaml programmers. There are several different styles of approximate computing; each requires of their users different technical knowledge of the subject.

As one example, loop perforation is an approximate computing technique where iterations of a loop are skipped in the pursuit of reducing resource usage (be it time or energy). A loop perforation build system will generally have a self tuning step where, given test input and a fitness function from the user, the system can automatically deduce an approximation strategy. Further refinement by the user is indeed an option, but this is a good example of a technique which asks little of its user.

Loop perforation's ease of use leads KC and I to believe that adding a loop perforation system in OCaml is a great first step in the broader plan of supplying a goodie bag of approximation tools.

I have written a ppx extension for loop perforation. It is basic. In writing it I have both learned a lot about ppx extensions and expanded my compiler knowledge. The next steps are to decide whether to implement a self tuning system. If yes: the ppx extension and the self tuning system would make for a decent first release of an approximation system for OCaml. If no: there are other techniques for approximate computing that we can play with before we decide where to spend coding efforts.

We have met with a group in the lab which is interested in prolonging the flight time of their drone operations. It is hard to say whether there is a collaboration opportunity; approximate computing is not always the right tool for the job.
