- Made a list of functionality in existing networking software and hardware for virtualised environments.
  - both Netmap and DPDK have a similar approach (software-based packet switching, userspace packet processing)  
  - using SR-IOV VFs is difficult to apply to some situations (for example, combined with DPDK on ARM)
  So I will conduct performance evaluation of the current implementation to understand which part is a bottleneck

- Preparing for the performance evaluation for the coming MirageOS v3 release
  - I will be engaged in network related topics.
  - I have started building a MirageOS/Solo5 testbed (in Japan) to easily move to the actual evaluation in a local environment. I will learn and test Mirage-related operations on the testbed in advance
