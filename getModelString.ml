open Core
open TmrLexer
open Lexing

(* print the current position *)
let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf = 
  try TmrRetparser.prog TmrLexer.read lexbuf with
  | SyntaxError msg -> 
    fprintf stderr "%a: %s\n" print_position lexbuf msg;
    None
  | TmrRetparser.Error ->
    fprintf stderr "\n%a: syntax error\n" print_position lexbuf;
    exit(-1)


let rec parse_and_print lexbuf = 
  match parse_with_error lexbuf with
  | Some value ->
  printf "%a\n" Protocols.genCode value;
  parse_and_print lexbuf
  | None -> ()

  

let loop filename () =
  let inx = In_channel.create filename in
  let filebuf = Lexing.from_channel inx in
  filebuf.lex_curr_p <- { filebuf.lex_curr_p with pos_fname = filename };
  parse_and_print filebuf;
  In_channel.close inx

let () =
  Command.basic ~summary:"Print protool list"
    Command.Spec.(empty +> anon ("filename" %: string))
    loop
  |> Command.run


