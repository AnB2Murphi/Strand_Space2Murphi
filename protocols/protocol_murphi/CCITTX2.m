const
  roleANum:1;
  roleBNum:1;
  totalFact:100;
  msgLength:10;
  chanNum:18;
  invokeNum:10;
type
  indexType:0..totalFact;
  roleANums:1..roleANum;
  roleBNums:1..roleBNum;
  msgLen:0..msgLength;
  chanNums:0..chanNum;
  invokeNums:0..invokeNum;

  AgentType : enum{anyAgent,Alice, Intruder, Bob}; ---Intruder 
  NonceType : enum{anyNonce, Na, Ta, Xa, Ya, Nb, Tb, Xb, Yb};
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

  AStatus: enum{A1,A2,A3};
  BStatus: enum{B1,B2,B3};

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
   Ta : NonceType;
   Xa : NonceType;
   Ya : NonceType;
   Nb : NonceType;
   Tb : NonceType;
   Xb : NonceType;
   Yb : NonceType;
   A : AgentType;
   B : AgentType;


   locNa : NonceType;
   locTa : NonceType;
   locXa : NonceType;
   locYa : NonceType;
   locNb : NonceType;
   locTb : NonceType;
   locXb : NonceType;
   locYb : NonceType;
   locA : AgentType;
   locB : AgentType;
   
   
   st: AStatus;
   commit : boolean;
  end;
  RoleB : record
   Na : NonceType;
   Ta : NonceType;
   Xa : NonceType;
   Ya : NonceType;
   Nb : NonceType;
   Tb : NonceType;
   Xb : NonceType;
   Yb : NonceType;
   A : AgentType;
   B : AgentType;


   locNa : NonceType;
   locTa : NonceType;
   locXa : NonceType;
   locYa : NonceType;
   locNb : NonceType;
   locTb : NonceType;
   locXb : NonceType;
   locYb : NonceType;
   locA : AgentType;
   locB : AgentType;
   
   
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

  A_known : Array[indexType] of boolean;
  B_known : Array[indexType] of boolean;
  Spy_known: Array[indexType] of boolean;
  IntruEmit1 : boolean;
  IntruEmit2 : boolean;
  IntruEmit3 : boolean;
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

function construct5By24(msgNo1,msgNo2:indexType):Message;
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

function constructIndex5By24(msgNo1,msgNo2:indexType):indexType;
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

function construct7By56(msgNo51, msgNo62:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo51 & msgs[i].aencKey = msgNo62) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo51;
     msg.aencKey := msgNo62;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex7By56(msgNo51, msgNo62:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo51 & msgs[i].aencKey = msgNo62) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct8By22127(msgNo1,msgNo2,msgNo3,msgNo4,msgNo5:indexType):Message;
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

function constructIndex8By22127(msgNo1,msgNo2,msgNo3,msgNo4,msgNo5:indexType):indexType;
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

function construct9By83(msgNo81, msgNo32:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo81 & msgs[i].aencKey = msgNo32) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo81;
     msg.aencKey := msgNo32;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex9By83(msgNo81, msgNo32:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo81 & msgs[i].aencKey = msgNo32) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct10By19(msgNo1,msgNo2:indexType):Message;
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

function constructIndex10By19(msgNo1,msgNo2:indexType):indexType;
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

function construct11By26(msgNo21, msgNo62:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo21 & msgs[i].aencKey = msgNo62) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo21;
     msg.aencKey := msgNo62;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex11By26(msgNo21, msgNo62:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo21 & msgs[i].aencKey = msgNo62) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct12By2212211(msgNo1,msgNo2,msgNo3,msgNo4,msgNo5,msgNo6:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 6) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3 & msgs[i].concatPart[4] = msgNo4 & msgs[i].concatPart[5] = msgNo5 & msgs[i].concatPart[6] = msgNo6) then
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
     msg.concatPart[6] := msgNo6;
     msg.length := 6;
   endif;
   return msg;
  end;

function constructIndex12By2212211(msgNo1,msgNo2,msgNo3,msgNo4,msgNo5,msgNo6:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length = 6) then
       if (msgs[i].concatPart[1] = msgNo1 & msgs[i].concatPart[2] = msgNo2 & msgs[i].concatPart[3] = msgNo3 & msgs[i].concatPart[4] = msgNo4 & msgs[i].concatPart[5] = msgNo5 & msgs[i].concatPart[6] = msgNo6) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index:=msg_end+1;
   endif;
   return index;
  end;

function construct13By123(msgNo121, msgNo32:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo121 & msgs[i].aencKey = msgNo32) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo121;
     msg.aencKey := msgNo32;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex13By123(msgNo121, msgNo32:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo121 & msgs[i].aencKey = msgNo32) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
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

function construct15By14(msgNo1,msgNo2:indexType):Message;
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

function constructIndex15By14(msgNo1,msgNo2:indexType):indexType;
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

function construct16By2(msgNo21:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = hash) then
       if (msgs[i].hashMsg = msgNo21) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := hash;
     msg.hashMsg := msgNo21;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex16By2(msgNo21:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = hash) then
       if (msgs[i].hashMsg = msgNo21) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct17By163(msgNo161, msgNo32:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo161 & msgs[i].aencKey = msgNo32) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo161;
     msg.aencKey := msgNo32;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex17By163(msgNo161, msgNo32:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo161 & msgs[i].aencKey = msgNo32) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct18By217(msgNo1,msgNo2:indexType):Message;
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

function constructIndex18By217(msgNo1,msgNo2:indexType):indexType;
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

function construct19By186(msgNo181, msgNo62:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo181 & msgs[i].aencKey = msgNo62) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo181;
     msg.aencKey := msgNo62;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex19By186(msgNo181, msgNo62:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo181 & msgs[i].aencKey = msgNo62) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct20By221219(msgNo1,msgNo2,msgNo3,msgNo4,msgNo5:indexType):Message;
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

function constructIndex20By221219(msgNo1,msgNo2,msgNo3,msgNo4,msgNo5:indexType):indexType;
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

function construct21By203(msgNo201, msgNo32:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo201 & msgs[i].aencKey = msgNo32) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo201;
     msg.aencKey := msgNo32;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex21By203(msgNo201, msgNo32:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo201 & msgs[i].aencKey = msgNo32) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct22By121(msgNo1,msgNo2:indexType):Message;
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

function constructIndex22By121(msgNo1,msgNo2:indexType):indexType;
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

---pat1: A 
procedure lookAddPat1(A:AgentType; Var msg:Message; Var num : indexType);
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

---pat1: A 
procedure isPat1(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = agent) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat1: A 
procedure constructSpat1(A:AgentType; Var num: indexType);
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
    sPat1Set.length := sPat1Set.length + 1;
    sPat1Set.content[sPat1Set.length] := index;
    num := index;
  end;

---pat2: Ta 
procedure lookAddPat2(Ta:NonceType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
      index:=0;
      for i: indexType do
        if(msgs[i].msgType=nonce) then
          if(msgs[i].noncePart=Ta) then
            index:=i;
          endif;
        endif;
      endfor;
      if(index=0) then
        msg_end := msg_end + 1 ;
        index := msg_end;
        msgs[index].msgType := nonce;
        msgs[index].noncePart:=Ta; 
        msgs[index].length := 1;
      endif;
      num:=index;
      msg:=msgs[index];
  end;

---pat2: Ta 
procedure isPat2(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = nonce) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat2: Ta 
procedure constructSpat2(Ta:NonceType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = nonce) then
        if (msgs[i].noncePart = Ta) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := nonce;
      msgs[index].noncePart := Ta;
      msgs[index].length := 1;
    endif;
    sPat2Set.length := sPat2Set.length + 1;
    sPat2Set.content[sPat2Set.length] := index;
    num := index;
  end;

---pat3: sk(A) 
procedure lookAddPat3(ASk:AgentType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    index:=0;
    for i: indexType do
      if (msgs[i].msgType = key) then
        if (msgs[i].k.encType = SK & msgs[i].k.ag = ASk) then
          index:=i;
        endif;
      endif;
    endfor;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := key;
      msgs[index].k.encType:=SK; 
      msgs[index].k.ag:=ASk;
    endif;
    num:=index;
    msg:=msgs[index];
  end;

---pat3: sk(A) 
procedure isPat3(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
      flag1 := false;
      if (msg.msgType = key & msg.k.encType = SK) then
        flag1 := true;
      endif;
      flag := flag1;
  end;

---spat3: sk(A) 
procedure constructSpat3(ASk:AgentType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = key & msgs[i].k.encType = SK) then
        if (msgs[i].k.ag = ASk) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := key;
      msgs[index].k.encType := SK;
      msgs[index].k.ag := ASk;
      msgs[index].length := 1;
    endif;
    sPat3Set.length := sPat3Set.length + 1;
    sPat3Set.content[sPat3Set.length] := index;
    num := index;
  end;

---pat4: aenc{Ya}sk(A) 
procedure lookAddPat4(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(Ya,msg1,i1);
   lookAddPat3(ASk,msg2,i2);
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

---pat4: aenc{Ya}sk(A) 
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

---spat4: aenc{Ya}sk(A) 
procedure constructSpat4(Ya:NonceType; ASk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat2(Ya, i1);
    constructSpat3(ASk, i2);
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

---pat5: Ya.aenc{Ya}sk(A) 
procedure lookAddPat5(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(Ya, msg1, i1);
   lookAddPat4(Ya, ASk, msg2, i2);
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

---pat5: Ya.aenc{Ya}sk(A) 
procedure isPat5(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat2(msgs[msg.concatPart[1]],flagPart1);
        isPat4(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat5: Ya.aenc{Ya}sk(A) 
procedure constructSpat5(Ya:NonceType; ASk:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat2(Ya, i1);
    constructSpat4(Ya, ASk, i2);
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
    sPat5Set.length := sPat5Set.length + 1;
    sPat5Set.content[sPat5Set.length] := index;
    num := index;
  end;

---pat6: pk(B) 
procedure lookAddPat6(BPk:AgentType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    index:=0;
    for i: indexType do
      if (msgs[i].msgType = key) then
        if (msgs[i].k.encType = PK & msgs[i].k.ag = BPk) then
          index:=i;
        endif;
      endif;
    endfor;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := key;
      msgs[index].k.encType:=PK; 
      msgs[index].k.ag:=BPk;
      msgs[index].length := 1;
    endif;
    num:=index;
    msg:=msgs[index];
  end;

---pat6: pk(B) 
procedure isPat6(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = key & msg.k.encType = PK) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat6: pk(B) 
procedure constructSpat6(BPk:AgentType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = key & msgs[i].k.encType = PK) then
        if (msgs[i].k.ag = BPk) then
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
      msgs[index].k.ag := BPk;
      msgs[index].length := 1;
    endif;
    sPat6Set.length := sPat6Set.length + 1;
    sPat6Set.content[sPat6Set.length] := index;
    num := index;
  end;

---pat7: aenc{Ya.aenc{Ya}sk(A)}pk(B) 
procedure lookAddPat7(Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat5(Ya, ASk,msg1,i1);
   lookAddPat6(BPk,msg2,i2);
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

---pat7: aenc{Ya.aenc{Ya}sk(A)}pk(B) 
procedure isPat7(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat5(msgs[msg.aencMsg],flagPart1);
      isPat6(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat7: aenc{Ya.aenc{Ya}sk(A)}pk(B) 
procedure constructSpat7(Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat5(Ya, ASk, i1);
    constructSpat6(BPk, i2);
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
    sPat7Set.length := sPat7Set.length + 1;
    sPat7Set.content[sPat7Set.length] := index;
    num := index;
  end;

---pat8: Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B) 
procedure lookAddPat8(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3,msg4,msg5: Message;
     index,i1,i2,i3,i4,i5:indexType;
  begin
   index:=0;
   lookAddPat2(Ta, msg1, i1);
   lookAddPat2(Na, msg2, i2);
   lookAddPat1(B, msg3, i3);
   lookAddPat2(Xa, msg4, i4);
   lookAddPat7(Ya, ASk, BPk, msg5, i5);
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

---pat8: Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B) 
procedure isPat8(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3,flagPart4,flagPart5: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     flagPart4 := false;
     flagPart5 := false;
     if(msg.msgType = concat) then
        isPat2(msgs[msg.concatPart[1]],flagPart1);
        isPat2(msgs[msg.concatPart[2]],flagPart2);
        isPat1(msgs[msg.concatPart[3]],flagPart3);
        isPat2(msgs[msg.concatPart[4]],flagPart4);
        isPat7(msgs[msg.concatPart[5]],flagPart5);
       if (flagPart1 & flagPart2 & flagPart3 & flagPart4 & flagPart5) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat8: Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B) 
procedure constructSpat8(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index, i1, i2, i3, i4, i5:indexType;
  begin
    index:=0;
    constructSpat2(Ta, i1);
    constructSpat2(Na, i2);
    constructSpat1(B, i3);
    constructSpat2(Xa, i4);
    constructSpat7(Ya, ASk, BPk, i5);
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
    sPat8Set.length := sPat8Set.length + 1;
    sPat8Set.content[sPat8Set.length] := index;
    num := index;
  end;

---pat9: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B)}sk(A) 
procedure lookAddPat9(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat8(Ta, Na, B, Xa, Ya, ASk, BPk,msg1,i1);
   lookAddPat3(ASk,msg2,i2);
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

---pat9: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B)}sk(A) 
procedure isPat9(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat8(msgs[msg.aencMsg],flagPart1);
      isPat3(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat9: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B)}sk(A) 
procedure constructSpat9(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat8(Ta, Na, B, Xa, Ya, ASk, BPk, i1);
    constructSpat3(ASk, i2);
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
    sPat9Set.length := sPat9Set.length + 1;
    sPat9Set.content[sPat9Set.length] := index;
    num := index;
  end;

---pat10: A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B)}sk(A) 
procedure lookAddPat10(A:AgentType; Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(A, msg1, i1);
   lookAddPat9(Ta, Na, B, Xa, Ya, ASk, BPk, msg2, i2);
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

---pat10: A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B)}sk(A) 
procedure isPat10(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat9(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat10: A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B)}sk(A) 
procedure constructSpat10(A:AgentType; Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(A, i1);
    constructSpat9(Ta, Na, B, Xa, Ya, ASk, BPk, i2);
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
    sPat10Set.length := sPat10Set.length + 1;
    sPat10Set.content[sPat10Set.length] := index;
    num := index;
  end;

---pat11: aenc{Yb}pk(A) 
procedure lookAddPat11(Yb:NonceType; APk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(Yb,msg1,i1);
   lookAddPat6(APk,msg2,i2);
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

---pat11: aenc{Yb}pk(A) 
procedure isPat11(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat2(msgs[msg.aencMsg],flagPart1);
      isPat6(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat11: aenc{Yb}pk(A) 
procedure constructSpat11(Yb:NonceType; APk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat2(Yb, i1);
    constructSpat6(APk, i2);
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

---pat12: Tb.Nb.A.Na.Xb.aenc{Yb}pk(A) 
procedure lookAddPat12(Tb:NonceType; Nb:NonceType; A:AgentType; Na:NonceType; Xb:NonceType; Yb:NonceType; APk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3,msg4,msg5,msg6: Message;
     index,i1,i2,i3,i4,i5,i6:indexType;
  begin
   index:=0;
   lookAddPat2(Tb, msg1, i1);
   lookAddPat2(Nb, msg2, i2);
   lookAddPat1(A, msg3, i3);
   lookAddPat2(Na, msg4, i4);
   lookAddPat2(Xb, msg5, i5);
   lookAddPat11(Yb, APk, msg6, i6);
   for i : indexType do
     if (msgs[i].msgType = concat & msgs[i].length=6) then
       if (msgs[i].concatPart[1]=i1 & msgs[i].concatPart[2]=i2 & msgs[i].concatPart[3]=i3 & msgs[i].concatPart[4]=i4 & msgs[i].concatPart[5]=i5 & msgs[i].concatPart[6]=i6) then
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
     msgs[index].concatPart[6]:=i6; 
     msgs[index].length := 6;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat12: Tb.Nb.A.Na.Xb.aenc{Yb}pk(A) 
procedure isPat12(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3,flagPart4,flagPart5,flagPart6: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     flagPart4 := false;
     flagPart5 := false;
     flagPart6 := false;
     if(msg.msgType = concat) then
        isPat2(msgs[msg.concatPart[1]],flagPart1);
        isPat2(msgs[msg.concatPart[2]],flagPart2);
        isPat1(msgs[msg.concatPart[3]],flagPart3);
        isPat2(msgs[msg.concatPart[4]],flagPart4);
        isPat2(msgs[msg.concatPart[5]],flagPart5);
        isPat11(msgs[msg.concatPart[6]],flagPart6);
       if (flagPart1 & flagPart2 & flagPart3 & flagPart4 & flagPart5 & flagPart6) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat12: Tb.Nb.A.Na.Xb.aenc{Yb}pk(A) 
procedure constructSpat12(Tb:NonceType; Nb:NonceType; A:AgentType; Na:NonceType; Xb:NonceType; Yb:NonceType; APk:AgentType; Var num: indexType);
  Var i,index, i1, i2, i3, i4, i5, i6:indexType;
  begin
    index:=0;
    constructSpat2(Tb, i1);
    constructSpat2(Nb, i2);
    constructSpat1(A, i3);
    constructSpat2(Na, i4);
    constructSpat2(Xb, i5);
    constructSpat11(Yb, APk, i6);
    i := 1;
    while(i<= msg_end) do
      if (msgs[i].msgType = concat & msgs[i].length = 6) then
        if (msgs[i].concatPart[1] = i1 & msgs[i].concatPart[2] = i2 & msgs[i].concatPart[3] = i3 & msgs[i].concatPart[4] = i4 & msgs[i].concatPart[5] = i5 & msgs[i].concatPart[6] = i6) then
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
      msgs[index].concatPart[6] := i6;
      msgs[index].length := 6;
    endif;
    sPat12Set.length := sPat12Set.length + 1;
    sPat12Set.content[sPat12Set.length] := index;
    num := index;
  end;

---pat13: aenc{Tb.Nb.A.Na.Xb.aenc{Yb}pk(A)}sk(B) 
procedure lookAddPat13(Tb:NonceType; Nb:NonceType; A:AgentType; Na:NonceType; Xb:NonceType; Yb:NonceType; APk:AgentType; BSk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat12(Tb, Nb, A, Na, Xb, Yb, APk,msg1,i1);
   lookAddPat3(BSk,msg2,i2);
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

---pat13: aenc{Tb.Nb.A.Na.Xb.aenc{Yb}pk(A)}sk(B) 
procedure isPat13(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat12(msgs[msg.aencMsg],flagPart1);
      isPat3(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat13: aenc{Tb.Nb.A.Na.Xb.aenc{Yb}pk(A)}sk(B) 
procedure constructSpat13(Tb:NonceType; Nb:NonceType; A:AgentType; Na:NonceType; Xb:NonceType; Yb:NonceType; APk:AgentType; BSk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat12(Tb, Nb, A, Na, Xb, Yb, APk, i1);
    constructSpat3(BSk, i2);
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
    sPat13Set.length := sPat13Set.length + 1;
    sPat13Set.content[sPat13Set.length] := index;
    num := index;
  end;

---pat14: B.aenc{Tb.Nb.A.Na.Xb.aenc{Yb}pk(A)}sk(B) 
procedure lookAddPat14(B:AgentType; Tb:NonceType; Nb:NonceType; A:AgentType; Na:NonceType; Xb:NonceType; Yb:NonceType; APk:AgentType; BSk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(B, msg1, i1);
   lookAddPat13(Tb, Nb, A, Na, Xb, Yb, APk, BSk, msg2, i2);
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

---pat14: B.aenc{Tb.Nb.A.Na.Xb.aenc{Yb}pk(A)}sk(B) 
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
---spat14: B.aenc{Tb.Nb.A.Na.Xb.aenc{Yb}pk(A)}sk(B) 
procedure constructSpat14(B:AgentType; Tb:NonceType; Nb:NonceType; A:AgentType; Na:NonceType; Xb:NonceType; Yb:NonceType; APk:AgentType; BSk:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(B, i1);
    constructSpat13(Tb, Nb, A, Na, Xb, Yb, APk, BSk, i2);
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

---pat15: A.aenc{Nb}sk(A) 
procedure lookAddPat15(A:AgentType; Nb:NonceType; ASk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(A, msg1, i1);
   lookAddPat4(Nb, ASk, msg2, i2);
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

---pat15: A.aenc{Nb}sk(A) 
procedure isPat15(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat4(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat15: A.aenc{Nb}sk(A) 
procedure constructSpat15(A:AgentType; Nb:NonceType; ASk:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(A, i1);
    constructSpat4(Nb, ASk, i2);
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
    sPat15Set.length := sPat15Set.length + 1;
    sPat15Set.content[sPat15Set.length] := index;
    num := index;
  end;

---pat16: hash(Ya) 
procedure lookAddPat16(Ya:NonceType; Var msg:Message; Var num : indexType);
  Var msg1: Message;
      index,i1:indexType;
  begin
   index:=0;
   lookAddPat2(Ya,msg1,i1);
   for i : indexType do
     if (msgs[i].msgType = hash) then
       if (msgs[i].hashMsg = i1) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := hash;
     msgs[index].hashMsg := i1; 
     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat16: hash(Ya) 
procedure isPat16(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    if (msg.msgType = hash) then
      isPat2(msgs[msg.hashMsg],flagPart1);
      if (flagPart1) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat16: hash(Ya) 
procedure constructSpat16(Ya:NonceType; Var num: indexType);
  Var i,index,i1:indexType;
  begin
    index:=0;
    constructSpat2(Ya, i1);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = hash) then
        if (msgs[i].hashMsg = i1) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := hash;
      msgs[index].hashMsg := i1; 
      msgs[index].length := 1;
    endif;
    sPat16Set.length := sPat16Set.length + 1;
    sPat16Set.content[sPat16Set.length] := index;
    num := index;
  end;

---pat17: aenc{hash(Ya)}sk(A) 
procedure lookAddPat17(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat16(Ya,msg1,i1);
   lookAddPat3(ASk,msg2,i2);
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

---pat17: aenc{hash(Ya)}sk(A) 
procedure isPat17(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat16(msgs[msg.aencMsg],flagPart1);
      isPat3(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat17: aenc{hash(Ya)}sk(A) 
procedure constructSpat17(Ya:NonceType; ASk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat16(Ya, i1);
    constructSpat3(ASk, i2);
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
    sPat17Set.length := sPat17Set.length + 1;
    sPat17Set.content[sPat17Set.length] := index;
    num := index;
  end;

---pat18: Ya.aenc{hash(Ya)}sk(A) 
procedure lookAddPat18(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(Ya, msg1, i1);
   lookAddPat17(Ya, ASk, msg2, i2);
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

---pat18: Ya.aenc{hash(Ya)}sk(A) 
procedure isPat18(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat2(msgs[msg.concatPart[1]],flagPart1);
        isPat17(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat18: Ya.aenc{hash(Ya)}sk(A) 
procedure constructSpat18(Ya:NonceType; ASk:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat2(Ya, i1);
    constructSpat17(Ya, ASk, i2);
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

---pat19: aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure lookAddPat19(Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat18(Ya, ASk,msg1,i1);
   lookAddPat6(BPk,msg2,i2);
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

---pat19: aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure isPat19(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat18(msgs[msg.aencMsg],flagPart1);
      isPat6(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat19: aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure constructSpat19(Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat18(Ya, ASk, i1);
    constructSpat6(BPk, i2);
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
    sPat19Set.length := sPat19Set.length + 1;
    sPat19Set.content[sPat19Set.length] := index;
    num := index;
  end;

---pat20: Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure lookAddPat20(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3,msg4,msg5: Message;
     index,i1,i2,i3,i4,i5:indexType;
  begin
   index:=0;
   lookAddPat2(Ta, msg1, i1);
   lookAddPat2(Na, msg2, i2);
   lookAddPat1(B, msg3, i3);
   lookAddPat2(Xa, msg4, i4);
   lookAddPat19(Ya, ASk, BPk, msg5, i5);
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

---pat20: Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure isPat20(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3,flagPart4,flagPart5: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     flagPart4 := false;
     flagPart5 := false;
     if(msg.msgType = concat) then
        isPat2(msgs[msg.concatPart[1]],flagPart1);
        isPat2(msgs[msg.concatPart[2]],flagPart2);
        isPat1(msgs[msg.concatPart[3]],flagPart3);
        isPat2(msgs[msg.concatPart[4]],flagPart4);
        isPat19(msgs[msg.concatPart[5]],flagPart5);
       if (flagPart1 & flagPart2 & flagPart3 & flagPart4 & flagPart5) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat20: Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure constructSpat20(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index, i1, i2, i3, i4, i5:indexType;
  begin
    index:=0;
    constructSpat2(Ta, i1);
    constructSpat2(Na, i2);
    constructSpat1(B, i3);
    constructSpat2(Xa, i4);
    constructSpat19(Ya, ASk, BPk, i5);
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
    sPat20Set.length := sPat20Set.length + 1;
    sPat20Set.content[sPat20Set.length] := index;
    num := index;
  end;

---pat21: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure lookAddPat21(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat20(Ta, Na, B, Xa, Ya, ASk, BPk,msg1,i1);
   lookAddPat3(ASk,msg2,i2);
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

---pat21: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure isPat21(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat20(msgs[msg.aencMsg],flagPart1);
      isPat3(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat21: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure constructSpat21(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat20(Ta, Na, B, Xa, Ya, ASk, BPk, i1);
    constructSpat3(ASk, i2);
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
    sPat21Set.length := sPat21Set.length + 1;
    sPat21Set.content[sPat21Set.length] := index;
    num := index;
  end;

---pat22: A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure lookAddPat22(A:AgentType; Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(A, msg1, i1);
   lookAddPat21(Ta, Na, B, Xa, Ya, ASk, BPk, msg2, i2);
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

---pat22: A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure isPat22(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat21(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat22: A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure constructSpat22(A:AgentType; Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(A, i1);
    constructSpat21(Ta, Na, B, Xa, Ya, ASk, BPk, i2);
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
    sPat22Set.length := sPat22Set.length + 1;
    sPat22Set.content[sPat22Set.length] := index;
    num := index;
  end;

procedure cons1(A:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat1(A,msg,num);
  end;
procedure destruct1(msg:Message; Var A:AgentType);
  begin
    A:=msg.ag;
  end;
procedure cons2(Ta:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat2(Ta,msg,num);
  end;
procedure destruct2(msg:Message; Var Ta:NonceType);
  begin
    Ta:=msg.noncePart;
  end;
procedure cons3(ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat3(ASk,msg,num);
  end;
procedure cons4(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat4(Ya, ASk,msg,num);
  end;
procedure destruct4(msg:Message; Var Ya:NonceType; Var ASk:AgentType);
  var k1:KeyType;
  var msgKey:Message;
      msg1:Message;
   begin
    clear msg1;
    msgKey := msgs[msg.aencKey];
    k1 := msgs[msg.aencKey].k;
    ASk := k1.ag;
    msg1:=msgs[msg.aencMsg];
    Ya:=msg1.noncePart;
   end;
procedure cons5(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat5(Ya, ASk,msg,num);
  end;
procedure destruct5(msg:Message; Var Ya:NonceType; Var ASk:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    Ya := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct4(msgNum2,Ya, ASk)
  end;
procedure cons6(BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat6(BPk,msg,num);
  end;
procedure cons7(Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat7(Ya, ASk, BPk,msg,num);
  end;
procedure destruct7(msg:Message; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    BPk := k1.ag;    aencMsg:=msgs[msg.aencMsg];
    destruct5(aencMsg,Ya, ASk);
  end;
procedure cons8(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat8(Ta, Na, B, Xa, Ya, ASk, BPk,msg,num);
  end;
procedure destruct8(msg:Message; Var Ta:NonceType; Var Na:NonceType; Var B:AgentType; Var Xa:NonceType; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  Var msgNum1,msgNum2,msgNum3,msgNum4,msgNum5: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    Ta := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    Na := msgNum2.noncePart;
    msgNum3 := msgs[msg.concatPart[3]];
    B := msgNum3.ag;
    msgNum4 := msgs[msg.concatPart[4]];
    Xa := msgNum4.noncePart;
    msgNum5 := msgs[msg.concatPart[5]];
    destruct7(msgNum5,Ya, ASk, BPk)
  end;
procedure cons9(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat9(Ta, Na, B, Xa, Ya, ASk, BPk,msg,num);
  end;
procedure destruct9(msg:Message; Var Ta:NonceType; Var Na:NonceType; Var B:AgentType; Var Xa:NonceType; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    ASk := k1.ag;    aencMsg:=msgs[msg.aencMsg];
    destruct8(aencMsg,Ta, Na, B, Xa, Ya, ASk, BPk);
  end;
procedure cons10(A:AgentType; Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat10(A, Ta, Na, B, Xa, Ya, ASk, BPk,msg,num);
  end;
procedure destruct10(msg:Message; Var A:AgentType; Var Ta:NonceType; Var Na:NonceType; Var B:AgentType; Var Xa:NonceType; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    A := msgNum1.ag;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct9(msgNum2,Ta, Na, B, Xa, Ya, ASk, BPk)
  end;
procedure cons11(Yb:NonceType; APk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat11(Yb, APk,msg,num);
  end;
procedure destruct11(msg:Message; Var Yb:NonceType; Var APk:AgentType);
  var k1:KeyType;
  var msgKey:Message;
      msg1:Message;
   begin
    clear msg1;
    msgKey := msgs[msg.aencKey];
    k1 := msgs[msg.aencKey].k;
    APk := k1.ag;
    msg1:=msgs[msg.aencMsg];
    Yb:=msg1.noncePart;
   end;
procedure cons12(Tb:NonceType; Nb:NonceType; A:AgentType; Na:NonceType; Xb:NonceType; Yb:NonceType; APk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat12(Tb, Nb, A, Na, Xb, Yb, APk,msg,num);
  end;
procedure destruct12(msg:Message; Var Tb:NonceType; Var Nb:NonceType; Var A:AgentType; Var Na:NonceType; Var Xb:NonceType; Var Yb:NonceType; Var APk:AgentType);
  Var msgNum1,msgNum2,msgNum3,msgNum4,msgNum5,msgNum6: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    Tb := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    Nb := msgNum2.noncePart;
    msgNum3 := msgs[msg.concatPart[3]];
    A := msgNum3.ag;
    msgNum4 := msgs[msg.concatPart[4]];
    Na := msgNum4.noncePart;
    msgNum5 := msgs[msg.concatPart[5]];
    Xb := msgNum5.noncePart;
    msgNum6 := msgs[msg.concatPart[6]];
    destruct11(msgNum6,Yb, APk)
  end;
procedure cons13(Tb:NonceType; Nb:NonceType; A:AgentType; Na:NonceType; Xb:NonceType; Yb:NonceType; APk:AgentType; BSk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat13(Tb, Nb, A, Na, Xb, Yb, APk, BSk,msg,num);
  end;
procedure destruct13(msg:Message; Var Tb:NonceType; Var Nb:NonceType; Var A:AgentType; Var Na:NonceType; Var Xb:NonceType; Var Yb:NonceType; Var APk:AgentType; Var BSk:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    BSk := k1.ag;    aencMsg:=msgs[msg.aencMsg];
    destruct12(aencMsg,Tb, Nb, A, Na, Xb, Yb, APk);
  end;
procedure cons14(B:AgentType; Tb:NonceType; Nb:NonceType; A:AgentType; Na:NonceType; Xb:NonceType; Yb:NonceType; APk:AgentType; BSk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat14(B, Tb, Nb, A, Na, Xb, Yb, APk, BSk,msg,num);
  end;
procedure destruct14(msg:Message; Var B:AgentType; Var Tb:NonceType; Var Nb:NonceType; Var A:AgentType; Var Na:NonceType; Var Xb:NonceType; Var Yb:NonceType; Var APk:AgentType; Var BSk:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    B := msgNum1.ag;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct13(msgNum2,Tb, Nb, A, Na, Xb, Yb, APk, BSk)
  end;
procedure cons15(A:AgentType; Nb:NonceType; ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat15(A, Nb, ASk,msg,num);
  end;
procedure destruct15(msg:Message; Var A:AgentType; Var Nb:NonceType; Var ASk:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    A := msgNum1.ag;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct4(msgNum2,Nb, ASk)
  end;
procedure cons16(Ya:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat16(Ya,msg,num);
  end;
procedure destruct16(msg:Message; Var Ya:NonceType);
  var msgNo:indexType;
  hashMsg:Message;
  begin
    hashMsg:=msgs[msg.hashMsg];
    destruct2(hashMsg,Ya);
  end;
procedure cons17(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat17(Ya, ASk,msg,num);
  end;
procedure destruct17(msg:Message; Var Ya:NonceType; Var ASk:AgentType);
  var k1:KeyType;
      msg1:Message;
   begin
      clear msg1;
      k1 := msgs[msg.aencKey].k;
      ASk := k1.ag;      msg1:=msgs[msg.aencMsg];
    destruct16(msg1,Ya);
   end;
procedure cons18(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat18(Ya, ASk,msg,num);
  end;
procedure destruct18(msg:Message; Var Ya:NonceType; Var ASk:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    Ya := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct17(msgNum2,Ya, ASk)
  end;
procedure cons19(Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat19(Ya, ASk, BPk,msg,num);
  end;
procedure destruct19(msg:Message; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    BPk := k1.ag;    aencMsg:=msgs[msg.aencMsg];
    destruct18(aencMsg,Ya, ASk);
  end;
procedure cons20(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat20(Ta, Na, B, Xa, Ya, ASk, BPk,msg,num);
  end;
procedure destruct20(msg:Message; Var Ta:NonceType; Var Na:NonceType; Var B:AgentType; Var Xa:NonceType; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  Var msgNum1,msgNum2,msgNum3,msgNum4,msgNum5: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    Ta := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    Na := msgNum2.noncePart;
    msgNum3 := msgs[msg.concatPart[3]];
    B := msgNum3.ag;
    msgNum4 := msgs[msg.concatPart[4]];
    Xa := msgNum4.noncePart;
    msgNum5 := msgs[msg.concatPart[5]];
    destruct19(msgNum5,Ya, ASk, BPk)
  end;
procedure cons21(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat21(Ta, Na, B, Xa, Ya, ASk, BPk,msg,num);
  end;
procedure destruct21(msg:Message; Var Ta:NonceType; Var Na:NonceType; Var B:AgentType; Var Xa:NonceType; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    ASk := k1.ag;    aencMsg:=msgs[msg.aencMsg];
    destruct20(aencMsg,Ta, Na, B, Xa, Ya, ASk, BPk);
  end;
procedure cons22(A:AgentType; Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat22(A, Ta, Na, B, Xa, Ya, ASk, BPk,msg,num);
  end;
procedure destruct22(msg:Message; Var A:AgentType; Var Ta:NonceType; Var Na:NonceType; Var B:AgentType; Var Xa:NonceType; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    A := msgNum1.ag;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct21(msgNum2,Ta, Na, B, Xa, Ya, ASk, BPk)
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
   cons10(roleA[i].A,roleA[i].Ta,roleA[i].Na,roleA[i].B,roleA[i].Xa,roleA[i].Ya,roleA[i].A,roleA[i].B,msg,msgNo);
   ch[1].empty := false;
   ch[1].msg := msg;
   ch[1].sender := roleA[i].A;
   ch[1].receiver := Intruder;
   roleA[i].st := A2;
   put "roleA[i] in st1\n";
end;
rule " roleA2 "
roleA[i].st = A2 & ch[2].empty = false & !roleA[i].commit & judge(ch[2].msg,roleA[i].A,msgs[0]) 
==>
var flag_pat14:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[2].msg;
   isPat14(msg, flag_pat14);
   if(flag_pat14) then
     destruct14(msg,roleA[i].locB,roleA[i].locTb,roleA[i].locNb,roleA[i].locA,roleA[i].locNa,roleA[i].locXb,roleA[i].locYb,roleA[i].locA,roleA[i].locB);
     if(matchAgent(roleA[i].locB, roleA[i].B) & matchNonce(roleA[i].locTb, roleA[i].Tb) & matchNonce(roleA[i].locNb, roleA[i].Nb) & matchAgent(roleA[i].locA, roleA[i].A) & matchNonce(roleA[i].locNa, roleA[i].Na) & matchNonce(roleA[i].locXb, roleA[i].Xb) & matchNonce(roleA[i].locYb, roleA[i].Yb) & matchAgent(roleA[i].locA, roleA[i].A) & matchAgent(roleA[i].locB, roleA[i].B))then
       ch[2].empty:=true;
       clear ch[2].msg;
       roleA[i].st := A3;
     endif;
   endif;
   put "roleA[i] in st2\n";
end;
rule " roleA3 "
roleA[i].st = A3 & ch[3].empty = true & !roleA[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons15(roleA[i].A,roleA[i].Nb,roleA[i].A,msg,msgNo);
   ch[3].empty := false;
   ch[3].msg := msg;
   ch[3].sender := roleA[i].A;
   ch[3].receiver := Intruder;
   roleA[i].st := A1;
   put "roleA[i] in st3\n";
   roleA[i].commit := true;
end;
endruleset;

ruleset i:roleBNums do
rule " roleB1 "
roleB[i].st = B1 & ch[1].empty = false & !roleB[i].commit & judge(ch[1].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat22:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[1].msg;
   isPat22(msg, flag_pat22);
   if(flag_pat22) then
     destruct22(msg,roleB[i].locA,roleB[i].locTa,roleB[i].locNa,roleB[i].locB,roleB[i].locXa,roleB[i].locYa,roleB[i].locA,roleB[i].locB);
     if(matchAgent(roleB[i].locA, roleB[i].A) & matchNonce(roleB[i].locTa, roleB[i].Ta) & matchNonce(roleB[i].locNa, roleB[i].Na) & matchAgent(roleB[i].locB, roleB[i].B) & matchNonce(roleB[i].locXa, roleB[i].Xa) & matchNonce(roleB[i].locYa, roleB[i].Ya) & matchAgent(roleB[i].locA, roleB[i].A) & matchAgent(roleB[i].locB, roleB[i].B))then
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
   cons14(roleB[i].B,roleB[i].Tb,roleB[i].Nb,roleB[i].A,roleB[i].Na,roleB[i].Xb,roleB[i].Yb,roleB[i].A,roleB[i].B,msg,msgNo);
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
     destruct15(msg,roleB[i].locA,roleB[i].locNb,roleB[i].locA);
     if(matchAgent(roleB[i].locA, roleB[i].A) & matchNonce(roleB[i].locNb, roleB[i].Nb) & matchAgent(roleB[i].locA, roleB[i].A))then
       ch[3].empty:=true;
       clear ch[3].msg;
       roleB[i].st := B1;
     endif;
   endif;
   put "roleB[i] in st3\n";
   roleB[i].commit := true;
end;
endruleset;


---rule of intruder to get msg from ch[1] 
rule "intruderGetMsgFromCh[1]" 
  ch[1].empty = false & ch[1].sender != Intruder ==>
  var flag_pat10:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[1].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat10(msg,flag_pat10);
    if (flag_pat10) then
      if(!exist(pat10Set,msgNo)) then
        pat10Set.length:=pat10Set.length+1;
        pat10Set.content[pat10Set.length]:=msgNo;
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
  var flag_pat15:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[3].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat15(msg,flag_pat15);
    if (flag_pat15) then
      if(!exist(pat15Set,msgNo)) then
        pat15Set.length:=pat15Set.length+1;
        pat15Set.content[pat15Set.length]:=msgNo;
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
  var flag_pat14:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[2].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat14(msg,flag_pat14);
    if (flag_pat14) then
      if(!exist(pat14Set,msgNo)) then
        pat14Set.length:=pat14Set.length+1;
        pat14Set.content[pat14Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[2].empty := true;
      clear ch[2].msg;
    endif;
    put "intruder get msg from ch[2].\n";
  end;

---rule of intruder to emit msg into ch[2].
ruleset i: msgLen do
  ruleset j: roleANums do
    rule "intruderEmitMsgIntoCh[2]"
      IntruEmit1 = true & roleA[j].st = A2 & ch[2].empty=true & i <= pat14Set.length & pat14Set.content[i] != 0 & Spy_known[pat14Set.content[i]] & !emit[pat14Set.content[i]] ---& matchPat(msgs[pat14Set.content[i]], sPat14Set)
      ==>
      begin
         clear ch[2];
        ch[2].msg:=msgs[pat14Set.content[i]];
        ch[2].sender:=Intruder;
        ch[2].receiver:=roleA[j].A;
        ch[2].empty:=false;
        emit[pat14Set.content[i]] := true;
        IntruEmit2 := true;
        put "intruder emit msg into ch[2].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[1].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[1]"
       roleB[j].st = B1 & ch[1].empty=true & i <= pat10Set.length & pat10Set.content[i] != 0 & Spy_known[pat10Set.content[i]] & !emit[pat10Set.content[i]] ---& matchPat(msgs[pat10Set.content[i]], sPat10Set)
      ==>
      begin
         clear ch[1];
        ch[1].msg:=msgs[pat10Set.content[i]];
        ch[1].sender:=Intruder;
        ch[1].receiver:=roleB[j].B;
        ch[1].empty:=false;
        emit[pat10Set.content[i]] := true;
        IntruEmit1 := true;
        put "intruder emit msg into ch[1].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[3].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[3]"
      IntruEmit2 = true & roleB[j].st = B3 & ch[3].empty=true & i <= pat15Set.length & pat15Set.content[i] != 0 & Spy_known[pat15Set.content[i]] & !emit[pat15Set.content[i]] ---& matchPat(msgs[pat15Set.content[i]], sPat15Set)
      ==>
      begin
         clear ch[3];
        ch[3].msg:=msgs[pat15Set.content[i]];
        ch[3].sender:=Intruder;
        ch[3].receiver:=roleB[j].B;
        ch[3].empty:=false;
        emit[pat15Set.content[i]] := true;
        IntruEmit3 := true;
        put "intruder emit msg into ch[3].\n";
      end;
  endruleset;
endruleset;
--- encrypt and decrypt rules of pat: aenc{Ya}sk(A), for intruder
ruleset i:msgLen do 
  rule "adecrypt 4"	---pat4
    i<=pat4Set.length & pat4Set.content[i] != 0 & Spy_known[pat4Set.content[i]] &
    !Spy_known[msgs[pat4Set.content[i]].aencMsg]
        ==>
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

--- enconcat and deconcat rules for pat: concat(Ya.aenc{Ya}sk(A))

ruleset i:msgLen do 
  rule "deconcat 5" --pat5
    i<=pat5Set.length & pat5Set.content[i] != 0 & Spy_known[pat5Set.content[i]]   &
    !(Spy_known[msgs[pat5Set.content[i]].concatPart[1]]&Spy_known[msgs[pat5Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat5\n";
      if (!Spy_known[msgs[pat5Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat5Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat5Set.content[i]].concatPart[1];
        isPat2(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat2Set,msgPat1)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat5Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat5Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat5Set.content[i]].concatPart[2];
        isPat4(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat4Set,msgPat2)) then
             pat4Set.length:=pat4Set.length+1;
             pat4Set.content[pat4Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 5"	---pat5
      roleB[i].st = B1 &      i1<=pat2Set.length & Spy_known[pat2Set.content[i1]] &
      i2<=pat4Set.length & Spy_known[pat4Set.content[i2]] &
      matchPat(construct5By24(pat2Set.content[i1],pat4Set.content[i2]), sPat5Set)&
      !Spy_known[constructIndex5By24(pat2Set.content[i1],pat4Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat5\n";
        concatMsgNo := constructIndex5By24(pat2Set.content[i1],pat4Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct5By24(pat2Set.content[i1],pat4Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat5Set,concatMsgNo)) then
          pat5Set.length:=pat5Set.length+1;
          pat5Set.content[pat5Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{Ya.aenc{Ya}sk(A)}pk(B), for intruder
ruleset i:msgLen do 
  rule "adecrypt 7"	---pat7
    i<=pat7Set.length & pat7Set.content[i] != 0 & Spy_known[pat7Set.content[i]] &
    !Spy_known[msgs[pat7Set.content[i]].aencMsg]&
    Spy_known[inverseKeyIndex(msgs[msgs[pat7Set.content[i]].aencKey])]  ==>
    var key_inv:Message;
	      msgPat5:indexType;
	      flag_pat5:boolean;	      num:indexType;
    begin
      put "rule adecrypt7\n";
      key_inv := inverseKey(msgs[msgs[pat7Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat7Set.content[i]].aencMsg]:=true;
        msgPat5:=msgs[pat7Set.content[i]].aencMsg;
        isPat5(msgs[msgPat5],flag_pat5);
        if (flag_pat5) then
          if (!exist(pat5Set,msgPat5)) then
            pat5Set.length:=pat5Set.length+1;
            pat5Set.content[pat5Set.length]:=msgPat5;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "aencrypt 7"	---pat7
      roleB[i1].st = B1 &      i<=pat5Set.length & pat5Set.content[i] != 0 & Spy_known[pat5Set.content[i]] &
      j<=pat6Set.length & pat6Set.content[j] != 0 & Spy_known[pat6Set.content[j]] &
      matchPat(construct7By56(pat5Set.content[i],pat6Set.content[j]), sPat7Set) &
      !Spy_known[constructIndex7By56(pat5Set.content[i],pat6Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt7\n";
        if (msgs[pat6Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex7By56(pat5Set.content[i],pat6Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct7By56(pat5Set.content[i],pat6Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat7Set,encMsgNo)) then
            pat7Set.length := pat7Set.length+1;
            pat7Set.content[pat7Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B))

ruleset i:msgLen do 
  rule "deconcat 8" --pat8
    i<=pat8Set.length & pat8Set.content[i] != 0 & Spy_known[pat8Set.content[i]]   &
    !(Spy_known[msgs[pat8Set.content[i]].concatPart[1]]&Spy_known[msgs[pat8Set.content[i]].concatPart[2]]&Spy_known[msgs[pat8Set.content[i]].concatPart[3]]&Spy_known[msgs[pat8Set.content[i]].concatPart[4]]&Spy_known[msgs[pat8Set.content[i]].concatPart[5]])
    ==>
    var msgPat1,msgPat2,msgPat3,msgPat4,msgPat5:indexType;
        flagPat1,flagPat2,flagPat3,flagPat4,flagPat5:boolean;
    begin
      put "rule deconcat8\n";
      if (!Spy_known[msgs[pat8Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat8Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat8Set.content[i]].concatPart[1];
        isPat2(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat2Set,msgPat1)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat8Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat8Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat8Set.content[i]].concatPart[2];
        isPat2(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat2Set,msgPat2)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat8Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat8Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat8Set.content[i]].concatPart[3];
        isPat1(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat1Set,msgPat3)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat3;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat8Set.content[i]].concatPart[4]]) then
        Spy_known[msgs[pat8Set.content[i]].concatPart[4]]:=true;
        msgPat4 := msgs[pat8Set.content[i]].concatPart[4];
        isPat2(msgs[msgPat4],flagPat4);
        if (flagPat4) then
          if(!exist(pat2Set,msgPat4)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat4;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat8Set.content[i]].concatPart[5]]) then
        Spy_known[msgs[pat8Set.content[i]].concatPart[5]]:=true;
        msgPat5 := msgs[pat8Set.content[i]].concatPart[5];
        isPat7(msgs[msgPat5],flagPat5);
        if (flagPat5) then
          if(!exist(pat7Set,msgPat5)) then
             pat7Set.length:=pat7Set.length+1;
             pat7Set.content[pat7Set.length] := msgPat5;
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
    ruleset i: roleBNums do
    rule "enconcat 8"	---pat8
      roleB[i].st = B1 &      i1<=pat2Set.length & Spy_known[pat2Set.content[i1]] &
      i2<=pat2Set.length & Spy_known[pat2Set.content[i2]] &
      i3<=pat1Set.length & Spy_known[pat1Set.content[i3]] &
      i4<=pat2Set.length & Spy_known[pat2Set.content[i4]] &
      i5<=pat7Set.length & Spy_known[pat7Set.content[i5]] &
      matchPat(construct8By22127(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat7Set.content[i5]), sPat8Set)&
      !Spy_known[constructIndex8By22127(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat7Set.content[i5])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat8\n";
        concatMsgNo := constructIndex8By22127(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat7Set.content[i5]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct8By22127(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat7Set.content[i5]);
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
endruleset;
endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B)}sk(A), for intruder
ruleset i:msgLen do 
  rule "adecrypt 9"	---pat9
    i<=pat9Set.length & pat9Set.content[i] != 0 & Spy_known[pat9Set.content[i]] &
    !Spy_known[msgs[pat9Set.content[i]].aencMsg]
        ==>
    var key_inv:Message;
	      msgPat8:indexType;
	      flag_pat8:boolean;	      num:indexType;
    begin
      put "rule adecrypt9\n";
      key_inv := inverseKey(msgs[msgs[pat9Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat9Set.content[i]].aencMsg]:=true;
        msgPat8:=msgs[pat9Set.content[i]].aencMsg;
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
    rule "aencrypt 9"	---pat9
      roleB[i1].st = B1 &      i<=pat8Set.length & pat8Set.content[i] != 0 & Spy_known[pat8Set.content[i]] &
      j<=pat3Set.length & pat3Set.content[j] != 0 & Spy_known[pat3Set.content[j]] &
      matchPat(construct9By83(pat8Set.content[i],pat3Set.content[j]), sPat9Set) &
      !Spy_known[constructIndex9By83(pat8Set.content[i],pat3Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt9\n";
        if (msgs[pat3Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex9By83(pat8Set.content[i],pat3Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct9By83(pat8Set.content[i],pat3Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat9Set,encMsgNo)) then
            pat9Set.length := pat9Set.length+1;
            pat9Set.content[pat9Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{Ya}sk(A)}pk(B)}sk(A))

ruleset i:msgLen do 
  rule "deconcat 10" --pat10
    i<=pat10Set.length & pat10Set.content[i] != 0 & Spy_known[pat10Set.content[i]]   &
    !(Spy_known[msgs[pat10Set.content[i]].concatPart[1]]&Spy_known[msgs[pat10Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat10\n";
      if (!Spy_known[msgs[pat10Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat10Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat10Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat10Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat10Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat10Set.content[i]].concatPart[2];
        isPat9(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat9Set,msgPat2)) then
             pat9Set.length:=pat9Set.length+1;
             pat9Set.content[pat9Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 10"	---pat10
      roleB[i].st = B1 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat9Set.length & Spy_known[pat9Set.content[i2]] &
      matchPat(construct10By19(pat1Set.content[i1],pat9Set.content[i2]), sPat10Set)&
      !Spy_known[constructIndex10By19(pat1Set.content[i1],pat9Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat10\n";
        concatMsgNo := constructIndex10By19(pat1Set.content[i1],pat9Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct10By19(pat1Set.content[i1],pat9Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat10Set,concatMsgNo)) then
          pat10Set.length:=pat10Set.length+1;
          pat10Set.content[pat10Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{Yb}pk(A), for intruder
ruleset i:msgLen do 
  rule "adecrypt 11"	---pat11
    i<=pat11Set.length & pat11Set.content[i] != 0 & Spy_known[pat11Set.content[i]] &
    !Spy_known[msgs[pat11Set.content[i]].aencMsg]&
    Spy_known[inverseKeyIndex(msgs[msgs[pat11Set.content[i]].aencKey])]  ==>
    var key_inv:Message;
	      msgPat2:indexType;
	      flag_pat2:boolean;	      num:indexType;
    begin
      put "rule adecrypt11\n";
      key_inv := inverseKey(msgs[msgs[pat11Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat11Set.content[i]].aencMsg]:=true;
        msgPat2:=msgs[pat11Set.content[i]].aencMsg;
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
    ruleset i1: roleANums do
    rule "aencrypt 11"	---pat11
      roleA[i1].st = A2 &      i<=pat2Set.length & pat2Set.content[i] != 0 & Spy_known[pat2Set.content[i]] &
      j<=pat6Set.length & pat6Set.content[j] != 0 & Spy_known[pat6Set.content[j]] &
      matchPat(construct11By26(pat2Set.content[i],pat6Set.content[j]), sPat11Set) &
      !Spy_known[constructIndex11By26(pat2Set.content[i],pat6Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt11\n";
        if (msgs[pat6Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex11By26(pat2Set.content[i],pat6Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct11By26(pat2Set.content[i],pat6Set.content[j]);
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

--- enconcat and deconcat rules for pat: concat(Tb.Nb.A.Na.Xb.aenc{Yb}pk(A))

ruleset i:msgLen do 
  rule "deconcat 12" --pat12
    i<=pat12Set.length & pat12Set.content[i] != 0 & Spy_known[pat12Set.content[i]]   &
    !(Spy_known[msgs[pat12Set.content[i]].concatPart[1]]&Spy_known[msgs[pat12Set.content[i]].concatPart[2]]&Spy_known[msgs[pat12Set.content[i]].concatPart[3]]&Spy_known[msgs[pat12Set.content[i]].concatPart[4]]&Spy_known[msgs[pat12Set.content[i]].concatPart[5]]&Spy_known[msgs[pat12Set.content[i]].concatPart[6]])
    ==>
    var msgPat1,msgPat2,msgPat3,msgPat4,msgPat5,msgPat6:indexType;
        flagPat1,flagPat2,flagPat3,flagPat4,flagPat5,flagPat6:boolean;
    begin
      put "rule deconcat12\n";
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat12Set.content[i]].concatPart[1];
        isPat2(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat2Set,msgPat1)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat12Set.content[i]].concatPart[2];
        isPat2(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat2Set,msgPat2)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat12Set.content[i]].concatPart[3];
        isPat1(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat1Set,msgPat3)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat3;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[4]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[4]]:=true;
        msgPat4 := msgs[pat12Set.content[i]].concatPart[4];
        isPat2(msgs[msgPat4],flagPat4);
        if (flagPat4) then
          if(!exist(pat2Set,msgPat4)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat4;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[5]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[5]]:=true;
        msgPat5 := msgs[pat12Set.content[i]].concatPart[5];
        isPat2(msgs[msgPat5],flagPat5);
        if (flagPat5) then
          if(!exist(pat2Set,msgPat5)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat5;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[6]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[6]]:=true;
        msgPat6 := msgs[pat12Set.content[i]].concatPart[6];
        isPat11(msgs[msgPat6],flagPat6);
        if (flagPat6) then
          if(!exist(pat11Set,msgPat6)) then
             pat11Set.length:=pat11Set.length+1;
             pat11Set.content[pat11Set.length] := msgPat6;
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
  ruleset i6: msgLen do 
    ruleset i: roleANums do
    rule "enconcat 12"	---pat12
      roleA[i].st = A2 &      i1<=pat2Set.length & Spy_known[pat2Set.content[i1]] &
      i2<=pat2Set.length & Spy_known[pat2Set.content[i2]] &
      i3<=pat1Set.length & Spy_known[pat1Set.content[i3]] &
      i4<=pat2Set.length & Spy_known[pat2Set.content[i4]] &
      i5<=pat2Set.length & Spy_known[pat2Set.content[i5]] &
      i6<=pat11Set.length & Spy_known[pat11Set.content[i6]] &
      matchPat(construct12By2212211(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat2Set.content[i5],pat11Set.content[i6]), sPat12Set)&
      !Spy_known[constructIndex12By2212211(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat2Set.content[i5],pat11Set.content[i6])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat12\n";
        concatMsgNo := constructIndex12By2212211(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat2Set.content[i5],pat11Set.content[i6]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct12By2212211(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat2Set.content[i5],pat11Set.content[i6]);
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
endruleset;
endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{Tb.Nb.A.Na.Xb.aenc{Yb}pk(A)}sk(B), for intruder
ruleset i:msgLen do 
  rule "adecrypt 13"	---pat13
    i<=pat13Set.length & pat13Set.content[i] != 0 & Spy_known[pat13Set.content[i]] &
    !Spy_known[msgs[pat13Set.content[i]].aencMsg]
        ==>
    var key_inv:Message;
	      msgPat12:indexType;
	      flag_pat12:boolean;	      num:indexType;
    begin
      put "rule adecrypt13\n";
      key_inv := inverseKey(msgs[msgs[pat13Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat13Set.content[i]].aencMsg]:=true;
        msgPat12:=msgs[pat13Set.content[i]].aencMsg;
        isPat12(msgs[msgPat12],flag_pat12);
        if (flag_pat12) then
          if (!exist(pat12Set,msgPat12)) then
            pat12Set.length:=pat12Set.length+1;
            pat12Set.content[pat12Set.length]:=msgPat12;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleANums do
    rule "aencrypt 13"	---pat13
      roleA[i1].st = A2 &      i<=pat12Set.length & pat12Set.content[i] != 0 & Spy_known[pat12Set.content[i]] &
      j<=pat3Set.length & pat3Set.content[j] != 0 & Spy_known[pat3Set.content[j]] &
      matchPat(construct13By123(pat12Set.content[i],pat3Set.content[j]), sPat13Set) &
      !Spy_known[constructIndex13By123(pat12Set.content[i],pat3Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt13\n";
        if (msgs[pat3Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex13By123(pat12Set.content[i],pat3Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct13By123(pat12Set.content[i],pat3Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat13Set,encMsgNo)) then
            pat13Set.length := pat13Set.length+1;
            pat13Set.content[pat13Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(B.aenc{Tb.Nb.A.Na.Xb.aenc{Yb}pk(A)}sk(B))

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
    ruleset i: roleANums do
    rule "enconcat 14"	---pat14
      roleA[i].st = A2 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
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

--- enconcat and deconcat rules for pat: concat(A.aenc{Nb}sk(A))

ruleset i:msgLen do 
  rule "deconcat 15" --pat15
    i<=pat15Set.length & pat15Set.content[i] != 0 & Spy_known[pat15Set.content[i]]   &
    !(Spy_known[msgs[pat15Set.content[i]].concatPart[1]]&Spy_known[msgs[pat15Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
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
        isPat4(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat4Set,msgPat2)) then
             pat4Set.length:=pat4Set.length+1;
             pat4Set.content[pat4Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 15"	---pat15
      roleB[i].st = B3 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat4Set.length & Spy_known[pat4Set.content[i2]] &
      matchPat(construct15By14(pat1Set.content[i1],pat4Set.content[i2]), sPat15Set)&
      !Spy_known[constructIndex15By14(pat1Set.content[i1],pat4Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat15\n";
        concatMsgNo := constructIndex15By14(pat1Set.content[i1],pat4Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct15By14(pat1Set.content[i1],pat4Set.content[i2]);
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

--- hash and dehash rules of pat: hash{}, for intruder
ruleset i:msgLen do 
  ruleset j:msgLen do 
        rule "constructHash 16"  --pat16
      i<=pat2Set.length & pat2Set.content[i] != 0 & Spy_known[pat2Set.content[i]] &
      matchPat(construct16By2(pat2Set.content[i]), sPat16Set) &
      !Spy_known[constructIndex16By2(pat2Set.content[i])]
      ==>
      var hashMsgNo:indexType;
      hashMsg:Message;
      begin
        put "rule constructHash 16\n";
        hashMsgNo := constructIndex16By2(pat2Set.content[i]);
        if hashMsgNo = msg_end + 1 then
          msg_end := msg_end + 1;
          hashMsg := construct16By2(pat2Set.content[i]);
          msgs[hashMsgNo] := hashMsg;
        endif;
        Spy_known[hashMsgNo]:=true;
        if (!exist(pat16Set,hashMsgNo)) then
          pat16Set.length:=pat16Set.length+1;
          pat16Set.content[pat16Set.length]:=hashMsgNo;
        endif;
      end;
    endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{hash(Ya)}sk(A), for intruder
ruleset i:msgLen do 
  rule "adecrypt 17"	---pat17
    i<=pat17Set.length & pat17Set.content[i] != 0 & Spy_known[pat17Set.content[i]] &
    !Spy_known[msgs[pat17Set.content[i]].aencMsg]
        ==>
    var key_inv:Message;
	      msgPat16:indexType;
	      flag_pat16:boolean;	      num:indexType;
    begin
      put "rule adecrypt17\n";
      key_inv := inverseKey(msgs[msgs[pat17Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat17Set.content[i]].aencMsg]:=true;
        msgPat16:=msgs[pat17Set.content[i]].aencMsg;
        isPat16(msgs[msgPat16],flag_pat16);
        if (flag_pat16) then
          if (!exist(pat16Set,msgPat16)) then
            pat16Set.length:=pat16Set.length+1;
            pat16Set.content[pat16Set.length]:=msgPat16;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
        rule "aencrypt 17"	---pat17
      i<=pat16Set.length & pat16Set.content[i] != 0 & Spy_known[pat16Set.content[i]] &
      j<=pat3Set.length & pat3Set.content[j] != 0 & Spy_known[pat3Set.content[j]] &
      matchPat(construct17By163(pat16Set.content[i],pat3Set.content[j]), sPat17Set) &
      !Spy_known[constructIndex17By163(pat16Set.content[i],pat3Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt17\n";
        if (msgs[pat3Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex17By163(pat16Set.content[i],pat3Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct17By163(pat16Set.content[i],pat3Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat17Set,encMsgNo)) then
            pat17Set.length := pat17Set.length+1;
            pat17Set.content[pat17Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
    endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(Ya.aenc{hash(Ya)}sk(A))

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
        isPat2(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat2Set,msgPat1)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat18Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat18Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat18Set.content[i]].concatPart[2];
        isPat17(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat17Set,msgPat2)) then
             pat17Set.length:=pat17Set.length+1;
             pat17Set.content[pat17Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    rule "enconcat 18"	---pat18
      i1<=pat2Set.length & Spy_known[pat2Set.content[i1]] &
      i2<=pat17Set.length & Spy_known[pat17Set.content[i2]] &
      matchPat(construct18By217(pat2Set.content[i1],pat17Set.content[i2]), sPat18Set)&
      !Spy_known[constructIndex18By217(pat2Set.content[i1],pat17Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat18\n";
        concatMsgNo := constructIndex18By217(pat2Set.content[i1],pat17Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct18By217(pat2Set.content[i1],pat17Set.content[i2]);
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

--- encrypt and decrypt rules of pat: aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B), for intruder
ruleset i:msgLen do 
  rule "adecrypt 19"	---pat19
    i<=pat19Set.length & pat19Set.content[i] != 0 & Spy_known[pat19Set.content[i]] &
    !Spy_known[msgs[pat19Set.content[i]].aencMsg]&
    Spy_known[inverseKeyIndex(msgs[msgs[pat19Set.content[i]].aencKey])]  ==>
    var key_inv:Message;
	      msgPat18:indexType;
	      flag_pat18:boolean;	      num:indexType;
    begin
      put "rule adecrypt19\n";
      key_inv := inverseKey(msgs[msgs[pat19Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat19Set.content[i]].aencMsg]:=true;
        msgPat18:=msgs[pat19Set.content[i]].aencMsg;
        isPat18(msgs[msgPat18],flag_pat18);
        if (flag_pat18) then
          if (!exist(pat18Set,msgPat18)) then
            pat18Set.length:=pat18Set.length+1;
            pat18Set.content[pat18Set.length]:=msgPat18;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
        rule "aencrypt 19"	---pat19
      i<=pat18Set.length & pat18Set.content[i] != 0 & Spy_known[pat18Set.content[i]] &
      j<=pat6Set.length & pat6Set.content[j] != 0 & Spy_known[pat6Set.content[j]] &
      matchPat(construct19By186(pat18Set.content[i],pat6Set.content[j]), sPat19Set) &
      !Spy_known[constructIndex19By186(pat18Set.content[i],pat6Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt19\n";
        if (msgs[pat6Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex19By186(pat18Set.content[i],pat6Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct19By186(pat18Set.content[i],pat6Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat19Set,encMsgNo)) then
            pat19Set.length := pat19Set.length+1;
            pat19Set.content[pat19Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
    endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B))

ruleset i:msgLen do 
  rule "deconcat 20" --pat20
    i<=pat20Set.length & pat20Set.content[i] != 0 & Spy_known[pat20Set.content[i]]   &
    !(Spy_known[msgs[pat20Set.content[i]].concatPart[1]]&Spy_known[msgs[pat20Set.content[i]].concatPart[2]]&Spy_known[msgs[pat20Set.content[i]].concatPart[3]]&Spy_known[msgs[pat20Set.content[i]].concatPart[4]]&Spy_known[msgs[pat20Set.content[i]].concatPart[5]])
    ==>
    var msgPat1,msgPat2,msgPat3,msgPat4,msgPat5:indexType;
        flagPat1,flagPat2,flagPat3,flagPat4,flagPat5:boolean;
    begin
      put "rule deconcat20\n";
      if (!Spy_known[msgs[pat20Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat20Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat20Set.content[i]].concatPart[1];
        isPat2(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat2Set,msgPat1)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat20Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat20Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat20Set.content[i]].concatPart[2];
        isPat2(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat2Set,msgPat2)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat20Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat20Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat20Set.content[i]].concatPart[3];
        isPat1(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat1Set,msgPat3)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat3;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat20Set.content[i]].concatPart[4]]) then
        Spy_known[msgs[pat20Set.content[i]].concatPart[4]]:=true;
        msgPat4 := msgs[pat20Set.content[i]].concatPart[4];
        isPat2(msgs[msgPat4],flagPat4);
        if (flagPat4) then
          if(!exist(pat2Set,msgPat4)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat4;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat20Set.content[i]].concatPart[5]]) then
        Spy_known[msgs[pat20Set.content[i]].concatPart[5]]:=true;
        msgPat5 := msgs[pat20Set.content[i]].concatPart[5];
        isPat19(msgs[msgPat5],flagPat5);
        if (flagPat5) then
          if(!exist(pat19Set,msgPat5)) then
             pat19Set.length:=pat19Set.length+1;
             pat19Set.content[pat19Set.length] := msgPat5;
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
    rule "enconcat 20"	---pat20
      i1<=pat2Set.length & Spy_known[pat2Set.content[i1]] &
      i2<=pat2Set.length & Spy_known[pat2Set.content[i2]] &
      i3<=pat1Set.length & Spy_known[pat1Set.content[i3]] &
      i4<=pat2Set.length & Spy_known[pat2Set.content[i4]] &
      i5<=pat19Set.length & Spy_known[pat19Set.content[i5]] &
      matchPat(construct20By221219(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat19Set.content[i5]), sPat20Set)&
      !Spy_known[constructIndex20By221219(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat19Set.content[i5])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat20\n";
        concatMsgNo := constructIndex20By221219(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat19Set.content[i5]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct20By221219(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat19Set.content[i5]);
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
endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A), for intruder
ruleset i:msgLen do 
  rule "adecrypt 21"	---pat21
    i<=pat21Set.length & pat21Set.content[i] != 0 & Spy_known[pat21Set.content[i]] &
    !Spy_known[msgs[pat21Set.content[i]].aencMsg]
        ==>
    var key_inv:Message;
	      msgPat20:indexType;
	      flag_pat20:boolean;	      num:indexType;
    begin
      put "rule adecrypt21\n";
      key_inv := inverseKey(msgs[msgs[pat21Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat21Set.content[i]].aencMsg]:=true;
        msgPat20:=msgs[pat21Set.content[i]].aencMsg;
        isPat20(msgs[msgPat20],flag_pat20);
        if (flag_pat20) then
          if (!exist(pat20Set,msgPat20)) then
            pat20Set.length:=pat20Set.length+1;
            pat20Set.content[pat20Set.length]:=msgPat20;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
        rule "aencrypt 21"	---pat21
      i<=pat20Set.length & pat20Set.content[i] != 0 & Spy_known[pat20Set.content[i]] &
      j<=pat3Set.length & pat3Set.content[j] != 0 & Spy_known[pat3Set.content[j]] &
      matchPat(construct21By203(pat20Set.content[i],pat3Set.content[j]), sPat21Set) &
      !Spy_known[constructIndex21By203(pat20Set.content[i],pat3Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt21\n";
        if (msgs[pat3Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex21By203(pat20Set.content[i],pat3Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct21By203(pat20Set.content[i],pat3Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat21Set,encMsgNo)) then
            pat21Set.length := pat21Set.length+1;
            pat21Set.content[pat21Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
    endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A))

ruleset i:msgLen do 
  rule "deconcat 22" --pat22
    i<=pat22Set.length & pat22Set.content[i] != 0 & Spy_known[pat22Set.content[i]]   &
    !(Spy_known[msgs[pat22Set.content[i]].concatPart[1]]&Spy_known[msgs[pat22Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
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
        isPat21(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat21Set,msgPat2)) then
             pat21Set.length:=pat21Set.length+1;
             pat21Set.content[pat21Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    rule "enconcat 22"	---pat22
      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat21Set.length & Spy_known[pat21Set.content[i2]] &
      matchPat(construct22By121(pat1Set.content[i1],pat21Set.content[i2]), sPat22Set)&
      !Spy_known[constructIndex22By121(pat1Set.content[i1],pat21Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat22\n";
        concatMsgNo := constructIndex22By121(pat1Set.content[i1],pat21Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct22By121(pat1Set.content[i1],pat21Set.content[i2]);
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

startstate
  roleA[1].A := Alice;
  roleA[1].B := Intruder;
  roleA[1].Na := Na;
  roleA[1].Ta := Ta;
  roleA[1].Xa := Xa;
  roleA[1].Ya := Ya;
  roleA[1].st := A1;
  roleA[1].commit := false;
  roleA[1].Nb := anyNonce;
  roleA[1].Tb := anyNonce;
  roleA[1].Xb := anyNonce;
  roleA[1].Yb := anyNonce;

  roleA[1].A := Alice;
  roleA[1].B := Intruder;
  roleA[1].Nb := Na;
  roleA[1].Tb := Ta;
  roleA[1].Xb := Xa;
  roleA[1].Yb := Ya;
  roleA[1].st := A1;
  roleA[1].commit := false;
  roleA[1].Na := anyNonce;
  roleA[1].Ta := anyNonce;
  roleA[1].Xa := anyNonce;
  roleA[1].Ya := anyNonce;

  roleB[1].A := Intruder;
  roleB[1].B := Bob;
  roleB[1].Na := Nb;
  roleB[1].Ta := Tb;
  roleB[1].Xa := Xb;
  roleB[1].Ya := Yb;
  roleB[1].st := B1;
  roleB[1].commit := false;
  roleB[1].Nb := anyNonce;
  roleB[1].Tb := anyNonce;
  roleB[1].Xb := anyNonce;
  roleB[1].Yb := anyNonce;

  roleB[1].A := Intruder;
  roleB[1].B := Bob;
  roleB[1].Nb := Nb;
  roleB[1].Tb := Tb;
  roleB[1].Xb := Xb;
  roleB[1].Yb := Yb;
  roleB[1].st := B1;
  roleB[1].commit := false;
  roleB[1].Na := anyNonce;
  roleB[1].Ta := anyNonce;
  roleB[1].Xa := anyNonce;
  roleB[1].Ya := anyNonce;


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
    IntruEmit1 := false;
    IntruEmit2 := false;
    IntruEmit3 := false;
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
    Spy_known[i] := false;
  endfor;
  msg_end:=msg_end+1;
  msgs[msg_end].msgType := key;
  msgs[msg_end].k.ag:=Intruder;
  msgs[msg_end].k.encType:=SK;
  msgs[msg_end].length := 1;
  pat3Set.length := pat3Set.length + 1; 
  pat3Set.content[pat3Set.length] :=msg_end;
  Spy_known[msg_end] := true;
    for i : roleANums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleA[i].A;
    msgs[msg_end].k.encType:=PK;
    msgs[msg_end].length := 1;
    pat6Set.length := pat6Set.length + 1;
    pat6Set.content[pat6Set.length] :=msg_end;
    Spy_known[msg_end] := true;
    A_known[msg_end] := true;
  endfor;
  for i : roleANums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleA[i].A;
    msgs[msg_end].k.encType:=SK;
    msgs[msg_end].length := 1;
    pat3Set.length := pat3Set.length + 1;
    pat3Set.content[pat3Set.length] :=msg_end;
    A_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleB[i].B;
    msgs[msg_end].k.encType:=PK;
    msgs[msg_end].length := 1;
    pat6Set.length := pat6Set.length + 1;
    pat6Set.content[pat6Set.length] :=msg_end;
    Spy_known[msg_end] := true;
    B_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleB[i].B;
    msgs[msg_end].k.encType:=SK;
    msgs[msg_end].length := 1;
    pat3Set.length := pat3Set.length + 1;
    pat3Set.content[pat3Set.length] :=msg_end;
    B_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    constructSpat10(roleB[i].A,roleB[i].Ta,roleB[i].Na,roleB[i].B,roleB[i].Xa,roleB[i].Ya,roleB[i].A,roleB[i].B, gnum);
  endfor;
  for i : roleBNums do
    constructSpat15(roleB[i].A,roleB[i].Nb,roleB[i].A, gnum);
  endfor;
  for i : roleANums do
    constructSpat14(roleA[i].B,roleA[i].Tb,roleA[i].Nb,roleA[i].A,roleA[i].Na,roleA[i].Xb,roleA[i].Yb,roleA[i].A,roleA[i].B, gnum);
  endfor;

end;

invariant "secrecy" 
forall i:indexType do
    (msgs[i].msgType=nonce & msgs[i].noncePart=Ya)
     ->
     Spy_known[i] = false
end;

invariant "secrecy1" 
forall i:indexType do
    (msgs[i].msgType=nonce & msgs[i].noncePart=Yb)
     ->
     Spy_known[i] = false
end;

invariant "weakA"
  forall i: roleBNums do
    roleB[i].commit = true 
    ->
    (exists j: roleANums do
      ---roleA[j].commit = true &
      roleA[i].Xa = roleB[j].Xa
    endexists)
  endforall;

invariant "weakA1"
  forall i: roleBNums do
    roleB[i].commit = true 
    ->
    (exists j: roleANums do
      ---roleA[j].commit = true &
      roleA[i].Ya = roleB[j].Ya
    endexists)
  endforall;
