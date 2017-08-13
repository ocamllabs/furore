- developping the bridge
  - adopted the idea of vpnkit: core part listening on a unix socket, unikernels, each responsible for a network interface, forwarding packets back and forth to the core part
  - provided two preliminary endpoints to configure the bridge: `/connect` and `/disconnect`, both accept a pair of container names, the bridge will resolve these names using a system resolver and translate them into ipv4 packets filter based on the resolved ip addresses
  - the configuration service is using a vnetif-based tcpip stack, pitfall got stuck in and out later after hours of debugging: `use_async_readers:true`, should've read the `README.md` : (
  - control rules also include the limited name resolving rights, only `connected` components could resolve the name of each other

