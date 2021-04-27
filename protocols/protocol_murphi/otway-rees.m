const
  roleANum:1;
  roleSNum:1;
  roleBNum:1;
  totalFact:100;
  msgLength:10;
  chanNum:18;
  invokeNum:10;
type
  indexType:0..totalFact;
  roleANums:1..roleANum;
  roleSNums:1..roleSNum;
  roleBNums:1..roleBNum;
  msgLen:0..msgLength;
  chanNums:0..chanNum;
  invokeNums:0..invokeNum;

  AgentType : enum{anyAgent,Intruder, Alice, Bob, Server}; ---Intruder 
  NonceType : enum{anyNonce, Na, N, Kab, Nb, na, n, kab, nb};
  ConstType : enum{anyNumber};
  MsgType : enum {null,agent,nonce,key,aenc,senc,sign,concat,hash,tmp,mod,e,number};
  
  EncryptType : enum{PK,SK,Symk,MsgK};
  KeyType: record 
    encType: EncryptType; 
    ag: AgentType; 
    ag1:AgentType;
    ag2:AgentType;
    m:indexType;
  end;

  AStatus: enum{A1,A2};
  SStatus: enum{S1,S2};
  BStatus: enum{B1,B2,B3,B4};

  Message: record
    msgType : MsgType;
    ag : AgentType;
    noncePart : NonceType;
    constPart : ConstType;
    tmpPart : indexType;
    k : KeyType;
    modMsg1 : indexType;
    modMsg2 : indexType;
    hashMsg : indexType;
    expMsg1 : indexType;
    expMsg2 : indexType;
    signMsg : indexType;
    signKey : indexType;
    aencMsg : indexType;
    aencKey : indexType;
    sencMsg : indexType;
    sencKey : indexType;
    concatPart: Array[msgLen] of indexType;--- concatParts could be written in arrays: concatPart: Array[msgLen] of indexType
    length : indexType;
  end;

  Channel: record
    msg : Message;
    sender : AgentType;
    receiver : AgentType;
    empty : boolean;
  end;
  RoleA : record
   Na : NonceType;
   N : NonceType;
   Kab : NonceType;
   Nb : NonceType;
   na : NonceType;
   n : NonceType;
   kab : NonceType;
   nb : NonceType;
   A : AgentType;
   S : AgentType;
   B : AgentType;
   m1 : Message;
   m2 : Message;

   locNa : NonceType;
   locN : NonceType;
   locKab : NonceType;
   locNb : NonceType;
   locna : NonceType;
   locn : NonceType;
   lockab : NonceType;
   locnb : NonceType;
   locA : AgentType;
   locS : AgentType;
   locB : AgentType;
   locm1 : Message;
   locm2 : Message;
   
   st: AStatus;
   commit : boolean;
  end;
  RoleS : record
   Na : NonceType;
   N : NonceType;
   Kab : NonceType;
   Nb : NonceType;
   na : NonceType;
   n : NonceType;
   kab : NonceType;
   nb : NonceType;
   A : AgentType;
   S : AgentType;
   B : AgentType;
   m1 : Message;
   m2 : Message;

   locNa : NonceType;
   locN : NonceType;
   locKab : NonceType;
   locNb : NonceType;
   locna : NonceType;
   locn : NonceType;
   lockab : NonceType;
   locnb : NonceType;
   locA : AgentType;
   locS : AgentType;
   locB : AgentType;
   locm1 : Message;
   locm2 : Message;
   
   st: SStatus;
   commit : boolean;
  end;
  RoleB : record
   Na : NonceType;
   N : NonceType;
   Kab : NonceType;
   Nb : NonceType;
   na : NonceType;
   n : NonceType;
   kab : NonceType;
   nb : NonceType;
   A : AgentType;
   S : AgentType;
   B : AgentType;
   m1 : Message;
   m2 : Message;

   locNa : NonceType;
   locN : NonceType;
   locKab : NonceType;
   locNb : NonceType;
   locna : NonceType;
   locn : NonceType;
   lockab : NonceType;
   locnb : NonceType;
   locA : AgentType;
   locS : AgentType;
   locB : AgentType;
   locm1 : Message;
   locm2 : Message;
   
   st: BStatus;
   commit : boolean;
  end;

  msgSet: record
    content : Array[indexType] of indexType;
    length : indexType;
  end;
  
var
  ch : Array[chanNums] of Channel;
  roleA : Array[roleANums] of RoleA;
  roleS : Array[roleSNums] of RoleS;
  roleB : Array[roleBNums] of RoleB;

  ---intruder    : RoleIntruder;
  msgs : Array[indexType] of Message;
  msg_end: indexType;
  pat1Set: msgSet;
  sPat1Set: msgSet;
  pat2Set: msgSet;
  sPat2Set: msgSet;
  pat3Set: msgSet;
  sPat3Set: msgSet;
  pat4Set: msgSet;
  sPat4Set: msgSet;
  pat5Set: msgSet;
  sPat5Set: msgSet;
  pat6Set: msgSet;
  sPat6Set: msgSet;
  pat7Set: msgSet;
  sPat7Set: msgSet;
  pat8Set: msgSet;
  sPat8Set: msgSet;
  pat9Set: msgSet;
  sPat9Set: msgSet;
  pat10Set: msgSet;
  sPat10Set: msgSet;
  pat11Set: msgSet;
  sPat11Set: msgSet;
  pat12Set: msgSet;
  sPat12Set: msgSet;
  pat13Set: msgSet;
  sPat13Set: msgSet;
  pat14Set: msgSet;
  sPat14Set: msgSet;
  pat15Set: msgSet;
  sPat15Set: msgSet;
  pat16Set: msgSet;
  sPat16Set: msgSet;
  pat17Set: msgSet;
  sPat17Set: msgSet;

  A_known : Array[indexType] of boolean;
  S_known : Array[indexType] of boolean;
  B_known : Array[indexType] of boolean;
  Spy_known: Array[indexType] of boolean;
  IntruEmit1 : boolean;
  IntruEmit2 : boolean;
  IntruEmit3 : boolean;
  IntruEmit4 : boolean;
  ---systemEvent   : array[eventNums] of Event;
  ---eve_end       : eventNums;
  emit: Array[indexType] of boolean;
  gnum : indexType;


procedure get_msgNo(msg:Message; Var num:indexType);
  var index:indexType;
    j:indexType;
    flag:boolean;
  begin
    index:=0;
    for i: indexType do
      if (msgs[i].msgType = msg.msgType) then
        if ( (msg.msgType=agent & msgs[i].ag=msg.ag)
        | (msg.msgType=nonce & msgs[i].noncePart=msg.noncePart)
        | (msg.msgType=tmp & msgs[i].tmpPart=msg.tmpPart)
        | (msg.msgType=mod & msgs[i].modMsg1=msg.modMsg1 & msgs[i].modMsg2=msg.modMsg2)
        | (msg.msgType=e & msgs[i].expMsg1=msg.expMsg1 & msgs[i].expMsg2=msg.expMsg2)
        | (msg.msgType=number & msgs[i].constPart=msg.constPart)
        | (msg.msgType=key & (msgs[i].k.encType=msg.k.encType & msg.k.encType != Symk & msgs[i].k.ag=msg.k.ag))
        | (msg.msgType=key & (msgs[i].k.encType=msg.k.encType & msg.k.encType = Symk & msgs[i].k.ag1=msg.k.ag1 & msgs[i].k.ag2=msg.k.ag2))
        | (msg.msgType=aenc & (msgs[i].aencMsg=msg.aencMsg & msgs[i].aencKey=msg.aencKey))
        | (msg.msgType=senc & (msgs[i].sencMsg=msg.sencMsg & msgs[i].sencKey=msg.sencKey))
        | (msg.msgType=sign & (msgs[i].signMsg=msg.signMsg & msgs[i].signKey=msg.signKey))
        | (msg.msgType=hash & (msgs[i].hashMsg=msg.hashMsg)) 
        ) then 
          index:=i;
        elsif (msg.msgType=concat & msg.length = msgs[i].length) then
          j := msg.length;
          flag := true;
          while j > 0 do
            if (msg.concatPart[j] != msgs[i].concatPart[j]) then
              flag := false;
            endif;
            j := j - 1;
        end;
        if (flag) then
          index := i;
        endif;
      endif;
    endif;
  endfor;
  num := index;
end;

procedure printMsg(msg:Message);
  var i:indexType;
  begin
    if msg.msgType=null then
      put "null\n";
    elsif msg.msgType=agent then
      put msg.ag;
    elsif msg.msgType=nonce then
      put msg.noncePart;
    elsif msg.msgType=key then
      if msg.k.encType=PK then
        put "PK(";
        put msg.k.ag;
        put ")";
      elsif msg.k.encType=SK then
        put "SK(";
        put msg.k.ag;
        put ")";
      elsif msg.k.encType=Symk then
        put "SymK(";
        put msg.k.ag1;
        put ",";
        put msg.k.ag2;
        put ")";
      endif;
      elsif msg.msgType=aenc then
        put "aenc{";
        printMsg(msgs[msg.aencMsg]);
        put "}";
        printMsg(msgs[msg.aencKey]);
      elsif msg.msgType=senc then
        put "senc{";
        printMsg(msgs[msg.sencMsg]);
        put "}";
        printMsg(msgs[msg.sencKey]);
      elsif msg.msgType = sign then 
        put "sign{";
        printMsg(msgs[msg.signMsg]);
        put "}";
        printMsg(msgs[msg.signKey]);
      elsif msg.msgType = hash then 
        put "hash(";
        printMsg(msgs[msg.hashMsg]);
        put ");"
      elsif msg.msgType=mod then 
        put "mod{";
        printMsg(msgs[msg.modMsg1]);
        put ",";
        printMsg(msgs[msg.modMsg2]);
        put "}";
      elsif msg.msgType= e then 
        put "exp{";
        printMsg(msgs[msg.expMsg1]);
        put ",";
        printMsg(msgs[msg.expMsg2]);
        put "}";
      elsif msg.msgType = number then 
        put msg.constPart;
      elsif msg.msgType = tmp then 
        put "tmp{";
        printMsg(msgs[msg.tmpPart]);
        put "}";
      elsif msg.msgType=concat then
        put "concat(";
        i := 1;
        while i < msg.length do
          printMsg(msgs[msg.concatPart[i]]);
          put ",";
          i := i+1;
        end;
        printMsg(msgs[msg.concatPart[i]]);
        put")";
      endif;
    end;
function inverseKey(msgK:Message):Message;
  var key_inv:Message;
  begin
    key_inv.msgType := null;
    if (msgK.msgType=key) then
      key_inv.msgType := msgK.msgType;
      if (msgK.k.encType = PK) then
        key_inv.k.encType := SK;
        key_inv.k.ag := msgK.k.ag;
      elsif (msgK.k.encType = SK) then
        key_inv.k.encType := PK;
        key_inv.k.ag := msgK.k.ag;
      elsif (msgK.k.encType = Symk) then
        key_inv.k.encType := Symk;
        key_inv.k.ag1 := msgK.k.ag1;
        key_inv.k.ag2 := msgK.k.ag2;
      endif;
    elsif (msgK.msgType != key) then 
      if (msgK.k.encType = MsgK) then 
        key_inv.msgType := msgK.msgType;
        ---key_inv.k.m := msgK.k.m;
        if (msgK.msgType = mod) then 
          ---key_inv.modMsg1 := msgK.modMsg1;
          ---key_inv.modMsg2 := msgK.modMsg2;
        ---elsif (msgK.msgType = e) then 
          ---key_inv.expMsg1 := msgK.expMsg1;
          ---key_inv.expMsg2 := msgK.expMsg2;
          key_inv := msgs[msgs[msgK.modMsg1].expMsg1];
          key_inv.k.encType := MsgK;
          elsif (msgK.msgType = hash) then 
          key_inv := msgs[msgK.hashMsg];
          key_inv.k.encType := MsgK;
        endif;
      endif;
    endif;
    return key_inv;
  end;
function inverseKeyIndex(msgK:Message):indexType;
  var key_inv:Message;
      index : indexType;
  begin
    key_inv := inverseKey(msgK);
    get_msgNo(key_inv,index);
    return index;
  end;
function judge(msg:Message;ag:AgentType;msg1:Message) :boolean;
  begin
    if msg.msgType = aenc & msg1.msgType != tmp then 
      return msgs[msg.aencKey].k.ag = ag;
    elsif msg.msgType = aenc & msg1.msgType = tmp then 
      return true;
    elsif msg.msgType = senc then 
      ---if msgs[msg.sencKey].k.m =0 then 
      return (msgs[msg.sencKey].k.ag1 = ag |msgs[msg.sencKey].k.ag2 = ag) 
      ---endif;
    endif;
    return true;
  end;

--- Sorry, construct_function of this pattern has not been written!

--- Sorry, construct_function of this pattern has not been written!

function construct3By1122(msgNo1,msgNo2,msgNo3,msgNo4:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 4) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3 & msgs[i].concatPart[4] = msgNo4) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := concat;
     msg.concatPart[1] := msgNo1;
     msg.concatPart[2] := msgNo2;
     msg.concatPart[3] := msgNo3;
     msg.concatPart[4] := msgNo4;
     msg.length := 4;
   endif;
   return msg;
  end;

function constructIndex3By1122(msgNo1,msgNo2,msgNo3,msgNo4:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 4) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3 & msgs[i].concatPart[4] = msgNo4) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index:=msg_end+1;
   endif;
   return index;
  end;

--- Sorry, construct_function of this pattern has not been written!

function construct5By34(msgNo31, msgNo42:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo31 & msgs[i].sencKey = msgNo42) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := senc;
     msg.sencMsg := msgNo31;
     msg.sencKey := msgNo42;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex5By34(msgNo31, msgNo42:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo31 & msgs[i].sencKey = msgNo42) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
      index:= msg_end + 1;
   endif;
   return index;
  end;
function construct6By1225(msgNo1,msgNo2,msgNo3,msgNo4:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 4) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3 & msgs[i].concatPart[4] = msgNo4) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := concat;
     msg.concatPart[1] := msgNo1;
     msg.concatPart[2] := msgNo2;
     msg.concatPart[3] := msgNo3;
     msg.concatPart[4] := msgNo4;
     msg.length := 4;
   endif;
   return msg;
  end;

function constructIndex6By1225(msgNo1,msgNo2,msgNo3,msgNo4:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 4) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3 & msgs[i].concatPart[4] = msgNo4) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index:=msg_end+1;
   endif;
   return index;
  end;

function construct7By11(msgNo1,msgNo2:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 2) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := concat;
     msg.concatPart[1] := msgNo1;
     msg.concatPart[2] := msgNo2;
     msg.length := 2;
   endif;
   return msg;
  end;

function constructIndex7By11(msgNo1,msgNo2:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 2) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index:=msg_end+1;
   endif;
   return index;
  end;

function construct8By74(msgNo71, msgNo42:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo71 & msgs[i].sencKey = msgNo42) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := senc;
     msg.sencMsg := msgNo71;
     msg.sencKey := msgNo42;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex8By74(msgNo71, msgNo42:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo71 & msgs[i].sencKey = msgNo42) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
      index:= msg_end + 1;
   endif;
   return index;
  end;
function construct9By18(msgNo1,msgNo2:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 2) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := concat;
     msg.concatPart[1] := msgNo1;
     msg.concatPart[2] := msgNo2;
     msg.length := 2;
   endif;
   return msg;
  end;

function constructIndex9By18(msgNo1,msgNo2:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 2) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index:=msg_end+1;
   endif;
   return index;
  end;

--- Sorry, construct_function of this pattern has not been written!

function construct11By122105(msgNo1,msgNo2,msgNo3,msgNo4,msgNo5:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 5) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3 & msgs[i].concatPart[4] = msgNo4 & msgs[i].concatPart[5] = msgNo5) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := concat;
     msg.concatPart[1] := msgNo1;
     msg.concatPart[2] := msgNo2;
     msg.concatPart[3] := msgNo3;
     msg.concatPart[4] := msgNo4;
     msg.concatPart[5] := msgNo5;
     msg.length := 5;
   endif;
   return msg;
  end;

function constructIndex11By122105(msgNo1,msgNo2,msgNo3,msgNo4,msgNo5:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 5) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3 & msgs[i].concatPart[4] = msgNo4 & msgs[i].concatPart[5] = msgNo5) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index:=msg_end+1;
   endif;
   return index;
  end;

function construct12By188(msgNo1,msgNo2,msgNo3:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 3) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := concat;
     msg.concatPart[1] := msgNo1;
     msg.concatPart[2] := msgNo2;
     msg.concatPart[3] := msgNo3;
     msg.length := 3;
   endif;
   return msg;
  end;

function constructIndex12By188(msgNo1,msgNo2,msgNo3:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 3) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index:=msg_end+1;
   endif;
   return index;
  end;

function construct13By12210(msgNo1,msgNo2,msgNo3,msgNo4:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 4) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3 & msgs[i].concatPart[4] = msgNo4) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := concat;
     msg.concatPart[1] := msgNo1;
     msg.concatPart[2] := msgNo2;
     msg.concatPart[3] := msgNo3;
     msg.concatPart[4] := msgNo4;
     msg.length := 4;
   endif;
   return msg;
  end;

function constructIndex13By12210(msgNo1,msgNo2,msgNo3,msgNo4:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 4) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3 & msgs[i].concatPart[4] = msgNo4) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index:=msg_end+1;
   endif;
   return index;
  end;

--- Sorry, construct_function of this pattern has not been written!

function construct15By1148(msgNo1,msgNo2,msgNo3:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 3) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := concat;
     msg.concatPart[1] := msgNo1;
     msg.concatPart[2] := msgNo2;
     msg.concatPart[3] := msgNo3;
     msg.length := 3;
   endif;
   return msg;
  end;

function constructIndex15By1148(msgNo1,msgNo2,msgNo3:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 3) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index:=msg_end+1;
   endif;
   return index;
  end;

function construct16By114(msgNo1,msgNo2:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 2) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := concat;
     msg.concatPart[1] := msgNo1;
     msg.concatPart[2] := msgNo2;
     msg.length := 2;
   endif;
   return msg;
  end;

function constructIndex16By114(msgNo1,msgNo2:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 2) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index:=msg_end+1;
   endif;
   return index;
  end;

---pat1: N 
procedure lookAddPat1(N:NonceType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
      index:=0;
      for i: indexType do
        if(msgs[i].msgType=nonce) then
          if(msgs[i].noncePart=N) then
            index:=i;
          endif;
        endif;
      endfor;
      if(index=0) then
        msg_end := msg_end + 1 ;
        index := msg_end;
        msgs[index].msgType := nonce;
        msgs[index].noncePart:=N; 
        msgs[index].length := 1;
      endif;
      num:=index;
      msg:=msgs[index];
  end;

---pat1: N 
procedure isPat1(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = nonce) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat1: N 
procedure constructSpat1(N:NonceType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = nonce) then
        if (msgs[i].noncePart = N) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := nonce;
      msgs[index].noncePart := N;
      msgs[index].length := 1;
    endif;
    sPat1Set.length := sPat1Set.length + 1;
    sPat1Set.content[sPat1Set.length] := index;
    num := index;
  end;

---pat2: A 
procedure lookAddPat2(A:AgentType; Var msg:Message; Var num : indexType);
 Var index : indexType;
 begin
   index:=0;
   for i: indexType do
    if (msgs[i].msgType = agent) then
      if (msgs[i].ag = A) then
        index:=i;
      endif;
    endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := agent;
     msgs[index].ag:=A; 
     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat2: A 
procedure isPat2(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = agent) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat2: A 
procedure constructSpat2(A:AgentType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = agent) then
        if (msgs[i].ag = A) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := agent;
      msgs[index].ag := A;
      msgs[index].length := 1;
    endif;
    sPat2Set.length := sPat2Set.length + 1;
    sPat2Set.content[sPat2Set.length] := index;
    num := index;
  end;

---pat3: Na.N.A.B 
procedure lookAddPat3(Na:NonceType; N:NonceType; A:AgentType; B:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3,msg4: Message;
     index,i1,i2,i3,i4:indexType;
  begin
   index:=0;
   lookAddPat1(Na, msg1, i1);
   lookAddPat1(N, msg2, i2);
   lookAddPat2(A, msg3, i3);
   lookAddPat2(B, msg4, i4);
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length=4) then
       if (msgs[i].concatPart[1]=i1 & msgs[i].concatPart[2]=i2 & msgs[i].concatPart[3]=i3 & msgs[i].concatPart[4]=i4) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := concat;
     msgs[index].concatPart[1]:=i1;
     msgs[index].concatPart[2]:=i2;
     msgs[index].concatPart[3]:=i3;
     msgs[index].concatPart[4]:=i4; 
     msgs[index].length := 4;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat3: Na.N.A.B 
procedure isPat3(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3,flagPart4: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     flagPart4 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat1(msgs[msg.concatPart[2]],flagPart2);
        isPat2(msgs[msg.concatPart[3]],flagPart3);
        isPat2(msgs[msg.concatPart[4]],flagPart4);
       if (flagPart1 & flagPart2 & flagPart3 & flagPart4) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat3: Na.N.A.B 
procedure constructSpat3(Na:NonceType; N:NonceType; A:AgentType; B:AgentType; Var num: indexType);
  Var i,index, i1, i2, i3, i4:indexType;
  begin
    index:=0;
    constructSpat1(Na, i1);
    constructSpat1(N, i2);
    constructSpat2(A, i3);
    constructSpat2(B, i4);
    i := 1;
    while(i<= msg_end) do
      if (msgs[i].msgType = concat & msgs[i].length = 4) then
        if (msgs[i].concatPart[1] = i1 & msgs[i].concatPart[2] = i2 & msgs[i].concatPart[3] = i3 & msgs[i].concatPart[4] = i4) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := concat;
      msgs[index].concatPart[1] := i1;
      msgs[index].concatPart[2] := i2;
      msgs[index].concatPart[3] := i3;
      msgs[index].concatPart[4] := i4;
      msgs[index].length := 4;
    endif;
    sPat3Set.length := sPat3Set.length + 1;
    sPat3Set.content[sPat3Set.length] := index;
    num := index;
  end;

---pat4: k(A,S) 
procedure lookAddPat4(Asymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    index := 0;
    for i :indexType do
      if (msgs[i].msgType = key) then 
        if (msgs[i].k.encType = Symk & msgs[i].k.ag1 = Asymk1 & msgs[i].k.ag2 = Ssymk2) then
          index := i;
        endif;
      endif;
    endfor;
    if (index = 0) then
      msg_end := msg_end + 1;
      index := msg_end;
      msgs[index].msgType := key;
      msgs[index].k.encType := Symk;
      msgs[index].k.ag1:=Asymk1;
      msgs[index].k.ag2:=Ssymk2;
    endif;
    num := index;
    msg := msgs[index];
  end;

---pat4: k(A,S) 
procedure isPat4(msg:Message; Var flag:boolean);
  var flag1:boolean;
  begin
    flag1:=false;
    if msg.msgType = key & msg.k.encType = Symk then
      flag1:=true;
    endif;
    flag:=flag1;
  end;

---spat4: k(A,S) 
procedure constructSpat4(Asymk1:AgentType; Ssymk2:AgentType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = key & msgs[i].k.encType = Symk) then
        if (msgs[i].k.ag1 = Asymk1 & msgs[i].k.ag2 = Ssymk2) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := key;
      msgs[index].k.encType := Symk;
      msgs[index].k.ag1 := Asymk1;
      msgs[index].k.ag2 := Ssymk2;
      msgs[index].length := 1;
    endif;
    sPat4Set.length := sPat4Set.length + 1;
    sPat4Set.content[sPat4Set.length] := index;
    num := index;
  end;

---pat5: senc{Na.N.A.B}k(A,S) 
procedure lookAddPat5(Na:NonceType; N:NonceType; A:AgentType; B:AgentType; Asymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat3(Na, N, A, B,msg1,i1);
   lookAddPat4(Asymk1, Ssymk2,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = i1 & msgs[i].sencKey = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := senc;
     msgs[index].sencMsg := i1; 
     msgs[index].sencKey := i2; 
     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat5: senc{Na.N.A.B}k(A,S) 
procedure isPat5(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = senc then
      isPat3(msgs[msg.sencMsg],flagPart1);
      isPat4(msgs[msg.sencKey],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat5: senc{Na.N.A.B}k(A,S) 
procedure constructSpat5(Na:NonceType; N:NonceType; A:AgentType; B:AgentType; Asymk1:AgentType; Ssymk2:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat3(Na, N, A, B, i1);
    constructSpat4(Asymk1, Ssymk2, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = senc) then
        if (msgs[i].sencMsg = i1 & msgs[i].sencKey = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := senc;
      msgs[index].sencMsg := i1; 
      msgs[index].sencKey := i2; 
      msgs[index].length := 1;
    endif;
    sPat5Set.length := sPat5Set.length + 1;
    sPat5Set.content[sPat5Set.length] := index;
    num := index;
  end;

---pat6: N.A.B.senc{Na.N.A.B}k(A,S) 
procedure lookAddPat6(N:NonceType; A:AgentType; B:AgentType; Na:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3,msg4: Message;
     index,i1,i2,i3,i4:indexType;
  begin
   index:=0;
   lookAddPat1(N, msg1, i1);
   lookAddPat2(A, msg2, i2);
   lookAddPat2(B, msg3, i3);
   lookAddPat5(Na, N, A, B, Asymk1, Ssymk2, msg4, i4);
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length=4) then
       if (msgs[i].concatPart[1]=i1 & msgs[i].concatPart[2]=i2 & msgs[i].concatPart[3]=i3 & msgs[i].concatPart[4]=i4) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := concat;
     msgs[index].concatPart[1]:=i1;
     msgs[index].concatPart[2]:=i2;
     msgs[index].concatPart[3]:=i3;
     msgs[index].concatPart[4]:=i4; 
     msgs[index].length := 4;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat6: N.A.B.senc{Na.N.A.B}k(A,S) 
procedure isPat6(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3,flagPart4: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     flagPart4 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat2(msgs[msg.concatPart[2]],flagPart2);
        isPat2(msgs[msg.concatPart[3]],flagPart3);
        isPat5(msgs[msg.concatPart[4]],flagPart4);
       if (flagPart1 & flagPart2 & flagPart3 & flagPart4) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat6: N.A.B.senc{Na.N.A.B}k(A,S) 
procedure constructSpat6(N:NonceType; A:AgentType; B:AgentType; Na:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Var num: indexType);
  Var i,index, i1, i2, i3, i4:indexType;
  begin
    index:=0;
    constructSpat1(N, i1);
    constructSpat2(A, i2);
    constructSpat2(B, i3);
    constructSpat5(Na, N, A, B, Asymk1, Ssymk2, i4);
    i := 1;
    while(i<= msg_end) do
      if (msgs[i].msgType = concat & msgs[i].length = 4) then
        if (msgs[i].concatPart[1] = i1 & msgs[i].concatPart[2] = i2 & msgs[i].concatPart[3] = i3 & msgs[i].concatPart[4] = i4) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := concat;
      msgs[index].concatPart[1] := i1;
      msgs[index].concatPart[2] := i2;
      msgs[index].concatPart[3] := i3;
      msgs[index].concatPart[4] := i4;
      msgs[index].length := 4;
    endif;
    sPat6Set.length := sPat6Set.length + 1;
    sPat6Set.content[sPat6Set.length] := index;
    num := index;
  end;

---pat7: Na.Kab 
procedure lookAddPat7(Na:NonceType; Kab:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(Na, msg1, i1);
   lookAddPat1(Kab, msg2, i2);
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length=2) then
       if (msgs[i].concatPart[1]=i1 & msgs[i].concatPart[2]=i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := concat;
     msgs[index].concatPart[1]:=i1;
     msgs[index].concatPart[2]:=i2; 
     msgs[index].length := 2;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat7: Na.Kab 
procedure isPat7(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat1(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat7: Na.Kab 
procedure constructSpat7(Na:NonceType; Kab:NonceType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(Na, i1);
    constructSpat1(Kab, i2);
    i := 1;
    while(i<= msg_end) do
      if (msgs[i].msgType = concat & msgs[i].length = 2) then
        if (msgs[i].concatPart[1] = i1 & msgs[i].concatPart[2] = i2) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := concat;
      msgs[index].concatPart[1] := i1;
      msgs[index].concatPart[2] := i2;
      msgs[index].length := 2;
    endif;
    sPat7Set.length := sPat7Set.length + 1;
    sPat7Set.content[sPat7Set.length] := index;
    num := index;
  end;

---pat8: senc{Na.Kab}k(A,S) 
procedure lookAddPat8(Na:NonceType; Kab:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat7(Na, Kab,msg1,i1);
   lookAddPat4(Asymk1, Ssymk2,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = i1 & msgs[i].sencKey = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := senc;
     msgs[index].sencMsg := i1; 
     msgs[index].sencKey := i2; 
     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat8: senc{Na.Kab}k(A,S) 
procedure isPat8(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = senc then
      isPat7(msgs[msg.sencMsg],flagPart1);
      isPat4(msgs[msg.sencKey],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat8: senc{Na.Kab}k(A,S) 
procedure constructSpat8(Na:NonceType; Kab:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat7(Na, Kab, i1);
    constructSpat4(Asymk1, Ssymk2, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = senc) then
        if (msgs[i].sencMsg = i1 & msgs[i].sencKey = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := senc;
      msgs[index].sencMsg := i1; 
      msgs[index].sencKey := i2; 
      msgs[index].length := 1;
    endif;
    sPat8Set.length := sPat8Set.length + 1;
    sPat8Set.content[sPat8Set.length] := index;
    num := index;
  end;

---pat9: N.senc{Na.Kab}k(A,S) 
procedure lookAddPat9(N:NonceType; Na:NonceType; Kab:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(N, msg1, i1);
   lookAddPat8(Na, Kab, Asymk1, Ssymk2, msg2, i2);
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length=2) then
       if (msgs[i].concatPart[1]=i1 & msgs[i].concatPart[2]=i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := concat;
     msgs[index].concatPart[1]:=i1;
     msgs[index].concatPart[2]:=i2; 
     msgs[index].length := 2;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat9: N.senc{Na.Kab}k(A,S) 
procedure isPat9(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat8(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat9: N.senc{Na.Kab}k(A,S) 
procedure constructSpat9(N:NonceType; Na:NonceType; Kab:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(N, i1);
    constructSpat8(Na, Kab, Asymk1, Ssymk2, i2);
    i := 1;
    while(i<= msg_end) do
      if (msgs[i].msgType = concat & msgs[i].length = 2) then
        if (msgs[i].concatPart[1] = i1 & msgs[i].concatPart[2] = i2) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := concat;
      msgs[index].concatPart[1] := i1;
      msgs[index].concatPart[2] := i2;
      msgs[index].length := 2;
    endif;
    sPat9Set.length := sPat9Set.length + 1;
    sPat9Set.content[sPat9Set.length] := index;
    num := index;
  end;

---pat10: m1 
procedure lookAddPat10(m1:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[m1.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat10: m1 
procedure isPat10(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat10: m1 
procedure constructSpat10(m1:Message; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = tmp) then
        if (msgs[i].tmpPart = m1.tmpPart) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := tmp;
      msgs[index].tmpPart := m1.tmpPart;
      msgs[index].length := 1;
    endif;
    sPat10Set.length := sPat10Set.length + 1;
    sPat10Set.content[sPat10Set.length] := index;
    num := index;
  end;

---pat11: N.A.B.m1.senc{Nb.N.A.B}k(B,S) 
procedure lookAddPat11(N:NonceType; A:AgentType; B:AgentType; m1:Message; Nb:NonceType; Bsymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3,msg4,msg5: Message;
     index,i1,i2,i3,i4,i5:indexType;
  begin
   index:=0;
   lookAddPat1(N, msg1, i1);
   lookAddPat2(A, msg2, i2);
   lookAddPat2(B, msg3, i3);
   lookAddPat10(m1, msg4, i4);
   lookAddPat5(Nb, N, A, B, Bsymk1, Ssymk2, msg5, i5);
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length=5) then
       if (msgs[i].concatPart[1]=i1 & msgs[i].concatPart[2]=i2 & msgs[i].concatPart[3]=i3 & msgs[i].concatPart[4]=i4 & msgs[i].concatPart[5]=i5) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := concat;
     msgs[index].concatPart[1]:=i1;
     msgs[index].concatPart[2]:=i2;
     msgs[index].concatPart[3]:=i3;
     msgs[index].concatPart[4]:=i4;
     msgs[index].concatPart[5]:=i5; 
     msgs[index].length := 5;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat11: N.A.B.m1.senc{Nb.N.A.B}k(B,S) 
procedure isPat11(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3,flagPart4,flagPart5: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     flagPart4 := false;
     flagPart5 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat2(msgs[msg.concatPart[2]],flagPart2);
        isPat2(msgs[msg.concatPart[3]],flagPart3);
        isPat10(msgs[msg.concatPart[4]],flagPart4);
        isPat5(msgs[msg.concatPart[5]],flagPart5);
       if (flagPart1 & flagPart2 & flagPart3 & flagPart4 & flagPart5) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat11: N.A.B.m1.senc{Nb.N.A.B}k(B,S) 
procedure constructSpat11(N:NonceType; A:AgentType; B:AgentType; m1:Message; Nb:NonceType; Bsymk1:AgentType; Ssymk2:AgentType; Var num: indexType);
  Var i,index, i1, i2, i3, i4, i5:indexType;
  begin
    index:=0;
    constructSpat1(N, i1);
    constructSpat2(A, i2);
    constructSpat2(B, i3);
    constructSpat10(m1, i4);
    constructSpat5(Nb, N, A, B, Bsymk1, Ssymk2, i5);
    i := 1;
    while(i<= msg_end) do
      if (msgs[i].msgType = concat & msgs[i].length = 5) then
        if (msgs[i].concatPart[1] = i1 & msgs[i].concatPart[2] = i2 & msgs[i].concatPart[3] = i3 & msgs[i].concatPart[4] = i4 & msgs[i].concatPart[5] = i5) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := concat;
      msgs[index].concatPart[1] := i1;
      msgs[index].concatPart[2] := i2;
      msgs[index].concatPart[3] := i3;
      msgs[index].concatPart[4] := i4;
      msgs[index].concatPart[5] := i5;
      msgs[index].length := 5;
    endif;
    sPat11Set.length := sPat11Set.length + 1;
    sPat11Set.content[sPat11Set.length] := index;
    num := index;
  end;

---pat12: N.senc{Na.Kab}k(A,S).senc{Nb.Kab}k(B,S) 
procedure lookAddPat12(N:NonceType; Na:NonceType; Kab:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Nb:NonceType; Bsymk1:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3: Message;
     index,i1,i2,i3:indexType;
  begin
   index:=0;
   lookAddPat1(N, msg1, i1);
   lookAddPat8(Na, Kab, Asymk1, Ssymk2, msg2, i2);
   lookAddPat8(Nb, Kab, Bsymk1, Ssymk2, msg3, i3);
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length=3) then
       if (msgs[i].concatPart[1]=i1 & msgs[i].concatPart[2]=i2 & msgs[i].concatPart[3]=i3) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := concat;
     msgs[index].concatPart[1]:=i1;
     msgs[index].concatPart[2]:=i2;
     msgs[index].concatPart[3]:=i3; 
     msgs[index].length := 3;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat12: N.senc{Na.Kab}k(A,S).senc{Nb.Kab}k(B,S) 
procedure isPat12(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat8(msgs[msg.concatPart[2]],flagPart2);
        isPat8(msgs[msg.concatPart[3]],flagPart3);
       if (flagPart1 & flagPart2 & flagPart3) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat12: N.senc{Na.Kab}k(A,S).senc{Nb.Kab}k(B,S) 
procedure constructSpat12(N:NonceType; Na:NonceType; Kab:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Nb:NonceType; Bsymk1:AgentType; Var num: indexType);
  Var i,index, i1, i2, i3:indexType;
  begin
    index:=0;
    constructSpat1(N, i1);
    constructSpat8(Na, Kab, Asymk1, Ssymk2, i2);
    constructSpat8(Nb, Kab, Bsymk1, Ssymk2, i3);
    i := 1;
    while(i<= msg_end) do
      if (msgs[i].msgType = concat & msgs[i].length = 3) then
        if (msgs[i].concatPart[1] = i1 & msgs[i].concatPart[2] = i2 & msgs[i].concatPart[3] = i3) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := concat;
      msgs[index].concatPart[1] := i1;
      msgs[index].concatPart[2] := i2;
      msgs[index].concatPart[3] := i3;
      msgs[index].length := 3;
    endif;
    sPat12Set.length := sPat12Set.length + 1;
    sPat12Set.content[sPat12Set.length] := index;
    num := index;
  end;

---pat13: N.A.B.m1 
procedure lookAddPat13(N:NonceType; A:AgentType; B:AgentType; m1:Message; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3,msg4: Message;
     index,i1,i2,i3,i4:indexType;
  begin
   index:=0;
   lookAddPat1(N, msg1, i1);
   lookAddPat2(A, msg2, i2);
   lookAddPat2(B, msg3, i3);
   lookAddPat10(m1, msg4, i4);
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length=4) then
       if (msgs[i].concatPart[1]=i1 & msgs[i].concatPart[2]=i2 & msgs[i].concatPart[3]=i3 & msgs[i].concatPart[4]=i4) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := concat;
     msgs[index].concatPart[1]:=i1;
     msgs[index].concatPart[2]:=i2;
     msgs[index].concatPart[3]:=i3;
     msgs[index].concatPart[4]:=i4; 
     msgs[index].length := 4;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat13: N.A.B.m1 
procedure isPat13(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3,flagPart4: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     flagPart4 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat2(msgs[msg.concatPart[2]],flagPart2);
        isPat2(msgs[msg.concatPart[3]],flagPart3);
        isPat10(msgs[msg.concatPart[4]],flagPart4);
       if (flagPart1 & flagPart2 & flagPart3 & flagPart4) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat13: N.A.B.m1 
procedure constructSpat13(N:NonceType; A:AgentType; B:AgentType; m1:Message; Var num: indexType);
  Var i,index, i1, i2, i3, i4:indexType;
  begin
    index:=0;
    constructSpat1(N, i1);
    constructSpat2(A, i2);
    constructSpat2(B, i3);
    constructSpat10(m1, i4);
    i := 1;
    while(i<= msg_end) do
      if (msgs[i].msgType = concat & msgs[i].length = 4) then
        if (msgs[i].concatPart[1] = i1 & msgs[i].concatPart[2] = i2 & msgs[i].concatPart[3] = i3 & msgs[i].concatPart[4] = i4) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := concat;
      msgs[index].concatPart[1] := i1;
      msgs[index].concatPart[2] := i2;
      msgs[index].concatPart[3] := i3;
      msgs[index].concatPart[4] := i4;
      msgs[index].length := 4;
    endif;
    sPat13Set.length := sPat13Set.length + 1;
    sPat13Set.content[sPat13Set.length] := index;
    num := index;
  end;

---pat14: m2 
procedure lookAddPat14(m2:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[m2.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat14: m2 
procedure isPat14(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat14: m2 
procedure constructSpat14(m2:Message; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = tmp) then
        if (msgs[i].tmpPart = m2.tmpPart) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := tmp;
      msgs[index].tmpPart := m2.tmpPart;
      msgs[index].length := 1;
    endif;
    sPat14Set.length := sPat14Set.length + 1;
    sPat14Set.content[sPat14Set.length] := index;
    num := index;
  end;

---pat15: N.m2.senc{Nb.Kab}k(B,S) 
procedure lookAddPat15(N:NonceType; m2:Message; Nb:NonceType; Kab:NonceType; Bsymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3: Message;
     index,i1,i2,i3:indexType;
  begin
   index:=0;
   lookAddPat1(N, msg1, i1);
   lookAddPat14(m2, msg2, i2);
   lookAddPat8(Nb, Kab, Bsymk1, Ssymk2, msg3, i3);
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length=3) then
       if (msgs[i].concatPart[1]=i1 & msgs[i].concatPart[2]=i2 & msgs[i].concatPart[3]=i3) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := concat;
     msgs[index].concatPart[1]:=i1;
     msgs[index].concatPart[2]:=i2;
     msgs[index].concatPart[3]:=i3; 
     msgs[index].length := 3;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat15: N.m2.senc{Nb.Kab}k(B,S) 
procedure isPat15(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat14(msgs[msg.concatPart[2]],flagPart2);
        isPat8(msgs[msg.concatPart[3]],flagPart3);
       if (flagPart1 & flagPart2 & flagPart3) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat15: N.m2.senc{Nb.Kab}k(B,S) 
procedure constructSpat15(N:NonceType; m2:Message; Nb:NonceType; Kab:NonceType; Bsymk1:AgentType; Ssymk2:AgentType; Var num: indexType);
  Var i,index, i1, i2, i3:indexType;
  begin
    index:=0;
    constructSpat1(N, i1);
    constructSpat14(m2, i2);
    constructSpat8(Nb, Kab, Bsymk1, Ssymk2, i3);
    i := 1;
    while(i<= msg_end) do
      if (msgs[i].msgType = concat & msgs[i].length = 3) then
        if (msgs[i].concatPart[1] = i1 & msgs[i].concatPart[2] = i2 & msgs[i].concatPart[3] = i3) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := concat;
      msgs[index].concatPart[1] := i1;
      msgs[index].concatPart[2] := i2;
      msgs[index].concatPart[3] := i3;
      msgs[index].length := 3;
    endif;
    sPat15Set.length := sPat15Set.length + 1;
    sPat15Set.content[sPat15Set.length] := index;
    num := index;
  end;

---pat16: N.m2 
procedure lookAddPat16(N:NonceType; m2:Message; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(N, msg1, i1);
   lookAddPat14(m2, msg2, i2);
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length=2) then
       if (msgs[i].concatPart[1]=i1 & msgs[i].concatPart[2]=i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := concat;
     msgs[index].concatPart[1]:=i1;
     msgs[index].concatPart[2]:=i2; 
     msgs[index].length := 2;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat16: N.m2 
procedure isPat16(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat14(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat16: N.m2 
procedure constructSpat16(N:NonceType; m2:Message; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(N, i1);
    constructSpat14(m2, i2);
    i := 1;
    while(i<= msg_end) do
      if (msgs[i].msgType = concat & msgs[i].length = 2) then
        if (msgs[i].concatPart[1] = i1 & msgs[i].concatPart[2] = i2) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := concat;
      msgs[index].concatPart[1] := i1;
      msgs[index].concatPart[2] := i2;
      msgs[index].length := 2;
    endif;
    sPat16Set.length := sPat16Set.length + 1;
    sPat16Set.content[sPat16Set.length] := index;
    num := index;
  end;

procedure cons1(N:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat1(N,msg,num);
  end;
procedure destruct1(msg:Message; Var N:NonceType);
  begin
    N:=msg.noncePart;
  end;
procedure cons2(A:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat2(A,msg,num);
  end;
procedure destruct2(msg:Message; Var A:AgentType);
  begin
    A:=msg.ag;
  end;
procedure cons3(Na:NonceType; N:NonceType; A:AgentType; B:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat3(Na, N, A, B,msg,num);
  end;
procedure destruct3(msg:Message; Var Na:NonceType; Var N:NonceType; Var A:AgentType; Var B:AgentType);
  Var msgNum1,msgNum2,msgNum3,msgNum4: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    Na := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    N := msgNum2.noncePart;
    msgNum3 := msgs[msg.concatPart[3]];
    A := msgNum3.ag;
    msgNum4 := msgs[msg.concatPart[4]];
    B := msgNum4.ag
  end;
procedure cons4(Asymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat4(Asymk1, Ssymk2,msg,num);
  end;
procedure destruct4(msg:Message; Var Asymk1:AgentType; Var Ssymk2:AgentType);
  var k1:KeyType;
      msg1:Message;
   begin
      clear msg1;
      k1 := msg.k;
      Asymk1 := k1.ag1;
      Ssymk2 := k1.ag2;
   end;
procedure cons5(Na:NonceType; N:NonceType; A:AgentType; B:AgentType; Asymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat5(Na, N, A, B, Asymk1, Ssymk2,msg,num);
  end;
procedure destruct5(msg:Message; Var Na:NonceType; Var N:NonceType; Var A:AgentType; Var B:AgentType; Var Asymk1:AgentType; Var Ssymk2:AgentType);
  var k1:KeyType;
      sencMsg:Message;
      sencKey:Message;
      begin
       sencMsg:=msgs[msg.sencMsg];
       sencKey:=msgs[msg.sencKey];
       destruct3(sencMsg,Na, N, A, B);
       destruct4(sencKey,Asymk1, Ssymk2);
  end;
procedure cons6(N:NonceType; A:AgentType; B:AgentType; Na:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat6(N, A, B, Na, Asymk1, Ssymk2,msg,num);
  end;
procedure destruct6(msg:Message; Var N:NonceType; Var A:AgentType; Var B:AgentType; Var Na:NonceType; Var Asymk1:AgentType; Var Ssymk2:AgentType);
  Var msgNum1,msgNum2,msgNum3,msgNum4: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    N := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    A := msgNum2.ag;
    msgNum3 := msgs[msg.concatPart[3]];
    B := msgNum3.ag;
    msgNum4 := msgs[msg.concatPart[4]];
    destruct5(msgNum4,Na, N, A, B, Asymk1, Ssymk2)
  end;
procedure cons7(Na:NonceType; Kab:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat7(Na, Kab,msg,num);
  end;
procedure destruct7(msg:Message; Var Na:NonceType; Var Kab:NonceType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    Na := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    Kab := msgNum2.noncePart
  end;
procedure cons8(Na:NonceType; Kab:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat8(Na, Kab, Asymk1, Ssymk2,msg,num);
  end;
procedure destruct8(msg:Message; Var Na:NonceType; Var Kab:NonceType; Var Asymk1:AgentType; Var Ssymk2:AgentType);
  var k1:KeyType;
      sencMsg:Message;
      sencKey:Message;
      begin
       sencMsg:=msgs[msg.sencMsg];
       sencKey:=msgs[msg.sencKey];
       destruct7(sencMsg,Na, Kab);
       destruct4(sencKey,Asymk1, Ssymk2);
  end;
procedure cons9(N:NonceType; Na:NonceType; Kab:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat9(N, Na, Kab, Asymk1, Ssymk2,msg,num);
  end;
procedure destruct9(msg:Message; Var N:NonceType; Var Na:NonceType; Var Kab:NonceType; Var Asymk1:AgentType; Var Ssymk2:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    N := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct8(msgNum2,Na, Kab, Asymk1, Ssymk2)
  end;
procedure cons10(m1:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat10(m1,msg,num);
  end;
procedure destruct10(msg:Message; Var m1:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    m1:=msg;
    m1.tmpPart:=msgNo;
  end;
procedure cons11(N:NonceType; A:AgentType; B:AgentType; m1:Message; Nb:NonceType; Bsymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat11(N, A, B, m1, Nb, Bsymk1, Ssymk2,msg,num);
  end;
procedure destruct11(msg:Message; Var N:NonceType; Var A:AgentType; Var B:AgentType; Var m1:Message; Var Nb:NonceType; Var Bsymk1:AgentType; Var Ssymk2:AgentType);
  Var msgNum1,msgNum2,msgNum3,msgNum4,msgNum5: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    N := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    A := msgNum2.ag;
    msgNum3 := msgs[msg.concatPart[3]];
    B := msgNum3.ag;
    msgNum4 := msgs[msg.concatPart[4]];
    m1.msgType := tmp;
    m1.tmpPart := msg.concatPart[4];
    msgNum5 := msgs[msg.concatPart[5]];
    destruct5(msgNum5,Nb, N, A, B, Bsymk1, Ssymk2)
  end;
procedure cons12(N:NonceType; Na:NonceType; Kab:NonceType; Asymk1:AgentType; Ssymk2:AgentType; Nb:NonceType; Bsymk1:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat12(N, Na, Kab, Asymk1, Ssymk2, Nb, Bsymk1,msg,num);
  end;
procedure destruct12(msg:Message; Var N:NonceType; Var Na:NonceType; Var Kab:NonceType; Var Asymk1:AgentType; Var Ssymk2:AgentType; Var Nb:NonceType; Var Bsymk1:AgentType);
  Var msgNum1,msgNum2,msgNum3: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    N := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct8(msgNum2,Na, Kab, Asymk1, Ssymk2);
    msgNum3 := msgs[msg.concatPart[3]];
    destruct8(msgNum3,Nb, Kab, Bsymk1, Ssymk2)
  end;
procedure cons13(N:NonceType; A:AgentType; B:AgentType; m1:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat13(N, A, B, m1,msg,num);
  end;
procedure destruct13(msg:Message; Var N:NonceType; Var A:AgentType; Var B:AgentType; Var m1:Message);
  Var msgNum1,msgNum2,msgNum3,msgNum4: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    N := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    A := msgNum2.ag;
    msgNum3 := msgs[msg.concatPart[3]];
    B := msgNum3.ag;
    msgNum4 := msgs[msg.concatPart[4]];
    m1.msgType := tmp;
    m1.tmpPart := msg.concatPart[4]
  end;
procedure cons14(m2:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat14(m2,msg,num);
  end;
procedure destruct14(msg:Message; Var m2:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    m2:=msg;
    m2.tmpPart:=msgNo;
  end;
procedure cons15(N:NonceType; m2:Message; Nb:NonceType; Kab:NonceType; Bsymk1:AgentType; Ssymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat15(N, m2, Nb, Kab, Bsymk1, Ssymk2,msg,num);
  end;
procedure destruct15(msg:Message; Var N:NonceType; Var m2:Message; Var Nb:NonceType; Var Kab:NonceType; Var Bsymk1:AgentType; Var Ssymk2:AgentType);
  Var msgNum1,msgNum2,msgNum3: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    N := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    m2.msgType := tmp;
    m2.tmpPart := msg.concatPart[2];
    msgNum3 := msgs[msg.concatPart[3]];
    destruct8(msgNum3,Nb, Kab, Bsymk1, Ssymk2)
  end;
procedure cons16(N:NonceType; m2:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat16(N, m2,msg,num);
  end;
procedure destruct16(msg:Message; Var N:NonceType; Var m2:Message);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    N := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    m2.msgType := tmp;
    m2.tmpPart := msg.concatPart[2]
  end;
function exist(PatnSet:msgSet; msgNo:indexType):boolean;
  var flag:boolean;
  begin
    flag := false;
    for i:msgLen do
      if (msgNo != 0 & PatnSet.content[i] = msgNo) then 
        flag := true;
      endif;
    endfor;
    return flag;
  end;
function matchAgent(locAg: AgentType; Var Ag: AgentType):boolean;  ---if ag equals to locAg which was derived from recieving msg, or anyAgent, then true
  var flag : boolean;
  begin
    flag := false;
    if (Ag = anyAgent) then
      flag := true;
      Ag := locAg;
    elsif (locAg = Ag) then
      flag := true;
    else
      flag := false;
    endif;
    return flag;
  end;

function matchTmp(locm:Message;Var m:Message):boolean; ---if m equals to locm which was derived from recieving msg, or tmp, then true
  var flag : boolean;
  var index1,index2 :indexType;
  begin 
    flag := false;
    get_msgNo(m,index2);
    get_msgNo(locm,index1);
    if (m.msgType = tmp) then 
      if (m.tmpPart =0) then 
        flag := true;
        m:=locm;
      elsif ( index1 = index2) then 
        flag := true;
      endif;
    else 
      flag := false;
    endif;
     return flag;
  end;

function matchNonce(locNa: NonceType; Var Na: NonceType):boolean;  ---if Na equals to locNa which was derived from recieving msg, or anyNonce, then true
  var flag : boolean;
  begin
    flag := false;
    if (Na = anyNonce) then
      flag := true;
      Na := locNa;
    elsif (locNa = Na) then
      flag:=true;
    else
      flag := false;
    endif;
    return flag;
  end;

function matchNumber(locNm: ConstType; Var Nm: ConstType):boolean;  ---if Nm equals to locNm which was derived from recieving msg, or anyNumber, then true
  var flag : boolean;
  begin
    flag := false;
    if (Nm = anyNumber) then
      flag := true;
      Nm := locNm;
    elsif locNm = Nm then 
      flag := true;
    else
      flag := false;
    endif;
    return flag;
  end;

function match(m1:Message; var m2:Message):boolean;
  var concatFlag: boolean;
      i,msgNo: indexType;
  begin 
    if m1.msgType = tmp then  
      return true;
    elsif m1.msgType = agent & m2.msgType = agent then
	    return matchAgent(m1.ag,m2.ag); ---ag and noncePart should be initiallized as anyAgent or anyNonce (m1.ag != anyAgent & m2.ag != anyAgent &)
    elsif m1.msgType = nonce & m2.msgType = nonce then
	    return matchNonce(m1.noncePart,m2.noncePart); --- m1.noncePart != anyNonce & m2.noncePart != anyNonce &
    elsif m1.msgType = number & m2.msgType = number then 
      return matchNumber(m1.constPart,m2.constPart);
    elsif m1.msgType = key & m2.msgType = key then
      if m1.k.encType = PK then
        return (m1.k.encType = m2.k.encType) & (matchAgent(m1.k.ag, m2.k.ag));
      elsif m1.k.encType = SK then
        return (m1.k.encType = m2.k.encType) & (matchAgent(m1.k.ag, m2.k.ag));
      elsif m1.k.encType = Symk then
        return (m1.k.encType = m2.k.encType) & (matchAgent(m1.k.ag1, m2.k.ag1)) & (matchAgent(m1.k.ag2, m2.k.ag2));
      endif;
    elsif m1.msgType = aenc & m2.msgType = aenc then
	    return match(msgs[m1.aencMsg], msgs[m2.aencMsg]) & match(msgs[m1.aencKey], msgs[m2.aencKey]);
    elsif m1.msgType = senc & m2.msgType = senc then
	    return true;
      --match(msgs[m1.sencMsg], msgs[m2.sencMsg]) & match(msgs[m1.sencKey], msgs[m2.sencKey]);
    elsif (m1.msgType = mod & m2.msgType = mod) then 
      return match(msgs[m1.modMsg1],msgs[m2.modMsg1]) & match(msgs[m1.modMsg2],msgs[m2.modMsg2]);
    elsif (m1.msgType = e & m2.msgType = e) then 
      return match(msgs[m1.expMsg1],msgs[m2.expMsg1]) & match(msgs[m1.expMsg2],msgs[m2.expMsg2]);
    elsif (m1.msgType = concat & m2.msgType = concat) & (m1.length = m2.length)  then
      concatFlag := true;
      i := m1.length;
      while (i > 0 & concatFlag)do
        concatFlag := concatFlag & match(msgs[m1.concatPart[i]], msgs[m2.concatPart[i]]);
        i := i-1;
      end;
	    return concatFlag;
    else
	    return false;
    endif;	
  end;

function matchPat(m1:Message; sPatnSet: msgSet):boolean;
  var flag:boolean;
      i : indexType;
  begin
    flag := false;
    i := 1;
    while (i<sPatnSet.length+1) do
      if(match(m1,msgs[sPatnSet.content[i]])) then
        flag := true;
      endif;
      i := i+1;
    end;
    return flag;
  end;

ruleset i:roleANums do
rule " roleA1 "
roleA[i].st = A1 & ch[1].empty = true & !roleA[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons6(roleA[i].N,roleA[i].A,roleA[i].B,roleA[i].Na,roleA[i].A,roleA[i].S,msg,msgNo);
   ch[1].empty := false;
   ch[1].msg := msg;
   ch[1].sender := roleA[i].A;
   ch[1].receiver := Intruder;
   roleA[i].st := A2;
   put "roleA[i] in st1\n";
end;
rule " roleA2 "
roleA[i].st = A2 & ch[4].empty = false & !roleA[i].commit & judge(ch[4].msg,roleA[i].A,msgs[0]) 
==>
var flag_pat9:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[4].msg;
   isPat9(msg, flag_pat9);
   if(flag_pat9) then
     destruct9(msg,roleA[i].locN,roleA[i].locNa,roleA[i].locKab,roleA[i].locA,roleA[i].locS);
     if(matchNonce(roleA[i].locN, roleA[i].N) & matchNonce(roleA[i].locNa, roleA[i].Na) & matchNonce(roleA[i].locKab, roleA[i].Kab) & matchAgent(roleA[i].locA, roleA[i].A) & matchAgent(roleA[i].locS, roleA[i].S))then
       ch[4].empty:=true;
       clear ch[4].msg;
       roleA[i].st := A1;
     endif;
   endif;
   put "roleA[i] in st2\n";
   roleA[i].commit := true;
end;
endruleset;

ruleset i:roleSNums do
rule " roleS1 "
roleS[i].st = S1 & ch[2].empty = false & !roleS[i].commit & judge(ch[2].msg,roleS[i].S,msgs[0]) 
==>
var flag_pat11:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[2].msg;
   isPat11(msg, flag_pat11);
   if(flag_pat11) then
     destruct11(msg,roleS[i].locN,roleS[i].locA,roleS[i].locB,roleS[i].locm1,roleS[i].locNb,roleS[i].locB,roleS[i].locS);
     if(matchNonce(roleS[i].locN, roleS[i].N) & matchAgent(roleS[i].locA, roleS[i].A) & matchAgent(roleS[i].locB, roleS[i].B) & matchTmp(roleS[i].locm1, roleS[i].m1) & matchNonce(roleS[i].locNb, roleS[i].Nb) & matchAgent(roleS[i].locB, roleS[i].B) & matchAgent(roleS[i].locS, roleS[i].S))then
       ch[2].empty:=true;
       clear ch[2].msg;
       roleS[i].st := S2;
     endif;
   endif;
   put "roleS[i] in st1\n";
end;
rule " roleS2 "
roleS[i].st = S2 & ch[3].empty = true & !roleS[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons12(roleS[i].N,roleS[i].Na,roleS[i].Kab,roleS[i].A,roleS[i].S,roleS[i].Nb,roleS[i].B,msg,msgNo);
   ch[3].empty := false;
   ch[3].msg := msg;
   ch[3].sender := roleS[i].S;
   ch[3].receiver := Intruder;
   roleS[i].st := S1;
   put "roleS[i] in st2\n";
   roleS[i].commit := true;
end;
endruleset;

ruleset i:roleBNums do
rule " roleB1 "
roleB[i].st = B1 & ch[1].empty = false & !roleB[i].commit & judge(ch[1].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat13:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[1].msg;
   isPat13(msg, flag_pat13);
   if(flag_pat13) then
     destruct13(msg,roleB[i].locN,roleB[i].locA,roleB[i].locB,roleB[i].locm1);
     if(matchNonce(roleB[i].locN, roleB[i].N) & matchAgent(roleB[i].locA, roleB[i].A) & matchAgent(roleB[i].locB, roleB[i].B) & matchTmp(roleB[i].locm1, roleB[i].m1))then
       ch[1].empty:=true;
       clear ch[1].msg;
       roleB[i].st := B2;
     endif;
   endif;
   put "roleB[i] in st1\n";
end;
rule " roleB2 "
roleB[i].st = B2 & ch[2].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons11(roleB[i].N,roleB[i].A,roleB[i].B,roleB[i].m1,roleB[i].Nb,roleB[i].B,roleB[i].S,msg,msgNo);
   ch[2].empty := false;
   ch[2].msg := msg;
   ch[2].sender := roleB[i].B;
   ch[2].receiver := Intruder;
   roleB[i].st := B3;
   put "roleB[i] in st2\n";
end;
rule " roleB3 "
roleB[i].st = B3 & ch[3].empty = false & !roleB[i].commit & judge(ch[3].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat15:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[3].msg;
   isPat15(msg, flag_pat15);
   if(flag_pat15) then
     destruct15(msg,roleB[i].locN,roleB[i].locm2,roleB[i].locNb,roleB[i].locKab,roleB[i].locB,roleB[i].locS);
     if(matchNonce(roleB[i].locN, roleB[i].N) & matchTmp(roleB[i].locm2, roleB[i].m2) & matchNonce(roleB[i].locNb, roleB[i].Nb) & matchNonce(roleB[i].locKab, roleB[i].Kab) & matchAgent(roleB[i].locB, roleB[i].B) & matchAgent(roleB[i].locS, roleB[i].S))then
       ch[3].empty:=true;
       clear ch[3].msg;
       roleB[i].st := B4;
     endif;
   endif;
   put "roleB[i] in st3\n";
end;
rule " roleB4 "
roleB[i].st = B4 & ch[4].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons16(roleB[i].N,roleB[i].m2,msg,msgNo);
   ch[4].empty := false;
   ch[4].msg := msg;
   ch[4].sender := roleB[i].B;
   ch[4].receiver := Intruder;
   roleB[i].st := B1;
   put "roleB[i] in st4\n";
   roleB[i].commit := true;
end;
endruleset;


---rule of intruder to get msg from ch[1] 
rule "intruderGetMsgFromCh[1]" 
  ch[1].empty = false & ch[1].sender != Intruder ==>
  var flag_pat6:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[1].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat6(msg,flag_pat6);
    if (flag_pat6) then
      if(!exist(pat6Set,msgNo)) then
        pat6Set.length:=pat6Set.length+1;
        pat6Set.content[pat6Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[1].empty := true;
      clear ch[1].msg;
    endif;
    put "intruder get msg from ch[1].\n";
  end;

---rule of intruder to get msg from ch[3] 
rule "intruderGetMsgFromCh[3]" 
  ch[3].empty = false & ch[3].sender != Intruder ==>
  var flag_pat12:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[3].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat12(msg,flag_pat12);
    if (flag_pat12) then
      if(!exist(pat12Set,msgNo)) then
        pat12Set.length:=pat12Set.length+1;
        pat12Set.content[pat12Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[3].empty := true;
      clear ch[3].msg;
    endif;
    put "intruder get msg from ch[3].\n";
  end;

---rule of intruder to get msg from ch[2] 
rule "intruderGetMsgFromCh[2]" 
  ch[2].empty = false & ch[2].sender != Intruder ==>
  var flag_pat11:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[2].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat11(msg,flag_pat11);
    if (flag_pat11) then
      if(!exist(pat11Set,msgNo)) then
        pat11Set.length:=pat11Set.length+1;
        pat11Set.content[pat11Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[2].empty := true;
      clear ch[2].msg;
    endif;
    put "intruder get msg from ch[2].\n";
  end;

---rule of intruder to get msg from ch[4] 
rule "intruderGetMsgFromCh[4]" 
  ch[4].empty = false & ch[4].sender != Intruder ==>
  var flag_pat16:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[4].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat16(msg,flag_pat16);
    if (flag_pat16) then
      if(!exist(pat16Set,msgNo)) then
        pat16Set.length:=pat16Set.length+1;
        pat16Set.content[pat16Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[4].empty := true;
      clear ch[4].msg;
    endif;
    put "intruder get msg from ch[4].\n";
  end;

---rule of intruder to emit msg into ch[4].
ruleset i: msgLen do
  ruleset j: roleANums do
    rule "intruderEmitMsgIntoCh[4]"
      IntruEmit3 = true & roleA[j].st = A2 & ch[4].empty=true & i <= pat16Set.length & pat16Set.content[i] != 0 & Spy_known[pat16Set.content[i]] & !emit[pat16Set.content[i]] ---& matchPat(msgs[pat16Set.content[i]], sPat16Set)
      ==>
      begin
         clear ch[4];
        ch[4].msg:=msgs[pat16Set.content[i]];
        ch[4].sender:=Intruder;
        ch[4].receiver:=roleA[j].A;
        ch[4].empty:=false;
        emit[pat16Set.content[i]] := true;
        IntruEmit4 := true;
        put "intruder emit msg into ch[4].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[2].
ruleset i: msgLen do
  ruleset j: roleSNums do
    rule "intruderEmitMsgIntoCh[2]"
      IntruEmit1 = true & roleS[j].st = S1 & ch[2].empty=true & i <= pat11Set.length & pat11Set.content[i] != 0 & Spy_known[pat11Set.content[i]] & !emit[pat11Set.content[i]] ---& matchPat(msgs[pat11Set.content[i]], sPat11Set)
      ==>
      begin
         clear ch[2];
        ch[2].msg:=msgs[pat11Set.content[i]];
        ch[2].sender:=Intruder;
        ch[2].receiver:=roleS[j].S;
        ch[2].empty:=false;
        emit[pat11Set.content[i]] := true;
        IntruEmit2 := true;
        put "intruder emit msg into ch[2].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[1].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[1]"
       roleB[j].st = B1 & ch[1].empty=true & i <= pat6Set.length & pat6Set.content[i] != 0 & Spy_known[pat6Set.content[i]] & !emit[pat6Set.content[i]] ---& matchPat(msgs[pat6Set.content[i]], sPat6Set)
      ==>
      begin
         clear ch[1];
        ch[1].msg:=msgs[pat6Set.content[i]];
        ch[1].sender:=Intruder;
        ch[1].receiver:=roleB[j].B;
        ch[1].empty:=false;
        emit[pat6Set.content[i]] := true;
        IntruEmit1 := true;
        put "intruder emit msg into ch[1].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[3].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[3]"
      IntruEmit2 = true & roleB[j].st = B3 & ch[3].empty=true & i <= pat12Set.length & pat12Set.content[i] != 0 & Spy_known[pat12Set.content[i]] & !emit[pat12Set.content[i]] ---& matchPat(msgs[pat12Set.content[i]], sPat12Set)
      ==>
      begin
         clear ch[3];
        ch[3].msg:=msgs[pat12Set.content[i]];
        ch[3].sender:=Intruder;
        ch[3].receiver:=roleB[j].B;
        ch[3].empty:=false;
        emit[pat12Set.content[i]] := true;
        IntruEmit3 := true;
        put "intruder emit msg into ch[3].\n";
      end;
  endruleset;
endruleset;
--- enconcat and deconcat rules for pat: concat(Na.N.A.B)

ruleset i:msgLen do 
  rule "deconcat 3" --pat3
    i<=pat3Set.length & pat3Set.content[i] != 0 & Spy_known[pat3Set.content[i]]   &
    !(Spy_known[msgs[pat3Set.content[i]].concatPart[1]]&Spy_known[msgs[pat3Set.content[i]].concatPart[2]]&Spy_known[msgs[pat3Set.content[i]].concatPart[3]]&Spy_known[msgs[pat3Set.content[i]].concatPart[4]])
    ==>
    var msgPat1,msgPat2,msgPat3,msgPat4:indexType;
        flagPat1,flagPat2,flagPat3,flagPat4:boolean;
    begin
      put "rule deconcat3\n";
      if (!Spy_known[msgs[pat3Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat3Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat3Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat3Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat3Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat3Set.content[i]].concatPart[2];
        isPat1(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat1Set,msgPat2)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat3Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat3Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat3Set.content[i]].concatPart[3];
        isPat2(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat2Set,msgPat3)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat3;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat3Set.content[i]].concatPart[4]]) then
        Spy_known[msgs[pat3Set.content[i]].concatPart[4]]:=true;
        msgPat4 := msgs[pat3Set.content[i]].concatPart[4];
        isPat2(msgs[msgPat4],flagPat4);
        if (flagPat4) then
          if(!exist(pat2Set,msgPat4)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat4;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do
  ruleset i3: msgLen do
  ruleset i4: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 3"	---pat3
      roleB[i].st = B1 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      i3<=pat2Set.length & Spy_known[pat2Set.content[i3]] &
      i4<=pat2Set.length & Spy_known[pat2Set.content[i4]] &
      matchPat(construct3By1122(pat1Set.content[i1],pat1Set.content[i2],pat2Set.content[i3],pat2Set.content[i4]), sPat3Set)&
      !Spy_known[constructIndex3By1122(pat1Set.content[i1],pat1Set.content[i2],pat2Set.content[i3],pat2Set.content[i4])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat3\n";
        concatMsgNo := constructIndex3By1122(pat1Set.content[i1],pat1Set.content[i2],pat2Set.content[i3],pat2Set.content[i4]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct3By1122(pat1Set.content[i1],pat1Set.content[i2],pat2Set.content[i3],pat2Set.content[i4]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat3Set,concatMsgNo)) then
          pat3Set.length:=pat3Set.length+1;
          pat3Set.content[pat3Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;
endruleset;
endruleset;

--- encrypt and decrypt rules of pat senc(Na.N.A.B,k(A,S))
ruleset i:msgLen do
  rule "sdecrypt 5" --pat5
    i<=pat5Set.length & pat5Set.content[i] != 0
    & Spy_known[pat5Set.content[i]] & !Spy_known[msgs[pat5Set.content[i]].sencMsg] & Spy_known[inverseKeyIndex(msgs[msgs[pat5Set.content[i]].sencKey])]
    ==>
    var key_inv:Message;
	      msgPat3,keyNo:indexType;
	      flag_pat3:boolean;
    begin
      put "rule sdecrypt5\n";
      key_inv := inverseKey(msgs[msgs[pat5Set.content[i]].sencKey]);
      get_msgNo(key_inv,keyNo);
      if ( (key_inv.k.encType = Symk & (key_inv.k.ag1 = Intruder | key_inv.k.ag2 = Intruder)) | Spy_known[keyNo]) then
        Spy_known[msgs[pat5Set.content[i]].sencMsg]:=true;
        msgPat3:=msgs[pat5Set.content[i]].sencMsg;
        isPat3(msgs[msgPat3],flag_pat3);
        if (flag_pat3) then
          if (!exist(pat3Set,msgPat3)) then
            pat3Set.length:=pat3Set.length+1;
            pat3Set.content[pat3Set.length]:=msgPat3;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "sencrypt 5"  --pat5
      roleB[i1].st = B1 &      i<=pat3Set.length & pat3Set.content[i] != 0 & Spy_known[pat3Set.content[i]] &
      j<=pat4Set.length & pat4Set.content[j] != 0 & Spy_known[pat4Set.content[j]] &
      matchPat(construct5By34(pat3Set.content[i],pat4Set.content[j]), sPat5Set) &
      !Spy_known[constructIndex5By34(pat3Set.content[i],pat4Set.content[j])] 
       ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule sencrypt5\n";
        if (msgs[pat4Set.content[j]].k.encType=Symk) then
          encMsgNo := constructIndex5By34(pat3Set.content[i],pat4Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg:= construct5By34(pat3Set.content[i],pat4Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat5Set,encMsgNo)) then
            pat5Set.length := pat5Set.length+1;
            pat5Set.content[pat5Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(N.A.B.senc{Na.N.A.B}k(A,S))

ruleset i:msgLen do 
  rule "deconcat 6" --pat6
    i<=pat6Set.length & pat6Set.content[i] != 0 & Spy_known[pat6Set.content[i]]   &
    !(Spy_known[msgs[pat6Set.content[i]].concatPart[1]]&Spy_known[msgs[pat6Set.content[i]].concatPart[2]]&Spy_known[msgs[pat6Set.content[i]].concatPart[3]]&Spy_known[msgs[pat6Set.content[i]].concatPart[4]])
    ==>
    var msgPat1,msgPat2,msgPat3,msgPat4:indexType;
        flagPat1,flagPat2,flagPat3,flagPat4:boolean;
    begin
      put "rule deconcat6\n";
      if (!Spy_known[msgs[pat6Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat6Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat6Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat6Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat6Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat6Set.content[i]].concatPart[2];
        isPat2(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat2Set,msgPat2)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat6Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat6Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat6Set.content[i]].concatPart[3];
        isPat2(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat2Set,msgPat3)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat3;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat6Set.content[i]].concatPart[4]]) then
        Spy_known[msgs[pat6Set.content[i]].concatPart[4]]:=true;
        msgPat4 := msgs[pat6Set.content[i]].concatPart[4];
        isPat5(msgs[msgPat4],flagPat4);
        if (flagPat4) then
          if(!exist(pat5Set,msgPat4)) then
             pat5Set.length:=pat5Set.length+1;
             pat5Set.content[pat5Set.length] := msgPat4;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do
  ruleset i3: msgLen do
  ruleset i4: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 6"	---pat6
      roleB[i].st = B1 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat2Set.length & Spy_known[pat2Set.content[i2]] &
      i3<=pat2Set.length & Spy_known[pat2Set.content[i3]] &
      i4<=pat5Set.length & Spy_known[pat5Set.content[i4]] &
      matchPat(construct6By1225(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat5Set.content[i4]), sPat6Set)&
      !Spy_known[constructIndex6By1225(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat5Set.content[i4])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat6\n";
        concatMsgNo := constructIndex6By1225(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat5Set.content[i4]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct6By1225(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat5Set.content[i4]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat6Set,concatMsgNo)) then
          pat6Set.length:=pat6Set.length+1;
          pat6Set.content[pat6Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(Na.Kab)

ruleset i:msgLen do 
  rule "deconcat 7" --pat7
    i<=pat7Set.length & pat7Set.content[i] != 0 & Spy_known[pat7Set.content[i]]   &
    !(Spy_known[msgs[pat7Set.content[i]].concatPart[1]]&Spy_known[msgs[pat7Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat7\n";
      if (!Spy_known[msgs[pat7Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat7Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat7Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat7Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat7Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat7Set.content[i]].concatPart[2];
        isPat1(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat1Set,msgPat2)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 7"	---pat7
      roleB[i].st = B3 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      matchPat(construct7By11(pat1Set.content[i1],pat1Set.content[i2]), sPat7Set)&
      !Spy_known[constructIndex7By11(pat1Set.content[i1],pat1Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat7\n";
        concatMsgNo := constructIndex7By11(pat1Set.content[i1],pat1Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct7By11(pat1Set.content[i1],pat1Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat7Set,concatMsgNo)) then
          pat7Set.length:=pat7Set.length+1;
          pat7Set.content[pat7Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- encrypt and decrypt rules of pat senc(Na.Kab,k(A,S))
ruleset i:msgLen do
  rule "sdecrypt 8" --pat8
    i<=pat8Set.length & pat8Set.content[i] != 0
    & Spy_known[pat8Set.content[i]] & !Spy_known[msgs[pat8Set.content[i]].sencMsg] & Spy_known[inverseKeyIndex(msgs[msgs[pat8Set.content[i]].sencKey])]
    ==>
    var key_inv:Message;
	      msgPat7,keyNo:indexType;
	      flag_pat7:boolean;
    begin
      put "rule sdecrypt8\n";
      key_inv := inverseKey(msgs[msgs[pat8Set.content[i]].sencKey]);
      get_msgNo(key_inv,keyNo);
      if ( (key_inv.k.encType = Symk & (key_inv.k.ag1 = Intruder | key_inv.k.ag2 = Intruder)) | Spy_known[keyNo]) then
        Spy_known[msgs[pat8Set.content[i]].sencMsg]:=true;
        msgPat7:=msgs[pat8Set.content[i]].sencMsg;
        isPat7(msgs[msgPat7],flag_pat7);
        if (flag_pat7) then
          if (!exist(pat7Set,msgPat7)) then
            pat7Set.length:=pat7Set.length+1;
            pat7Set.content[pat7Set.length]:=msgPat7;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "sencrypt 8"  --pat8
      roleB[i1].st = B3 &      i<=pat7Set.length & pat7Set.content[i] != 0 & Spy_known[pat7Set.content[i]] &
      j<=pat4Set.length & pat4Set.content[j] != 0 & Spy_known[pat4Set.content[j]] &
      matchPat(construct8By74(pat7Set.content[i],pat4Set.content[j]), sPat8Set) &
      !Spy_known[constructIndex8By74(pat7Set.content[i],pat4Set.content[j])] 
       ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule sencrypt8\n";
        if (msgs[pat4Set.content[j]].k.encType=Symk) then
          encMsgNo := constructIndex8By74(pat7Set.content[i],pat4Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg:= construct8By74(pat7Set.content[i],pat4Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat8Set,encMsgNo)) then
            pat8Set.length := pat8Set.length+1;
            pat8Set.content[pat8Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(N.senc{Na.Kab}k(A,S))

ruleset i:msgLen do 
  rule "deconcat 9" --pat9
    i<=pat9Set.length & pat9Set.content[i] != 0 & Spy_known[pat9Set.content[i]]   &
    !(Spy_known[msgs[pat9Set.content[i]].concatPart[1]]&Spy_known[msgs[pat9Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat9\n";
      if (!Spy_known[msgs[pat9Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat9Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat9Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat9Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat9Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat9Set.content[i]].concatPart[2];
        isPat8(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat8Set,msgPat2)) then
             pat8Set.length:=pat8Set.length+1;
             pat8Set.content[pat8Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    rule "enconcat 9"	---pat9
      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat8Set.length & Spy_known[pat8Set.content[i2]] &
      matchPat(construct9By18(pat1Set.content[i1],pat8Set.content[i2]), sPat9Set)&
      !Spy_known[constructIndex9By18(pat1Set.content[i1],pat8Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat9\n";
        concatMsgNo := constructIndex9By18(pat1Set.content[i1],pat8Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct9By18(pat1Set.content[i1],pat8Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat9Set,concatMsgNo)) then
          pat9Set.length:=pat9Set.length+1;
          pat9Set.content[pat9Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(N.A.B.m1.senc{Nb.N.A.B}k(B,S))

ruleset i:msgLen do 
  rule "deconcat 11" --pat11
    i<=pat11Set.length & pat11Set.content[i] != 0 & Spy_known[pat11Set.content[i]]   &
    !(Spy_known[msgs[pat11Set.content[i]].concatPart[1]]&Spy_known[msgs[pat11Set.content[i]].concatPart[2]]&Spy_known[msgs[pat11Set.content[i]].concatPart[3]]&Spy_known[msgs[pat11Set.content[i]].concatPart[4]]&Spy_known[msgs[pat11Set.content[i]].concatPart[5]])
    ==>
    var msgPat1,msgPat2,msgPat3,msgPat4,msgPat5:indexType;
        flagPat1,flagPat2,flagPat3,flagPat4,flagPat5:boolean;
    begin
      put "rule deconcat11\n";
      if (!Spy_known[msgs[pat11Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat11Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat11Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat11Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat11Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat11Set.content[i]].concatPart[2];
        isPat2(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat2Set,msgPat2)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat11Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat11Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat11Set.content[i]].concatPart[3];
        isPat2(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat2Set,msgPat3)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat3;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat11Set.content[i]].concatPart[4]]) then
        Spy_known[msgs[pat11Set.content[i]].concatPart[4]]:=true;
        msgPat4 := msgs[pat11Set.content[i]].concatPart[4];
        isPat10(msgs[msgPat4],flagPat4);
        if (flagPat4) then
          if(!exist(pat10Set,msgPat4)) then
             pat10Set.length:=pat10Set.length+1;
             pat10Set.content[pat10Set.length] := msgPat4;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat11Set.content[i]].concatPart[5]]) then
        Spy_known[msgs[pat11Set.content[i]].concatPart[5]]:=true;
        msgPat5 := msgs[pat11Set.content[i]].concatPart[5];
        isPat5(msgs[msgPat5],flagPat5);
        if (flagPat5) then
          if(!exist(pat5Set,msgPat5)) then
             pat5Set.length:=pat5Set.length+1;
             pat5Set.content[pat5Set.length] := msgPat5;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do
  ruleset i3: msgLen do
  ruleset i4: msgLen do
  ruleset i5: msgLen do 
    ruleset i: roleSNums do
    rule "enconcat 11"	---pat11
      roleS[i].st = S1 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat2Set.length & Spy_known[pat2Set.content[i2]] &
      i3<=pat2Set.length & Spy_known[pat2Set.content[i3]] &
      i4<=pat10Set.length & Spy_known[pat10Set.content[i4]] &
      i5<=pat5Set.length & Spy_known[pat5Set.content[i5]] &
      matchPat(construct11By122105(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat10Set.content[i4],pat5Set.content[i5]), sPat11Set)&
      !Spy_known[constructIndex11By122105(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat10Set.content[i4],pat5Set.content[i5])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat11\n";
        concatMsgNo := constructIndex11By122105(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat10Set.content[i4],pat5Set.content[i5]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct11By122105(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat10Set.content[i4],pat5Set.content[i5]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat11Set,concatMsgNo)) then
          pat11Set.length:=pat11Set.length+1;
          pat11Set.content[pat11Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;
endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(N.senc{Na.Kab}k(A,S).senc{Nb.Kab}k(B,S))

ruleset i:msgLen do 
  rule "deconcat 12" --pat12
    i<=pat12Set.length & pat12Set.content[i] != 0 & Spy_known[pat12Set.content[i]]   &
    !(Spy_known[msgs[pat12Set.content[i]].concatPart[1]]&Spy_known[msgs[pat12Set.content[i]].concatPart[2]]&Spy_known[msgs[pat12Set.content[i]].concatPart[3]])
    ==>
    var msgPat1,msgPat2,msgPat3:indexType;
        flagPat1,flagPat2,flagPat3:boolean;
    begin
      put "rule deconcat12\n";
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat12Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat12Set.content[i]].concatPart[2];
        isPat8(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat8Set,msgPat2)) then
             pat8Set.length:=pat8Set.length+1;
             pat8Set.content[pat8Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat12Set.content[i]].concatPart[3];
        isPat8(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat8Set,msgPat3)) then
             pat8Set.length:=pat8Set.length+1;
             pat8Set.content[pat8Set.length] := msgPat3;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do
  ruleset i3: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 12"	---pat12
      roleB[i].st = B3 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat8Set.length & Spy_known[pat8Set.content[i2]] &
      i3<=pat8Set.length & Spy_known[pat8Set.content[i3]] &
      matchPat(construct12By188(pat1Set.content[i1],pat8Set.content[i2],pat8Set.content[i3]), sPat12Set)&
      !Spy_known[constructIndex12By188(pat1Set.content[i1],pat8Set.content[i2],pat8Set.content[i3])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat12\n";
        concatMsgNo := constructIndex12By188(pat1Set.content[i1],pat8Set.content[i2],pat8Set.content[i3]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct12By188(pat1Set.content[i1],pat8Set.content[i2],pat8Set.content[i3]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat12Set,concatMsgNo)) then
          pat12Set.length:=pat12Set.length+1;
          pat12Set.content[pat12Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(N.A.B.m1)

ruleset i:msgLen do 
  rule "deconcat 13" --pat13
    i<=pat13Set.length & pat13Set.content[i] != 0 & Spy_known[pat13Set.content[i]]   &
    !(Spy_known[msgs[pat13Set.content[i]].concatPart[1]]&Spy_known[msgs[pat13Set.content[i]].concatPart[2]]&Spy_known[msgs[pat13Set.content[i]].concatPart[3]]&Spy_known[msgs[pat13Set.content[i]].concatPart[4]])
    ==>
    var msgPat1,msgPat2,msgPat3,msgPat4:indexType;
        flagPat1,flagPat2,flagPat3,flagPat4:boolean;
    begin
      put "rule deconcat13\n";
      if (!Spy_known[msgs[pat13Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat13Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat13Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat13Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat13Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat13Set.content[i]].concatPart[2];
        isPat2(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat2Set,msgPat2)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat13Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat13Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat13Set.content[i]].concatPart[3];
        isPat2(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat2Set,msgPat3)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat3;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat13Set.content[i]].concatPart[4]]) then
        Spy_known[msgs[pat13Set.content[i]].concatPart[4]]:=true;
        msgPat4 := msgs[pat13Set.content[i]].concatPart[4];
        isPat10(msgs[msgPat4],flagPat4);
        if (flagPat4) then
          if(!exist(pat10Set,msgPat4)) then
             pat10Set.length:=pat10Set.length+1;
             pat10Set.content[pat10Set.length] := msgPat4;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do
  ruleset i3: msgLen do
  ruleset i4: msgLen do 
    rule "enconcat 13"	---pat13
      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat2Set.length & Spy_known[pat2Set.content[i2]] &
      i3<=pat2Set.length & Spy_known[pat2Set.content[i3]] &
      i4<=pat10Set.length & Spy_known[pat10Set.content[i4]] &
      matchPat(construct13By12210(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat10Set.content[i4]), sPat13Set)&
      !Spy_known[constructIndex13By12210(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat10Set.content[i4])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat13\n";
        concatMsgNo := constructIndex13By12210(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat10Set.content[i4]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct13By12210(pat1Set.content[i1],pat2Set.content[i2],pat2Set.content[i3],pat10Set.content[i4]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat13Set,concatMsgNo)) then
          pat13Set.length:=pat13Set.length+1;
          pat13Set.content[pat13Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(N.m2.senc{Nb.Kab}k(B,S))

ruleset i:msgLen do 
  rule "deconcat 15" --pat15
    i<=pat15Set.length & pat15Set.content[i] != 0 & Spy_known[pat15Set.content[i]]   &
    !(Spy_known[msgs[pat15Set.content[i]].concatPart[1]]&Spy_known[msgs[pat15Set.content[i]].concatPart[2]]&Spy_known[msgs[pat15Set.content[i]].concatPart[3]])
    ==>
    var msgPat1,msgPat2,msgPat3:indexType;
        flagPat1,flagPat2,flagPat3:boolean;
    begin
      put "rule deconcat15\n";
      if (!Spy_known[msgs[pat15Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat15Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat15Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat15Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat15Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat15Set.content[i]].concatPart[2];
        isPat14(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat14Set,msgPat2)) then
             pat14Set.length:=pat14Set.length+1;
             pat14Set.content[pat14Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat15Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat15Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat15Set.content[i]].concatPart[3];
        isPat8(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat8Set,msgPat3)) then
             pat8Set.length:=pat8Set.length+1;
             pat8Set.content[pat8Set.length] := msgPat3;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do
  ruleset i3: msgLen do 
    rule "enconcat 15"	---pat15
      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat14Set.length & Spy_known[pat14Set.content[i2]] &
      i3<=pat8Set.length & Spy_known[pat8Set.content[i3]] &
      matchPat(construct15By1148(pat1Set.content[i1],pat14Set.content[i2],pat8Set.content[i3]), sPat15Set)&
      !Spy_known[constructIndex15By1148(pat1Set.content[i1],pat14Set.content[i2],pat8Set.content[i3])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat15\n";
        concatMsgNo := constructIndex15By1148(pat1Set.content[i1],pat14Set.content[i2],pat8Set.content[i3]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct15By1148(pat1Set.content[i1],pat14Set.content[i2],pat8Set.content[i3]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat15Set,concatMsgNo)) then
          pat15Set.length:=pat15Set.length+1;
          pat15Set.content[pat15Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(N.m2)

ruleset i:msgLen do 
  rule "deconcat 16" --pat16
    i<=pat16Set.length & pat16Set.content[i] != 0 & Spy_known[pat16Set.content[i]]   &
    !(Spy_known[msgs[pat16Set.content[i]].concatPart[1]]&Spy_known[msgs[pat16Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat16\n";
      if (!Spy_known[msgs[pat16Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat16Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat16Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat16Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat16Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat16Set.content[i]].concatPart[2];
        isPat14(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat14Set,msgPat2)) then
             pat14Set.length:=pat14Set.length+1;
             pat14Set.content[pat14Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleANums do
    rule "enconcat 16"	---pat16
      roleA[i].st = A2 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat14Set.length & Spy_known[pat14Set.content[i2]] &
      matchPat(construct16By114(pat1Set.content[i1],pat14Set.content[i2]), sPat16Set)&
      !Spy_known[constructIndex16By114(pat1Set.content[i1],pat14Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat16\n";
        concatMsgNo := constructIndex16By114(pat1Set.content[i1],pat14Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct16By114(pat1Set.content[i1],pat14Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat16Set,concatMsgNo)) then
          pat16Set.length:=pat16Set.length+1;
          pat16Set.content[pat16Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

startstate
  roleA[1].A := Alice;
  roleA[1].B := Bob;
  roleA[1].Na := na;
  roleA[1].N := n;
    roleA[1].st := A1;
  roleA[1].commit := false;
  roleA[1].Kab := anyNonce;
  roleA[1].Nb := anyNonce;
  roleA[1].S := anyAgent;
  roleA[1].m1.msgType := tmp;
  roleA[1].m1.tmpPart := 0;
  roleA[1].m2.msgType := tmp;
  roleA[1].m2.tmpPart := 0;

  roleS[1].Kab := kab;
      roleS[1].st := S1;
  roleS[1].commit := false;
  roleS[1].Na := anyNonce;
  roleS[1].N := anyNonce;
  roleS[1].Nb := anyNonce;
  roleS[1].A := anyAgent;
  roleS[1].S := anyAgent;
  roleS[1].B := anyAgent;
  roleS[1].m1.msgType := tmp;
  roleS[1].m1.tmpPart := 0;
  roleS[1].m2.msgType := tmp;
  roleS[1].m2.tmpPart := 0;

  roleB[1].B := Bob;
  roleB[1].S := Server;
  roleB[1].Nb := nb;
    roleB[1].st := B1;
  roleB[1].commit := false;
  roleB[1].Na := anyNonce;
  roleB[1].N := anyNonce;
  roleB[1].Kab := anyNonce;
  roleB[1].A := anyAgent;
  roleB[1].m1.msgType := tmp;
  roleB[1].m1.tmpPart := 0;
  roleB[1].m2.msgType := tmp;
  roleB[1].m2.tmpPart := 0;


---intruder.B := Bob;
  for i:chanNums do
    ch[i].empty := true;
  endfor;

  for i: indexType do
    emit[i]:=false;
  endfor;

  for i:indexType do
    msgs[i].msgType := null;
    msgs[i].length := 0;
  endfor;

  msg_end := 0;
  for i:indexType do
    pat1Set.content[i] := 0;
    sPat1Set.content[i] := 0;
    pat2Set.content[i] := 0;
    sPat2Set.content[i] := 0;
    pat3Set.content[i] := 0;
    sPat3Set.content[i] := 0;
    pat4Set.content[i] := 0;
    sPat4Set.content[i] := 0;
    pat5Set.content[i] := 0;
    sPat5Set.content[i] := 0;
    pat6Set.content[i] := 0;
    sPat6Set.content[i] := 0;
    pat7Set.content[i] := 0;
    sPat7Set.content[i] := 0;
    pat8Set.content[i] := 0;
    sPat8Set.content[i] := 0;
    pat9Set.content[i] := 0;
    sPat9Set.content[i] := 0;
    pat10Set.content[i] := 0;
    sPat10Set.content[i] := 0;
    pat11Set.content[i] := 0;
    sPat11Set.content[i] := 0;
    pat12Set.content[i] := 0;
    sPat12Set.content[i] := 0;
    pat13Set.content[i] := 0;
    sPat13Set.content[i] := 0;
    pat14Set.content[i] := 0;
    sPat14Set.content[i] := 0;
    pat15Set.content[i] := 0;
    sPat15Set.content[i] := 0;
    pat16Set.content[i] := 0;
    sPat16Set.content[i] := 0;
    pat17Set.content[i] := 0;
    sPat17Set.content[i] := 0;
    pat1Set.length := 0;
    sPat1Set.length := 0;
    pat2Set.length := 0;
    sPat2Set.length := 0;
    pat3Set.length := 0;
    sPat3Set.length := 0;
    pat4Set.length := 0;
    sPat4Set.length := 0;
    pat5Set.length := 0;
    sPat5Set.length := 0;
    pat6Set.length := 0;
    sPat6Set.length := 0;
    pat7Set.length := 0;
    sPat7Set.length := 0;
    pat8Set.length := 0;
    sPat8Set.length := 0;
    pat9Set.length := 0;
    sPat9Set.length := 0;
    pat10Set.length := 0;
    sPat10Set.length := 0;
    pat11Set.length := 0;
    sPat11Set.length := 0;
    pat12Set.length := 0;
    sPat12Set.length := 0;
    pat13Set.length := 0;
    sPat13Set.length := 0;
    pat14Set.length := 0;
    sPat14Set.length := 0;
    pat15Set.length := 0;
    sPat15Set.length := 0;
    pat16Set.length := 0;
    sPat16Set.length := 0;
    pat17Set.length := 0;
    sPat17Set.length := 0;
    IntruEmit1 := false;
    IntruEmit2 := false;
    IntruEmit3 := false;
    IntruEmit4 := false;
  endfor;
  for i:indexType do 
    Spy_known[i] := false;
  endfor;
  for i:indexType do
    A_known[i] := false;
  endfor;
  for i:indexType do
    S_known[i] := false;
  endfor;
  for i:indexType do
    B_known[i] := false;
  endfor;

  for i:indexType do 
    Spy_known[i] := false;
  endfor;
  msg_end:=msg_end+1;
  msgs[msg_end].msgType := key;
  msgs[msg_end].k.ag:=Intruder;
  msgs[msg_end].k.encType:=SK;
  msgs[msg_end].length := 1;
  pat17Set.length := pat17Set.length + 1; 
  pat17Set.content[pat17Set.length] :=msg_end;
  Spy_known[msg_end] := true;
    for i : roleANums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag1 := roleA[i].A;
    msgs[msg_end].k.ag2 := roleA[i].S;
    msgs[msg_end].k.encType:=Symk;
    msgs[msg_end].length := 1;
    pat4Set.length := pat4Set.length + 1;
    pat4Set.content[pat4Set.length] :=msg_end;
    Spy_known[msg_end] := true;
  endfor;
  for i : roleSNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag1 := roleA[i].A;
    msgs[msg_end].k.ag2 := roleA[i].B;
    msgs[msg_end].k.encType:=Symk;
    msgs[msg_end].length := 1;
    pat4Set.length := pat4Set.length + 1;
    pat4Set.content[pat4Set.length] :=msg_end;
    Spy_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag1 := roleS[i].S;
    msgs[msg_end].k.ag2 := roleS[i].B;
    msgs[msg_end].k.encType:=Symk;
    msgs[msg_end].length := 1;
    pat4Set.length := pat4Set.length + 1;
    pat4Set.content[pat4Set.length] :=msg_end;
    Spy_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    constructSpat6(roleB[i].N,roleB[i].A,roleB[i].B,roleB[i].Na,roleB[i].A,roleB[i].S, gnum);
  endfor;
  for i : roleBNums do
    constructSpat12(roleB[i].N,roleB[i].Na,roleB[i].Kab,roleB[i].A,roleB[i].S,roleB[i].Nb,roleB[i].B, gnum);
  endfor;
  for i : roleSNums do
    constructSpat11(roleS[i].N,roleS[i].A,roleS[i].B,roleS[i].m1,roleS[i].Nb,roleS[i].B,roleS[i].S, gnum);
  endfor;
  for i : roleANums do
    constructSpat16(roleA[i].N,roleA[i].m2, gnum);
  endfor;

end;

invariant "secrecy1" 
forall i:indexType do
    (msgs[i].msgType=nonce & msgs[i].noncePart=kab)
     ->
     Spy_known[i] = false
end;
