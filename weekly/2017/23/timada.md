- Implementation (Netmap on Solo5-ukvm)
  - Finished implementation of Netmap buffer mapping test functions, and confirmed Netmap buffers on the host OS can be directly accessed from the guest Solo5-ukvm kernel.
  - The current memory mapping location is designed like MMIO, but tentative. So I will need to consider the best mapping address for Solo5-ukvm.
  - I will move to the next step, implementation of queue-based packet handling in the guest Solo5-ukvm kernel.