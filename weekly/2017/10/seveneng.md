- databox-export-service
  - implemented a long-polling version endpoint, temporarily with the route `/lp/export`
  - added a test case against this endpoint

- databox-bridge:
  - decided to try to implement at first with docker bridge, equivalent to use `docker network create ...` and `docker network connect ...` to connect pairs that need communications
  - implemented this [link](https://github.com/me-box/databox/pull/50), waiting for more polishing and testing before merged
  - catched up with mirage3, cause later there should be a stand-alone bridge component rather that a patch in databox's container manager
