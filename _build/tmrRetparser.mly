%token <string> IDENT
%token <string> USTR
%token <string> STRING
/* %token <char> CHAR */
%token <int> INT (* parse integers *)
%token LEFT_BRACE
%token RIGHT_BRACE
%token LEFT_BRACK
%token RIGHT_BRACK
%token LEFT_MIDBRACE
%token PLUS
%token MINUS
%token RIGHT_MIDBRACE
%token COMMA
%token PERIOD  
/* %token AT */
%token AGENTS
%token AGENT
%token NUMBER
%token TO
%token FUNCTION
%left PERIOD 
%token INV
%token XOR
%token PK
%token SK
%token K
%token TMP
%token MULTI
/* %token FRESH  */
%token LEFT_ANGLEBARCK
%token RIGHT_ANGLEBARCK
%token NONCE
%token HASHCON
%token SIGN
%token EXP
%token MOD
%token AENC
%token SENC
/* %token SENDTO */
%token COLON
%token SEMICOLON
%token ACTIONS
%token GOALS
%token KNOWLEDGES
%token TYPES
%token PROTOCOL
%token END
%token SECRETOF
%token NINJ
%token INJ
%token ON
%token EOF
%token ENVIRONMENT
%token CONF
%token AND
%token CONST
%token F1
%token F2
%token FORMAT
%start <Proctype.protocols option> prog
%%
(* part 1 *)
prog:
  | p = protocols; EOF { Some p }
  | EOF       { None   } 
;

protocols:
  | PROTOCOL; name=IDENT; COLON ; p=pocolcontext ; END { `Protocol (name,p)}
;

pocolcontext:
  | t=types;k=knowledges;ag = agents;env=envrionment; g = goals; { `Pocol (t,k,ag,g,env) }
;

types:
  | TYPES; typelist = mode;{typelist}
;
mode:
  | AGENT; rs=ident_list {`Agent rs}
  | NUMBER ; ms=message_list {`Number ms}
  | LEFT_BRACE; ms = type_list ; RIGHT_BRACE {`Modelist ms}
;

ident_list:
  is = separated_list(PERIOD,IDENT) {is}

type_list: 
 ts = separated_list(SEMICOLON, mode)    { ts } 
;

agents:
  |AGENTS ; ags=agent;{ags}
;
agent:
  | name=IDENT ;COLON; ms = message_list ;COMMA; actlist=action_list;{`Agent (name,ms,actlist)}
  /* | RESP ; ms = message_list ;COMMA; actlist=action_list;{`Resp (ms,actlist)} */
  | LEFT_BRACE; agts = agent_list; RIGHT_BRACE {`Agentlist agts}
;

agent_list:
  ags = separated_list(SEMICOLON, agent) {ags}
;

knowledges:
  | KNOWLEDGES; knwlist=knowledge; { knwlist }
;

knowledge:
  | r=IDENT; COLON ; m=message { `Knowledge (r,m) }
  | LEFT_BRACE; knws = knowledge_list; RIGHT_BRACE { `Knowledge_list knws}
;

knowledge_list:
  knws = separated_list(SEMICOLON, knowledge)    { knws } 
;

envrionment:
  | ENVIRONMENT; envlist = envs; { envlist }
;

envs:
  | LEFT_MIDBRACE; seq=IDENT; RIGHT_MIDBRACE; r=IDENT; LEFT_MIDBRACE; num = INT; RIGHT_MIDBRACE; COLON; m=message { `Env_agent (r,num,m)} (* add the attribute num *)
  | LEFT_BRACE; envs = env_list; RIGHT_BRACE {`Envlist envs }
;
env_list:
 envs = separated_list(SEMICOLON, envs) {envs} 
;
goals:
  | GOALS; goallist=goal; { goallist }
;
  
goal:
  (*| LEFT_MIDBRACE; seq=IDENT; RIGHT_MIDBRACE ; m=message; SECRETOF ; rlist=role { `Secretgoal (seq,m,rlist)}*)
  | LEFT_MIDBRACE; seq=IDENT; RIGHT_MIDBRACE ; m=message { `Secretgoal (seq,m)}
  | LEFT_MIDBRACE; seq=IDENT; RIGHT_MIDBRACE ; m=message; CONF; r1 = IDENT; AND; r2=IDENT { `Secretgoal1 (seq,m,r1,r2)}
  | LEFT_MIDBRACE; seq=IDENT; RIGHT_MIDBRACE ; r1=IDENT;NINJ;r2=IDENT;ON; m=message { `Agreegoal (seq,r1,r2,m)}
  | LEFT_MIDBRACE; seq=IDENT; COLON; seq1=INT; RIGHT_MIDBRACE ; r1=IDENT;NINJ;r2=IDENT;ON; m=message { `Agreegoal1 (seq,seq1,r1,r2,m)}
  | LEFT_BRACE; gols = goal_list; RIGHT_BRACE {`Goallist gols };


goal_list:
  gols = separated_list(SEMICOLON, goal)    { gols } 
;

role:
  | id=IDENT { `RoleName id}
  | LEFT_ANGLEBARCK;rlist=rolelist;RIGHT_ANGLEBARCK { `roleName_list  rlist}
;

rolelist:
  rlist = separated_nonempty_list(PERIOD, role)    { rlist } 
;

actions:
  | ACTIONS; actlist= action;  { actlist }
;
sign:
  |MINUS {`Minus}
  |PLUS {`Plus}
;
action:
   | LEFT_MIDBRACE;seq=INT;RIGHT_MIDBRACE;s=sign;COMMA;r=IDENT;COMMA;LEFT_BRACK;ms=message_list;RIGHT_BRACK;COLON;m=message{`Send (seq,s,r,ms,m)}
  | LEFT_MIDBRACE;seq=INT;RIGHT_MIDBRACE;s=sign;COLON;m=message {`Receive (seq,s,m)}
  | LEFT_BRACE;acts = action_list; RIGHT_BRACE { `Actlist acts}
;

action_list:
   acts = separated_list(COMMA, action)    { acts } 
;

message: 
  | id=IDENT { `Str id }
  | NONCE;LEFT_BRACK;id=IDENT;RIGHT_BRACK {`Var id }
  /* | FRESH;LEFT_BRACK;id=IDENT;RIGHT_BRACK {`Fresh id} */
  /* | INV;LEFT_BRACK;v=message;RIGHT_BRACK { `Inv v} */
  | PK;LEFT_BRACK;rlnm=IDENT;RIGHT_BRACK { `Pk rlnm }
  | SK;LEFT_BRACK;rlnm=IDENT;RIGHT_BRACK { `Sk rlnm }
  | TMP;LEFT_BRACK;mn=IDENT;RIGHT_BRACK{`Tmp mn}
  | MOD;LEFT_BRACK;m1=message;COMMA;m2=message;RIGHT_BRACK {`Mod (m1,m2)}
  /* | v1= message;MULTI;v2=message  {`Multi (v1,v2)} */
  | K;LEFT_BRACK;rlnm1=IDENT;COMMA;rlnm2=IDENT;RIGHT_BRACK { `K (rlnm1,rlnm2)}
  | HASHCON;LEFT_BRACK;v1=message;RIGHT_BRACK;{`Hash (v1)}
  | CONST;LEFT_BRACK;n = IDENT;RIGHT_BRACK{`Const n}
  | SIGN;LEFT_BRACE;v=message;RIGHT_BRACE;k=message {`Sign (v,k)}
  /* | XOR;LEFT_BRACK;v1=message;COMMA;v2=message;RIGHT_BRACK {`Xor (v1,v2)}  */
  | EXP;LEFT_BRACK;v=message;COMMA;i=message;RIGHT_BRACK {`Exp (v,i)} 
  | AENC;LEFT_BRACE;v1=message;RIGHT_BRACE;v2=message {`Aenc (v1,v2)}
  | SENC;LEFT_BRACE;v1=message;RIGHT_BRACE;v2=message {`Senc (v1,v2)} 
  | LEFT_ANGLEBARCK;msgs=message_list;RIGHT_ANGLEBARCK { `Concat msgs}
  | LEFT_BRACK;v=message;RIGHT_BRACK { v }
;

message_list:
  msgs = separated_list(PERIOD, message)    { msgs } 
;
