(* This file was generated by Ocsigen Start.
   Feel free to use it, modify it, and redistribute it as you wish. *)

let%server about_service =
  Eliom_service.create
    ~path:(Eliom_service.Path ["about"])
    ~meth:(Eliom_service.Get Eliom_parameter.unit)
    ()

let%server upload_user_avatar_service
  : (unit, unit) Ot_picture_uploader.service =
  Ot_picture_uploader.mk_service
    "upload_user_avatar_service"
    [%derive.json: unit]

let%server demo_service =
  Eliom_service.create
    ~path:(Eliom_service.Path ["demo"])
    ~meth:(Eliom_service.Get Eliom_parameter.unit)
    ()

let%server settings_service = Eliom_service.create
  ~path:(Eliom_service.Path ["settings"])
  ~meth:(Eliom_service.Get Eliom_parameter.unit)
  ()

let%server os_github_service =
  Eliom_service.extern
    ~prefix:"http://github.com"
    ~path:["ocsigen"; "ocsigen-start"]
    ~meth:(Eliom_service.Get Eliom_parameter.unit)
    ()

let%server ocsigen_service =
  Eliom_service.extern
    ~prefix:"http://ocsigen.org"
    ~path:[]
    ~meth:(Eliom_service.Get Eliom_parameter.unit)
    ()

let%client about_service =
  ~%about_service

let%client upload_user_avatar_service =
  ~%upload_user_avatar_service

let%client demo_service =
  ~%demo_service

let%client settings_service =
  ~%settings_service

let%client ocsigen_service =
  ~%ocsigen_service

let%client os_github_service =
  ~%os_github_service
