- Network performance evaluation
  - Implemented my iperf program using Mirage vnetif as an interconnect, and found there were still unexpected waiting(blocking) periods. So I concluded that somthing in MirageOS triggered this behavior. I will investigate a root cause of it by starting with further tracing schemes in MirageOS.
  - Conducted further analysis based on the previously obtained results, and found that the host OS side processing(i.e. network bridging) can occupies higher than 65% of the total network processing time without the unexpected waiting periods. This is an expected result, not suprising. The host OS side processing time can be reduced by taking advantage of existing schemes such as Netmap or DPDK.
  - Prioritized topics to be conducted
    1. investigation of the waiting periods not anticipated
	2. implementation design to reduce overhead in the host OS side
	3. implementation design to reduce overhead in the MirageOS network protocol layer
