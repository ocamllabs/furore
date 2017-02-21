- implementation of [databox-bridge][1]
  - using ocaml-macaroons to do the access right control of API
  - allow local driver/app to submit export request to a queue
  - worker thread (single one for now) extracts a request from the queue and processes it
  - driver/app polling the same API to get update on its request (may support websocket notification)

- next week may spend some time to test the basic working flow, add logging operations, ws support maybe

[1]: https://github.com/sevenEng/databox-storage
