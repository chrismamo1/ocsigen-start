(* This file was generated by Ocsigen Start.
   Feel free to use it, modify it, and redistribute it as you wish. *)

(** carousel demo ************************************************************)

[%%shared
  open Eliom_content.Html
  open Eliom_content.Html.D
]

let%server service =
  Eliom_service.create
    ~path:(Eliom_service.Path ["demo-carousel3"])
    ~meth:(Eliom_service.Get Eliom_parameter.unit)
    ()

let%client service = ~%service

let%shared name = "Wheel carousel"
let%shared page_class = "os-page-demo-carousel3"

let%shared page () =
  let carousel_pages =
    [ "--- First Monday 1 ---"
    ; "Tuesday 1"
    ; "Wednesday 1"
    ; "Thursday 1"
    ; "Friday 1"
    ; "Saturday 1"
    ; "Sunday 1"
    ; "Monday 2"
    ; "Tuesday 2"
    ; "Wednesday 2"
    ; "Thursday 2"
    ; "Friday 2"
    ; "Saturday 2"
    ; "Sunday 2"
    ; "Monday 3"
    ; "Tuesday 3"
    ; "Wednesday 3"
    ; "Thursday 3"
    ; "Friday 3"
    ; "Saturday 3"
    ; "Sunday 3"
    ; "Monday 4"
    ; "Tuesday 4"
    ; "Wednesday 4"
    ; "Thursday 4"
    ; "Friday 4"
    ; "Saturday 4"
    ; "Sunday 4"
    ; "Monday 5"
    ; "Tuesday 5"
    ; "Wednesday 5"
    ; "Thursday 5"
    ; "Friday 5"
    ; "Saturday 5"
    ; "=== Last Sunday 5 ===" ]
  in
  let length = List.length carousel_pages in
  let carousel_content = List.map (fun p -> D.div [ pcdata p ]) carousel_pages
  in
  let carousel_change_signal = [%client (React.E.create () : 'a * 'b) ] in
  let update = [%client fst ~%carousel_change_signal] in
  let change = [%client fun a -> (snd ~%carousel_change_signal ?step:None a) ]
  in
  let carousel, pos, swipe_pos =
    Ot_carousel.wheel
      ~a:[ a_class ["demo-carousel3"] ]
      ~update
      ~vertical:true
      ~inertia:1.
      ~position:10
      ~transition_duration:3.
      ~face_size:25
      carousel_content
  in

  Lwt.return
    [ p [pcdata "Example of vertical circular carousel (wheel). Try with a touch screen."]
    ; carousel
    ; div [
        Ot_carousel.previous ~a:[ a_class ["demo-prev"] ] ~change ~pos [];
        Ot_carousel.next ~a:[ a_class ["demo-next"] ] ~change
          ~pos ~size:(Eliom_shared.React.S.const 1) ~length
          []
      ]
    ]
