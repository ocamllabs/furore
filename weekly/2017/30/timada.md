- Implementation (MQTT broker on MirageOS)
  - Investigated which MQTT control packet I must implement, and found that I must 14 MQTT control packets to support the lowest QoS level.
  - Started implementing packet handlers for the 14 MQTT control packets.
