- Implementation (Netmap on Solo5-ukvm)
  - Started implementation of the second phase.
  - Finished iothread porting from kvmtool[1], and confirmed ioeventfd-based trapping worked as expected.
  - Investigating the current design of the upper layers(mirage-tcpip and mirage-net-solo5) to have a new path between mirage-tcpip in a guest OS and Netmap on its host OS.
  
[1] https://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git
