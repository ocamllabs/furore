- Completed building my MirageOS/Solo5 environments in Japan
  - they are operating perfectly.

- Investigating and trying to execute existing network programs on MirageOS
 - found arp and iperf implementation, but found out they cannot use with the latest MirageOS branch (mirage-dev) due to rapidly changing MirageOS APIs
 - modifying their source codes:
   arp  : modification finished and worked correctly
   iperf: under modification, network connection and data transfer were OK but a result printing part was wrong
 - I will move to learning of performance profiling on MirageOS after finishing the iperf modification
