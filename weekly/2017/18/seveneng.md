#### databox-bridge

Thes first step is to intercept l2/l3 packets from multiple interfaces and forward them.

All the existed MirageOS network io solutions may not seem to fit:

  - this compoment will be used inside a docker container, so `xen` is not good
  - `unix` and `ukvm`, `virtio` targets all use tap devices to do the network io, so for each container interface, there will be bridging and NATing, which will filter out the arp traffic and the ip traffic not targeting the same network

So for now, looking into the possibility of a new network device for unikernels, which is on unix, and instead of openning tun/tap devices, open raw sockets and output the l2 packets

Maybe could also modify the [mirage-net-unix](https://github.com/mirage/mirage-net-unix/blob/master/src/netif.ml#L58), to use `opentun` inside the `connect` function call *(tried earlier, but resulted in failures, could look further in the [c code](https://github.com/mirage/ocaml-tuntap/blob/master/lib/tuntap_stubs.c#L73))*
