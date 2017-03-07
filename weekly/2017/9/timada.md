- Network performance
  - Attended MirageOS Hack Retreat on 1st-2nd March, and mainly had discussions on Solo5 with Martin.
  - Learned the current implementation philosophy of Solo5 and found that it focus on only simplicity and its functionality, not on performance. 
  - Conducted iperf experiments under Solo5-ukvm, and confirmed that longer waiting periods in the sender side actually affets the iperf throughput performance.
    (Only 7MB/sec throughput due to the waiting periods though I confirmed the receiver side can achieve 70MB/sec throughput)
  - I will start designing new networking scheme wich consideration of the current Solo5-ukvm.
