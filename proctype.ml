open Core
(* part 1 type definition *)
type label = string
type roleName = string 
type identifier = string 
type messName = string
type index = int 
(*type nonce = string *)

type message = [
  | `Null
  | `Var of identifier (*variable*)
  | `Str of roleName
  | `Tmp of messName 
  | `Const of identifier
  | `Mod of message * message
  | `Exp of message * message
  | `Concat of message list
  | `Aenc of message * message   (* Asymmetric encryption *)
  | `Senc of message * message   (* Symmetric encryption *)
  | `Sign of message * message 
  | `Hash of message
  | `Pk of roleName
  | `Sk of roleName
  | `K of roleName * roleName
] 

type sign = [
  | `Plus
  | `Minus
]
 
type action = [
  | `Send of int * sign * roleName * message list * message 
  | `Receive of int  * sign * message
  | `Actlist of action list
  | `Null
] 

type knowledge = [
  | `Knowledge of roleName * message
  | `Knowledge_list of knowledge list
  | `Null
] 

type mode = [
  | `Agent of roleName list
  | `Number of message list
  | `Modelist of mode list
  | `Null 
]

type environment = [
  |`Env_agent of roleName * int * message
  |`Envlist of environment list
  |`Null
]

type agent = [
  |`Agent of roleName * message list * action list
  |`Agentlist of agent list 
  |`Null
]

type goal = [
  |`Secretgoal of identifier * message
  |`Secretgoal1 of identifier * message * roleName * roleName
  |`Agreegoal of identifier * roleName * roleName * message
  |`Agreegoal1 of identifier * int * roleName * roleName * message
  |`Goallist of goal list
  |`Null
]

type pocolcontext = [
  | `Pocol of mode  * knowledge * agent * goal * environment
  | `Null
] 

type protocols = [
  | `Protocol of label * pocolcontext
  | `Null
]
