open Core
open Proctype

(*judge e whether in list l*)
let rec listwithout l e =  
  match l with
  | [] -> true
  | hd::tl -> if hd = e then false else listwithout tl e
  
(*extract tail element of list*)
let rec tail xlist =
  match xlist with 
  | hd::tl -> tl
  | []    -> failwith "no element"
 
(*extract head element of list*)
let head xlist =
  match xlist with
  | x::tl -> x
  | [] -> failwith "no element"
 
(*相同位置的x放在同一列表*)
let rec transpose xlist = 
  match xlist with
  | []             -> []
  | []   :: xss    -> transpose xss
  | (x::xs) :: xss ->
    (x :: List.map ~f:head xss) :: transpose (xs :: List.map ~f:tail xss)
 
(*delete duplicate element*)
let del_duplicate org_list =
  match org_list with
  | [] -> []
  | l -> let len = List.length l in
         let non_duplicate = ref [] in
         for i = 0 to len do
           match List.nth l i with
           | None -> ()
           | Some x -> if listwithout !non_duplicate x then non_duplicate := !non_duplicate @ [x]
         done;
         !non_duplicate

 (* get role's msg from knowledges : [msgofA;msgofB] *)
let rec getMsgOfRoles knws =
  match knws with
  | `Null -> []
  | `Knowledge (r,m) -> [m]
  | `Knowledge_list knws -> List.concat (List.map ~f:(fun k -> getMsgOfRoles k) knws)

let rec getRolesFromKnws knws rl =
  match knws with
    | `Null -> rl
    | `Knowledge (r,m) -> if listwithout rl r then r :: rl else rl
    | `Knowledge_list ks -> getroles ks rl
  and getroles ks rl =
    List.concat (List.map ~f:(fun k -> getRolesFromKnws k rl ) ks)
    
let rec getNonces msgs =
  match msgs with
    | [] -> []
    | hd :: tl -> (getNoncesOfMsg hd) @ (getNonces tl)
  and getNoncesOfMsg m =
    match m with
    |`Var n -> [n]
    |`Concat msgs -> List.concat (List.map ~f:getNoncesOfMsg msgs)
    |_ -> []

let rec getEnvRoles env rl = 
    match env with
      |`Null -> rl
      |`Env_agent (r, num, m) -> getRolesInstance m rl (*if listwithout rl r then r :: rl else rl*)
      |`Envlist envs -> getRole envs rl
    and getRole envs rl =
      List.concat (List.map ~f:(fun e -> getEnvRoles e rl ) envs)
    and getRolesInstance m rl =
      match m with
      | `Str r -> if listwithout rl r then r :: rl else rl
      | `Concat msgs -> getRolesInstances msgs rl
      | _ -> rl
    and getRolesInstances msgs rl =
      List.concat (List.map ~f:(fun m -> getRolesInstance m rl) msgs)
    
let getRolesFromEnv env rl =
    let rlist = getEnvRoles env rl in
      del_duplicate rlist

let rec getEnvNonces env nl = 
    match env with
        |`Null -> nl
        |`Env_agent (r, num, m) -> getNonceInstance m nl 
        |`Envlist envs -> getNonce envs nl
    and getNonce envs nl =
      List.concat (List.map ~f:(fun e -> getEnvNonces e nl) envs)
    and getNonceInstance m nl =
      match m with
        | `Var n -> if listwithout nl n then n :: nl else nl
        | `Concat msgs -> getNonceInstances msgs nl
        | _ -> nl
    and getNonceInstances msgs nl =
        List.concat (List.map ~f:(fun m -> getNonceInstance m nl) msgs)
      
let getNonceFromEnv env nl =
    let nlist = getEnvNonces env nl in
    del_duplicate nlist
