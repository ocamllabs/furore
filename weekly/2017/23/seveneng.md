#### databox-bridge
- supported dns, containers from different networks that are connected by the bridge could resolve the domain names of each other
- looked into [vpnkit](https://github.com/moby/vpnkit), code about de/multiplexing packets from/to multiple tcp/ip stack endpoints could probably reused by the bridge
  - when started, each stack registerd itself to some central dispatching unit
  - for input, push packets to the same stream
  - the central unit drain from the stream, parse packets, distribute packet to corresponding stack
