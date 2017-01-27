* I fixed some little bug with MrMime and the "real world" email
* Firstly, I use a script with fetchmail program to download my email
* But, I implemented a library to communicate with my GMail (with the POP3 protocol), you can see the project: https://github.com/oklm-wsh/Jackson (it's a little project, and it just a prototype to test MrMime)
* So I continue to fix MrMime with the real world and automatize the test suite
* At the same time, I look sessions type and GADT in OCaml to create a tool to describe a protocol (like POP3 or SMTP) with GADT (so a typed protocol), may be if I have a good result with GADT (because it's very complex), I use that for Jackson and for the implementation of SMTP
* So not specifically productive but, step by step, I have a little prototype to communicate with GMail (or another service) and a resilient implementation of email
