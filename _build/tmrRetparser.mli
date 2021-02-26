
(* The type of tokens. *)

type token = 
  | XOR
  | USTR of (string)
  | TYPES
  | TO
  | TMP
  | STRING of (string)
  | SK
  | SIGN
  | SENC
  | SEMICOLON
  | SECRETOF
  | RIGHT_MIDBRACE
  | RIGHT_BRACK
  | RIGHT_BRACE
  | RIGHT_ANGLEBARCK
  | PROTOCOL
  | PLUS
  | PK
  | PERIOD
  | ON
  | NUMBER
  | NONCE
  | NINJ
  | MULTI
  | MOD
  | MINUS
  | LEFT_MIDBRACE
  | LEFT_BRACK
  | LEFT_BRACE
  | LEFT_ANGLEBARCK
  | KNOWLEDGES
  | K
  | INV
  | INT of (int)
  | INJ
  | IDENT of (string)
  | HASHCON
  | GOALS
  | FUNCTION
  | FORMAT
  | F2
  | F1
  | EXP
  | EOF
  | ENVIRONMENT
  | END
  | CONST
  | CONF
  | COMMA
  | COLON
  | AND
  | AGENTS
  | AGENT
  | AENC
  | ACTIONS

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val prog: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Proctype.protocols option)
