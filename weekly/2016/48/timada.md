- Preparing for the network performance evaluation
  - finished the iperf modification, now iperf can be conducted between independent MirageOS VMs
  - finished investigation of performance profiling schemes for MirageOS/Solo5
   - tested mirage-trace-viewer and it worked fine
   - investigated Xen and QEMU/KVM tracing facilities, and confirmed they can provide what I want to know
     (I will try them later)
     https://blog.xenproject.org/2012/09/27/tracing-with-xentrace-and-xenalyze/
     http://www.linux-kvm.org/page/Perf_events
     http://vmsplice.net/~stefan/stefanha-tracing-summit-2014.pdf
- Started implementing an automation framework of the network performance evaluation
  - Completed rough implementation design and checking other software required
  - I will implement it next week
