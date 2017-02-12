- Network performance evaluation
  - Found out that the long waiting periods is a Xen-specific issue, it did not occur under my QEMU/KVM configuration.
  - Observed waiting periods even under the QEMU/KVM configurations, but they were shorter than under my Xen configuration and their fequency was low.
  - I will not have furuther investigation on this issue if not required, so I will move to designing new software archtecture to achieve higher network perforamnce on MirageOS.

- FOSDEM2017
  - Attended the event to get topics realted to network, micro-kernel, micro-service, virtualization.
  - Several presentations were intersting for me (For example, TCP acceleration by using Intel Transration Layer Development Kit which is based on DPDK).
  - I will have a short presentation to report this topic on 28th Feb. 
