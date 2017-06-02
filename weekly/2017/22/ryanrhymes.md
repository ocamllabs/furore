- I spent a lot of time in refractoring the API in neural module, and added several merge layer (add/mul/dot) into the module.
- I finished the first version of `Owl_neural_graph` module. Owl can make a neural network of DAG topology. The new api is also easier to use. For example, making a convolutional neural network as blow
```ocaml
open Owl_neural;;
open Owl_neural_feedforward;;

let nn = input [|28;28;1|]
  |> conv2d [|5;5;1;32|] [|1;1|] ~act_typ:Activation.Relu
  |> max_pool2d [|2;2|] [|2;2|]
  |> conv2d [|5;5;32;64|] [|1;1|] ~act_typ:Activation.Relu
  |> max_pool2d [|2;2|] [|2;2|]
  |> dropout 0.1
  |> fully_connected 1024 ~act_typ:Activation.Relu
  |> linear 10 ~act_typ:Activation.Softmax
in print nn;;
```
