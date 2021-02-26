open Core
open Proctype

  
let rec print_message m=
  match m with 
  | `Null -> sprintf ""
  | `Var i -> sprintf "%s" i 
  | `Str r -> sprintf "%s" r
  | `Const i -> sprintf "%s" i
  | `Tmp m -> sprintf "%s" m
  | `Exp (m,i) -> sprintf "exp(%s,%s)" (print_message m) (print_message i) 
  | `Concat ms-> String.concat ~sep:"." (List.map ~f:print_message ms)
  | `Aenc (m1,m2)-> sprintf "aenc{%s}%s" (print_message m1) (print_message m2)
  | `Senc (m1,m2) -> sprintf "senc{%s}%s" (print_message m1) (print_message m2)
  | `Hash (m1) -> sprintf("hash(%s)") (print_message m1)
  | `Mod (m1,m2) -> sprintf ("mod(%s,%s)") (print_message m1) (print_message m2)
  | `Pk r -> sprintf "pk(%s)" r
  | `Sk r -> sprintf "sk(%s)" r 
  | `K (r1,r2) -> sprintf "k(%s,%s)" r1 r2
  | `Sign (m1,m2) -> sprintf "sign(%s,%s)" (print_message m1) (print_message m2)

let rec print_knowledge  knws = 
  match knws with 
  | `Null -> sprintf "\n" 
  | `Knowledge (r,m) ->  sprintf ("%s:%s\n") r  (print_message m)
  | `Knowledge_list kns -> String.concat ~sep:"\n" (List.map ~f:print_knowledge kns)

  let print_sign s = 
    match s with 
    | `Plus -> "+"
    | `Minus -> "-"

  let rec print_action actions i= 
    match actions with 
      | `Null -> sprintf "\n"
      | `Send (seq,s,r,ms,m) -> sprintf "[%d] %s %s (%s):%s" i  (print_sign s) r (String.concat ~sep:"," (List.map ~f:print_message ms)) (print_message m)
      | `Receive (seq,s,m) -> sprintf "[%d] %s :%s" i  (print_sign s) (print_message m)
      | `Actlist arr ->String.concat ~sep:"\n" (List.map ~f:(fun a->print_action a i ) arr)

  let rec print_action1 actions= 
    match actions with 
      | `Null -> sprintf "\n"
      | `Send (seq,s,r,ms,m) -> sprintf "%s" (print_message m)
      | `Receive (seq,s,m) -> sprintf "%s" (print_message m)
      | `Actlist arr ->String.concat ~sep:"\n" (List.map ~f:(fun a->print_action1 a) arr)
(* let rec print_agents ags = 
  match ags with 
  | `Null -> sprintf "\n"
  | `Agent (n,ms,actlist) -> sprintf "%s:%s\n%s" n (String.concat ~sep:"," (List.map ~f:print_message ms)) (String.concat ~sep:"\n" (List.map ~f:print_action actlist))
  | `Agentlist als -> String.concat ~sep:"\n" (List.map ~f:print_agents als) *)


let rec print_function f=
  match f with 
  | `Pk c -> sprintf "pk"
  | `Sk s -> sprintf "sk"
  | `Exp e -> sprintf "exp"
  | `Mod m -> sprintf "mod"

let rec print_type types = 
  match types with 
  | `Null -> sprintf "\n"
  | `Number ms -> sprintf "Number:%s" (String.concat ~sep:"," (List.map ~f:print_message ms))
  | `Function fs -> sprintf "Function:%s" (String.concat ~sep:"," (List.map ~f:print_function fs))
  | `Agent rs -> sprintf "Agent:%s" (String.concat ~sep:"," rs)
  | `Modelist ls -> String.concat ~sep:"\n" (List.map ~f:print_type ls)

let rec print_env envs = 
  match envs with 
  | `Null -> sprintf "\n"
  | `Env_agent (r,i,m)->sprintf "%s[%d]:%s" r i (print_message m)
  | `Envlist es ->String.concat ~sep:"\n" (List.map ~f:print_env es)

let rec print_goal gs = 
  match gs with 
  |`Secretgoal (id,m) -> sprintf "%s,%s" id (print_message m)
  |`Secretgoal1 (id,m,r1,r2) -> sprintf "%s,%s,%s,%s" id (print_message m) r1 r2
  |`Agreegoal (id,r1,r2,m) -> sprintf "%s,%s,%s,%s" id r1 r2 (print_message m)
  |`Agreegoal1 (id,id1,r1,r2,m) -> sprintf "%s,%d,%s,%s,%s" id id1 r1 r2 (print_message m)
  |`Goallist gs -> String.concat (List.map ~f:print_goal gs)
  |`Null -> sprintf ""

let rec combination list n =
  match list with
  | [] -> []
  | ele::list' ->
    let len = List.length list in
    if len < n then
      []
    else begin
      match n with
      | 0 -> []
      | 1 -> List.map list ~f:(fun x -> [x])
      | _ ->
        let first_set = List.map (combination list' (n - 1)) ~f:(fun x -> ele::x) in
        first_set@(combination list' n)
    end


let rec getAllActsList agents = 
  match agents with 
  | `Null -> []
  | `Agent (n,ms,actlists) -> actlists
  | `Agentlist als ->List.concat (List.map ~f:getAllActsList als)

let rec getAllSendActs actions =
  match actions with
  | `Null -> []
  | `Send (seq,s,r,mls,m) -> [actions]
  | `Receive (seq,s,m) -> []
  | `Actlist arr -> List.concat (List.map ~f:getAllSendActs arr)

let rec getAllReceActs actions =
  match actions with
  | `Null -> []
  | `Send (seq,s,r,mls,m) -> []
  | `Receive (seq,s,m) -> [actions]
  | `Actlist arr -> List.concat (List.map ~f:getAllReceActs arr)


let rec getActsList agents roleName= 
  match agents with 
  | `Null -> []
  | `Agent (n,ms,actlists) -> if n=roleName then actlists else []
  | `Agentlist als ->getActs als roleName
  and  getActs agents  roleName=   List.concat (List.map ~f:(fun a -> getActsList a roleName) agents)

let rec getSeqByActions actions = 
  match actions with
  | `Null -> []
  | `Send (seq,s,r,mls,m) -> [seq]
  | `Receive (seq,s,m) -> [seq]
  | `Actlist arr -> List.concat (List.map ~f:getSeqByActions arr)

let rec getSendActsBySeq actions seq = 
  match actions with 
  | `Null -> []
  | `Send (seq1,s,r,mls,m) -> if seq1 = seq then [`Send (seq1,s,r,mls,m)] else []
  | `Receive (seq1,s,m) -> []
  | `Actlist arr -> List.concat (List.map ~f:(fun x->getSendActsBySeq x seq) arr)

let rec getRecvActsBySeq actions seq = 
    match actions with 
    | `Null -> []
    | `Send (seq1,s,r,mls,m) -> []
    | `Receive (seq1,s,m) -> if seq1 = seq then [actions] else [] 
    | `Actlist arr -> List.concat (List.map ~f:(fun x->getRecvActsBySeq x seq) arr)

let rec getmsgFromActs actions =
  match actions with 
  | `Null -> []
  | `Send (seq1,s,r,mls,m) -> [m]
  | `Receive (seq1,s,m) -> [m]
  | `Actlist arr -> List.concat (List.map ~f:(fun x->getmsgFromActs x) arr)


let print_option po=
  match po with 
  |None->""
  |Some a -> a

let get_option go = 
  match go with 
  | None -> [] 
  | Some a -> a 
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

let rec remove ls e =
  match ls with
  | [] -> []
  | hd::tl -> if hd = e then remove tl e else hd::(remove tl e)

  let genRuleName rolename i =
  sprintf "rule \" role%s%d \"\n" rolename i
;;

let genSendGuard rolename i seq =
  sprintf "role%s[i].st = %s%d & ch[%d].empty = true & !role%s[i].commit \n==>\n" rolename rolename i seq rolename
;;

let genRecvGuard rolename i seq agents=
  let allactions =getActsList agents rolename in 
  let recvaction = List.hd_exn (List.concat (List.map ~f:(fun x->getRecvActsBySeq x seq) allactions)) in 
  let msg = List.hd_exn (getmsgFromActs recvaction) in 
  let flag = match msg with 
  |`Tmp (name1) -> true 
  | _ -> false
  in 
  sprintf "role%s[i].st = %s%d & ch[%d].empty = false & !role%s[i].commit & judge(ch[%d].msg,role%s[i].%s,%s) \n==>\n" rolename rolename i seq rolename seq rolename rolename (if flag = true then (sprintf "role%s[i].%s" rolename (print_message msg)) else "msgs[0]")
;;

(* Transforming the i-th action into murphy rule *)
let rec getAtoms msg =
  match msg with
  |`Null   	-> [`Null]
  |`Var id 	-> [`Var id]
  |`Str s 	-> [`Str s]
  |`Tmp mn -> [`Tmp mn]
  |`Concat msgs -> getEachAtoms msgs
  |`Hash (m1) 	->   List.concat (List.map ~f:getAtoms [m1])
  |`Aenc (m1,m2)-> List.concat (List.map ~f:getAtoms [m1;m2])
  |`Senc (m1,m2)-> List.concat (List.map ~f:getAtoms [m1;m2])
  |`Exp (m1,m2)-> List.concat (List.map ~f:getAtoms [m1;m2])
  |`Mod (m1,m2)-> List.concat (List.map ~f:getAtoms [m1;m2])
  |`Pk rolename -> [`Pk rolename]
  |`Sk rolename -> [`Sk rolename]
  |`K (r1,r2)	-> [`K (r1,r2)] (* the symmetrix should be one atoms *)
  |`Const i -> [`Const i]
  |`Sign (m1,m2) -> List.concat (List.map ~f:getAtoms [m1;m2])
and getEachAtoms msgs =
  remove (List.concat (List.map ~f:getAtoms msgs)) `Null


 (* get role's msg from knowledges : [msgofA;msgofB] *)
let rec getMsgOfRoles knws =
  match knws with
  | `Null -> []
  | `Knowledge (r,m) -> [m]
  | `Knowledge_list knws -> List.concat (List.map ~f:(fun k -> getMsgOfRoles k) knws)

  let rec getMsgOfIntruder knws =
    match knws with
    | `Null -> []
    | `Knowledge (r,m) -> if r = "I" then [m] else []
    | `Knowledge_list knws -> List.concat (List.map ~f:(fun k -> getMsgOfIntruder k) knws)

let rec getRolesFromKnws knws rl =
  match knws with
    | `Null -> rl
    | `Knowledge (r,m) -> if r <> "I" then if listwithout rl r then r :: rl else rl else rl
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


let rec getConsts msgs =
  match msgs with
    | [] -> []
    | hd :: tl -> (getConstsOfMsg hd) @ (getConsts tl)
  and getConstsOfMsg m =
    match m with
    |`Const n -> [n]
    |`Concat msgs -> List.concat (List.map ~f:getConstsOfMsg msgs)
    |_ -> []

let rec getTmp msgs =
  match msgs with
    | [] -> []
    | hd :: tl -> (getTmpsOfMsg hd) @ (getTmp tl)
  and getTmpsOfMsg m =
    match m with
    |`Tmp n -> [n]
    (* |`Concat msgs -> List.concat (List.map ~f:getTmpsOfMsg msgs) *)
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

let rec getEnvConsts env cs = 
    match env with
        |`Null -> cs
        |`Env_agent (r, num, m) -> getConstInstance m cs
        |`Envlist envs -> getConst envs cs
    and getConst envs cs =
      List.concat (List.map ~f:(fun e -> getEnvConsts e cs) envs)
    and getConstInstance m cs =
      match m with
        | `Const c -> if listwithout cs c then c :: cs else cs
        | `Concat msgs -> getConstInstances msgs cs
        | _ -> cs
    and getConstInstances msgs cs =
        List.concat (List.map ~f:(fun m -> getConstInstance m cs) msgs)
      
let getConstFromEnv env cs =
    let clist = getEnvConsts env cs in
      del_duplicate clist

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
  
  let rec getKnwNonces knw nl = 
      match knw with
          |`Null -> nl
          |`Knowledge (r, m) -> getNonceInstance m nl 
          |`Knowledge_list knw -> getNonce knw nl
      and getNonce knw nl =
        List.concat (List.map ~f:(fun e -> getKnwNonces e nl) knw)
      and getNonceInstance m nl =
        match m with
          | `Var n -> if listwithout nl n then n :: nl else nl
          | `Concat msgs -> getNonceInstances msgs nl
          | _ -> nl
      and getNonceInstances msgs nl =
          List.concat (List.map ~f:(fun m -> getNonceInstance m nl) msgs)

  let rec getKnwNoncesInt knw nl = 
      match knw with
          |`Null -> nl
          |`Knowledge (r, m) -> if r = "I" then getNonceInstanceInt m nl else []
          |`Knowledge_list knw -> getNonceInt knw nl
      and getNonceInt knw nl =
        List.concat (List.map ~f:(fun e -> getKnwNoncesInt e nl) knw)
      and getNonceInstanceInt m nl =
        match m with
          | `Var n -> if listwithout nl n then n :: nl else nl
          | `Concat msgs -> getNonceInstancesInt msgs nl
          | _ -> nl
      and getNonceInstancesInt msgs nl =
          List.concat (List.map ~f:(fun m -> getNonceInstanceInt m nl) msgs)


let agents2Str rlist =
    let intruStr = if listwithout rlist ("Intruder") then "Intruder, " else "" in
      intruStr ^ String.concat ~sep:", " rlist

let nonce2Str nlist =
    String.concat ~sep:", " nlist
let nonce2IntruderStr nlist = 
    String.concat ~sep:"i, " nlist 
let const2Str clist =
    String.concat ~sep:", " clist
let const2IntruderStr clist = 
    String.concat ~sep:"i, " clist 

let agentSStatus rlist lensOfrlist =
      String.concat ~sep:";\n  " (List.mapi ~f:(fun i r -> 
                                let len = match List.nth lensOfrlist i with
                                          |None -> 0
                                          |Some l -> l
                                in
                                let statuslist = ref [] in
                                for j = 1 to len do
                                  let statu = sprintf "%s%d" r j in
                                  statuslist := !statuslist @ [statu]
                                done;
                                let status = String.concat ~sep:"," !statuslist in
                                sprintf "%sStatus: enum{%s}" r status ) rlist)

let rec getAgentRole agents = 
  match agents with 
  | `Null -> []
  | `Agent (n,ms,acts) -> if (List.length acts)>0 then [n] else []
  | `Agentlist als ->List.concat (List.map ~f:getAgentRole als)

     
let agentSStatus rlist lensOfrlist =
    String.concat ~sep:";\n  " (List.mapi ~f:(fun i r -> 
                              let len = match List.nth lensOfrlist i with
                                        |None -> 0
                                        |Some l -> l
                              in
                              let statuslist = ref [] in
                              for j = 1 to len do
                                let statu = sprintf "%s%d" r j in
                                statuslist := !statuslist @ [statu]
                              done;
                              let status = String.concat ~sep:"," !statuslist in
                              sprintf "%sStatus: enum{%s}" r status ) rlist)
let nType2Str nlist = 
  String.concat ~sep:";\n   " (List.map ~f:(fun n -> sprintf "loc%s : NonceType" n) nlist)

let cType2Str clist = 
    String.concat ~sep:";\n   " (List.map ~f:(fun n -> sprintf "loc%s : ConstType" n) clist)

let agType2Str rlist =
  String.concat ~sep: ";\n   " (List.map ~f:(fun r -> sprintf "loc%s : AgentType" r) rlist)

let mType2Str tlist = 
  String.concat ~sep: ";\n   " (List.map ~f:(fun m -> sprintf "loc%s : Message" m) tlist)

let rec printMurphiRecords knw nlist aglist tlist clist=
  match knw with
  |`Null -> sprintf "null"
  | `Knowledge (r,m) -> if r <> "I" then let str1 = sprintf "  Role%s : record\n" r in
                        let str2 = String.concat ~sep:"\n" (List.map ~f:(fun n -> sprintf "   %s : NonceType;" n) nlist) ^ "\n" in
                        let str3 = String.concat ~sep:"\n" (List.map ~f:(fun r -> sprintf "   %s : AgentType;" r) aglist) ^ "\n" in
                        let str4 = String.concat ~sep:"\n" (List.map ~f:(fun r -> sprintf "   %s : Message;" r) tlist) ^ "\n" in
                        let str5 = String.concat ~sep:"\n" (List.map ~f:(fun r -> sprintf "   %s : ConstType;" r) clist) ^ "\n" in
                        let str6 = sprintf "   %s;\n   %s;\n   %s\n   %s\n   st: %sStatus;\n" (nType2Str nlist) (agType2Str aglist) (if (List.length tlist >0) then (sprintf "%s;" (mType2Str tlist)) else (sprintf "%s" (mType2Str tlist))) (if (List.length clist >0) then (sprintf "%s;" (cType2Str clist)) else (sprintf "%s" (cType2Str clist))) r in
                        let str7 = sprintf "   commit : boolean;\n" in
                        let str8 = sprintf "  end;\n" in
                        str1 ^ str2 ^ str3 ^ str4 ^ str5 ^ str6 ^ str7 ^ str8
                        else ""
  | `Knowledge_list knws ->String.concat (List.map ~f:(fun k -> printMurphiRecords k nlist aglist tlist clist) knws)

let rlistToVars rlist =
    String.concat ~sep:";\n  " (List.map ~f:(fun r -> 
                  sprintf "role%s : Array[role%sNums] of Role%s" r r r) rlist)
let rlistToKnows rlist =
    String.concat ~sep:"\n  " (List.map ~f:(fun r -> 
                  sprintf "%s_known : Array[indexType] of boolean;" r) rlist)
let intruderEmitIntoCh slist = 
    String.concat ~sep:"\n  "  (List.map ~f:(fun s -> 
                  sprintf "IntruEmit%d : boolean;" s) slist)
let rlistToState rlist =
    String.concat ~sep:"\n" (List.map ~f:(fun r -> 
                  sprintf "  for i:indexType do\n    %s_known[i] := false;\n  endfor;" r) rlist)
let rlistToDest1 rlist = 
    String.concat ~sep:" |" (List.map ~f:(fun r -> 
                  sprintf "%s_known[msgNo1]" r) rlist)
let rlistToDest2 rlist = 
    String.concat ~sep:" |" (List.map ~f:(fun r -> 
                  sprintf "%s_known[msgNo2]" r) rlist)
let printPatSetVars pats =
  String.concat  (List.mapi ~f:(fun i p ->sprintf "  pat%dSet: msgSet;\n" (i+1)^
                                          sprintf "  sPat%dSet: msgSet;\n" (i+1)) pats)


(**pattern match part *)
let rec isSamePat m1 m2 =
  match (m1,m2) with
  | (`Aenc(m1',k1'),`Aenc(m2',k2')) -> if (isSamePat k1' k2') && (isSamePat m1' m2') then true else false
  | (`Senc(m1',k1'),`Senc(m2',k2')) -> if (isSamePat k1' k2') && (isSamePat m1' m2') then true else false
  | (`Tmp(m1), `Tmp(m2))-> if (m1=m2) then true else false
  | (`Exp(m11,m12),`Exp(m21,m22)) -> if (isSamePat m11 m21) && (isSamePat m12 m22) then true else false
  | (`Const i1,`Const i2) -> true
  | (`Mod(m11,m12),`Mod(m21,m22)) -> if (isSamePat m11 m21) && (isSamePat m12 m22) then true else false
  | (`Pk r1,`Pk r2) -> true
  | (`Sk r1,`Sk r2) -> true
  (* | (`Pk r1,`Sk r2) -> true  (* sk(r1),pk(r1) are the same pat, they are stored into the same patSet*)
  | (`Sk r1,`Pk r2) -> true *)
  | (`K(r11,r12),`K(r21,r22)) -> true
  | (`Var n1,`Var n2) -> true
  | (`Concat msgs1,`Concat msgs2) -> isSameList msgs1 msgs2
  | (`Hash(m1'),`Hash(m2')) -> true
  | (`Str r1,`Str r2) -> true
  | (`Sign(m1',k1'),`Sign(m2',k2')) -> if (isSamePat k1' k2') && (isSamePat m1' m2') then true else false

  | _ -> false

and isSameList msgs1 msgs2 = 
  let len1 = List.length msgs1 in
  let len2 = List.length msgs2 in
  if len1 <> len2 then false 
  else let boolList = List.map2_exn ~f:isSamePat msgs1 msgs2 in
  match List.reduce ~f:(&&) boolList with
  | Some b -> b
  | None -> false 
;;

(* Get pattern Set number in Murphi code *)
let getPatNum pat patList=
  let len = List.length patList in
  let patIndex = ref 0 in
  for i = 0 to len do
    match List.nth patList i with
    | Some x -> if isSamePat pat x then patIndex := i+1
    | None -> ()
  done;
  !patIndex
;;

(* Extracting msg patterns from actions and its sub-patterns *)
(* Extract msg from action *)
(*let extractMsg (seq,r1,r2,n,m) = m ;;*)
let rec getSubMsg msg =
  match msg with
  |`Null -> []
  |`Var nonce -> [`Var nonce]
  |`Str role  -> [`Str role]
  |`Tmp m -> [`Tmp m]
  |`Const i -> [`Const i]
  |`Exp (m1,m2) -> (getSubMsg m1)@(getSubMsg m2)@ [msg]
  |`Mod (m1,m2) -> (getSubMsg m1)@(getSubMsg m2)@[msg]
  |`Concat msgs -> let submsgs = List.concat (List.map ~f:getSubMsg msgs) in 
                    submsgs@[msg]
  |`Aenc (m,k) -> (getSubMsg m)@ (getSubMsg k)@[m;k]@[msg]
  |`Senc (m,k) -> (getSubMsg m)@ (getSubMsg k) @[m;k]@[msg]
  |`Sign (m,k) -> (getSubMsg m)@ (getSubMsg k)@[m;k]@[msg]
  |`Hash m -> (getSubMsg m)@[msg]
  |`Pk role -> [`Pk role]
  |`Sk role -> [`Sk role]
  |`K (r1,r2) -> [`K (r1,r2)]
;;

(* To get equivalent msg pattern from patlist. *)
let rec existSamePat eqvlPats pat = 
  match eqvlPats with
  | [] -> false
  | hd::tl -> if isSamePat hd pat then true else existSamePat tl pat
;;

let isSubPat y x =
  let ysubs = getSubMsg y in
    let boollist = List.map ~f:(fun ysub -> if isSamePat ysub x then true else false) ysubs in
    match List.reduce ~f:(||) boollist with
    |Some b -> b
    |None -> false

let rec getEqvlMsgPattern patlist =
  let non_eqvlPat = ref [] in 
  let len = List.length patlist in
  for i = 0 to len do
	match List.nth patlist i with
	| None -> ()
 	| Some x -> if existSamePat !non_eqvlPat x then () else non_eqvlPat := (insert x !non_eqvlPat) (* insert x into an appropriate position *)
  done;
  !non_eqvlPat
and insert x patlist =
    match patlist with
    | [] -> x::patlist
    | [y] -> if isSubPat y x then x::patlist else patlist@[x] (* if x is a subpat of y,then x before y,else x after y*)
    | hd :: tl -> if isSubPat hd x then x::patlist else hd::(insert x tl)
;;

let rec getPatList actions =
  match actions with
  | `Null -> []
  | `Send (seq,s,r,mls,m) -> (getSubMsg m) @ [m]
  | `Receive (seq,s,m) -> (getSubMsg m) @ [m] 
  | `Actlist arr -> List.concat (List.map ~f:getPatList arr)

let getSendPatList actions = 
  let `Send (seq,s,r,mls,m) = actions in 
  (getSubMsg m) @ [m]
  
let rec list_max xs =
  match xs with
  | [] ->  failwith "list_max called on empty list" (* empty list: fail *)
  | [x] -> x (* single element list: return the element *)
  | x :: remainder -> max x (list_max remainder) (* multiple element list: recursive case *)


let getMaxLenMsg actions = 
  let pats = getPatList actions in
  list_max (List.map ~f:(fun p -> match p with
                                |`Null -> 0
                                |`Concat msgs -> List.length msgs
                                |_ -> 1 ) pats)

let rec getMsgs actions =
  match actions with
  | `Null -> []
  | `Send (seq,s,r,ms,m) -> [(seq,0,r,m)]
  | `Receive (seq,s,m) -> [(seq,0,"",m)]
  | `Actlist arr ->List.concat (List.map ~f:getMsgs arr)

let rec getMsgs1 action acts i= 
  match action with
  | `Null -> []
  | `Send (seq,s,r,ms,m) -> [] 
  | `Receive (seq,s,m) -> let il= (List.concat (List.map ~f:(fun a -> getSendActsBySeq a seq) acts)) in let `Send (seq1,s1,r1,ms1,m1) = (List.hd_exn il) in [(seq,i,r1,m1)]
  | `Actlist arr ->List.concat (List.map ~f:(fun a->getMsgs1 a acts i) arr)

  

let rec existInit msg atom =
    match msg with
    |`Null -> false
    |`Var n -> if isSamePat msg atom then 
                  match atom with
                  |`Var n1 -> if n = n1 then true else false
                  |_ -> false
                else false
    |`Str r -> if isSamePat msg atom then 
                match atom with
                |`Str r1 -> if r = r1 then true else false
                |_ -> false
              else false
    |`Const i -> if isSamePat msg atom then 
                match atom with
                |`Const i1 -> if i = i1 then true else false
                |_ -> false
              else false
    |`Concat msgs -> existInMsgs msgs atom
    |`Tmp m -> false
    |`Exp(m1,m2) -> false
    |`Mod(m1,m2) -> false
    |`Aenc (m,k) -> false
    |`Sign (m1,m2) ->false
    |`Senc (m,k) -> false
    |`Hash (m) -> false
    |`Pk r -> true
    |`Sk r -> false
    |`K (r1,r2) -> false
    |_ -> false
  and existInMsgs msgs atom =
    let boolList = List.map ~f:(fun msg -> existInit msg atom ) msgs in
    match List.reduce ~f:(||) boolList with
    |Some b -> b
    |None -> false 
  ;;
  
  let rec genSendAct rolename seq i m atoms length msgofRolename patlist =
    let commitStr = if i = length then sprintf "   role%s[i].commit := true;\n" rolename else "" in
    let patNum = getPatNum m patlist in
    sprintf "var msg:Message;\n    msgNo:indexType;\nbegin\n" ^
    sprintf "   clear msg;\n   cons%d(%s,msg,msgNo);\n" patNum (sendAtoms2Str rolename i atoms msgofRolename) ^
    sprintf "   ch[%d].empty := false;\n" seq ^ 
    sprintf "   ch[%d].msg := msg;\n" seq ^
    sprintf "   ch[%d].sender := role%s[i].%s;\n" seq rolename rolename ^ 
    sprintf "   ch[%d].receiver := Intruder;\n" seq ^
    sprintf "   role%s[i].st := %s%d;\n" rolename rolename ((i mod length)+1) ^
    (* sprintf "   printMsg(msg);\n" ^ 
    sprintf "   put \"\\n\";\n" ^  *)
    sprintf "   put \"role%s[i] in st%d\\n\";\n" rolename i ^
    commitStr ^
    sprintf "end;\n"
  and sendAtoms2Str rolename i atoms msgofRolename =
    let s = "role" ^ rolename ^"[i]." in
    let paralist = ref [] in
    let atoms' = ref [] in
    for i = 0 to (List.length atoms)-1 do
      match List.nth atoms i with
      |Some(`Var n) ->let n' = "nonce_"^n in
                      if listwithout !atoms' n' then
                      begin
                        atoms' := !atoms'@[n'];
                        let nstr = s^n in
                        paralist := !paralist@[nstr];
                      end
      |Some(`Const n) ->let n' = "number_"^n in
                      if listwithout !atoms' n' then
                      begin
                        atoms' := !atoms'@[n'];
                        let nstr = s^n in
                        paralist := !paralist@[nstr];
                      end
      |Some(`Str r) ->let r' = "agent_"^r in
                      if listwithout !atoms' r' then
                      begin
                        atoms':=!atoms'@[r'];
                        let rstr = s^r in
                        paralist := !paralist@[rstr];
                      end
      |Some(`Tmp mn) ->let mn'="tmp_"^mn in 
                      if listwithout !atoms' mn' then
                      begin
                        atoms':=!atoms'@[mn'];
                        let rstr = s^mn in
                        paralist := !paralist@[rstr];
                      end
      |Some(`Pk r) -> let r'="pk_"^r in
                      if listwithout !atoms' r' then
                      begin
                        atoms':=!atoms'@[r'];
                        let rstr = s^r in
                        paralist:=!paralist@[rstr];
                      end
      |Some(`Sk r) -> let r'="sk_"^r in
                      if listwithout !atoms' r' then
                      begin
                        atoms':=!atoms'@[r'];
                        let rstr = s^r in
                        paralist:=!paralist@[rstr];
                      end
      |Some(`K(r1,r2)) -> let r1'="symk1_"^r1 in
                          if listwithout !atoms' r1' then
                          begin
                            atoms':=!atoms'@[r1'];
                            let r1str = s^r1 in
                            paralist:=!paralist@[r1str];
                          end;
                          let r2'="symk2_"^r2 in
                          if listwithout !atoms' r2' then
                          begin
                            atoms':=!atoms'@[r2'];
                            let r2str = s^r2 in
                            paralist:=!paralist@[r2str];
                          end;
    |_ ->()
    done;
    String.concat ~sep:"," !paralist
  and getPkAg atoms msgofRolename =
    let ag = ref "" in
    let atomlen = List.length atoms in
    for i = 0 to (atomlen-1) do
      let ag' = match List.nth atoms i with
              | Some (`Pk r) -> r
              | Some (`Var n) -> ""
              | Some (`Str r) -> ""
              | _ -> ""
      in
      if ag' <> "" then ag := ag' else ()
    done;
    let loc = "loc" in
    if (existInit msgofRolename (`Str (!ag))) then !ag else loc^(!ag)
  ;;
  
  (** rolename: the owner of the strand
      i: i-th node in strand (-,m)
      m: msg of the i-th node
      atoms: atoms derived from msg
      length: strand length
      msgofRolename: get msg from initial knowledge
      patlist: Patterns derived from the protocol
  *)
  let rec genRecvAct rolename seq i m atoms length msgofRolename patlist =
    let commitStr = if i = length then sprintf "   role%s[i].commit := true;\n" rolename else "" in 
    let patNum = getPatNum m patlist in
    match m with 
    | `Aenc(m1,m2) ->
    sprintf "var flag_pat%d:boolean;\n    msg:Message;\nbegin\n" patNum ^ 
    sprintf "   clear msg;\n   msg := ch[%d].msg;\n   isPat%d(msg, flag_pat%d);\n" seq patNum patNum ^ 
    sprintf "   if(flag_pat%d) then\n" patNum ^
    sprintf "     destruct%d(msg,%s);\n" patNum (recvAtoms2Str atoms rolename) ^
    sprintf "     if(%s)then\n" (atoms2Str atoms rolename msgofRolename) ^
    sprintf "       ch[%d].empty:=true;\n       clear ch[%d].msg;\n" seq seq ^
    sprintf "       role%s[i].st := %s%d;\n" rolename rolename ((i mod length)+1) ^
    sprintf "     endif;\n"^
    sprintf "   endif;\n" ^
    sprintf "       put \"role%s[i] in st%d\\n\";\n" rolename i ^
    (* sprintf "   printMsg(msg);\n" ^ 
    sprintf "   put \"\\n\";\n" ^  *)
    commitStr ^
    sprintf "end;\n"
    |`Senc(m1,m2)->
    sprintf "var flag_pat%d:boolean;\n    msg:Message;\nbegin\n" patNum ^ 
    sprintf "   clear msg;\n   msg := ch[%d].msg;\n   isPat%d(msg, flag_pat%d);\n" seq patNum patNum ^ 
    sprintf "   if(flag_pat%d & %s_known[msg.sencKey]) then\n" patNum rolename ^
    sprintf "     destruct%d(msg,%s);\n" patNum (recvAtoms2Str atoms rolename) ^
    sprintf "     if(%s)then\n" (atoms2Str atoms rolename msgofRolename) ^
    (* sprintf "%s" (atoms2Str1 atoms rolename msgofRolename) ^ *)
    sprintf "       ch[%d].empty:=true;\n       clear ch[%d].msg;\n" seq seq ^
    sprintf "       role%s[i].st := %s%d;\n" rolename rolename ((i mod length)+1) ^
    sprintf "     endif;\n"^
    sprintf "   endif;\n" ^
    (* sprintf "   printMsg(msg);\n" ^ 
    sprintf "   put \"\\n\";\n" ^  *)
    sprintf "   put \"role%s[i] in st%d\\n\";\n" rolename i ^
    commitStr ^
    sprintf "end;\n"
    |_->    
    sprintf "var flag_pat%d:boolean;\n    msg:Message;\nbegin\n" patNum ^ 
    sprintf "   clear msg;\n   msg := ch[%d].msg;\n   isPat%d(msg, flag_pat%d);\n" seq patNum patNum ^ 
    sprintf "   if(flag_pat%d) then\n" patNum ^
    sprintf "     destruct%d(msg,%s);\n" patNum (recvAtoms2Str atoms rolename) ^
    sprintf "     if(%s)then\n" (atoms2Str atoms rolename msgofRolename) ^
    (* sprintf "%s" (atoms2Str1 atoms rolename msgofRolename) ^ *)
    sprintf "       ch[%d].empty:=true;\n       clear ch[%d].msg;\n" seq seq ^
    sprintf "       role%s[i].st := %s%d;\n" rolename rolename ((i mod length)+1) ^
    sprintf "     endif;\n"^
    sprintf "   endif;\n" ^
    (* sprintf "   printMsg(msg);\n" ^ 
    sprintf "   put \"\\n\";\n" ^  *)
    sprintf "   put \"role%s[i] in st%d\\n\";\n" rolename i ^
    commitStr ^
    sprintf "end;\n"
  
  and recvAtoms2Str atoms rolename = 
    let atoms' = ref [] in
    let str' = ref [] in
    let loc = "role"^rolename^"[i].loc" in
    for i = 0 to (List.length atoms)-1 do
      match List.nth atoms i with
      |Some (`Var n) -> let n' = "nonce_"^n in
                        if listwithout !atoms' n' then
                        begin 
                          atoms' := !atoms'@[n'];
                          let nstr = loc^n in
                          str' := !str'@[nstr];
                        end
      |Some (`Const n) -> let n' = "number_"^n in
                        if listwithout !atoms' n' then
                        begin 
                          atoms' := !atoms'@[n'];
                          let nstr = loc^n in
                          str' := !str'@[nstr];
                        end
      |Some (`Str r) -> let r' = "agent_"^r in
                        if listwithout !atoms' r' then 
                        begin
                          atoms' := !atoms'@[r'];
                          let rstr = loc^r in
                          str' := !str'@[rstr];
                        end
      |Some(`Tmp mn) ->let mn'="tmp_"^mn in 
                      if listwithout !atoms' mn' then
                      begin
                        atoms' := !atoms'@[mn'];
                        let rstr = loc^mn in
                        str' := !str'@[rstr];
                      end              
      |Some (`Pk r) ->let r' = "pk_"^r in
                      if listwithout !atoms' r' then 
                      begin
                        atoms' := !atoms'@[r'];
                        let rstr = loc^r in
                        str' := !str'@[rstr];
                      end
      |Some (`Sk r) ->let r' = "sk_"^r in
                      if listwithout !atoms' r' then 
                      begin
                        atoms' := !atoms'@[r'];
                        let rstr = loc^r in
                        str' := !str'@[rstr]
                      end
      |Some (`K(r1,r2)) ->let r1' = "symk1_"^r1 in
                          if listwithout !atoms' r1' then
                          begin
                            atoms' := !atoms'@[r1'];
                            let r1str = loc^r1 in
                            str' := !str'@[r1str];
                          end;
                          let r2' = "symk2_"^r2 in
                          if listwithout !atoms' r2' then
                          begin 
                            atoms' := !atoms'@[r2'];
                            let r2str = loc^r2 in
                            str' := !str'@[r2str];
                          end
      |_ -> ()
    done;
    String.concat ~sep:"," !str'
  and atoms2Str atoms rolename msgofRolename = 
    (* let loc = "role"^rolename^"[i].loc_" in   *)
    let atoms' = ref [] in
    let strlist = ref [] in
    for i = 0 to (List.length atoms)-1 do
      match List.nth atoms i with
      |Some (`Var n) -> let n' = "nonce_"^n in
                        if listwithout !atoms' n' then
                        begin 
                          atoms' := !atoms'@[n'];
                          let nstr = sprintf "matchNonce(role%s[i].loc%s, role%s[i].%s)" rolename n rolename n in
                          strlist := !strlist@[nstr];
                        end
      |Some (`Const n) -> let n' = "number_"^n in
                        if listwithout !atoms' n' then
                        begin 
                          atoms' := !atoms'@[n'];
                          let nstr = sprintf "matchNumber(role%s[i].loc%s, role%s[i].%s)" rolename n rolename n in
                          strlist := !strlist@[nstr];
                        end
      |Some (`Tmp m) -> let m' = "tmp_"^m in 
                        if listwithout !atoms' m' then 
                        begin 
                          atoms' :=!atoms' @ [m'];
                          let mstr = sprintf "matchTmp(role%s[i].loc%s, role%s[i].%s)" rolename m rolename m in 
                          strlist := !strlist@[mstr];
                        end
      |Some (`Str r) -> let r' = "agent_"^r in
                        if listwithout !atoms' r' then 
                        begin
                          atoms' := !atoms'@[r'];
                          let rstr = sprintf "matchAgent(role%s[i].loc%s, role%s[i].%s)" rolename r rolename r in
                          strlist := !strlist@[rstr];
                        end
      |Some (`Pk r) ->let r' = "pk_"^r in
                      if listwithout !atoms' r' then 
                      begin
                        atoms' := !atoms'@[r'];
                        let rstr = sprintf "matchAgent(role%s[i].loc%s, role%s[i].%s)" rolename r rolename r in
                        strlist := !strlist@[rstr];
                      end
      |Some (`Sk r) ->let r' = "sk_"^r in
                      if listwithout !atoms' r' then 
                      begin
                        atoms' := !atoms'@[r'];
                        let rstr = sprintf "matchAgent(role%s[i].loc%s, role%s[i].%s)" rolename r rolename r in
                        strlist := !strlist@[rstr]
                      end
      |Some (`K(r1,r2)) ->let r1' = "symk1_"^r1 in
                          if listwithout !atoms' r1' then
                          begin
                            atoms' := !atoms'@[r1'];
                            let r1str = sprintf "matchAgent(role%s[i].loc%s, role%s[i].%s)" rolename r1 rolename r1 in
                            strlist := !strlist@[r1str];
                          end;
                          let r2' = "symk2_"^r2 in
                          if listwithout !atoms' r2' then
                          begin 
                            atoms' := !atoms'@[r2'];
                            let r2str = sprintf "matchAgent(role%s[i].loc%s, role%s[i].%s)" rolename r2 rolename r2 in
                            strlist := !strlist@[r2str];
                          end
      |_ -> ()
    done;
    String.concat ~sep:" & " !strlist
    and atoms2Str1 atoms rolename msgofRolename = 
    (* let loc = "role"^rolename^"[i].loc_" in   *)
    let atoms' = ref [] in
    let strlist1 = ref [] in
    for i = 0 to (List.length atoms)-1 do
      match List.nth atoms i with
      |Some (`Var n) -> let n' = "nonce_"^n in
                        if listwithout !atoms' n' then
                        begin 
                          atoms' := !atoms'@[n'];
                          let nstr = sprintf "       if role%s[i].%s = anyNonce then\n        role%s[i].%s :=role%s[i].loc%s;\n       endif;\n" rolename n rolename n rolename n in
                          strlist1 := !strlist1@[nstr];
                        end
      |Some (`Const n) -> let n' = "number_"^n in
                        if listwithout !atoms' n' then
                        begin 
                          atoms' := !atoms'@[n'];
                          let nstr = sprintf "       if role%s[i].%s = anyNumber then\n        role%s[i].%s :=role%s[i].loc%s;\n       endif;\n" rolename n rolename n rolename n in
                          strlist1 := !strlist1@[nstr];
                        end
      |Some (`Tmp m) -> let m' = "tmp_"^m in 
                        if listwithout !atoms' m' then 
                        begin 
                          atoms' :=!atoms' @ [m'];
                          let mstr = sprintf "       if role%s[i].%s.tmpPart = 0 then\n        role%s[i].%s :=role%s[i].loc%s;\n       endif;\n" rolename m rolename m rolename m in
                          strlist1 := !strlist1@[mstr];
                        end
      |Some (`Str r) -> let r' = "agent_"^r in
                        if listwithout !atoms' r' then 
                        begin
                          atoms' := !atoms'@[r'];
                          let rstr = sprintf "       if role%s[i].%s = anyAgent then\n        role%s[i].%s :=role%s[i].loc%s;\n       endif;\n" rolename r rolename r rolename r in
                          strlist1 := !strlist1@[rstr];
                        end
      |Some (`Pk r) ->let r' = "pk_"^r in
                      if listwithout !atoms' r' then 
                      begin
                        atoms' := !atoms'@[r'];
                        let rstr = sprintf "       if role%s[i].%s = anyAgent then\n        role%s[i].%s :=role%s[i].loc%s;\n       endif;\n" rolename r rolename r rolename r in
                        strlist1 := !strlist1@[rstr];
                      end
      |Some (`Sk r) ->let r' = "sk_"^r in
                      if listwithout !atoms' r' then 
                      begin
                        atoms' := !atoms'@[r'];
                        let rstr = sprintf "       if role%s[i].%s = anyAgent then\n        role%s[i].%s :=role%s[i].loc%s;\n       endif;\n" rolename r rolename r rolename r in
                        strlist1 := !strlist1@[rstr]
                      end
      |Some (`K(r1,r2)) ->let r1' = "symk1_"^r1 in
                          if listwithout !atoms' r1' then
                          begin
                            atoms' := !atoms'@[r1'];
                            let r1str = sprintf "       if role%s[i].%s = anyAgent then\n        role%s[i].%s :=role%s[i].loc%s;\n       endif;\n" rolename r1 rolename r1 rolename r1 in
                            strlist1 := !strlist1@[r1str];
                          end;
                          let r2' = "symk2_"^r2 in
                          if listwithout !atoms' r2' then
                          begin 
                            atoms' := !atoms'@[r2'];
                            let r2str = sprintf "       if role%s[i].%s = anyAgent then\n        role%s[i].%s :=role%s[i].loc%s;\n       endif;\n" rolename r2 rolename r2 rolename r2 in
                            strlist1 := !strlist1@[r2str];
                          end
      |_ -> () 
      done;
      String.concat ~sep:"" !strlist1
  (*   
    let strlist = (List.map ~f:(fun  a ->
    match a with
    |`Var n -> sprintf "matchNonce(role%s[i].loc%s, role%s[i].%s)" rolename n rolename n
    |`Str r -> sprintf "matchAgent(role%s[i].loc%s, role%s[i].%s)" rolename r rolename r
    |`Pk r -> sprintf "matchAgent(role%s[i].loc%s, role%s[i].%s)" rolename r rolename r
    |`Sk r -> sprintf "matchAgent(role%s[i].loc%s, role%s[i].%s)" rolename r rolename r
    |_ -> "null" ) atoms)
    in
    String.concat ~sep:" & " (remove strlist "true")
  *)
  ;;
  

  let rec trans act i rolename length msgOfrolename patlist agents=
    match act with
    |`Null -> sprintf ""
    |`Send (seq, s,r,ms, m) ->let atoms = getAtoms m in
                      (* let atoms = del_duplicate atoms in *)
                      genRuleName rolename i^
                      genSendGuard rolename i seq^
                      (genSendAct rolename seq i m atoms length msgOfrolename patlist)
    |`Receive (seq,s,m) ->let atoms = getAtoms m in
                      let atoms = del_duplicate atoms in
                      genRuleName rolename i ^
                      genRecvGuard rolename i seq agents^
                      (genRecvAct rolename seq i m atoms length msgOfrolename patlist)
    | `Actlist arr -> String.concat (List.map ~f:(fun a-> trans a i rolename length msgOfrolename patlist agents)  arr)
  ;;

let print_murphiRule agents knws =  (*printf "murphi code"*)
  let rolelist = getRolesFromKnws knws [] in (* Get role list:[A;B;...] *)
  (* let actsOfAllRls = getActsList actions rolelist in  Get act list: [(sign,seq,msg);(sign,seq,msg);...] *)
  let actOfAgent = List.map ~f:(fun r->getActsList agents r) rolelist in (*get role's action*)
  let initKnws = getMsgOfRoles knws in 
  let allOfAct =  (getAllActsList agents) in
  let patlist = List.concat (List.map ~f:getPatList (allOfAct)) in (*get all patterns from actions*)
  let patlist = del_duplicate patlist in (* delete duplicate *)
  let patlist = getEqvlMsgPattern patlist in (* delete equivalent class *)
  String.concat (List.mapi ~f:(fun i r -> (*if i = 0  || i = 1 then*)
                            let acts =  List.nth_exn actOfAgent i  (* Get the i-th act list of role_i*)
                            in
                            let msgofRole = match List.nth initKnws i with (* Get the i-th msg list of role_i*)
                                            |None -> `Null
                                            |Some msg -> msg
                            in
                            let lenActs = List.length acts in
                            sprintf "ruleset i:role%sNums do\n" r ^
                            String.concat (List.mapi ~f:(fun j act -> trans act (j+1) r lenActs msgofRole patlist agents) acts) ^
                            sprintf "endruleset;\n\n" ) rolelist)


let genCodeOfIntruderGetMsg (seq,st,r,m) patList = 
  let j = getPatNum m patList in
  sprintf "\n---rule of intruder to get msg from ch[%d] \n" seq ^
  sprintf "rule \"intruderGetMsgFromCh[%d]\" \n" seq ^ 
  sprintf "  ch[%d].empty = false & ch[%d].sender != Intruder ==>\n" seq seq^
  sprintf "  var flag_pat%d:boolean;\n      msgNo:indexType;\n      msg:Message;\n" j^
  sprintf "  begin\n" ^
  sprintf "    msg := ch[%d].msg;\n" seq ^ 
  sprintf "    get_msgNo(msg, msgNo);\n"^ 
  sprintf "    msg.tmpPart := msgNo;\n" ^
  sprintf "    isPat%d(msg,flag_pat%d);\n" j j^ 
  sprintf "    if (flag_pat%d) then\n" j^
  sprintf "      if(!exist(pat%dSet,msgNo)) then\n" j^
  sprintf "        pat%dSet.length:=pat%dSet.length+1;\n" j j^
  sprintf "        pat%dSet.content[pat%dSet.length]:=msgNo;\n" j j^
  sprintf "        Spy_known[msgNo] := true;\n"^
  sprintf "      endif;\n" ^
  sprintf "      ch[%d].empty := true;\n      clear ch[%d].msg;\n" seq seq^
  sprintf "    endif;\n" ^
  sprintf "    put \"intruder get msg from ch[%d].\\n\";\n" seq ^
  sprintf "  end;\n"
;;

let genCodeOfIntruderEmitMsg (seq,st,r,m) patList= 
  let j = getPatNum m patList in
  let str1 = sprintf "\n---rule of intruder to emit msg into ch[%d].\n" seq ^ sprintf "ruleset i: msgLen do\n" in
  let str2 = sprintf "  ruleset j: role%sNums do\n" r in
  let str3 = sprintf "    rule \"intruderEmitMsgIntoCh[%d]\"\n" seq ^ sprintf "      %s role%s[j].st = %s%d & ch[%d].empty=true & i <= pat%dSet.length & pat%dSet.content[i] != 0 & Spy_known[pat%dSet.content[i]] & !emit[pat%dSet.content[i]] ---& matchPat(msgs[pat%dSet.content[i]], sPat%dSet)\n      ==>\n" (if seq = 1 then sprintf "" else sprintf "IntruEmit%d = true &" (seq-1)) r r st seq  j j j j j j^
  (* let str3 = sprintf "    rule \"intruderEmitMsgIntoCh[%d]\"\n" seq ^ sprintf "      role%s[j].st = %s%d & ch[%d].empty=true & i <= pat%dSet.length & pat%dSet.content[i] != 0 & Spy_known[pat%dSet.content[i]] & !emit[pat%dSet.content[i]] ---& matchPat(msgs[pat%dSet.content[i]], sPat%dSet)\n      ==>\n"  r r st seq  j j j j j j^  *)
 
             sprintf "      begin\n "   ^ 
             sprintf "        clear ch[%d];\n" seq ^sprintf "        ch[%d].msg:=msgs[pat%dSet.content[i]];\n" seq j^
             sprintf "        ch[%d].sender:=Intruder;\n" seq
  in
  let str4 = sprintf "        ch[%d].receiver:=role%s[j].%s;\n" seq r r in
  str1 ^ str2 ^ str3^ str4 ^ 
  sprintf "        ch[%d].empty:=false;\n" seq^
  sprintf "        emit[pat%dSet.content[i]] := true;\n" j^
  sprintf "        IntruEmit%d := true;\n" seq ^
  sprintf "        put \"intruder emit msg into ch[%d].\\n\";\n" seq ^
  sprintf "      end;\n"^
  sprintf "  endruleset;\n"^
  sprintf "endruleset;\n"
;;

let print_murphiRule_ofIntruder agents knws=
  let rolelist = getRolesFromKnws knws [] in (* Get role list:[A;B;...] *)
  let actOfAgent = List.map ~f:(fun r->getActsList agents r) rolelist in (*get role's action*)
  let actions = getAllActsList agents in
  let sendActions = List.concat (List.map ~f:getAllSendActs actions ) in 
  let receActions = List.concat (List.map ~f:getAllReceActs actions ) in
  let msgs = List.concat (List.map ~f:getMsgs (receActions)) in    (* get all msgs from actions *)
  let msgs1 = List.concat (List.map ~f:getMsgs (sendActions)) in    (* get all msgs from actions *)
  let msgs2 = List.concat (List.mapi ~f:(fun i a->getMsgs1 a sendActions (i+1) ) (actions)) in    (* get all msgs from actions *)
  let try1 = List.concat (List.map ~f:(fun aas ->List.concat (List.mapi ~f:(fun i a->getMsgs1 a actions (i+1) ) aas)) actOfAgent) in 
  let patlist = List.concat (List.map ~f:getPatList (actions)) in (*get all patterns from actions*)
  let non_dup = del_duplicate patlist in (* delete duplicate *)
  let non_equivalent = getEqvlMsgPattern non_dup in
  let getMsgStr = String.concat (List.map ~f:(fun m -> genCodeOfIntruderGetMsg m non_equivalent) msgs1) in
  let emitMsgStr = String.concat (List.mapi ~f:(fun i m -> genCodeOfIntruderEmitMsg m non_equivalent) try1) in
  getMsgStr ^ emitMsgStr      
  