- [databox-export-service][1] (*we renamed the repo from 'databox-bridge' to this*)
  - Dockerised this repo, added docker hub autobuild, added opam file to use opam to install the service
  - Supported https by wrapping `cert` and `key` environment varialbles into local files, and passing them to the `opium` interface
  - Refactored [test.ml](../blob/master/test/test.ml) to make it easier to write more tests from client side rather the monolithic single test before this
  - Added some new tests to test against scenarios where we would have invalide id or macaroons etc.
  - Tried out some new libraries to make days easier: `depyt`, `rresult`, `bos` etc.

- databox-bridge:
  - Discussed the functionalities and interactions with other components, should be able to see the very first version next week
  - Step one: assuming bridge has connected to the right network and so do other components, it should recognize DNS requests, give right responses and then forwarding ethernet packets to the right interfaces

*Only realized forgot to add the weekly 8 while in the middle of this week, so this log actually covered work done for the past two weeks*

[1]: https://github.com/me-box/databox-export-service.git
