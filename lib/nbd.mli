(*
 * Copyright (C) Citrix Systems Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation; version 2.1 only. with the special
 * exception on linking described in file LICENSE.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *)

(** {0 Low-level NBD interface *)

val nbd_cmd_read : int32
val nbd_cmd_write : int32
val nbd_cmd_disc : int32
val nbd_cmd_flush : int32
val nbd_cmd_trim : int32
val nbd_request_magic : int32
val nbd_reply_magic : int32
val nbd_flag_has_flags : int
val nbd_flag_read_only : int
val nbd_flag_send_flush : int
val nbd_flag_send_fua : int
val nbd_flag_rotational : int
val nbd_flag_send_trim : int
val init_passwd : string
val opts_magic : int64
val cliserv_magic : int64
type flag =
    NBD_read_only
  | NBD_send_flush
  | NBD_send_fua
  | NBD_rotational
  | NBD_send_trim
type cmd =
    NBD_cmd_read
  | NBD_cmd_write
  | NBD_cmd_disc
  | NBD_cmd_flush
  | NBD_cmd_trim
val flags_of_flags : int -> flag list
module Request :
  sig type t = { ty : cmd; handle : int64; from : int64; len : int32; } end
module Reply : sig type t = { error : int32; handle : int64; } end
val ty_of_int32 : int32 -> cmd
val int32_of_ty : cmd -> int32
val parse_request : string * int * int -> Request.t
val parse_reply : string * int * int -> Reply.t
val construct_request : Request.t -> string
val construct_reply : Reply.t -> string
val get_int64 : string * int * int -> int64
val get_int32 : string * int * int -> int32
