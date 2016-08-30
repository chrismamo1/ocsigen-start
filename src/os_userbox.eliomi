(* This file was generated by Ocsigen-start.
   Feel free to use it, modify it, and redistribute it as you wish. *)

(** Connexion box, box with connected user information and menu *)

[%%shared.start]

type uploader = unit Ot_picture_uploader.service

(** Box for connected users, with picture, name, and menu *)
val connected_user_box :
  Os_user.t -> uploader -> [> Html_types.div ] Eliom_content.Html.D.elt

(** Connection box *)
val connection_box :
  unit -> [> Html_types.div ] Eliom_content.Html.D.elt Lwt.t

(** Connected user box or connexion box, depending whether user
    is connected or not *)
val userbox :
  Os_user.t option ->
  uploader ->
  [> Html_types.div ] Eliom_content.Html.D.elt Lwt.t

(** Link to upload a picture.
    The client function given as first parameter will be called first,
    for example to close the menu containing the link. *)
val upload_pic_link :
  ?a:[< Html_types.a_attrib > `OnClick ] Eliom_content.Html.D.Raw.attrib list
  -> ?content:Html_types.a_content Eliom_content.Html.D.Raw.elt list
  -> ?crop:float option
  -> ?input:
    Html_types.label_attrib Eliom_content.Html.D.Raw.attrib list
     * Html_types.label_content_fun Eliom_content.Html.D.Raw.elt list
  -> ?submit:
    Html_types.button_attrib Eliom_content.Html.D.Raw.attrib list
     * Html_types.button_content_fun Eliom_content.Html.D.Raw.elt list
  -> (unit -> unit) Eliom_client_value.t
  -> uploader
  -> int64
  -> [> `A of Html_types.a_content ] Eliom_content.Html.D.Raw.elt

(** Link to start to see the help from the begining.
    The client function given as first parameter will be called first,
    for example to close the menu containing the link. *)
val reset_tips_link :
  (unit -> unit) Eliom_client_value.t ->
  [> `A of [> `PCDATA ] ] Eliom_content.Html.D.Raw.elt

(** Display user menu *)
val user_menu :
  Os_user.t ->
  uploader -> [> Html_types.div ] Eliom_content.Html.F.elt


[%%client.start]

(** Personnalize user menu *)
val set_user_menu :
  ((unit -> unit) ->
   Os_user.t ->
   uploader ->
   Html_types.div_content Eliom_content.Html.D.elt
     Eliom_content.Html.D.list_wrap) ->
  unit



[%%server.start]
  val wrong_password : bool Eliom_reference.Volatile.eref
  val user_already_exists : bool Eliom_reference.Volatile.eref
  val user_does_not_exist : bool Eliom_reference.Volatile.eref
  val user_already_preregistered : bool Eliom_reference.Volatile.eref
  val activation_key_outdated : bool Eliom_reference.Volatile.eref