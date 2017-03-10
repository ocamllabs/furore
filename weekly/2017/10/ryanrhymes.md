- The GSL dependency has been removed from the core components in Owl.
- Current modules (partly) rely on GSL are Maths, Stats, FFT. I am currently wrapping up Cephes to replace GSL-based modules.
- I spend some time in refining the AD interface. The following code show how to build a trival neural network with AD (from scratch).
```ocaml
open Owl_algodiff_ad

type layer = { mutable w : t; mutable b : t; a : t -> t }

type network = { layers : layer array }

let run_layer x l = Maths.((x $@ l.w) + l.b) |> l.a

let run_network x nn = Array.fold_left run_layer x nn.layers

let backprop nn eta epoch x y =
  let t = tag () in
  for i = 1 to epoch do
    Array.iter (fun l ->
      l.w <- make_reverse l.w t;
      l.b <- make_reverse l.b t;
    ) nn.layers;
    Maths.(l2norm_sqr((run_network x nn) - y)) |> reverse_prop (F 1.);
    Array.iter (fun l ->
      l.w <- Maths.((primal l.w) - (eta * (adjval l.w))) |> primal;
      l.b <- Maths.((primal l.b) - (eta * (adjval l.b))) |> primal;
    ) nn.layers;
  done
```  
- However, I noticed the memory consumption grows really fast in the previous naive neural network experiment. The allocated memory did not seem to be correctly released after usage. I still try to identify the (possible) memory leak issue. Let me know if anyone has any idea about this.
