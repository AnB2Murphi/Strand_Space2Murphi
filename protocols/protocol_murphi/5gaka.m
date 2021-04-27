const
  roleANum:1;
  roleBNum:1;
  roleCNum:1;
  totalFact:100;
  msgLength:10;
  chanNum:18;
  invokeNum:10;
type
  indexType:0..totalFact;
  roleANums:1..roleANum;
  roleBNums:1..roleBNum;
  roleCNums:1..roleCNum;
  msgLen:0..msgLength;
  chanNums:0..chanNum;
  invokeNums:0..invokeNum;

  AgentType : enum{anyAgent,Intruder, UE, SN, HN}; ---Intruder 
  NonceType : enum{anyNonce, supi, s, sqnue, fail, sqnhn, R, kseaf};
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

  AStatus: enum{A1,A2,A3,A4,A5};
  BStatus: enum{B1,B2,B3,B4,B5,B6,B7,B8,B9,B10};
  CStatus: enum{C1,C2,C3,C4,C5};

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
   supi : NonceType;
   s : NonceType;
   sqnue : NonceType;
   fail : NonceType;
   sqnhn : NonceType;
   R : NonceType;
   kseaf : NonceType;
   A : AgentType;
   B : AgentType;
   C : AgentType;
   m2 : Message;
   m1 : Message;
   m3 : Message;

   locsupi : NonceType;
   locs : NonceType;
   locsqnue : NonceType;
   locfail : NonceType;
   locsqnhn : NonceType;
   locR : NonceType;
   lockseaf : NonceType;
   locA : AgentType;
   locB : AgentType;
   locC : AgentType;
   locm2 : Message;
   locm1 : Message;
   locm3 : Message;
   
   st: AStatus;
   commit : boolean;
  end;
  RoleB : record
   supi : NonceType;
   s : NonceType;
   sqnue : NonceType;
   fail : NonceType;
   sqnhn : NonceType;
   R : NonceType;
   kseaf : NonceType;
   A : AgentType;
   B : AgentType;
   C : AgentType;
   m2 : Message;
   m1 : Message;
   m3 : Message;

   locsupi : NonceType;
   locs : NonceType;
   locsqnue : NonceType;
   locfail : NonceType;
   locsqnhn : NonceType;
   locR : NonceType;
   lockseaf : NonceType;
   locA : AgentType;
   locB : AgentType;
   locC : AgentType;
   locm2 : Message;
   locm1 : Message;
   locm3 : Message;
   
   st: BStatus;
   commit : boolean;
  end;
  RoleC : record
   supi : NonceType;
   s : NonceType;
   sqnue : NonceType;
   fail : NonceType;
   sqnhn : NonceType;
   R : NonceType;
   kseaf : NonceType;
   A : AgentType;
   B : AgentType;
   C : AgentType;
   m2 : Message;
   m1 : Message;
   m3 : Message;

   locsupi : NonceType;
   locs : NonceType;
   locsqnue : NonceType;
   locfail : NonceType;
   locsqnhn : NonceType;
   locR : NonceType;
   lockseaf : NonceType;
   locA : AgentType;
   locB : AgentType;
   locC : AgentType;
   locm2 : Message;
   locm1 : Message;
   locm3 : Message;
   
   st: CStatus;
   commit : boolean;
  end;

  msgSet: record
    content : Array[indexType] of indexType;
    length : indexType;
  end;
  
var
  ch : Array[chanNums] of Channel;
  roleA : Array[roleANums] of RoleA;
  roleB : Array[roleBNums] of RoleB;
  roleC : Array[roleCNums] of RoleC;

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
  pat18Set: msgSet;
  sPat18Set: msgSet;
  pat19Set: msgSet;
  sPat19Set: msgSet;
  pat20Set: msgSet;
  sPat20Set: msgSet;
  pat21Set: msgSet;
  sPat21Set: msgSet;
  pat22Set: msgSet;
  sPat22Set: msgSet;
  pat23Set: msgSet;
  sPat23Set: msgSet;

  A_known : Array[indexType] of boolean;
  B_known : Array[indexType] of boolean;
  C_known : Array[indexType] of boolean;
  Spy_known: Array[indexType] of boolean;
  IntruEmit1 : boolean;
  IntruEmit2 : boolean;
  IntruEmit3 : boolean;
  IntruEmit4 : boolean;
  IntruEmit5 : boolean;
  IntruEmit6 : boolean;
  IntruEmit7 : boolean;
  IntruEmit8 : boolean;
  IntruEmit9 : boolean;
  IntruEmit10 : boolean;
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

function construct2By11(msgNo1,msgNo2:indexType):Message;
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

function constructIndex2By11(msgNo1,msgNo2:indexType):indexType;
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

function construct4By23(msgNo21, msgNo32:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo21 & msgs[i].aencKey = msgNo32) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo21;
     msg.aencKey := msgNo32;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex4By23(msgNo21, msgNo32:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo21 & msgs[i].aencKey = msgNo32) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

--- Sorry, construct_function of this pattern has not been written!

function construct6By45(msgNo1,msgNo2:indexType):Message;
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

function constructIndex6By45(msgNo1,msgNo2:indexType):indexType;
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

function construct8By15(msgNo1,msgNo2:indexType):Message;
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

function constructIndex8By15(msgNo1,msgNo2:indexType):indexType;
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

function construct10By89(msgNo81, msgNo92:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo81 & msgs[i].aencKey = msgNo92) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo81;
     msg.aencKey := msgNo92;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex10By89(msgNo81, msgNo92:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo81 & msgs[i].aencKey = msgNo92) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct11By19(msgNo11, msgNo92:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo11 & msgs[i].aencKey = msgNo92) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo11;
     msg.aencKey := msgNo92;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex11By19(msgNo11, msgNo92:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo11 & msgs[i].aencKey = msgNo92) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct12By29(msgNo21, msgNo92:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo21 & msgs[i].aencKey = msgNo92) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo21;
     msg.aencKey := msgNo92;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex12By29(msgNo21, msgNo92:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo21 & msgs[i].aencKey = msgNo92) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct13By1112(msgNo1,msgNo2:indexType):Message;
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

function constructIndex13By1112(msgNo1,msgNo2:indexType):indexType;
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

function construct14By113(msgNo1,msgNo2:indexType):Message;
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

function constructIndex14By113(msgNo1,msgNo2:indexType):indexType;
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

function construct16By155(msgNo1,msgNo2:indexType):Message;
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

function constructIndex16By155(msgNo1,msgNo2:indexType):indexType;
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

function construct17By171(msgNo1,msgNo2,msgNo3:indexType):Message;
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

function constructIndex17By171(msgNo1,msgNo2,msgNo3:indexType):indexType;
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

function construct18By17(msgNo1,msgNo2:indexType):Message;
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

function constructIndex18By17(msgNo1,msgNo2:indexType):indexType;
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

function construct20By1915(msgNo1,msgNo2:indexType):Message;
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

function constructIndex20By1915(msgNo1,msgNo2:indexType):indexType;
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

function construct21By19115(msgNo1,msgNo2,msgNo3:indexType):Message;
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

function constructIndex21By19115(msgNo1,msgNo2,msgNo3:indexType):indexType;
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

function construct22By1121(msgNo1,msgNo2,msgNo3:indexType):Message;
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

function constructIndex22By1121(msgNo1,msgNo2,msgNo3:indexType):indexType;
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

---pat1: supi 
procedure lookAddPat1(supi:NonceType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
      index:=0;
      for i: indexType do
        if(msgs[i].msgType=nonce) then
          if(msgs[i].noncePart=supi) then
            index:=i;
          endif;
        endif;
      endfor;
      if(index=0) then
        msg_end := msg_end + 1 ;
        index := msg_end;
        msgs[index].msgType := nonce;
        msgs[index].noncePart:=supi; 
        msgs[index].length := 1;
      endif;
      num:=index;
      msg:=msgs[index];
  end;

---pat1: supi 
procedure isPat1(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = nonce) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat1: supi 
procedure constructSpat1(supi:NonceType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = nonce) then
        if (msgs[i].noncePart = supi) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := nonce;
      msgs[index].noncePart := supi;
      msgs[index].length := 1;
    endif;
    sPat1Set.length := sPat1Set.length + 1;
    sPat1Set.content[sPat1Set.length] := index;
    num := index;
  end;

---pat2: supi.s 
procedure lookAddPat2(supi:NonceType; s:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(supi, msg1, i1);
   lookAddPat1(s, msg2, i2);
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

---pat2: supi.s 
procedure isPat2(msg:Message; Var flag:boolean);
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
---spat2: supi.s 
procedure constructSpat2(supi:NonceType; s:NonceType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(supi, i1);
    constructSpat1(s, i2);
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
    sPat2Set.length := sPat2Set.length + 1;
    sPat2Set.content[sPat2Set.length] := index;
    num := index;
  end;

---pat3: pk(C) 
procedure lookAddPat3(CPk:AgentType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    index:=0;
    for i: indexType do
      if (msgs[i].msgType = key) then
        if (msgs[i].k.encType = PK & msgs[i].k.ag = CPk) then
          index:=i;
        endif;
      endif;
    endfor;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := key;
      msgs[index].k.encType:=PK; 
      msgs[index].k.ag:=CPk;
      msgs[index].length := 1;
    endif;
    num:=index;
    msg:=msgs[index];
  end;

---pat3: pk(C) 
procedure isPat3(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = key & msg.k.encType = PK) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat3: pk(C) 
procedure constructSpat3(CPk:AgentType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = key & msgs[i].k.encType = PK) then
        if (msgs[i].k.ag = CPk) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := key;
      msgs[index].k.encType := PK;
      msgs[index].k.ag := CPk;
      msgs[index].length := 1;
    endif;
    sPat3Set.length := sPat3Set.length + 1;
    sPat3Set.content[sPat3Set.length] := index;
    num := index;
  end;

---pat4: aenc{supi.s}pk(C) 
procedure lookAddPat4(supi:NonceType; s:NonceType; CPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(supi, s,msg1,i1);
   lookAddPat3(CPk,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = i1 & msgs[i].aencKey = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := aenc;
     msgs[index].aencMsg := i1; 
     msgs[index].aencKey := i2;     
     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat4: aenc{supi.s}pk(C) 
procedure isPat4(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat2(msgs[msg.aencMsg],flagPart1);
      isPat3(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat4: aenc{supi.s}pk(C) 
procedure constructSpat4(supi:NonceType; s:NonceType; CPk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat2(supi, s, i1);
    constructSpat3(CPk, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = aenc) then
        if (msgs[i].aencMsg = i1 & msgs[i].aencKey = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := aenc;
      msgs[index].aencMsg := i1; 
      msgs[index].aencKey := i2; 
      msgs[index].length := 1;
    endif;
    sPat4Set.length := sPat4Set.length + 1;
    sPat4Set.content[sPat4Set.length] := index;
    num := index;
  end;

---pat5: C 
procedure lookAddPat5(C:AgentType; Var msg:Message; Var num : indexType);
 Var index : indexType;
 begin
   index:=0;
   for i: indexType do
    if (msgs[i].msgType = agent) then
      if (msgs[i].ag = C) then
        index:=i;
      endif;
    endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := agent;
     msgs[index].ag:=C; 
     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat5: C 
procedure isPat5(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = agent) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat5: C 
procedure constructSpat5(C:AgentType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = agent) then
        if (msgs[i].ag = C) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := agent;
      msgs[index].ag := C;
      msgs[index].length := 1;
    endif;
    sPat5Set.length := sPat5Set.length + 1;
    sPat5Set.content[sPat5Set.length] := index;
    num := index;
  end;

---pat6: aenc{supi.s}pk(C).C 
procedure lookAddPat6(supi:NonceType; s:NonceType; CPk:AgentType; C:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat4(supi, s, CPk, msg1, i1);
   lookAddPat5(C, msg2, i2);
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

---pat6: aenc{supi.s}pk(C).C 
procedure isPat6(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat4(msgs[msg.concatPart[1]],flagPart1);
        isPat5(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat6: aenc{supi.s}pk(C).C 
procedure constructSpat6(supi:NonceType; s:NonceType; CPk:AgentType; C:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat4(supi, s, CPk, i1);
    constructSpat5(C, i2);
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
    sPat6Set.length := sPat6Set.length + 1;
    sPat6Set.content[sPat6Set.length] := index;
    num := index;
  end;

---pat7: m2 
procedure lookAddPat7(m2:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[m2.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat7: m2 
procedure isPat7(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat7: m2 
procedure constructSpat7(m2:Message; Var num: indexType);
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
    sPat7Set.length := sPat7Set.length + 1;
    sPat7Set.content[sPat7Set.length] := index;
    num := index;
  end;

---pat8: R.B 
procedure lookAddPat8(R:NonceType; B:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(R, msg1, i1);
   lookAddPat5(B, msg2, i2);
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

---pat8: R.B 
procedure isPat8(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat5(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat8: R.B 
procedure constructSpat8(R:NonceType; B:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(R, i1);
    constructSpat5(B, i2);
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
    sPat8Set.length := sPat8Set.length + 1;
    sPat8Set.content[sPat8Set.length] := index;
    num := index;
  end;

---pat9: k(A,C) 
procedure lookAddPat9(Asymk1:AgentType; Csymk2:AgentType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    index := 0;
    for i :indexType do
      if (msgs[i].msgType = key) then 
        if (msgs[i].k.encType = Symk & msgs[i].k.ag1 = Asymk1 & msgs[i].k.ag2 = Csymk2) then
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
      msgs[index].k.ag2:=Csymk2;
    endif;
    num := index;
    msg := msgs[index];
  end;

---pat9: k(A,C) 
procedure isPat9(msg:Message; Var flag:boolean);
  var flag1:boolean;
  begin
    flag1:=false;
    if msg.msgType = key & msg.k.encType = Symk then
      flag1:=true;
    endif;
    flag:=flag1;
  end;

---spat9: k(A,C) 
procedure constructSpat9(Asymk1:AgentType; Csymk2:AgentType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = key & msgs[i].k.encType = Symk) then
        if (msgs[i].k.ag1 = Asymk1 & msgs[i].k.ag2 = Csymk2) then
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
      msgs[index].k.ag2 := Csymk2;
      msgs[index].length := 1;
    endif;
    sPat9Set.length := sPat9Set.length + 1;
    sPat9Set.content[sPat9Set.length] := index;
    num := index;
  end;

---pat10: aenc{R.B}k(A,C) 
procedure lookAddPat10(R:NonceType; B:AgentType; Asymk1:AgentType; Csymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat8(R, B,msg1,i1);
   lookAddPat9(Asymk1, Csymk2,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = i1 & msgs[i].aencKey = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := aenc;
     msgs[index].aencMsg := i1; 
     msgs[index].aencKey := i2;     
     msgs[i2].k.encType := MsgK;
     msgs[i2].k.m := i2;
msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat10: aenc{R.B}k(A,C) 
procedure isPat10(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat8(msgs[msg.aencMsg],flagPart1);
      isPat9(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat10: aenc{R.B}k(A,C) 
procedure constructSpat10(R:NonceType; B:AgentType; Asymk1:AgentType; Csymk2:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat8(R, B, i1);
    constructSpat9(Asymk1, Csymk2, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = aenc) then
        if (msgs[i].aencMsg = i1 & msgs[i].aencKey = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := aenc;
      msgs[index].aencMsg := i1; 
      msgs[index].aencKey := i2; 
      msgs[index].length := 1;
    endif;
    sPat10Set.length := sPat10Set.length + 1;
    sPat10Set.content[sPat10Set.length] := index;
    num := index;
  end;

---pat11: aenc{R}k(A,C) 
procedure lookAddPat11(R:NonceType; Asymk1:AgentType; Csymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(R,msg1,i1);
   lookAddPat9(Asymk1, Csymk2,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = i1 & msgs[i].aencKey = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := aenc;
     msgs[index].aencMsg := i1; 
     msgs[index].aencKey := i2;     
     msgs[i2].k.encType := MsgK;
     msgs[i2].k.m := i2;
msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat11: aenc{R}k(A,C) 
procedure isPat11(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat1(msgs[msg.aencMsg],flagPart1);
      isPat9(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat11: aenc{R}k(A,C) 
procedure constructSpat11(R:NonceType; Asymk1:AgentType; Csymk2:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat1(R, i1);
    constructSpat9(Asymk1, Csymk2, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = aenc) then
        if (msgs[i].aencMsg = i1 & msgs[i].aencKey = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := aenc;
      msgs[index].aencMsg := i1; 
      msgs[index].aencKey := i2; 
      msgs[index].length := 1;
    endif;
    sPat11Set.length := sPat11Set.length + 1;
    sPat11Set.content[sPat11Set.length] := index;
    num := index;
  end;

---pat12: aenc{sqnue.R}k(A,C) 
procedure lookAddPat12(sqnue:NonceType; R:NonceType; Asymk1:AgentType; Csymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(sqnue, R,msg1,i1);
   lookAddPat9(Asymk1, Csymk2,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = i1 & msgs[i].aencKey = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := aenc;
     msgs[index].aencMsg := i1; 
     msgs[index].aencKey := i2;     
     msgs[i2].k.encType := MsgK;
     msgs[i2].k.m := i2;
msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat12: aenc{sqnue.R}k(A,C) 
procedure isPat12(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat2(msgs[msg.aencMsg],flagPart1);
      isPat9(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat12: aenc{sqnue.R}k(A,C) 
procedure constructSpat12(sqnue:NonceType; R:NonceType; Asymk1:AgentType; Csymk2:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat2(sqnue, R, i1);
    constructSpat9(Asymk1, Csymk2, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = aenc) then
        if (msgs[i].aencMsg = i1 & msgs[i].aencKey = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := aenc;
      msgs[index].aencMsg := i1; 
      msgs[index].aencKey := i2; 
      msgs[index].length := 1;
    endif;
    sPat12Set.length := sPat12Set.length + 1;
    sPat12Set.content[sPat12Set.length] := index;
    num := index;
  end;

---pat13: aenc{R}k(A,C).aenc{sqnue.R}k(A,C) 
procedure lookAddPat13(R:NonceType; Asymk1:AgentType; Csymk2:AgentType; sqnue:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat11(R, Asymk1, Csymk2, msg1, i1);
   lookAddPat12(sqnue, R, Asymk1, Csymk2, msg2, i2);
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

---pat13: aenc{R}k(A,C).aenc{sqnue.R}k(A,C) 
procedure isPat13(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat11(msgs[msg.concatPart[1]],flagPart1);
        isPat12(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat13: aenc{R}k(A,C).aenc{sqnue.R}k(A,C) 
procedure constructSpat13(R:NonceType; Asymk1:AgentType; Csymk2:AgentType; sqnue:NonceType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat11(R, Asymk1, Csymk2, i1);
    constructSpat12(sqnue, R, Asymk1, Csymk2, i2);
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
    sPat13Set.length := sPat13Set.length + 1;
    sPat13Set.content[sPat13Set.length] := index;
    num := index;
  end;

---pat14: fail.aenc{R}k(A,C).aenc{sqnue.R}k(A,C) 
procedure lookAddPat14(fail:NonceType; R:NonceType; Asymk1:AgentType; Csymk2:AgentType; sqnue:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(fail, msg1, i1);
   lookAddPat13(R, Asymk1, Csymk2, sqnue, msg2, i2);
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

---pat14: fail.aenc{R}k(A,C).aenc{sqnue.R}k(A,C) 
procedure isPat14(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat13(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat14: fail.aenc{R}k(A,C).aenc{sqnue.R}k(A,C) 
procedure constructSpat14(fail:NonceType; R:NonceType; Asymk1:AgentType; Csymk2:AgentType; sqnue:NonceType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(fail, i1);
    constructSpat13(R, Asymk1, Csymk2, sqnue, i2);
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
    sPat14Set.length := sPat14Set.length + 1;
    sPat14Set.content[sPat14Set.length] := index;
    num := index;
  end;

---pat15: m1 
procedure lookAddPat15(m1:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[m1.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat15: m1 
procedure isPat15(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat15: m1 
procedure constructSpat15(m1:Message; Var num: indexType);
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
    sPat15Set.length := sPat15Set.length + 1;
    sPat15Set.content[sPat15Set.length] := index;
    num := index;
  end;

---pat16: m1.B 
procedure lookAddPat16(m1:Message; B:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat15(m1, msg1, i1);
   lookAddPat5(B, msg2, i2);
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

---pat16: m1.B 
procedure isPat16(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat15(msgs[msg.concatPart[1]],flagPart1);
        isPat5(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat16: m1.B 
procedure constructSpat16(m1:Message; B:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat15(m1, i1);
    constructSpat5(B, i2);
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

---pat17: R.m2.kseaf 
procedure lookAddPat17(R:NonceType; m2:Message; kseaf:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3: Message;
     index,i1,i2,i3:indexType;
  begin
   index:=0;
   lookAddPat1(R, msg1, i1);
   lookAddPat7(m2, msg2, i2);
   lookAddPat1(kseaf, msg3, i3);
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

---pat17: R.m2.kseaf 
procedure isPat17(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat7(msgs[msg.concatPart[2]],flagPart2);
        isPat1(msgs[msg.concatPart[3]],flagPart3);
       if (flagPart1 & flagPart2 & flagPart3) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat17: R.m2.kseaf 
procedure constructSpat17(R:NonceType; m2:Message; kseaf:NonceType; Var num: indexType);
  Var i,index, i1, i2, i3:indexType;
  begin
    index:=0;
    constructSpat1(R, i1);
    constructSpat7(m2, i2);
    constructSpat1(kseaf, i3);
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
    sPat17Set.length := sPat17Set.length + 1;
    sPat17Set.content[sPat17Set.length] := index;
    num := index;
  end;

---pat18: R.m2 
procedure lookAddPat18(R:NonceType; m2:Message; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(R, msg1, i1);
   lookAddPat7(m2, msg2, i2);
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

---pat18: R.m2 
procedure isPat18(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat7(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat18: R.m2 
procedure constructSpat18(R:NonceType; m2:Message; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(R, i1);
    constructSpat7(m2, i2);
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
    sPat18Set.length := sPat18Set.length + 1;
    sPat18Set.content[sPat18Set.length] := index;
    num := index;
  end;

---pat19: m3 
procedure lookAddPat19(m3:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[m3.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat19: m3 
procedure isPat19(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat19: m3 
procedure constructSpat19(m3:Message; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = tmp) then
        if (msgs[i].tmpPart = m3.tmpPart) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := tmp;
      msgs[index].tmpPart := m3.tmpPart;
      msgs[index].length := 1;
    endif;
    sPat19Set.length := sPat19Set.length + 1;
    sPat19Set.content[sPat19Set.length] := index;
    num := index;
  end;

---pat20: m3.m1 
procedure lookAddPat20(m3:Message; m1:Message; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat19(m3, msg1, i1);
   lookAddPat15(m1, msg2, i2);
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

---pat20: m3.m1 
procedure isPat20(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat19(msgs[msg.concatPart[1]],flagPart1);
        isPat15(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat20: m3.m1 
procedure constructSpat20(m3:Message; m1:Message; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat19(m3, i1);
    constructSpat15(m1, i2);
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
    sPat20Set.length := sPat20Set.length + 1;
    sPat20Set.content[sPat20Set.length] := index;
    num := index;
  end;

---pat21: m3.R.m1 
procedure lookAddPat21(m3:Message; R:NonceType; m1:Message; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3: Message;
     index,i1,i2,i3:indexType;
  begin
   index:=0;
   lookAddPat19(m3, msg1, i1);
   lookAddPat1(R, msg2, i2);
   lookAddPat15(m1, msg3, i3);
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

---pat21: m3.R.m1 
procedure isPat21(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     if(msg.msgType = concat) then
        isPat19(msgs[msg.concatPart[1]],flagPart1);
        isPat1(msgs[msg.concatPart[2]],flagPart2);
        isPat15(msgs[msg.concatPart[3]],flagPart3);
       if (flagPart1 & flagPart2 & flagPart3) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat21: m3.R.m1 
procedure constructSpat21(m3:Message; R:NonceType; m1:Message; Var num: indexType);
  Var i,index, i1, i2, i3:indexType;
  begin
    index:=0;
    constructSpat19(m3, i1);
    constructSpat1(R, i2);
    constructSpat15(m1, i3);
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
    sPat21Set.length := sPat21Set.length + 1;
    sPat21Set.content[sPat21Set.length] := index;
    num := index;
  end;

---pat22: R.aenc{sqnhn.R}k(A,C).kseaf 
procedure lookAddPat22(R:NonceType; sqnhn:NonceType; Asymk1:AgentType; Csymk2:AgentType; kseaf:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3: Message;
     index,i1,i2,i3:indexType;
  begin
   index:=0;
   lookAddPat1(R, msg1, i1);
   lookAddPat12(sqnhn, R, Asymk1, Csymk2, msg2, i2);
   lookAddPat1(kseaf, msg3, i3);
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

---pat22: R.aenc{sqnhn.R}k(A,C).kseaf 
procedure isPat22(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat12(msgs[msg.concatPart[2]],flagPart2);
        isPat1(msgs[msg.concatPart[3]],flagPart3);
       if (flagPart1 & flagPart2 & flagPart3) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat22: R.aenc{sqnhn.R}k(A,C).kseaf 
procedure constructSpat22(R:NonceType; sqnhn:NonceType; Asymk1:AgentType; Csymk2:AgentType; kseaf:NonceType; Var num: indexType);
  Var i,index, i1, i2, i3:indexType;
  begin
    index:=0;
    constructSpat1(R, i1);
    constructSpat12(sqnhn, R, Asymk1, Csymk2, i2);
    constructSpat1(kseaf, i3);
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
    sPat22Set.length := sPat22Set.length + 1;
    sPat22Set.content[sPat22Set.length] := index;
    num := index;
  end;

procedure cons1(supi:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat1(supi,msg,num);
  end;
procedure destruct1(msg:Message; Var supi:NonceType);
  begin
    supi:=msg.noncePart;
  end;
procedure cons2(supi:NonceType; s:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat2(supi, s,msg,num);
  end;
procedure destruct2(msg:Message; Var supi:NonceType; Var s:NonceType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    supi := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    s := msgNum2.noncePart
  end;
procedure cons3(CPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat3(CPk,msg,num);
  end;
procedure cons4(supi:NonceType; s:NonceType; CPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat4(supi, s, CPk,msg,num);
  end;
procedure destruct4(msg:Message; Var supi:NonceType; Var s:NonceType; Var CPk:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    CPk := k1.ag;    aencMsg:=msgs[msg.aencMsg];
    destruct2(aencMsg,supi, s);
  end;
procedure cons5(C:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat5(C,msg,num);
  end;
procedure destruct5(msg:Message; Var C:AgentType);
  begin
    C:=msg.ag;
  end;
procedure cons6(supi:NonceType; s:NonceType; CPk:AgentType; C:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat6(supi, s, CPk, C,msg,num);
  end;
procedure destruct6(msg:Message; Var supi:NonceType; Var s:NonceType; Var CPk:AgentType; Var C:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    destruct4(msgNum1,supi, s, CPk);
    msgNum2 := msgs[msg.concatPart[2]];
    C := msgNum2.ag
  end;
procedure cons7(m2:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat7(m2,msg,num);
  end;
procedure destruct7(msg:Message; Var m2:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    m2:=msg;
    m2.tmpPart:=msgNo;
  end;
procedure cons8(R:NonceType; B:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat8(R, B,msg,num);
  end;
procedure destruct8(msg:Message; Var R:NonceType; Var B:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    R := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    B := msgNum2.ag
  end;
procedure cons9(Asymk1:AgentType; Csymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat9(Asymk1, Csymk2,msg,num);
  end;
procedure destruct9(msg:Message; Var Asymk1:AgentType; Var Csymk2:AgentType);
  var k1:KeyType;
      msg1:Message;
   begin
      clear msg1;
      k1 := msg.k;
      Asymk1 := k1.ag1;
      Csymk2 := k1.ag2;
   end;
procedure cons10(R:NonceType; B:AgentType; Asymk1:AgentType; Csymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat10(R, B, Asymk1, Csymk2,msg,num);
  end;
procedure destruct10(msg:Message; Var R:NonceType; Var B:AgentType; Var Asymk1:AgentType; Var Csymk2:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    Asymk1:=k1.ag1;
    Csymk2:=k1.ag2;
    aencMsg:=msgs[msg.aencMsg];
    destruct8(aencMsg,R, B);
  end;
procedure cons11(R:NonceType; Asymk1:AgentType; Csymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat11(R, Asymk1, Csymk2,msg,num);
  end;
procedure destruct11(msg:Message; Var R:NonceType; Var Asymk1:AgentType; Var Csymk2:AgentType);
  var k1:KeyType;
  var msgKey:Message;
      msg1:Message;
   begin
    clear msg1;
    msgKey := msgs[msg.aencKey];
    destruct9(msgKey, Asymk1, Csymk2);
    msg1:=msgs[msg.aencMsg];
    R:=msg1.noncePart;
   end;
procedure cons12(sqnue:NonceType; R:NonceType; Asymk1:AgentType; Csymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat12(sqnue, R, Asymk1, Csymk2,msg,num);
  end;
procedure destruct12(msg:Message; Var sqnue:NonceType; Var R:NonceType; Var Asymk1:AgentType; Var Csymk2:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    Asymk1:=k1.ag1;
    Csymk2:=k1.ag2;
    aencMsg:=msgs[msg.aencMsg];
    destruct2(aencMsg,sqnue, R);
  end;
procedure cons13(R:NonceType; Asymk1:AgentType; Csymk2:AgentType; sqnue:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat13(R, Asymk1, Csymk2, sqnue,msg,num);
  end;
procedure destruct13(msg:Message; Var R:NonceType; Var Asymk1:AgentType; Var Csymk2:AgentType; Var sqnue:NonceType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    destruct11(msgNum1,R, Asymk1, Csymk2);
    msgNum2 := msgs[msg.concatPart[2]];
    destruct12(msgNum2,sqnue, R, Asymk1, Csymk2)
  end;
procedure cons14(fail:NonceType; R:NonceType; Asymk1:AgentType; Csymk2:AgentType; sqnue:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat14(fail, R, Asymk1, Csymk2, sqnue,msg,num);
  end;
procedure destruct14(msg:Message; Var fail:NonceType; Var R:NonceType; Var Asymk1:AgentType; Var Csymk2:AgentType; Var sqnue:NonceType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    fail := msgNum1.noncePart;

  end;
procedure cons15(m1:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat15(m1,msg,num);
  end;
procedure destruct15(msg:Message; Var m1:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    m1:=msg;
    m1.tmpPart:=msgNo;
  end;
procedure cons16(m1:Message; B:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat16(m1, B,msg,num);
  end;
procedure destruct16(msg:Message; Var m1:Message; Var B:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    m1.msgType := tmp;
    m1.tmpPart := msg.concatPart[1];
    msgNum2 := msgs[msg.concatPart[2]];
    B := msgNum2.ag
  end;
procedure cons17(R:NonceType; m2:Message; kseaf:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat17(R, m2, kseaf,msg,num);
  end;
procedure destruct17(msg:Message; Var R:NonceType; Var m2:Message; Var kseaf:NonceType);
  Var msgNum1,msgNum2,msgNum3: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    R := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    m2.msgType := tmp;
    m2.tmpPart := msg.concatPart[2];
    msgNum3 := msgs[msg.concatPart[3]];
    kseaf := msgNum3.noncePart
  end;
procedure cons18(R:NonceType; m2:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat18(R, m2,msg,num);
  end;
procedure destruct18(msg:Message; Var R:NonceType; Var m2:Message);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    R := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    m2.msgType := tmp;
    m2.tmpPart := msg.concatPart[2]
  end;
procedure cons19(m3:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat19(m3,msg,num);
  end;
procedure destruct19(msg:Message; Var m3:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    m3:=msg;
    m3.tmpPart:=msgNo;
  end;
procedure cons20(m3:Message; m1:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat20(m3, m1,msg,num);
  end;
procedure destruct20(msg:Message; Var m3:Message; Var m1:Message);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    m3.msgType := tmp;
    m3.tmpPart := msg.concatPart[1];
    msgNum2 := msgs[msg.concatPart[2]];
    m1.msgType := tmp;
    m1.tmpPart := msg.concatPart[2]
  end;
procedure cons21(m3:Message; R:NonceType; m1:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat21(m3, R, m1,msg,num);
  end;
procedure destruct21(msg:Message; Var m3:Message; Var R:NonceType; Var m1:Message);
  Var msgNum1,msgNum2,msgNum3: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    m3.msgType := tmp;
    m3.tmpPart := msg.concatPart[1];
    msgNum2 := msgs[msg.concatPart[2]];
    R := msgNum2.noncePart;
    msgNum3 := msgs[msg.concatPart[3]];
    m1.msgType := tmp;
    m1.tmpPart := msg.concatPart[3]
  end;
procedure cons22(R:NonceType; sqnhn:NonceType; Asymk1:AgentType; Csymk2:AgentType; kseaf:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat22(R, sqnhn, Asymk1, Csymk2, kseaf,msg,num);
  end;
procedure destruct22(msg:Message; Var R:NonceType; Var sqnhn:NonceType; Var Asymk1:AgentType; Var Csymk2:AgentType; Var kseaf:NonceType);
  Var msgNum1,msgNum2,msgNum3: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    R := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct12(msgNum2,sqnhn, R, Asymk1, Csymk2);
    msgNum3 := msgs[msg.concatPart[3]];
    kseaf := msgNum3.noncePart
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
   cons6(roleA[i].supi,roleA[i].s,roleA[i].C,roleA[i].C,msg,msgNo);
   ch[1].empty := false;
   ch[1].msg := msg;
   ch[1].sender := roleA[i].A;
   ch[1].receiver := Intruder;
   roleA[i].st := A2;
   put "roleA[i] in st1\n";
end;
rule " roleA2 "
roleA[i].st = A2 & ch[4].empty = false & !roleA[i].commit & judge(ch[4].msg,roleA[i].A,roleA[i].m2) 
==>
var flag_pat7:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[4].msg;
   isPat7(msg, flag_pat7);
   if(flag_pat7) then
     destruct7(msg,roleA[i].locm2);
     if(matchTmp(roleA[i].locm2, roleA[i].m2))then
       ch[4].empty:=true;
       clear ch[4].msg;
       roleA[i].st := A3;
     endif;
   endif;
   put "roleA[i] in st2\n";
end;
rule " roleA3 "
roleA[i].st = A3 & ch[5].empty = true & !roleA[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons10(roleA[i].R,roleA[i].B,roleA[i].A,roleA[i].C,msg,msgNo);
   ch[5].empty := false;
   ch[5].msg := msg;
   ch[5].sender := roleA[i].A;
   ch[5].receiver := Intruder;
   roleA[i].st := A4;
   put "roleA[i] in st3\n";
end;
rule " roleA4 "
roleA[i].st = A4 & ch[8].empty = true & !roleA[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons14(roleA[i].fail,roleA[i].R,roleA[i].A,roleA[i].C,roleA[i].sqnue,msg,msgNo);
   ch[8].empty := false;
   ch[8].msg := msg;
   ch[8].sender := roleA[i].A;
   ch[8].receiver := Intruder;
   roleA[i].st := A5;
   put "roleA[i] in st4\n";
end;
rule " roleA5 "
roleA[i].st = A5 & ch[10].empty = true & !roleA[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons1(roleA[i].fail,msg,msgNo);
   ch[10].empty := false;
   ch[10].msg := msg;
   ch[10].sender := roleA[i].A;
   ch[10].receiver := Intruder;
   roleA[i].st := A1;
   put "roleA[i] in st5\n";
   roleA[i].commit := true;
end;
endruleset;

ruleset i:roleBNums do
rule " roleB1 "
roleB[i].st = B1 & ch[1].empty = false & !roleB[i].commit & judge(ch[1].msg,roleB[i].B,roleB[i].m1) 
==>
var flag_pat15:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[1].msg;
   isPat15(msg, flag_pat15);
   if(flag_pat15) then
     destruct15(msg,roleB[i].locm1);
     if(matchTmp(roleB[i].locm1, roleB[i].m1))then
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
   cons16(roleB[i].m1,roleB[i].B,msg,msgNo);
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
var flag_pat17:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[3].msg;
   isPat17(msg, flag_pat17);
   if(flag_pat17) then
     destruct17(msg,roleB[i].locR,roleB[i].locm2,roleB[i].lockseaf);
     if(matchNonce(roleB[i].locR, roleB[i].R) & matchTmp(roleB[i].locm2, roleB[i].m2) & matchNonce(roleB[i].lockseaf, roleB[i].kseaf))then
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
   cons18(roleB[i].R,roleB[i].m2,msg,msgNo);
   ch[4].empty := false;
   ch[4].msg := msg;
   ch[4].sender := roleB[i].B;
   ch[4].receiver := Intruder;
   roleB[i].st := B5;
   put "roleB[i] in st4\n";
end;
rule " roleB5 "
roleB[i].st = B5 & ch[5].empty = false & !roleB[i].commit & judge(ch[5].msg,roleB[i].B,roleB[i].m3) 
==>
var flag_pat19:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[5].msg;
   isPat19(msg, flag_pat19);
   if(flag_pat19) then
     destruct19(msg,roleB[i].locm3);
     if(matchTmp(roleB[i].locm3, roleB[i].m3))then
       ch[5].empty:=true;
       clear ch[5].msg;
       roleB[i].st := B6;
     endif;
   endif;
   put "roleB[i] in st5\n";
end;
rule " roleB6 "
roleB[i].st = B6 & ch[6].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons20(roleB[i].m3,roleB[i].m1,msg,msgNo);
   ch[6].empty := false;
   ch[6].msg := msg;
   ch[6].sender := roleB[i].B;
   ch[6].receiver := Intruder;
   roleB[i].st := B7;
   put "roleB[i] in st6\n";
end;
rule " roleB7 "
roleB[i].st = B7 & ch[7].empty = false & !roleB[i].commit & judge(ch[7].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat1:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[7].msg;
   isPat1(msg, flag_pat1);
   if(flag_pat1) then
     destruct1(msg,roleB[i].locsupi);
     if(matchNonce(roleB[i].locsupi, roleB[i].supi))then
       ch[7].empty:=true;
       clear ch[7].msg;
       roleB[i].st := B8;
     endif;
   endif;
   put "roleB[i] in st7\n";
end;
rule " roleB8 "
roleB[i].st = B8 & ch[8].empty = false & !roleB[i].commit & judge(ch[8].msg,roleB[i].B,roleB[i].m3) 
==>
var flag_pat19:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[8].msg;
   isPat19(msg, flag_pat19);
   if(flag_pat19) then
     destruct19(msg,roleB[i].locm3);
     if(matchTmp(roleB[i].locm3, roleB[i].m3))then
       ch[8].empty:=true;
       clear ch[8].msg;
       roleB[i].st := B9;
     endif;
   endif;
   put "roleB[i] in st8\n";
end;
rule " roleB9 "
roleB[i].st = B9 & ch[9].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons21(roleB[i].m3,roleB[i].R,roleB[i].m1,msg,msgNo);
   ch[9].empty := false;
   ch[9].msg := msg;
   ch[9].sender := roleB[i].B;
   ch[9].receiver := Intruder;
   roleB[i].st := B10;
   put "roleB[i] in st9\n";
end;
rule " roleB10 "
roleB[i].st = B10 & ch[10].empty = false & !roleB[i].commit & judge(ch[10].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat1:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[10].msg;
   isPat1(msg, flag_pat1);
   if(flag_pat1) then
     destruct1(msg,roleB[i].locfail);
     if(matchNonce(roleB[i].locfail, roleB[i].fail))then
       ch[10].empty:=true;
       clear ch[10].msg;
       roleB[i].st := B1;
     endif;
   endif;
   put "roleB[i] in st10\n";
   roleB[i].commit := true;
end;
endruleset;

ruleset i:roleCNums do
rule " roleC1 "
roleC[i].st = C1 & ch[2].empty = false & !roleC[i].commit & judge(ch[2].msg,roleC[i].C,msgs[0]) 
==>
var flag_pat16:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[2].msg;
   isPat16(msg, flag_pat16);
   if(flag_pat16) then
     destruct16(msg,roleC[i].locm1,roleC[i].locB);
     if(matchTmp(roleC[i].locm1, roleC[i].m1) & matchAgent(roleC[i].locB, roleC[i].B))then
       ch[2].empty:=true;
       clear ch[2].msg;
       roleC[i].st := C2;
     endif;
   endif;
   put "roleC[i] in st1\n";
end;
rule " roleC2 "
roleC[i].st = C2 & ch[3].empty = true & !roleC[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons22(roleC[i].R,roleC[i].sqnhn,roleC[i].A,roleC[i].C,roleC[i].kseaf,msg,msgNo);
   ch[3].empty := false;
   ch[3].msg := msg;
   ch[3].sender := roleC[i].C;
   ch[3].receiver := Intruder;
   roleC[i].st := C3;
   put "roleC[i] in st2\n";
end;
rule " roleC3 "
roleC[i].st = C3 & ch[6].empty = false & !roleC[i].commit & judge(ch[6].msg,roleC[i].C,msgs[0]) 
==>
var flag_pat20:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[6].msg;
   isPat20(msg, flag_pat20);
   if(flag_pat20) then
     destruct20(msg,roleC[i].locm3,roleC[i].locm1);
     if(matchTmp(roleC[i].locm3, roleC[i].m3) & matchTmp(roleC[i].locm1, roleC[i].m1))then
       ch[6].empty:=true;
       clear ch[6].msg;
       roleC[i].st := C4;
     endif;
   endif;
   put "roleC[i] in st3\n";
end;
rule " roleC4 "
roleC[i].st = C4 & ch[7].empty = true & !roleC[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons1(roleC[i].supi,msg,msgNo);
   ch[7].empty := false;
   ch[7].msg := msg;
   ch[7].sender := roleC[i].C;
   ch[7].receiver := Intruder;
   roleC[i].st := C5;
   put "roleC[i] in st4\n";
end;
rule " roleC5 "
roleC[i].st = C5 & ch[9].empty = false & !roleC[i].commit & judge(ch[9].msg,roleC[i].C,msgs[0]) 
==>
var flag_pat21:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[9].msg;
   isPat21(msg, flag_pat21);
   if(flag_pat21) then
     destruct21(msg,roleC[i].locm3,roleC[i].locR,roleC[i].locm1);
     if(matchTmp(roleC[i].locm3, roleC[i].m3) & matchNonce(roleC[i].locR, roleC[i].R) & matchTmp(roleC[i].locm1, roleC[i].m1))then
       ch[9].empty:=true;
       clear ch[9].msg;
       roleC[i].st := C1;
     endif;
   endif;
   put "roleC[i] in st5\n";
   roleC[i].commit := true;
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

---rule of intruder to get msg from ch[5] 
rule "intruderGetMsgFromCh[5]" 
  ch[5].empty = false & ch[5].sender != Intruder ==>
  var flag_pat10:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[5].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat10(msg,flag_pat10);
    if (flag_pat10) then
      if(!exist(pat10Set,msgNo)) then
        pat10Set.length:=pat10Set.length+1;
        pat10Set.content[pat10Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[5].empty := true;
      clear ch[5].msg;
    endif;
    put "intruder get msg from ch[5].\n";
  end;

---rule of intruder to get msg from ch[8] 
rule "intruderGetMsgFromCh[8]" 
  ch[8].empty = false & ch[8].sender != Intruder ==>
  var flag_pat14:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[8].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat14(msg,flag_pat14);
    if (flag_pat14) then
      if(!exist(pat14Set,msgNo)) then
        pat14Set.length:=pat14Set.length+1;
        pat14Set.content[pat14Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[8].empty := true;
      clear ch[8].msg;
    endif;
    put "intruder get msg from ch[8].\n";
  end;

---rule of intruder to get msg from ch[10] 
rule "intruderGetMsgFromCh[10]" 
  ch[10].empty = false & ch[10].sender != Intruder ==>
  var flag_pat1:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[10].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat1(msg,flag_pat1);
    if (flag_pat1) then
      if(!exist(pat1Set,msgNo)) then
        pat1Set.length:=pat1Set.length+1;
        pat1Set.content[pat1Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[10].empty := true;
      clear ch[10].msg;
    endif;
    put "intruder get msg from ch[10].\n";
  end;

---rule of intruder to get msg from ch[2] 
rule "intruderGetMsgFromCh[2]" 
  ch[2].empty = false & ch[2].sender != Intruder ==>
  var flag_pat16:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[2].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat16(msg,flag_pat16);
    if (flag_pat16) then
      if(!exist(pat16Set,msgNo)) then
        pat16Set.length:=pat16Set.length+1;
        pat16Set.content[pat16Set.length]:=msgNo;
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
  var flag_pat18:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[4].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat18(msg,flag_pat18);
    if (flag_pat18) then
      if(!exist(pat18Set,msgNo)) then
        pat18Set.length:=pat18Set.length+1;
        pat18Set.content[pat18Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[4].empty := true;
      clear ch[4].msg;
    endif;
    put "intruder get msg from ch[4].\n";
  end;

---rule of intruder to get msg from ch[6] 
rule "intruderGetMsgFromCh[6]" 
  ch[6].empty = false & ch[6].sender != Intruder ==>
  var flag_pat20:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[6].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat20(msg,flag_pat20);
    if (flag_pat20) then
      if(!exist(pat20Set,msgNo)) then
        pat20Set.length:=pat20Set.length+1;
        pat20Set.content[pat20Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[6].empty := true;
      clear ch[6].msg;
    endif;
    put "intruder get msg from ch[6].\n";
  end;

---rule of intruder to get msg from ch[9] 
rule "intruderGetMsgFromCh[9]" 
  ch[9].empty = false & ch[9].sender != Intruder ==>
  var flag_pat21:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[9].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat21(msg,flag_pat21);
    if (flag_pat21) then
      if(!exist(pat21Set,msgNo)) then
        pat21Set.length:=pat21Set.length+1;
        pat21Set.content[pat21Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[9].empty := true;
      clear ch[9].msg;
    endif;
    put "intruder get msg from ch[9].\n";
  end;

---rule of intruder to get msg from ch[3] 
rule "intruderGetMsgFromCh[3]" 
  ch[3].empty = false & ch[3].sender != Intruder ==>
  var flag_pat22:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[3].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat22(msg,flag_pat22);
    if (flag_pat22) then
      if(!exist(pat22Set,msgNo)) then
        pat22Set.length:=pat22Set.length+1;
        pat22Set.content[pat22Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[3].empty := true;
      clear ch[3].msg;
    endif;
    put "intruder get msg from ch[3].\n";
  end;

---rule of intruder to get msg from ch[7] 
rule "intruderGetMsgFromCh[7]" 
  ch[7].empty = false & ch[7].sender != Intruder ==>
  var flag_pat1:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[7].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat1(msg,flag_pat1);
    if (flag_pat1) then
      if(!exist(pat1Set,msgNo)) then
        pat1Set.length:=pat1Set.length+1;
        pat1Set.content[pat1Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[7].empty := true;
      clear ch[7].msg;
    endif;
    put "intruder get msg from ch[7].\n";
  end;

---rule of intruder to emit msg into ch[4].
ruleset i: msgLen do
  ruleset j: roleANums do
    rule "intruderEmitMsgIntoCh[4]"
      IntruEmit3 = true & roleA[j].st = A2 & ch[4].empty=true & i <= pat18Set.length & pat18Set.content[i] != 0 & Spy_known[pat18Set.content[i]] & !emit[pat18Set.content[i]] ---& matchPat(msgs[pat18Set.content[i]], sPat18Set)
      ==>
      begin
         clear ch[4];
        ch[4].msg:=msgs[pat18Set.content[i]];
        ch[4].sender:=Intruder;
        ch[4].receiver:=roleA[j].A;
        ch[4].empty:=false;
        emit[pat18Set.content[i]] := true;
        IntruEmit4 := true;
        put "intruder emit msg into ch[4].\n";
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
      IntruEmit2 = true & roleB[j].st = B3 & ch[3].empty=true & i <= pat22Set.length & pat22Set.content[i] != 0 & Spy_known[pat22Set.content[i]] & !emit[pat22Set.content[i]] ---& matchPat(msgs[pat22Set.content[i]], sPat22Set)
      ==>
      begin
         clear ch[3];
        ch[3].msg:=msgs[pat22Set.content[i]];
        ch[3].sender:=Intruder;
        ch[3].receiver:=roleB[j].B;
        ch[3].empty:=false;
        emit[pat22Set.content[i]] := true;
        IntruEmit3 := true;
        put "intruder emit msg into ch[3].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[5].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[5]"
      IntruEmit4 = true & roleB[j].st = B5 & ch[5].empty=true & i <= pat10Set.length & pat10Set.content[i] != 0 & Spy_known[pat10Set.content[i]] & !emit[pat10Set.content[i]] ---& matchPat(msgs[pat10Set.content[i]], sPat10Set)
      ==>
      begin
         clear ch[5];
        ch[5].msg:=msgs[pat10Set.content[i]];
        ch[5].sender:=Intruder;
        ch[5].receiver:=roleB[j].B;
        ch[5].empty:=false;
        emit[pat10Set.content[i]] := true;
        IntruEmit5 := true;
        put "intruder emit msg into ch[5].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[7].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[7]"
      IntruEmit6 = true & roleB[j].st = B7 & ch[7].empty=true & i <= pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] & !emit[pat1Set.content[i]] ---& matchPat(msgs[pat1Set.content[i]], sPat1Set)
      ==>
      begin
         clear ch[7];
        ch[7].msg:=msgs[pat1Set.content[i]];
        ch[7].sender:=Intruder;
        ch[7].receiver:=roleB[j].B;
        ch[7].empty:=false;
        emit[pat1Set.content[i]] := true;
        IntruEmit7 := true;
        put "intruder emit msg into ch[7].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[8].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[8]"
      IntruEmit7 = true & roleB[j].st = B8 & ch[8].empty=true & i <= pat14Set.length & pat14Set.content[i] != 0 & Spy_known[pat14Set.content[i]] & !emit[pat14Set.content[i]] ---& matchPat(msgs[pat14Set.content[i]], sPat14Set)
      ==>
      begin
         clear ch[8];
        ch[8].msg:=msgs[pat14Set.content[i]];
        ch[8].sender:=Intruder;
        ch[8].receiver:=roleB[j].B;
        ch[8].empty:=false;
        emit[pat14Set.content[i]] := true;
        IntruEmit8 := true;
        put "intruder emit msg into ch[8].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[10].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[10]"
      IntruEmit9 = true & roleB[j].st = B10 & ch[10].empty=true & i <= pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] & !emit[pat1Set.content[i]] ---& matchPat(msgs[pat1Set.content[i]], sPat1Set)
      ==>
      begin
         clear ch[10];
        ch[10].msg:=msgs[pat1Set.content[i]];
        ch[10].sender:=Intruder;
        ch[10].receiver:=roleB[j].B;
        ch[10].empty:=false;
        emit[pat1Set.content[i]] := true;
        IntruEmit10 := true;
        put "intruder emit msg into ch[10].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[2].
ruleset i: msgLen do
  ruleset j: roleCNums do
    rule "intruderEmitMsgIntoCh[2]"
      IntruEmit1 = true & roleC[j].st = C1 & ch[2].empty=true & i <= pat16Set.length & pat16Set.content[i] != 0 & Spy_known[pat16Set.content[i]] & !emit[pat16Set.content[i]] ---& matchPat(msgs[pat16Set.content[i]], sPat16Set)
      ==>
      begin
         clear ch[2];
        ch[2].msg:=msgs[pat16Set.content[i]];
        ch[2].sender:=Intruder;
        ch[2].receiver:=roleC[j].C;
        ch[2].empty:=false;
        emit[pat16Set.content[i]] := true;
        IntruEmit2 := true;
        put "intruder emit msg into ch[2].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[6].
ruleset i: msgLen do
  ruleset j: roleCNums do
    rule "intruderEmitMsgIntoCh[6]"
      IntruEmit5 = true & roleC[j].st = C3 & ch[6].empty=true & i <= pat20Set.length & pat20Set.content[i] != 0 & Spy_known[pat20Set.content[i]] & !emit[pat20Set.content[i]] ---& matchPat(msgs[pat20Set.content[i]], sPat20Set)
      ==>
      begin
         clear ch[6];
        ch[6].msg:=msgs[pat20Set.content[i]];
        ch[6].sender:=Intruder;
        ch[6].receiver:=roleC[j].C;
        ch[6].empty:=false;
        emit[pat20Set.content[i]] := true;
        IntruEmit6 := true;
        put "intruder emit msg into ch[6].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[9].
ruleset i: msgLen do
  ruleset j: roleCNums do
    rule "intruderEmitMsgIntoCh[9]"
      IntruEmit8 = true & roleC[j].st = C5 & ch[9].empty=true & i <= pat21Set.length & pat21Set.content[i] != 0 & Spy_known[pat21Set.content[i]] & !emit[pat21Set.content[i]] ---& matchPat(msgs[pat21Set.content[i]], sPat21Set)
      ==>
      begin
         clear ch[9];
        ch[9].msg:=msgs[pat21Set.content[i]];
        ch[9].sender:=Intruder;
        ch[9].receiver:=roleC[j].C;
        ch[9].empty:=false;
        emit[pat21Set.content[i]] := true;
        IntruEmit9 := true;
        put "intruder emit msg into ch[9].\n";
      end;
  endruleset;
endruleset;
--- enconcat and deconcat rules for pat: concat(supi.s)

ruleset i:msgLen do 
  rule "deconcat 2" --pat2
    i<=pat2Set.length & pat2Set.content[i] != 0 & Spy_known[pat2Set.content[i]]   &
    !(Spy_known[msgs[pat2Set.content[i]].concatPart[1]]&Spy_known[msgs[pat2Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat2\n";
      if (!Spy_known[msgs[pat2Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat2Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat2Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat2Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat2Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat2Set.content[i]].concatPart[2];
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
    rule "enconcat 2"	---pat2
      roleB[i].st = B1 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      matchPat(construct2By11(pat1Set.content[i1],pat1Set.content[i2]), sPat2Set)&
      !Spy_known[constructIndex2By11(pat1Set.content[i1],pat1Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat2\n";
        concatMsgNo := constructIndex2By11(pat1Set.content[i1],pat1Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct2By11(pat1Set.content[i1],pat1Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat2Set,concatMsgNo)) then
          pat2Set.length:=pat2Set.length+1;
          pat2Set.content[pat2Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{supi.s}pk(C), for intruder
ruleset i:msgLen do 
  rule "adecrypt 4"	---pat4
    i<=pat4Set.length & pat4Set.content[i] != 0 & Spy_known[pat4Set.content[i]] &
    !Spy_known[msgs[pat4Set.content[i]].aencMsg]&
    Spy_known[inverseKeyIndex(msgs[msgs[pat4Set.content[i]].aencKey])]  ==>
    var key_inv:Message;
	      msgPat2:indexType;
	      flag_pat2:boolean;	      num:indexType;
    begin
      put "rule adecrypt4\n";
      key_inv := inverseKey(msgs[msgs[pat4Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat4Set.content[i]].aencMsg]:=true;
        msgPat2:=msgs[pat4Set.content[i]].aencMsg;
        isPat2(msgs[msgPat2],flag_pat2);
        if (flag_pat2) then
          if (!exist(pat2Set,msgPat2)) then
            pat2Set.length:=pat2Set.length+1;
            pat2Set.content[pat2Set.length]:=msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "aencrypt 4"	---pat4
      roleB[i1].st = B1 &      i<=pat2Set.length & pat2Set.content[i] != 0 & Spy_known[pat2Set.content[i]] &
      j<=pat3Set.length & pat3Set.content[j] != 0 & Spy_known[pat3Set.content[j]] &
      matchPat(construct4By23(pat2Set.content[i],pat3Set.content[j]), sPat4Set) &
      !Spy_known[constructIndex4By23(pat2Set.content[i],pat3Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt4\n";
        if (msgs[pat3Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex4By23(pat2Set.content[i],pat3Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct4By23(pat2Set.content[i],pat3Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat4Set,encMsgNo)) then
            pat4Set.length := pat4Set.length+1;
            pat4Set.content[pat4Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(aenc{supi.s}pk(C).C)

ruleset i:msgLen do 
  rule "deconcat 6" --pat6
    i<=pat6Set.length & pat6Set.content[i] != 0 & Spy_known[pat6Set.content[i]]   &
    !(Spy_known[msgs[pat6Set.content[i]].concatPart[1]]&Spy_known[msgs[pat6Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat6\n";
      if (!Spy_known[msgs[pat6Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat6Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat6Set.content[i]].concatPart[1];
        isPat4(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat4Set,msgPat1)) then
             pat4Set.length:=pat4Set.length+1;
             pat4Set.content[pat4Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat6Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat6Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat6Set.content[i]].concatPart[2];
        isPat5(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat5Set,msgPat2)) then
             pat5Set.length:=pat5Set.length+1;
             pat5Set.content[pat5Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 6"	---pat6
      roleB[i].st = B1 &      i1<=pat4Set.length & Spy_known[pat4Set.content[i1]] &
      i2<=pat5Set.length & Spy_known[pat5Set.content[i2]] &
      matchPat(construct6By45(pat4Set.content[i1],pat5Set.content[i2]), sPat6Set)&
      !Spy_known[constructIndex6By45(pat4Set.content[i1],pat5Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat6\n";
        concatMsgNo := constructIndex6By45(pat4Set.content[i1],pat5Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct6By45(pat4Set.content[i1],pat5Set.content[i2]);
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

--- enconcat and deconcat rules for pat: concat(R.B)

ruleset i:msgLen do 
  rule "deconcat 8" --pat8
    i<=pat8Set.length & pat8Set.content[i] != 0 & Spy_known[pat8Set.content[i]]   &
    !(Spy_known[msgs[pat8Set.content[i]].concatPart[1]]&Spy_known[msgs[pat8Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat8\n";
      if (!Spy_known[msgs[pat8Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat8Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat8Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat8Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat8Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat8Set.content[i]].concatPart[2];
        isPat5(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat5Set,msgPat2)) then
             pat5Set.length:=pat5Set.length+1;
             pat5Set.content[pat5Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 8"	---pat8
      roleB[i].st = B5 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat5Set.length & Spy_known[pat5Set.content[i2]] &
      matchPat(construct8By15(pat1Set.content[i1],pat5Set.content[i2]), sPat8Set)&
      !Spy_known[constructIndex8By15(pat1Set.content[i1],pat5Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat8\n";
        concatMsgNo := constructIndex8By15(pat1Set.content[i1],pat5Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct8By15(pat1Set.content[i1],pat5Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat8Set,concatMsgNo)) then
          pat8Set.length:=pat8Set.length+1;
          pat8Set.content[pat8Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{R.B}k(A,C), for intruder
ruleset i:msgLen do 
  rule "adecrypt 10"	---pat10
    i<=pat10Set.length & pat10Set.content[i] != 0 & Spy_known[pat10Set.content[i]] &
    !Spy_known[msgs[pat10Set.content[i]].aencMsg] 
   ==>
    var key_inv:Message;
	      msgPat8,keyNo:indexType;
	      flag_pat8:boolean;
    begin
      put "rule adecrypt10\n";
      key_inv := inverseKey(msgs[msgs[pat10Set.content[i]].aencKey]);
      get_msgNo(key_inv,keyNo);
      if (Spy_known[keyNo]) then
        Spy_known[msgs[pat10Set.content[i]].aencMsg]:=true;
        msgPat8:=msgs[pat10Set.content[i]].aencMsg;
        isPat8(msgs[msgPat8],flag_pat8);
        if (flag_pat8) then
          if (!exist(pat8Set,msgPat8)) then
            pat8Set.length:=pat8Set.length+1;
            pat8Set.content[pat8Set.length]:=msgPat8;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "aencrypt 10"	---pat10
      roleB[i1].st = B5 &      i<=pat8Set.length & pat8Set.content[i] != 0 & Spy_known[pat8Set.content[i]] &
      j<=pat9Set.length & pat9Set.content[j] != 0 & Spy_known[pat9Set.content[j]] &
      matchPat(construct10By89(pat8Set.content[i],pat9Set.content[j]), sPat10Set) &
      !Spy_known[constructIndex10By89(pat8Set.content[i],pat9Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt10\n";
        if (msgs[pat9Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex10By89(pat8Set.content[i],pat9Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct10By89(pat8Set.content[i],pat9Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat10Set,encMsgNo)) then
            pat10Set.length := pat10Set.length+1;
            pat10Set.content[pat10Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{R}k(A,C), for intruder
ruleset i:msgLen do 
  rule "adecrypt 11"	---pat11
    i<=pat11Set.length & pat11Set.content[i] != 0 & Spy_known[pat11Set.content[i]] &
    !Spy_known[msgs[pat11Set.content[i]].aencMsg] 
   ==>
    var key_inv:Message;
	      msgPat1,keyNo:indexType;
	      flag_pat1:boolean;
    begin
      put "rule adecrypt11\n";
      key_inv := inverseKey(msgs[msgs[pat11Set.content[i]].aencKey]);
      get_msgNo(key_inv,keyNo);
      if (Spy_known[keyNo]) then
        Spy_known[msgs[pat11Set.content[i]].aencMsg]:=true;
        msgPat1:=msgs[pat11Set.content[i]].aencMsg;
        isPat1(msgs[msgPat1],flag_pat1);
        if (flag_pat1) then
          if (!exist(pat1Set,msgPat1)) then
            pat1Set.length:=pat1Set.length+1;
            pat1Set.content[pat1Set.length]:=msgPat1;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "aencrypt 11"	---pat11
      roleB[i1].st = B8 &      i<=pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] &
      j<=pat9Set.length & pat9Set.content[j] != 0 & Spy_known[pat9Set.content[j]] &
      matchPat(construct11By19(pat1Set.content[i],pat9Set.content[j]), sPat11Set) &
      !Spy_known[constructIndex11By19(pat1Set.content[i],pat9Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt11\n";
        if (msgs[pat9Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex11By19(pat1Set.content[i],pat9Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct11By19(pat1Set.content[i],pat9Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat11Set,encMsgNo)) then
            pat11Set.length := pat11Set.length+1;
            pat11Set.content[pat11Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{sqnue.R}k(A,C), for intruder
ruleset i:msgLen do 
  rule "adecrypt 12"	---pat12
    i<=pat12Set.length & pat12Set.content[i] != 0 & Spy_known[pat12Set.content[i]] &
    !Spy_known[msgs[pat12Set.content[i]].aencMsg] 
   ==>
    var key_inv:Message;
	      msgPat2,keyNo:indexType;
	      flag_pat2:boolean;
    begin
      put "rule adecrypt12\n";
      key_inv := inverseKey(msgs[msgs[pat12Set.content[i]].aencKey]);
      get_msgNo(key_inv,keyNo);
      if (Spy_known[keyNo]) then
        Spy_known[msgs[pat12Set.content[i]].aencMsg]:=true;
        msgPat2:=msgs[pat12Set.content[i]].aencMsg;
        isPat2(msgs[msgPat2],flag_pat2);
        if (flag_pat2) then
          if (!exist(pat2Set,msgPat2)) then
            pat2Set.length:=pat2Set.length+1;
            pat2Set.content[pat2Set.length]:=msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "aencrypt 12"	---pat12
      roleB[i1].st = B8 &      i<=pat2Set.length & pat2Set.content[i] != 0 & Spy_known[pat2Set.content[i]] &
      j<=pat9Set.length & pat9Set.content[j] != 0 & Spy_known[pat9Set.content[j]] &
      matchPat(construct12By29(pat2Set.content[i],pat9Set.content[j]), sPat12Set) &
      !Spy_known[constructIndex12By29(pat2Set.content[i],pat9Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt12\n";
        if (msgs[pat9Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex12By29(pat2Set.content[i],pat9Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct12By29(pat2Set.content[i],pat9Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat12Set,encMsgNo)) then
            pat12Set.length := pat12Set.length+1;
            pat12Set.content[pat12Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(aenc{R}k(A,C).aenc{sqnue.R}k(A,C))

ruleset i:msgLen do 
  rule "deconcat 13" --pat13
    i<=pat13Set.length & pat13Set.content[i] != 0 & Spy_known[pat13Set.content[i]]   &
    !(Spy_known[msgs[pat13Set.content[i]].concatPart[1]]&Spy_known[msgs[pat13Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat13\n";
      if (!Spy_known[msgs[pat13Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat13Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat13Set.content[i]].concatPart[1];
        isPat11(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat11Set,msgPat1)) then
             pat11Set.length:=pat11Set.length+1;
             pat11Set.content[pat11Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat13Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat13Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat13Set.content[i]].concatPart[2];
        isPat12(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat12Set,msgPat2)) then
             pat12Set.length:=pat12Set.length+1;
             pat12Set.content[pat12Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 13"	---pat13
      roleB[i].st = B8 &      i1<=pat11Set.length & Spy_known[pat11Set.content[i1]] &
      i2<=pat12Set.length & Spy_known[pat12Set.content[i2]] &
      matchPat(construct13By1112(pat11Set.content[i1],pat12Set.content[i2]), sPat13Set)&
      !Spy_known[constructIndex13By1112(pat11Set.content[i1],pat12Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat13\n";
        concatMsgNo := constructIndex13By1112(pat11Set.content[i1],pat12Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct13By1112(pat11Set.content[i1],pat12Set.content[i2]);
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

--- enconcat and deconcat rules for pat: concat(fail.aenc{R}k(A,C).aenc{sqnue.R}k(A,C))

ruleset i:msgLen do 
  rule "deconcat 14" --pat14
    i<=pat14Set.length & pat14Set.content[i] != 0 & Spy_known[pat14Set.content[i]]   &
    !(Spy_known[msgs[pat14Set.content[i]].concatPart[1]]&Spy_known[msgs[pat14Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat14\n";
      if (!Spy_known[msgs[pat14Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat14Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat14Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat14Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat14Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat14Set.content[i]].concatPart[2];
        isPat13(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat13Set,msgPat2)) then
             pat13Set.length:=pat13Set.length+1;
             pat13Set.content[pat13Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 14"	---pat14
      roleB[i].st = B8 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat13Set.length & Spy_known[pat13Set.content[i2]] &
      matchPat(construct14By113(pat1Set.content[i1],pat13Set.content[i2]), sPat14Set)&
      !Spy_known[constructIndex14By113(pat1Set.content[i1],pat13Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat14\n";
        concatMsgNo := constructIndex14By113(pat1Set.content[i1],pat13Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct14By113(pat1Set.content[i1],pat13Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat14Set,concatMsgNo)) then
          pat14Set.length:=pat14Set.length+1;
          pat14Set.content[pat14Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(m1.B)

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
        isPat15(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat15Set,msgPat1)) then
             pat15Set.length:=pat15Set.length+1;
             pat15Set.content[pat15Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat16Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat16Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat16Set.content[i]].concatPart[2];
        isPat5(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat5Set,msgPat2)) then
             pat5Set.length:=pat5Set.length+1;
             pat5Set.content[pat5Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleCNums do
    rule "enconcat 16"	---pat16
      roleC[i].st = C1 &      i1<=pat15Set.length & Spy_known[pat15Set.content[i1]] &
      i2<=pat5Set.length & Spy_known[pat5Set.content[i2]] &
      matchPat(construct16By155(pat15Set.content[i1],pat5Set.content[i2]), sPat16Set)&
      !Spy_known[constructIndex16By155(pat15Set.content[i1],pat5Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat16\n";
        concatMsgNo := constructIndex16By155(pat15Set.content[i1],pat5Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct16By155(pat15Set.content[i1],pat5Set.content[i2]);
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

--- enconcat and deconcat rules for pat: concat(R.m2.kseaf)

ruleset i:msgLen do 
  rule "deconcat 17" --pat17
    i<=pat17Set.length & pat17Set.content[i] != 0 & Spy_known[pat17Set.content[i]]   &
    !(Spy_known[msgs[pat17Set.content[i]].concatPart[1]]&Spy_known[msgs[pat17Set.content[i]].concatPart[2]]&Spy_known[msgs[pat17Set.content[i]].concatPart[3]])
    ==>
    var msgPat1,msgPat2,msgPat3:indexType;
        flagPat1,flagPat2,flagPat3:boolean;
    begin
      put "rule deconcat17\n";
      if (!Spy_known[msgs[pat17Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat17Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat17Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat17Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat17Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat17Set.content[i]].concatPart[2];
        isPat7(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat7Set,msgPat2)) then
             pat7Set.length:=pat7Set.length+1;
             pat7Set.content[pat7Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat17Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat17Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat17Set.content[i]].concatPart[3];
        isPat1(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat1Set,msgPat3)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat3;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do
  ruleset i3: msgLen do 
    rule "enconcat 17"	---pat17
      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat7Set.length & Spy_known[pat7Set.content[i2]] &
      i3<=pat1Set.length & Spy_known[pat1Set.content[i3]] &
      matchPat(construct17By171(pat1Set.content[i1],pat7Set.content[i2],pat1Set.content[i3]), sPat17Set)&
      !Spy_known[constructIndex17By171(pat1Set.content[i1],pat7Set.content[i2],pat1Set.content[i3])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat17\n";
        concatMsgNo := constructIndex17By171(pat1Set.content[i1],pat7Set.content[i2],pat1Set.content[i3]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct17By171(pat1Set.content[i1],pat7Set.content[i2],pat1Set.content[i3]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat17Set,concatMsgNo)) then
          pat17Set.length:=pat17Set.length+1;
          pat17Set.content[pat17Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(R.m2)

ruleset i:msgLen do 
  rule "deconcat 18" --pat18
    i<=pat18Set.length & pat18Set.content[i] != 0 & Spy_known[pat18Set.content[i]]   &
    !(Spy_known[msgs[pat18Set.content[i]].concatPart[1]]&Spy_known[msgs[pat18Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat18\n";
      if (!Spy_known[msgs[pat18Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat18Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat18Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat18Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat18Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat18Set.content[i]].concatPart[2];
        isPat7(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat7Set,msgPat2)) then
             pat7Set.length:=pat7Set.length+1;
             pat7Set.content[pat7Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleANums do
    rule "enconcat 18"	---pat18
      roleA[i].st = A2 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat7Set.length & Spy_known[pat7Set.content[i2]] &
      matchPat(construct18By17(pat1Set.content[i1],pat7Set.content[i2]), sPat18Set)&
      !Spy_known[constructIndex18By17(pat1Set.content[i1],pat7Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat18\n";
        concatMsgNo := constructIndex18By17(pat1Set.content[i1],pat7Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct18By17(pat1Set.content[i1],pat7Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat18Set,concatMsgNo)) then
          pat18Set.length:=pat18Set.length+1;
          pat18Set.content[pat18Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(m3.m1)

ruleset i:msgLen do 
  rule "deconcat 20" --pat20
    i<=pat20Set.length & pat20Set.content[i] != 0 & Spy_known[pat20Set.content[i]]   &
    !(Spy_known[msgs[pat20Set.content[i]].concatPart[1]]&Spy_known[msgs[pat20Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat20\n";
      if (!Spy_known[msgs[pat20Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat20Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat20Set.content[i]].concatPart[1];
        isPat19(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat19Set,msgPat1)) then
             pat19Set.length:=pat19Set.length+1;
             pat19Set.content[pat19Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat20Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat20Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat20Set.content[i]].concatPart[2];
        isPat15(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat15Set,msgPat2)) then
             pat15Set.length:=pat15Set.length+1;
             pat15Set.content[pat15Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleCNums do
    rule "enconcat 20"	---pat20
      roleC[i].st = C3 &      i1<=pat19Set.length & Spy_known[pat19Set.content[i1]] &
      i2<=pat15Set.length & Spy_known[pat15Set.content[i2]] &
      matchPat(construct20By1915(pat19Set.content[i1],pat15Set.content[i2]), sPat20Set)&
      !Spy_known[constructIndex20By1915(pat19Set.content[i1],pat15Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat20\n";
        concatMsgNo := constructIndex20By1915(pat19Set.content[i1],pat15Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct20By1915(pat19Set.content[i1],pat15Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat20Set,concatMsgNo)) then
          pat20Set.length:=pat20Set.length+1;
          pat20Set.content[pat20Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(m3.R.m1)

ruleset i:msgLen do 
  rule "deconcat 21" --pat21
    i<=pat21Set.length & pat21Set.content[i] != 0 & Spy_known[pat21Set.content[i]]   &
    !(Spy_known[msgs[pat21Set.content[i]].concatPart[1]]&Spy_known[msgs[pat21Set.content[i]].concatPart[2]]&Spy_known[msgs[pat21Set.content[i]].concatPart[3]])
    ==>
    var msgPat1,msgPat2,msgPat3:indexType;
        flagPat1,flagPat2,flagPat3:boolean;
    begin
      put "rule deconcat21\n";
      if (!Spy_known[msgs[pat21Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat21Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat21Set.content[i]].concatPart[1];
        isPat19(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat19Set,msgPat1)) then
             pat19Set.length:=pat19Set.length+1;
             pat19Set.content[pat19Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat21Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat21Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat21Set.content[i]].concatPart[2];
        isPat1(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat1Set,msgPat2)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat21Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat21Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat21Set.content[i]].concatPart[3];
        isPat15(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat15Set,msgPat3)) then
             pat15Set.length:=pat15Set.length+1;
             pat15Set.content[pat15Set.length] := msgPat3;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do
  ruleset i3: msgLen do 
    ruleset i: roleCNums do
    rule "enconcat 21"	---pat21
      roleC[i].st = C5 &      i1<=pat19Set.length & Spy_known[pat19Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      i3<=pat15Set.length & Spy_known[pat15Set.content[i3]] &
      matchPat(construct21By19115(pat19Set.content[i1],pat1Set.content[i2],pat15Set.content[i3]), sPat21Set)&
      !Spy_known[constructIndex21By19115(pat19Set.content[i1],pat1Set.content[i2],pat15Set.content[i3])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat21\n";
        concatMsgNo := constructIndex21By19115(pat19Set.content[i1],pat1Set.content[i2],pat15Set.content[i3]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct21By19115(pat19Set.content[i1],pat1Set.content[i2],pat15Set.content[i3]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat21Set,concatMsgNo)) then
          pat21Set.length:=pat21Set.length+1;
          pat21Set.content[pat21Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(R.aenc{sqnhn.R}k(A,C).kseaf)

ruleset i:msgLen do 
  rule "deconcat 22" --pat22
    i<=pat22Set.length & pat22Set.content[i] != 0 & Spy_known[pat22Set.content[i]]   &
    !(Spy_known[msgs[pat22Set.content[i]].concatPart[1]]&Spy_known[msgs[pat22Set.content[i]].concatPart[2]]&Spy_known[msgs[pat22Set.content[i]].concatPart[3]])
    ==>
    var msgPat1,msgPat2,msgPat3:indexType;
        flagPat1,flagPat2,flagPat3:boolean;
    begin
      put "rule deconcat22\n";
      if (!Spy_known[msgs[pat22Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat22Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat22Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat22Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat22Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat22Set.content[i]].concatPart[2];
        isPat12(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat12Set,msgPat2)) then
             pat12Set.length:=pat12Set.length+1;
             pat12Set.content[pat12Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat22Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat22Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat22Set.content[i]].concatPart[3];
        isPat1(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat1Set,msgPat3)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat3;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do
  ruleset i3: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 22"	---pat22
      roleB[i].st = B3 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat12Set.length & Spy_known[pat12Set.content[i2]] &
      i3<=pat1Set.length & Spy_known[pat1Set.content[i3]] &
      matchPat(construct22By1121(pat1Set.content[i1],pat12Set.content[i2],pat1Set.content[i3]), sPat22Set)&
      !Spy_known[constructIndex22By1121(pat1Set.content[i1],pat12Set.content[i2],pat1Set.content[i3])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat22\n";
        concatMsgNo := constructIndex22By1121(pat1Set.content[i1],pat12Set.content[i2],pat1Set.content[i3]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct22By1121(pat1Set.content[i1],pat12Set.content[i2],pat1Set.content[i3]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat22Set,concatMsgNo)) then
          pat22Set.length:=pat22Set.length+1;
          pat22Set.content[pat22Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;
endruleset;

startstate
  roleA[1].A := UE;
  roleA[1].B := SN;
  roleA[1].C := HN;
  roleA[1].supi := supi;
  roleA[1].s := s;
      roleA[1].sqnue := sqnue;
  roleA[1].fail := fail;
  roleA[1].st := A1;
  roleA[1].commit := false;
  roleA[1].sqnhn := anyNonce;
  roleA[1].R := anyNonce;
  roleA[1].kseaf := anyNonce;
  roleA[1].m2.msgType := tmp;
  roleA[1].m2.tmpPart := 0;
  roleA[1].m1.msgType := tmp;
  roleA[1].m1.tmpPart := 0;
  roleA[1].m3.msgType := tmp;
  roleA[1].m3.tmpPart := 0;

  roleB[1].A := UE;
  roleB[1].B := SN;
  roleB[1].C := HN;
  roleB[1].st := B1;
  roleB[1].commit := false;
  roleB[1].supi := anyNonce;
  roleB[1].s := anyNonce;
  roleB[1].sqnue := anyNonce;
  roleB[1].fail := anyNonce;
  roleB[1].sqnhn := anyNonce;
  roleB[1].R := anyNonce;
  roleB[1].kseaf := anyNonce;
  roleB[1].m2.msgType := tmp;
  roleB[1].m2.tmpPart := 0;
  roleB[1].m1.msgType := tmp;
  roleB[1].m1.tmpPart := 0;
  roleB[1].m3.msgType := tmp;
  roleB[1].m3.tmpPart := 0;

  roleC[1].A := UE;
  roleC[1].B := SN;
  roleC[1].C := HN;
      roleC[1].sqnhn := sqnhn;
  roleC[1].R := R;
  roleC[1].kseaf := kseaf;
  roleC[1].st := C1;
  roleC[1].commit := false;
  roleC[1].supi := anyNonce;
  roleC[1].s := anyNonce;
  roleC[1].sqnue := anyNonce;
  roleC[1].fail := anyNonce;
  roleC[1].m2.msgType := tmp;
  roleC[1].m2.tmpPart := 0;
  roleC[1].m1.msgType := tmp;
  roleC[1].m1.tmpPart := 0;
  roleC[1].m3.msgType := tmp;
  roleC[1].m3.tmpPart := 0;


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
    pat18Set.content[i] := 0;
    sPat18Set.content[i] := 0;
    pat19Set.content[i] := 0;
    sPat19Set.content[i] := 0;
    pat20Set.content[i] := 0;
    sPat20Set.content[i] := 0;
    pat21Set.content[i] := 0;
    sPat21Set.content[i] := 0;
    pat22Set.content[i] := 0;
    sPat22Set.content[i] := 0;
    pat23Set.content[i] := 0;
    sPat23Set.content[i] := 0;
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
    pat18Set.length := 0;
    sPat18Set.length := 0;
    pat19Set.length := 0;
    sPat19Set.length := 0;
    pat20Set.length := 0;
    sPat20Set.length := 0;
    pat21Set.length := 0;
    sPat21Set.length := 0;
    pat22Set.length := 0;
    sPat22Set.length := 0;
    pat23Set.length := 0;
    sPat23Set.length := 0;
    IntruEmit1 := false;
    IntruEmit2 := false;
    IntruEmit3 := false;
    IntruEmit4 := false;
    IntruEmit5 := false;
    IntruEmit6 := false;
    IntruEmit7 := false;
    IntruEmit8 := false;
    IntruEmit9 := false;
    IntruEmit10 := false;
  endfor;
  for i:indexType do 
    Spy_known[i] := false;
  endfor;
  for i:indexType do
    A_known[i] := false;
  endfor;
  for i:indexType do
    B_known[i] := false;
  endfor;
  for i:indexType do
    C_known[i] := false;
  endfor;

  for i:indexType do 
    Spy_known[i] := false;
  endfor;
  msg_end:=msg_end+1;
  msgs[msg_end].msgType := key;
  msgs[msg_end].k.ag:=Intruder;
  msgs[msg_end].k.encType:=SK;
  msgs[msg_end].length := 1;
  pat23Set.length := pat23Set.length + 1; 
  pat23Set.content[pat23Set.length] :=msg_end;
  Spy_known[msg_end] := true;
    for i : roleANums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleA[i].A;
    msgs[msg_end].k.encType:=PK;
    msgs[msg_end].length := 1;
    pat3Set.length := pat3Set.length + 1;
    pat3Set.content[pat3Set.length] :=msg_end;
    Spy_known[msg_end] := true;
    A_known[msg_end] := true;
  endfor;
  for i : roleANums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleA[i].A;
    msgs[msg_end].k.encType:=SK;
    msgs[msg_end].length := 1;
    pat23Set.length := pat23Set.length + 1;
    pat23Set.content[pat23Set.length] :=msg_end;
    A_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleB[i].B;
    msgs[msg_end].k.encType:=PK;
    msgs[msg_end].length := 1;
    pat3Set.length := pat3Set.length + 1;
    pat3Set.content[pat3Set.length] :=msg_end;
    Spy_known[msg_end] := true;
    B_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleB[i].B;
    msgs[msg_end].k.encType:=SK;
    msgs[msg_end].length := 1;
    pat23Set.length := pat23Set.length + 1;
    pat23Set.content[pat23Set.length] :=msg_end;
    B_known[msg_end] := true;
  endfor;
  for i : roleCNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleC[i].C;
    msgs[msg_end].k.encType:=PK;
    msgs[msg_end].length := 1;
    pat3Set.length := pat3Set.length + 1;
    pat3Set.content[pat3Set.length] :=msg_end;
    Spy_known[msg_end] := true;
    C_known[msg_end] := true;
  endfor;
  for i : roleCNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleC[i].C;
    msgs[msg_end].k.encType:=SK;
    msgs[msg_end].length := 1;
    pat23Set.length := pat23Set.length + 1;
    pat23Set.content[pat23Set.length] :=msg_end;
    C_known[msg_end] := true;
  endfor;
  for i : roleANums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag1 := roleA[i].A;
    msgs[msg_end].k.ag2 := roleA[i].B;
    msgs[msg_end].k.encType:=Symk;
    msgs[msg_end].length := 1;
    pat9Set.length := pat9Set.length + 1;
    pat9Set.content[pat9Set.length] :=msg_end;
    Spy_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag1 := roleA[i].A;
    msgs[msg_end].k.ag2 := roleA[i].C;
    msgs[msg_end].k.encType:=Symk;
    msgs[msg_end].length := 1;
    pat9Set.length := pat9Set.length + 1;
    pat9Set.content[pat9Set.length] :=msg_end;
    Spy_known[msg_end] := true;
  endfor;
  for i : roleCNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag1 := roleB[i].B;
    msgs[msg_end].k.ag2 := roleB[i].C;
    msgs[msg_end].k.encType:=Symk;
    msgs[msg_end].length := 1;
    pat9Set.length := pat9Set.length + 1;
    pat9Set.content[pat9Set.length] :=msg_end;
    Spy_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    constructSpat6(roleB[i].supi,roleB[i].s,roleB[i].C,roleB[i].C, gnum);
  endfor;
  for i : roleBNums do
    constructSpat10(roleB[i].R,roleB[i].B,roleB[i].A,roleB[i].C, gnum);
  endfor;
  for i : roleBNums do
    constructSpat14(roleB[i].fail,roleB[i].R,roleB[i].A,roleB[i].C,roleB[i].sqnue, gnum);
  endfor;
  for i : roleBNums do
    constructSpat1(roleB[i].fail, gnum);
  endfor;
  for i : roleCNums do
    constructSpat16(roleC[i].m1,roleC[i].B, gnum);
  endfor;
  for i : roleANums do
    constructSpat18(roleA[i].R,roleA[i].m2, gnum);
  endfor;
  for i : roleCNums do
    constructSpat20(roleC[i].m3,roleC[i].m1, gnum);
  endfor;
  for i : roleCNums do
    constructSpat21(roleC[i].m3,roleC[i].R,roleC[i].m1, gnum);
  endfor;
  for i : roleBNums do
    constructSpat22(roleB[i].R,roleB[i].sqnhn,roleB[i].A,roleB[i].C,roleB[i].kseaf, gnum);
  endfor;
  for i : roleBNums do
    constructSpat1(roleB[i].supi, gnum);
  endfor;

end;

invariant "secrecy" 
forall i:indexType do
    (msgs[i].msgType=nonce & msgs[i].noncePart=supi)
     ->
     Spy_known[i] = false
end;
