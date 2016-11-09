(* This file was generated by Ocsigen Start.
   Feel free to use it, modify it, and redistribute it as you wish. *)

(** rpc button demo *********************************************************)

[%%shared
  open Eliom_content.Html
  open Eliom_content.Html.D
]

let%server value =
  Eliom_reference.Volatile.eref_from_fun
    ~scope:Eliom_common.global_scope
    (fun () -> 0)

let%server s, f =
  let value = Eliom_reference.Volatile.get value in
  Eliom_shared.React.S.create value

let%server demo_function () = Lwt.return (
  let v = succ (Eliom_reference.Volatile.get value) in
  Eliom_reference.Volatile.set value v;
  ignore [%client (~%f ~%v : unit)]
)

let%client demo_function =
  let demo_rpc =
    ~%(Eliom_client.server_function
         [%derive.json : unit]
         demo_function)
  in
  demo_rpc

let%server value_as_string () : string Eliom_shared.React.S.t =
  Eliom_shared.React.S.map [%shared string_of_int] s

let%server value_reactive () =
  Lwt.return @@ value_as_string ()

let%client value_reactive =
  ~%(Eliom_client.server_function [%derive.json: unit] value_reactive)

let%server service =
  Eliom_service.create
    ~path:(Eliom_service.Path ["demo-rpc"])
    ~meth:(Eliom_service.Get Eliom_parameter.unit)
    ()

let%client service = ~%service

let%shared name = "RPC Button"
let%shared page_class = "os-page-demo-rpc"

let%shared page () =
  let button =
    button
      ~a:[a_class ["button"]]
      [pcdata "Click to call a RPC"]
  in
  ignore
    [%client
      (Lwt.async (fun () ->
         Lwt_js_events.clicks
           (To_dom.of_element ~%button)
           (fun _ _ -> demo_function ())
       )
       : _)
    ];
  let%lwt value = value_reactive () in
  Lwt.return
    [
      p [pcdata "Here is a button calling a rpc to increase a server side \
                 value."];
      p [Eliom_content.Html.R.pcdata value];
      p [button]
    ]
