const
  roleANum:1;
  roleBNum:1;
  roleCNum:1;
  roleDNum:1;
  totalFact:100;
  msgLength:10;
  chanNum:18;
  invokeNum:10;
type
  indexType:0..totalFact;
  roleANums:1..roleANum;
  roleBNums:1..roleBNum;
  roleCNums:1..roleCNum;
  roleDNums:1..roleDNum;
  msgLen:0..msgLength;
  chanNums:0..chanNum;
  invokeNums:0..invokeNum;

  AgentType : enum{anyAgent,UE, SEAF, Intruder, UDM, AUSF}; ---Intruder 
  NonceType : enum{anyNonce, supi, ue, ue1, prekey, certA, eapm, seafn, ausf, ausfn, sucm, certC, start};
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

  AStatus: enum{A1,A2,A3,A4,A5,A6,A7,A8};
  BStatus: enum{B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15,B16};
  CStatus: enum{C1,C2,C3,C4,C5,C6,C7,C8,C9,C10};
  DStatus: enum{D1,D2};

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
   ue : NonceType;
   ue1 : NonceType;
   prekey : NonceType;
   certA : NonceType;
   eapm : NonceType;
   seafn : NonceType;
   ausf : NonceType;
   ausfn : NonceType;
   sucm : NonceType;
   certC : NonceType;
   start : NonceType;
   A : AgentType;
   B : AgentType;
   C : AgentType;
   D : AgentType;
   x10 : Message;
   m1 : Message;
   x2 : Message;
   x3 : Message;
   x1 : Message;

   locsupi : NonceType;
   locue : NonceType;
   locue1 : NonceType;
   locprekey : NonceType;
   loccertA : NonceType;
   loceapm : NonceType;
   locseafn : NonceType;
   locausf : NonceType;
   locausfn : NonceType;
   locsucm : NonceType;
   loccertC : NonceType;
   locstart : NonceType;
   locA : AgentType;
   locB : AgentType;
   locC : AgentType;
   locD : AgentType;
   locx10 : Message;
   locm1 : Message;
   locx2 : Message;
   locx3 : Message;
   locx1 : Message;
   
   st: AStatus;
   commit : boolean;
  end;
  RoleB : record
   supi : NonceType;
   ue : NonceType;
   ue1 : NonceType;
   prekey : NonceType;
   certA : NonceType;
   eapm : NonceType;
   seafn : NonceType;
   ausf : NonceType;
   ausfn : NonceType;
   sucm : NonceType;
   certC : NonceType;
   start : NonceType;
   A : AgentType;
   B : AgentType;
   C : AgentType;
   D : AgentType;
   x10 : Message;
   m1 : Message;
   x2 : Message;
   x3 : Message;
   x1 : Message;

   locsupi : NonceType;
   locue : NonceType;
   locue1 : NonceType;
   locprekey : NonceType;
   loccertA : NonceType;
   loceapm : NonceType;
   locseafn : NonceType;
   locausf : NonceType;
   locausfn : NonceType;
   locsucm : NonceType;
   loccertC : NonceType;
   locstart : NonceType;
   locA : AgentType;
   locB : AgentType;
   locC : AgentType;
   locD : AgentType;
   locx10 : Message;
   locm1 : Message;
   locx2 : Message;
   locx3 : Message;
   locx1 : Message;
   
   st: BStatus;
   commit : boolean;
  end;
  RoleC : record
   supi : NonceType;
   ue : NonceType;
   ue1 : NonceType;
   prekey : NonceType;
   certA : NonceType;
   eapm : NonceType;
   seafn : NonceType;
   ausf : NonceType;
   ausfn : NonceType;
   sucm : NonceType;
   certC : NonceType;
   start : NonceType;
   A : AgentType;
   B : AgentType;
   C : AgentType;
   D : AgentType;
   x10 : Message;
   m1 : Message;
   x2 : Message;
   x3 : Message;
   x1 : Message;

   locsupi : NonceType;
   locue : NonceType;
   locue1 : NonceType;
   locprekey : NonceType;
   loccertA : NonceType;
   loceapm : NonceType;
   locseafn : NonceType;
   locausf : NonceType;
   locausfn : NonceType;
   locsucm : NonceType;
   loccertC : NonceType;
   locstart : NonceType;
   locA : AgentType;
   locB : AgentType;
   locC : AgentType;
   locD : AgentType;
   locx10 : Message;
   locm1 : Message;
   locx2 : Message;
   locx3 : Message;
   locx1 : Message;
   
   st: CStatus;
   commit : boolean;
  end;
  RoleD : record
   supi : NonceType;
   ue : NonceType;
   ue1 : NonceType;
   prekey : NonceType;
   certA : NonceType;
   eapm : NonceType;
   seafn : NonceType;
   ausf : NonceType;
   ausfn : NonceType;
   sucm : NonceType;
   certC : NonceType;
   start : NonceType;
   A : AgentType;
   B : AgentType;
   C : AgentType;
   D : AgentType;
   x10 : Message;
   m1 : Message;
   x2 : Message;
   x3 : Message;
   x1 : Message;

   locsupi : NonceType;
   locue : NonceType;
   locue1 : NonceType;
   locprekey : NonceType;
   loccertA : NonceType;
   loceapm : NonceType;
   locseafn : NonceType;
   locausf : NonceType;
   locausfn : NonceType;
   locsucm : NonceType;
   loccertC : NonceType;
   locstart : NonceType;
   locA : AgentType;
   locB : AgentType;
   locC : AgentType;
   locD : AgentType;
   locx10 : Message;
   locm1 : Message;
   locx2 : Message;
   locx3 : Message;
   locx1 : Message;
   
   st: DStatus;
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
  roleD : Array[roleDNums] of RoleD;

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
  C_known : Array[indexType] of boolean;
  D_known : Array[indexType] of boolean;
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
  IntruEmit11 : boolean;
  IntruEmit12 : boolean;
  IntruEmit13 : boolean;
  IntruEmit14 : boolean;
  IntruEmit15 : boolean;
  IntruEmit16 : boolean;
  IntruEmit17 : boolean;
  IntruEmit18 : boolean;
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

function construct5By111(msgNo1,msgNo2,msgNo3:indexType):Message;
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

function constructIndex5By111(msgNo1,msgNo2,msgNo3:indexType):indexType;
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

function construct6By13(msgNo11, msgNo32:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo11 & msgs[i].aencKey = msgNo32) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo11;
     msg.aencKey := msgNo32;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex6By13(msgNo11, msgNo32:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo11 & msgs[i].aencKey = msgNo32) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct7By1111(msgNo1,msgNo2,msgNo3,msgNo4:indexType):Message;
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

function constructIndex7By1111(msgNo1,msgNo2,msgNo3,msgNo4:indexType):indexType;
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

function construct9By78(msgNo71, msgNo82:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = sign) then
       if (msgs[i].signMsg = msgNo71 & msgs[i].signKey = msgNo82) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := sign;
     msg.signMsg := msgNo71;
     msg.signKey := msgNo82;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex9By78(msgNo71, msgNo82:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = sign) then
       if (msgs[i].signMsg = msgNo71 & msgs[i].signKey = msgNo82) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct10By5(msgNo51:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = hash) then
       if (msgs[i].hashMsg = msgNo51) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := hash;
     msg.hashMsg := msgNo51;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex10By5(msgNo51:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = hash) then
       if (msgs[i].hashMsg = msgNo51) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct11By710(msgNo71, msgNo102:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo71 & msgs[i].sencKey = msgNo102) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := senc;
     msg.sencMsg := msgNo71;
     msg.sencKey := msgNo102;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex11By710(msgNo71, msgNo102:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo71 & msgs[i].sencKey = msgNo102) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
      index:= msg_end + 1;
   endif;
   return index;
  end;
function construct12By61911(msgNo1,msgNo2,msgNo3,msgNo4:indexType):Message;
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

function constructIndex12By61911(msgNo1,msgNo2,msgNo3,msgNo4:indexType):indexType;
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

--- Sorry, construct_function of this pattern has not been written!

function construct15By141(msgNo1,msgNo2:indexType):Message;
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

function constructIndex15By141(msgNo1,msgNo2:indexType):indexType;
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

function construct17By161(msgNo1,msgNo2:indexType):Message;
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

function constructIndex17By161(msgNo1,msgNo2:indexType):indexType;
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

function construct19By181(msgNo1,msgNo2:indexType):Message;
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

function constructIndex19By181(msgNo1,msgNo2:indexType):indexType;
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

function construct20By1411(msgNo1,msgNo2,msgNo3:indexType):Message;
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

function constructIndex20By1411(msgNo1,msgNo2,msgNo3:indexType):indexType;
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

--- Sorry, construct_function of this pattern has not been written!

function construct22By2111(msgNo1,msgNo2,msgNo3:indexType):Message;
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

function constructIndex22By2111(msgNo1,msgNo2,msgNo3:indexType):indexType;
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

---pat2: supi.ue 
procedure lookAddPat2(supi:NonceType; ue:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(supi, msg1, i1);
   lookAddPat1(ue, msg2, i2);
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

---pat2: supi.ue 
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
---spat2: supi.ue 
procedure constructSpat2(supi:NonceType; ue:NonceType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(supi, i1);
    constructSpat1(ue, i2);
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

---pat3: pk(D) 
procedure lookAddPat3(DPk:AgentType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    index:=0;
    for i: indexType do
      if (msgs[i].msgType = key) then
        if (msgs[i].k.encType = PK & msgs[i].k.ag = DPk) then
          index:=i;
        endif;
      endif;
    endfor;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := key;
      msgs[index].k.encType:=PK; 
      msgs[index].k.ag:=DPk;
      msgs[index].length := 1;
    endif;
    num:=index;
    msg:=msgs[index];
  end;

---pat3: pk(D) 
procedure isPat3(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = key & msg.k.encType = PK) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat3: pk(D) 
procedure constructSpat3(DPk:AgentType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = key & msgs[i].k.encType = PK) then
        if (msgs[i].k.ag = DPk) then
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
      msgs[index].k.ag := DPk;
      msgs[index].length := 1;
    endif;
    sPat3Set.length := sPat3Set.length + 1;
    sPat3Set.content[sPat3Set.length] := index;
    num := index;
  end;

---pat4: aenc{supi.ue}pk(D) 
procedure lookAddPat4(supi:NonceType; ue:NonceType; DPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(supi, ue,msg1,i1);
   lookAddPat3(DPk,msg2,i2);
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

---pat4: aenc{supi.ue}pk(D) 
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

---spat4: aenc{supi.ue}pk(D) 
procedure constructSpat4(supi:NonceType; ue:NonceType; DPk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat2(supi, ue, i1);
    constructSpat3(DPk, i2);
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

---pat5: ausf.certC.seafn 
procedure lookAddPat5(ausf:NonceType; certC:NonceType; seafn:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3: Message;
     index,i1,i2,i3:indexType;
  begin
   index:=0;
   lookAddPat1(ausf, msg1, i1);
   lookAddPat1(certC, msg2, i2);
   lookAddPat1(seafn, msg3, i3);
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

---pat5: ausf.certC.seafn 
procedure isPat5(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat1(msgs[msg.concatPart[2]],flagPart2);
        isPat1(msgs[msg.concatPart[3]],flagPart3);
       if (flagPart1 & flagPart2 & flagPart3) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat5: ausf.certC.seafn 
procedure constructSpat5(ausf:NonceType; certC:NonceType; seafn:NonceType; Var num: indexType);
  Var i,index, i1, i2, i3:indexType;
  begin
    index:=0;
    constructSpat1(ausf, i1);
    constructSpat1(certC, i2);
    constructSpat1(seafn, i3);
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
    sPat5Set.length := sPat5Set.length + 1;
    sPat5Set.content[sPat5Set.length] := index;
    num := index;
  end;

---pat6: aenc{prekey}pk(C) 
procedure lookAddPat6(prekey:NonceType; CPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(prekey,msg1,i1);
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

---pat6: aenc{prekey}pk(C) 
procedure isPat6(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat1(msgs[msg.aencMsg],flagPart1);
      isPat3(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat6: aenc{prekey}pk(C) 
procedure constructSpat6(prekey:NonceType; CPk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat1(prekey, i1);
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
    sPat6Set.length := sPat6Set.length + 1;
    sPat6Set.content[sPat6Set.length] := index;
    num := index;
  end;

---pat7: start.ue1.ausf.certC 
procedure lookAddPat7(start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3,msg4: Message;
     index,i1,i2,i3,i4:indexType;
  begin
   index:=0;
   lookAddPat1(start, msg1, i1);
   lookAddPat1(ue1, msg2, i2);
   lookAddPat1(ausf, msg3, i3);
   lookAddPat1(certC, msg4, i4);
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

---pat7: start.ue1.ausf.certC 
procedure isPat7(msg:Message; Var flag:boolean);
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
        isPat1(msgs[msg.concatPart[3]],flagPart3);
        isPat1(msgs[msg.concatPart[4]],flagPart4);
       if (flagPart1 & flagPart2 & flagPart3 & flagPart4) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat7: start.ue1.ausf.certC 
procedure constructSpat7(start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; Var num: indexType);
  Var i,index, i1, i2, i3, i4:indexType;
  begin
    index:=0;
    constructSpat1(start, i1);
    constructSpat1(ue1, i2);
    constructSpat1(ausf, i3);
    constructSpat1(certC, i4);
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
    sPat7Set.length := sPat7Set.length + 1;
    sPat7Set.content[sPat7Set.length] := index;
    num := index;
  end;

---pat8: sk(A) 
procedure lookAddPat8(ASk:AgentType; Var msg:Message; Var num : indexType);
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

---pat8: sk(A) 
procedure isPat8(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
      flag1 := false;
      if (msg.msgType = key & msg.k.encType = SK) then
        flag1 := true;
      endif;
      flag := flag1;
  end;

---spat8: sk(A) 
procedure constructSpat8(ASk:AgentType; Var num: indexType);
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
    sPat8Set.length := sPat8Set.length + 1;
    sPat8Set.content[sPat8Set.length] := index;
    num := index;
  end;

---pat9: sign(start.ue1.ausf.certC,sk(A)) 
procedure lookAddPat9(start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; ASk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat7(start, ue1, ausf, certC,msg1,i1);
   lookAddPat8(ASk,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = sign) then
       if (msgs[i].signMsg = i1 & msgs[i].signKey = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := sign;
     msgs[index].signMsg := i1; 
     msgs[index].signKey := i2;     
          msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat9: sign(start.ue1.ausf.certC,sk(A)) 
procedure isPat9(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = sign) then
      isPat7(msgs[msg.signMsg],flagPart1);
      isPat8(msgs[msg.signKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat9: sign(start.ue1.ausf.certC,sk(A)) 
procedure constructSpat9(start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; ASk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat7(start, ue1, ausf, certC, i1);
    constructSpat8(ASk, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = sign) then
        if (msgs[i].signMsg = i1 & msgs[i].signKey = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := sign;
      msgs[index].signMsg := i1; 
      msgs[index].signKey := i2; 
      msgs[index].length := 1;
    endif;
    sPat9Set.length := sPat9Set.length + 1;
    sPat9Set.content[sPat9Set.length] := index;
    num := index;
  end;

---pat10: hash(ue1.ausf.prekey) 
procedure lookAddPat10(ue1:NonceType; ausf:NonceType; prekey:NonceType; Var msg:Message; Var num : indexType);
  Var msg1: Message;
      index,i1:indexType;
  begin
   index:=0;
   lookAddPat5(ue1, ausf, prekey,msg1,i1);
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

---pat10: hash(ue1.ausf.prekey) 
procedure isPat10(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    if (msg.msgType = hash) then
      isPat5(msgs[msg.hashMsg],flagPart1);
      if (flagPart1) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat10: hash(ue1.ausf.prekey) 
procedure constructSpat10(ue1:NonceType; ausf:NonceType; prekey:NonceType; Var num: indexType);
  Var i,index,i1:indexType;
  begin
    index:=0;
    constructSpat5(ue1, ausf, prekey, i1);
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
    sPat10Set.length := sPat10Set.length + 1;
    sPat10Set.content[sPat10Set.length] := index;
    num := index;
  end;

---pat11: senc{start.ue1.ausf.certC}hash(ue1.ausf.prekey) 
procedure lookAddPat11(start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; prekey:NonceType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat7(start, ue1, ausf, certC,msg1,i1);
   lookAddPat10(ue1, ausf, prekey,msg2,i2);
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
    msgs[i2].k.encType := MsgK;
     msgs[i2].k.m := i2;

     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat11: senc{start.ue1.ausf.certC}hash(ue1.ausf.prekey) 
procedure isPat11(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = senc then
      isPat7(msgs[msg.sencMsg],flagPart1);
      isPat10(msgs[msg.sencKey],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat11: senc{start.ue1.ausf.certC}hash(ue1.ausf.prekey) 
procedure constructSpat11(start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; prekey:NonceType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat7(start, ue1, ausf, certC, i1);
    constructSpat10(ue1, ausf, prekey, i2);
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
    sPat11Set.length := sPat11Set.length + 1;
    sPat11Set.content[sPat11Set.length] := index;
    num := index;
  end;

---pat12: aenc{prekey}pk(C).certA.sign(start.ue1.ausf.certC,sk(A)).senc{start.ue1.ausf.certC}hash(ue1.ausf.prekey) 
procedure lookAddPat12(prekey:NonceType; CPk:AgentType; certA:NonceType; start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; ASk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3,msg4: Message;
     index,i1,i2,i3,i4:indexType;
  begin
   index:=0;
   lookAddPat6(prekey, CPk, msg1, i1);
   lookAddPat1(certA, msg2, i2);
   lookAddPat9(start, ue1, ausf, certC, ASk, msg3, i3);
   lookAddPat11(start, ue1, ausf, certC, prekey, msg4, i4);
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

---pat12: aenc{prekey}pk(C).certA.sign(start.ue1.ausf.certC,sk(A)).senc{start.ue1.ausf.certC}hash(ue1.ausf.prekey) 
procedure isPat12(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3,flagPart4: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     flagPart4 := false;
     if(msg.msgType = concat) then
        isPat6(msgs[msg.concatPart[1]],flagPart1);
        isPat1(msgs[msg.concatPart[2]],flagPart2);
        isPat9(msgs[msg.concatPart[3]],flagPart3);
        isPat11(msgs[msg.concatPart[4]],flagPart4);
       if (flagPart1 & flagPart2 & flagPart3 & flagPart4) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat12: aenc{prekey}pk(C).certA.sign(start.ue1.ausf.certC,sk(A)).senc{start.ue1.ausf.certC}hash(ue1.ausf.prekey) 
procedure constructSpat12(prekey:NonceType; CPk:AgentType; certA:NonceType; start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; ASk:AgentType; Var num: indexType);
  Var i,index, i1, i2, i3, i4:indexType;
  begin
    index:=0;
    constructSpat6(prekey, CPk, i1);
    constructSpat1(certA, i2);
    constructSpat9(start, ue1, ausf, certC, ASk, i3);
    constructSpat11(start, ue1, ausf, certC, prekey, i4);
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
    sPat12Set.length := sPat12Set.length + 1;
    sPat12Set.content[sPat12Set.length] := index;
    num := index;
  end;

---pat13: x10 
procedure lookAddPat13(x10:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[x10.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat13: x10 
procedure isPat13(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat13: x10 
procedure constructSpat13(x10:Message; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = tmp) then
        if (msgs[i].tmpPart = x10.tmpPart) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := tmp;
      msgs[index].tmpPart := x10.tmpPart;
      msgs[index].length := 1;
    endif;
    sPat13Set.length := sPat13Set.length + 1;
    sPat13Set.content[sPat13Set.length] := index;
    num := index;
  end;

---pat14: m1 
procedure lookAddPat14(m1:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[m1.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat14: m1 
procedure isPat14(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat14: m1 
procedure constructSpat14(m1:Message; Var num: indexType);
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
    sPat14Set.length := sPat14Set.length + 1;
    sPat14Set.content[sPat14Set.length] := index;
    num := index;
  end;

---pat15: m1.seafn 
procedure lookAddPat15(m1:Message; seafn:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat14(m1, msg1, i1);
   lookAddPat1(seafn, msg2, i2);
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

---pat15: m1.seafn 
procedure isPat15(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat14(msgs[msg.concatPart[1]],flagPart1);
        isPat1(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat15: m1.seafn 
procedure constructSpat15(m1:Message; seafn:NonceType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat14(m1, i1);
    constructSpat1(seafn, i2);
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

---pat16: x2 
procedure lookAddPat16(x2:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[x2.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat16: x2 
procedure isPat16(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat16: x2 
procedure constructSpat16(x2:Message; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = tmp) then
        if (msgs[i].tmpPart = x2.tmpPart) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := tmp;
      msgs[index].tmpPart := x2.tmpPart;
      msgs[index].length := 1;
    endif;
    sPat16Set.length := sPat16Set.length + 1;
    sPat16Set.content[sPat16Set.length] := index;
    num := index;
  end;

---pat17: x2.seafn 
procedure lookAddPat17(x2:Message; seafn:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat16(x2, msg1, i1);
   lookAddPat1(seafn, msg2, i2);
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

---pat17: x2.seafn 
procedure isPat17(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat16(msgs[msg.concatPart[1]],flagPart1);
        isPat1(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat17: x2.seafn 
procedure constructSpat17(x2:Message; seafn:NonceType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat16(x2, i1);
    constructSpat1(seafn, i2);
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
    sPat17Set.length := sPat17Set.length + 1;
    sPat17Set.content[sPat17Set.length] := index;
    num := index;
  end;

---pat18: x3 
procedure lookAddPat18(x3:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[x3.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat18: x3 
procedure isPat18(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat18: x3 
procedure constructSpat18(x3:Message; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = tmp) then
        if (msgs[i].tmpPart = x3.tmpPart) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := tmp;
      msgs[index].tmpPart := x3.tmpPart;
      msgs[index].length := 1;
    endif;
    sPat18Set.length := sPat18Set.length + 1;
    sPat18Set.content[sPat18Set.length] := index;
    num := index;
  end;

---pat19: x3.seafn 
procedure lookAddPat19(x3:Message; seafn:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat18(x3, msg1, i1);
   lookAddPat1(seafn, msg2, i2);
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

---pat19: x3.seafn 
procedure isPat19(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat18(msgs[msg.concatPart[1]],flagPart1);
        isPat1(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat19: x3.seafn 
procedure constructSpat19(x3:Message; seafn:NonceType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat18(x3, i1);
    constructSpat1(seafn, i2);
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
    sPat19Set.length := sPat19Set.length + 1;
    sPat19Set.content[sPat19Set.length] := index;
    num := index;
  end;

---pat20: m1.seafn.ausfn 
procedure lookAddPat20(m1:Message; seafn:NonceType; ausfn:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3: Message;
     index,i1,i2,i3:indexType;
  begin
   index:=0;
   lookAddPat14(m1, msg1, i1);
   lookAddPat1(seafn, msg2, i2);
   lookAddPat1(ausfn, msg3, i3);
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

---pat20: m1.seafn.ausfn 
procedure isPat20(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     if(msg.msgType = concat) then
        isPat14(msgs[msg.concatPart[1]],flagPart1);
        isPat1(msgs[msg.concatPart[2]],flagPart2);
        isPat1(msgs[msg.concatPart[3]],flagPart3);
       if (flagPart1 & flagPart2 & flagPart3) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat20: m1.seafn.ausfn 
procedure constructSpat20(m1:Message; seafn:NonceType; ausfn:NonceType; Var num: indexType);
  Var i,index, i1, i2, i3:indexType;
  begin
    index:=0;
    constructSpat14(m1, i1);
    constructSpat1(seafn, i2);
    constructSpat1(ausfn, i3);
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
    sPat20Set.length := sPat20Set.length + 1;
    sPat20Set.content[sPat20Set.length] := index;
    num := index;
  end;

---pat21: x1 
procedure lookAddPat21(x1:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[x1.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat21: x1 
procedure isPat21(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat21: x1 
procedure constructSpat21(x1:Message; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = tmp) then
        if (msgs[i].tmpPart = x1.tmpPart) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := tmp;
      msgs[index].tmpPart := x1.tmpPart;
      msgs[index].length := 1;
    endif;
    sPat21Set.length := sPat21Set.length + 1;
    sPat21Set.content[sPat21Set.length] := index;
    num := index;
  end;

---pat22: x1.seafn.ausfn 
procedure lookAddPat22(x1:Message; seafn:NonceType; ausfn:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3: Message;
     index,i1,i2,i3:indexType;
  begin
   index:=0;
   lookAddPat21(x1, msg1, i1);
   lookAddPat1(seafn, msg2, i2);
   lookAddPat1(ausfn, msg3, i3);
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

---pat22: x1.seafn.ausfn 
procedure isPat22(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2,flagPart3: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     flagPart3 := false;
     if(msg.msgType = concat) then
        isPat21(msgs[msg.concatPart[1]],flagPart1);
        isPat1(msgs[msg.concatPart[2]],flagPart2);
        isPat1(msgs[msg.concatPart[3]],flagPart3);
       if (flagPart1 & flagPart2 & flagPart3) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat22: x1.seafn.ausfn 
procedure constructSpat22(x1:Message; seafn:NonceType; ausfn:NonceType; Var num: indexType);
  Var i,index, i1, i2, i3:indexType;
  begin
    index:=0;
    constructSpat21(x1, i1);
    constructSpat1(seafn, i2);
    constructSpat1(ausfn, i3);
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
procedure cons2(supi:NonceType; ue:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat2(supi, ue,msg,num);
  end;
procedure destruct2(msg:Message; Var supi:NonceType; Var ue:NonceType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    supi := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    ue := msgNum2.noncePart
  end;
procedure cons3(DPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat3(DPk,msg,num);
  end;
procedure cons4(supi:NonceType; ue:NonceType; DPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat4(supi, ue, DPk,msg,num);
  end;
procedure destruct4(msg:Message; Var supi:NonceType; Var ue:NonceType; Var DPk:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    DPk := k1.ag;    aencMsg:=msgs[msg.aencMsg];
    destruct2(aencMsg,supi, ue);
  end;
procedure cons5(ausf:NonceType; certC:NonceType; seafn:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat5(ausf, certC, seafn,msg,num);
  end;
procedure destruct5(msg:Message; Var ausf:NonceType; Var certC:NonceType; Var seafn:NonceType);
  Var msgNum1,msgNum2,msgNum3: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    ausf := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    certC := msgNum2.noncePart;
    msgNum3 := msgs[msg.concatPart[3]];
    seafn := msgNum3.noncePart
  end;
procedure cons6(prekey:NonceType; CPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat6(prekey, CPk,msg,num);
  end;
procedure destruct6(msg:Message; Var prekey:NonceType; Var CPk:AgentType);
  var k1:KeyType;
  var msgKey:Message;
      msg1:Message;
   begin
    clear msg1;
    msgKey := msgs[msg.aencKey];
    k1 := msgs[msg.aencKey].k;
    CPk := k1.ag;
    msg1:=msgs[msg.aencMsg];
    prekey:=msg1.noncePart;
   end;
procedure cons7(start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat7(start, ue1, ausf, certC,msg,num);
  end;
procedure destruct7(msg:Message; Var start:NonceType; Var ue1:NonceType; Var ausf:NonceType; Var certC:NonceType);
  Var msgNum1,msgNum2,msgNum3,msgNum4: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    start := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    ue1 := msgNum2.noncePart;
    msgNum3 := msgs[msg.concatPart[3]];
    ausf := msgNum3.noncePart;
    msgNum4 := msgs[msg.concatPart[4]];
    certC := msgNum4.noncePart
  end;
procedure cons8(ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat8(ASk,msg,num);
  end;
procedure cons9(start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat9(start, ue1, ausf, certC, ASk,msg,num);
  end;
procedure destruct9(msg:Message; Var start:NonceType; Var ue1:NonceType; Var ausf:NonceType; Var certC:NonceType; Var ASk:AgentType);
  var k1:KeyType;
      signMsg:Message;
      begin
    clear signMsg;
    k1:=msgs[msg.signKey].k;
    ASk := k1.ag;
    signMsg:=msgs[msg.signMsg];
    destruct7(signMsg,start, ue1, ausf, certC);
  end;
procedure cons10(ue1:NonceType; ausf:NonceType; prekey:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat10(ue1, ausf, prekey,msg,num);
  end;
procedure destruct10(msg:Message; Var ue1:NonceType; Var ausf:NonceType; Var prekey:NonceType);
  var msgNo:indexType;
  hashMsg:Message;
  begin
    hashMsg:=msgs[msg.hashMsg];
    destruct5(hashMsg,ue1, ausf, prekey);
  end;
procedure cons11(start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; prekey:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat11(start, ue1, ausf, certC, prekey,msg,num);
  end;
procedure destruct11(msg:Message; Var start:NonceType; Var ue1:NonceType; Var ausf:NonceType; Var certC:NonceType; Var prekey:NonceType);
  var k1:KeyType;
      sencMsg:Message;
      sencKey:Message;
      begin
       sencMsg:=msgs[msg.sencMsg];
       sencKey:=msgs[msg.sencKey];
       destruct7(sencMsg,start, ue1, ausf, certC);
       destruct10(sencKey,ue1, ausf, prekey);
  end;
procedure cons12(prekey:NonceType; CPk:AgentType; certA:NonceType; start:NonceType; ue1:NonceType; ausf:NonceType; certC:NonceType; ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat12(prekey, CPk, certA, start, ue1, ausf, certC, ASk,msg,num);
  end;
procedure destruct12(msg:Message; Var prekey:NonceType; Var CPk:AgentType; Var certA:NonceType; Var start:NonceType; Var ue1:NonceType; Var ausf:NonceType; Var certC:NonceType; Var ASk:AgentType);
  Var msgNum1,msgNum2,msgNum3,msgNum4: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    destruct6(msgNum1,prekey, CPk);
    msgNum2 := msgs[msg.concatPart[2]];
    certA := msgNum2.noncePart;
    msgNum3 := msgs[msg.concatPart[3]];
    destruct9(msgNum3,start, ue1, ausf, certC, ASk);
    msgNum4 := msgs[msg.concatPart[4]];
    destruct11(msgNum4,start, ue1, ausf, certC, prekey)
  end;
procedure cons13(x10:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat13(x10,msg,num);
  end;
procedure destruct13(msg:Message; Var x10:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    x10:=msg;
    x10.tmpPart:=msgNo;
  end;
procedure cons14(m1:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat14(m1,msg,num);
  end;
procedure destruct14(msg:Message; Var m1:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    m1:=msg;
    m1.tmpPart:=msgNo;
  end;
procedure cons15(m1:Message; seafn:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat15(m1, seafn,msg,num);
  end;
procedure destruct15(msg:Message; Var m1:Message; Var seafn:NonceType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    m1.msgType := tmp;
    m1.tmpPart := msg.concatPart[1];
    msgNum2 := msgs[msg.concatPart[2]];
    seafn := msgNum2.noncePart
  end;
procedure cons16(x2:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat16(x2,msg,num);
  end;
procedure destruct16(msg:Message; Var x2:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    x2:=msg;
    x2.tmpPart:=msgNo;
  end;
procedure cons17(x2:Message; seafn:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat17(x2, seafn,msg,num);
  end;
procedure destruct17(msg:Message; Var x2:Message; Var seafn:NonceType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    x2.msgType := tmp;
    x2.tmpPart := msg.concatPart[1];
    msgNum2 := msgs[msg.concatPart[2]];
    seafn := msgNum2.noncePart
  end;
procedure cons18(x3:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat18(x3,msg,num);
  end;
procedure destruct18(msg:Message; Var x3:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    x3:=msg;
    x3.tmpPart:=msgNo;
  end;
procedure cons19(x3:Message; seafn:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat19(x3, seafn,msg,num);
  end;
procedure destruct19(msg:Message; Var x3:Message; Var seafn:NonceType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    x3.msgType := tmp;
    x3.tmpPart := msg.concatPart[1];
    msgNum2 := msgs[msg.concatPart[2]];
    seafn := msgNum2.noncePart
  end;
procedure cons20(m1:Message; seafn:NonceType; ausfn:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat20(m1, seafn, ausfn,msg,num);
  end;
procedure destruct20(msg:Message; Var m1:Message; Var seafn:NonceType; Var ausfn:NonceType);
  Var msgNum1,msgNum2,msgNum3: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    m1.msgType := tmp;
    m1.tmpPart := msg.concatPart[1];
    msgNum2 := msgs[msg.concatPart[2]];
    seafn := msgNum2.noncePart;
    msgNum3 := msgs[msg.concatPart[3]];
    ausfn := msgNum3.noncePart
  end;
procedure cons21(x1:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat21(x1,msg,num);
  end;
procedure destruct21(msg:Message; Var x1:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    x1:=msg;
    x1.tmpPart:=msgNo;
  end;
procedure cons22(x1:Message; seafn:NonceType; ausfn:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat22(x1, seafn, ausfn,msg,num);
  end;
procedure destruct22(msg:Message; Var x1:Message; Var seafn:NonceType; Var ausfn:NonceType);
  Var msgNum1,msgNum2,msgNum3: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    x1.msgType := tmp;
    x1.tmpPart := msg.concatPart[1];
    msgNum2 := msgs[msg.concatPart[2]];
    seafn := msgNum2.noncePart;
    msgNum3 := msgs[msg.concatPart[3]];
    ausfn := msgNum3.noncePart
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
   cons4(roleA[i].supi,roleA[i].ue,roleA[i].D,msg,msgNo);
   ch[1].empty := false;
   ch[1].msg := msg;
   ch[1].sender := roleA[i].A;
   ch[1].receiver := Intruder;
   roleA[i].st := A2;
   put "roleA[i] in st1\n";
end;
rule " roleA2 "
roleA[i].st = A2 & ch[6].empty = false & !roleA[i].commit & judge(ch[6].msg,roleA[i].A,msgs[0]) 
==>
var flag_pat2:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[6].msg;
   isPat2(msg, flag_pat2);
   if(flag_pat2) then
     destruct2(msg,roleA[i].locstart,roleA[i].locseafn);
     if(matchNonce(roleA[i].locstart, roleA[i].start) & matchNonce(roleA[i].locseafn, roleA[i].seafn))then
       ch[6].empty:=true;
       clear ch[6].msg;
       roleA[i].st := A3;
     endif;
   endif;
   put "roleA[i] in st2\n";
end;
rule " roleA3 "
roleA[i].st = A3 & ch[7].empty = true & !roleA[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons1(roleA[i].ue1,msg,msgNo);
   ch[7].empty := false;
   ch[7].msg := msg;
   ch[7].sender := roleA[i].A;
   ch[7].receiver := Intruder;
   roleA[i].st := A4;
   put "roleA[i] in st3\n";
end;
rule " roleA4 "
roleA[i].st = A4 & ch[10].empty = false & !roleA[i].commit & judge(ch[10].msg,roleA[i].A,msgs[0]) 
==>
var flag_pat5:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[10].msg;
   isPat5(msg, flag_pat5);
   if(flag_pat5) then
     destruct5(msg,roleA[i].locausf,roleA[i].loccertC,roleA[i].locseafn);
     if(matchNonce(roleA[i].locausf, roleA[i].ausf) & matchNonce(roleA[i].loccertC, roleA[i].certC) & matchNonce(roleA[i].locseafn, roleA[i].seafn))then
       ch[10].empty:=true;
       clear ch[10].msg;
       roleA[i].st := A5;
     endif;
   endif;
   put "roleA[i] in st4\n";
end;
rule " roleA5 "
roleA[i].st = A5 & ch[11].empty = true & !roleA[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons12(roleA[i].prekey,roleA[i].C,roleA[i].certA,roleA[i].start,roleA[i].ue1,roleA[i].ausf,roleA[i].certC,roleA[i].A,msg,msgNo);
   ch[11].empty := false;
   ch[11].msg := msg;
   ch[11].sender := roleA[i].A;
   ch[11].receiver := Intruder;
   roleA[i].st := A6;
   put "roleA[i] in st5\n";
end;
rule " roleA6 "
roleA[i].st = A6 & ch[14].empty = false & !roleA[i].commit & judge(ch[14].msg,roleA[i].A,roleA[i].x10) 
==>
var flag_pat13:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[14].msg;
   isPat13(msg, flag_pat13);
   if(flag_pat13) then
     destruct13(msg,roleA[i].locx10);
     if(matchTmp(roleA[i].locx10, roleA[i].x10))then
       ch[14].empty:=true;
       clear ch[14].msg;
       roleA[i].st := A7;
     endif;
   endif;
   put "roleA[i] in st6\n";
end;
rule " roleA7 "
roleA[i].st = A7 & ch[15].empty = true & !roleA[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons1(roleA[i].eapm,msg,msgNo);
   ch[15].empty := false;
   ch[15].msg := msg;
   ch[15].sender := roleA[i].A;
   ch[15].receiver := Intruder;
   roleA[i].st := A8;
   put "roleA[i] in st7\n";
end;
rule " roleA8 "
roleA[i].st = A8 & ch[18].empty = false & !roleA[i].commit & judge(ch[18].msg,roleA[i].A,msgs[0]) 
==>
var flag_pat1:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[18].msg;
   isPat1(msg, flag_pat1);
   if(flag_pat1) then
     destruct1(msg,roleA[i].locsucm);
     if(matchNonce(roleA[i].locsucm, roleA[i].sucm))then
       ch[18].empty:=true;
       clear ch[18].msg;
       roleA[i].st := A1;
     endif;
   endif;
   put "roleA[i] in st8\n";
   roleA[i].commit := true;
end;
endruleset;

ruleset i:roleBNums do
rule " roleB1 "
roleB[i].st = B1 & ch[1].empty = false & !roleB[i].commit & judge(ch[1].msg,roleB[i].B,roleB[i].m1) 
==>
var flag_pat14:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[1].msg;
   isPat14(msg, flag_pat14);
   if(flag_pat14) then
     destruct14(msg,roleB[i].locm1);
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
   cons15(roleB[i].m1,roleB[i].seafn,msg,msgNo);
   ch[2].empty := false;
   ch[2].msg := msg;
   ch[2].sender := roleB[i].B;
   ch[2].receiver := Intruder;
   roleB[i].st := B3;
   put "roleB[i] in st2\n";
end;
rule " roleB3 "
roleB[i].st = B3 & ch[5].empty = false & !roleB[i].commit & judge(ch[5].msg,roleB[i].B,roleB[i].x2) 
==>
var flag_pat16:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[5].msg;
   isPat16(msg, flag_pat16);
   if(flag_pat16) then
     destruct16(msg,roleB[i].locx2);
     if(matchTmp(roleB[i].locx2, roleB[i].x2))then
       ch[5].empty:=true;
       clear ch[5].msg;
       roleB[i].st := B4;
     endif;
   endif;
   put "roleB[i] in st3\n";
end;
rule " roleB4 "
roleB[i].st = B4 & ch[6].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons17(roleB[i].x2,roleB[i].seafn,msg,msgNo);
   ch[6].empty := false;
   ch[6].msg := msg;
   ch[6].sender := roleB[i].B;
   ch[6].receiver := Intruder;
   roleB[i].st := B5;
   put "roleB[i] in st4\n";
end;
rule " roleB5 "
roleB[i].st = B5 & ch[7].empty = false & !roleB[i].commit & judge(ch[7].msg,roleB[i].B,roleB[i].x3) 
==>
var flag_pat18:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[7].msg;
   isPat18(msg, flag_pat18);
   if(flag_pat18) then
     destruct18(msg,roleB[i].locx3);
     if(matchTmp(roleB[i].locx3, roleB[i].x3))then
       ch[7].empty:=true;
       clear ch[7].msg;
       roleB[i].st := B6;
     endif;
   endif;
   put "roleB[i] in st5\n";
end;
rule " roleB6 "
roleB[i].st = B6 & ch[8].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons19(roleB[i].x3,roleB[i].seafn,msg,msgNo);
   ch[8].empty := false;
   ch[8].msg := msg;
   ch[8].sender := roleB[i].B;
   ch[8].receiver := Intruder;
   roleB[i].st := B7;
   put "roleB[i] in st6\n";
end;
rule " roleB7 "
roleB[i].st = B7 & ch[9].empty = false & !roleB[i].commit & judge(ch[9].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat5:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[9].msg;
   isPat5(msg, flag_pat5);
   if(flag_pat5) then
     destruct5(msg,roleB[i].locausf,roleB[i].loccertC,roleB[i].locausfn);
     if(matchNonce(roleB[i].locausf, roleB[i].ausf) & matchNonce(roleB[i].loccertC, roleB[i].certC) & matchNonce(roleB[i].locausfn, roleB[i].ausfn))then
       ch[9].empty:=true;
       clear ch[9].msg;
       roleB[i].st := B8;
     endif;
   endif;
   put "roleB[i] in st7\n";
end;
rule " roleB8 "
roleB[i].st = B8 & ch[10].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons5(roleB[i].ausf,roleB[i].certC,roleB[i].seafn,msg,msgNo);
   ch[10].empty := false;
   ch[10].msg := msg;
   ch[10].sender := roleB[i].B;
   ch[10].receiver := Intruder;
   roleB[i].st := B9;
   put "roleB[i] in st8\n";
end;
rule " roleB9 "
roleB[i].st = B9 & ch[11].empty = false & !roleB[i].commit & judge(ch[11].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat12:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[11].msg;
   isPat12(msg, flag_pat12);
   if(flag_pat12) then
     destruct12(msg,roleB[i].locprekey,roleB[i].locC,roleB[i].loccertA,roleB[i].locstart,roleB[i].locue1,roleB[i].locausf,roleB[i].loccertC,roleB[i].locA);
     if(matchNonce(roleB[i].locprekey, roleB[i].prekey) & matchAgent(roleB[i].locC, roleB[i].C) & matchNonce(roleB[i].loccertA, roleB[i].certA) & matchNonce(roleB[i].locstart, roleB[i].start) & matchNonce(roleB[i].locue1, roleB[i].ue1) & matchNonce(roleB[i].locausf, roleB[i].ausf) & matchNonce(roleB[i].loccertC, roleB[i].certC) & matchAgent(roleB[i].locA, roleB[i].A))then
       ch[11].empty:=true;
       clear ch[11].msg;
       roleB[i].st := B10;
     endif;
   endif;
   put "roleB[i] in st9\n";
end;
rule " roleB10 "
roleB[i].st = B10 & ch[12].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons12(roleB[i].prekey,roleB[i].C,roleB[i].certA,roleB[i].start,roleB[i].ue1,roleB[i].ausf,roleB[i].certC,roleB[i].A,msg,msgNo);
   ch[12].empty := false;
   ch[12].msg := msg;
   ch[12].sender := roleB[i].B;
   ch[12].receiver := Intruder;
   roleB[i].st := B11;
   put "roleB[i] in st10\n";
end;
rule " roleB11 "
roleB[i].st = B11 & ch[13].empty = false & !roleB[i].commit & judge(ch[13].msg,roleB[i].B,roleB[i].x10) 
==>
var flag_pat13:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[13].msg;
   isPat13(msg, flag_pat13);
   if(flag_pat13) then
     destruct13(msg,roleB[i].locx10);
     if(matchTmp(roleB[i].locx10, roleB[i].x10))then
       ch[13].empty:=true;
       clear ch[13].msg;
       roleB[i].st := B12;
     endif;
   endif;
   put "roleB[i] in st11\n";
end;
rule " roleB12 "
roleB[i].st = B12 & ch[14].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons13(roleB[i].x10,msg,msgNo);
   ch[14].empty := false;
   ch[14].msg := msg;
   ch[14].sender := roleB[i].B;
   ch[14].receiver := Intruder;
   roleB[i].st := B13;
   put "roleB[i] in st12\n";
end;
rule " roleB13 "
roleB[i].st = B13 & ch[15].empty = false & !roleB[i].commit & judge(ch[15].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat1:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[15].msg;
   isPat1(msg, flag_pat1);
   if(flag_pat1) then
     destruct1(msg,roleB[i].loceapm);
     if(matchNonce(roleB[i].loceapm, roleB[i].eapm))then
       ch[15].empty:=true;
       clear ch[15].msg;
       roleB[i].st := B14;
     endif;
   endif;
   put "roleB[i] in st13\n";
end;
rule " roleB14 "
roleB[i].st = B14 & ch[16].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons1(roleB[i].eapm,msg,msgNo);
   ch[16].empty := false;
   ch[16].msg := msg;
   ch[16].sender := roleB[i].B;
   ch[16].receiver := Intruder;
   roleB[i].st := B15;
   put "roleB[i] in st14\n";
end;
rule " roleB15 "
roleB[i].st = B15 & ch[17].empty = false & !roleB[i].commit & judge(ch[17].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat1:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[17].msg;
   isPat1(msg, flag_pat1);
   if(flag_pat1) then
     destruct1(msg,roleB[i].locsucm);
     if(matchNonce(roleB[i].locsucm, roleB[i].sucm))then
       ch[17].empty:=true;
       clear ch[17].msg;
       roleB[i].st := B16;
     endif;
   endif;
   put "roleB[i] in st15\n";
end;
rule " roleB16 "
roleB[i].st = B16 & ch[18].empty = true & !roleB[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons1(roleB[i].sucm,msg,msgNo);
   ch[18].empty := false;
   ch[18].msg := msg;
   ch[18].sender := roleB[i].B;
   ch[18].receiver := Intruder;
   roleB[i].st := B1;
   put "roleB[i] in st16\n";
   roleB[i].commit := true;
end;
endruleset;

ruleset i:roleCNums do
rule " roleC1 "
roleC[i].st = C1 & ch[2].empty = false & !roleC[i].commit & judge(ch[2].msg,roleC[i].C,msgs[0]) 
==>
var flag_pat15:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[2].msg;
   isPat15(msg, flag_pat15);
   if(flag_pat15) then
     destruct15(msg,roleC[i].locm1,roleC[i].locseafn);
     if(matchTmp(roleC[i].locm1, roleC[i].m1) & matchNonce(roleC[i].locseafn, roleC[i].seafn))then
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
   cons20(roleC[i].m1,roleC[i].seafn,roleC[i].ausfn,msg,msgNo);
   ch[3].empty := false;
   ch[3].msg := msg;
   ch[3].sender := roleC[i].C;
   ch[3].receiver := Intruder;
   roleC[i].st := C3;
   put "roleC[i] in st2\n";
end;
rule " roleC3 "
roleC[i].st = C3 & ch[4].empty = false & !roleC[i].commit & judge(ch[4].msg,roleC[i].C,msgs[0]) 
==>
var flag_pat1:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[4].msg;
   isPat1(msg, flag_pat1);
   if(flag_pat1) then
     destruct1(msg,roleC[i].locstart);
     if(matchNonce(roleC[i].locstart, roleC[i].start))then
       ch[4].empty:=true;
       clear ch[4].msg;
       roleC[i].st := C4;
     endif;
   endif;
   put "roleC[i] in st3\n";
end;
rule " roleC4 "
roleC[i].st = C4 & ch[5].empty = true & !roleC[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons1(roleC[i].start,msg,msgNo);
   ch[5].empty := false;
   ch[5].msg := msg;
   ch[5].sender := roleC[i].C;
   ch[5].receiver := Intruder;
   roleC[i].st := C5;
   put "roleC[i] in st4\n";
end;
rule " roleC5 "
roleC[i].st = C5 & ch[8].empty = false & !roleC[i].commit & judge(ch[8].msg,roleC[i].C,msgs[0]) 
==>
var flag_pat2:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[8].msg;
   isPat2(msg, flag_pat2);
   if(flag_pat2) then
     destruct2(msg,roleC[i].locue1,roleC[i].locseafn);
     if(matchNonce(roleC[i].locue1, roleC[i].ue1) & matchNonce(roleC[i].locseafn, roleC[i].seafn))then
       ch[8].empty:=true;
       clear ch[8].msg;
       roleC[i].st := C6;
     endif;
   endif;
   put "roleC[i] in st5\n";
end;
rule " roleC6 "
roleC[i].st = C6 & ch[9].empty = true & !roleC[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons5(roleC[i].ausf,roleC[i].certC,roleC[i].ausfn,msg,msgNo);
   ch[9].empty := false;
   ch[9].msg := msg;
   ch[9].sender := roleC[i].C;
   ch[9].receiver := Intruder;
   roleC[i].st := C7;
   put "roleC[i] in st6\n";
end;
rule " roleC7 "
roleC[i].st = C7 & ch[12].empty = false & !roleC[i].commit & judge(ch[12].msg,roleC[i].C,msgs[0]) 
==>
var flag_pat12:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[12].msg;
   isPat12(msg, flag_pat12);
   if(flag_pat12) then
     destruct12(msg,roleC[i].locprekey,roleC[i].locC,roleC[i].loccertA,roleC[i].locstart,roleC[i].locue1,roleC[i].locausf,roleC[i].loccertC,roleC[i].locA);
     if(matchNonce(roleC[i].locprekey, roleC[i].prekey) & matchAgent(roleC[i].locC, roleC[i].C) & matchNonce(roleC[i].loccertA, roleC[i].certA) & matchNonce(roleC[i].locstart, roleC[i].start) & matchNonce(roleC[i].locue1, roleC[i].ue1) & matchNonce(roleC[i].locausf, roleC[i].ausf) & matchNonce(roleC[i].loccertC, roleC[i].certC) & matchAgent(roleC[i].locA, roleC[i].A))then
       ch[12].empty:=true;
       clear ch[12].msg;
       roleC[i].st := C8;
     endif;
   endif;
   put "roleC[i] in st7\n";
end;
rule " roleC8 "
roleC[i].st = C8 & ch[13].empty = true & !roleC[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons11(roleC[i].start,roleC[i].ue1,roleC[i].ausf,roleC[i].certC,roleC[i].prekey,msg,msgNo);
   ch[13].empty := false;
   ch[13].msg := msg;
   ch[13].sender := roleC[i].C;
   ch[13].receiver := Intruder;
   roleC[i].st := C9;
   put "roleC[i] in st8\n";
end;
rule " roleC9 "
roleC[i].st = C9 & ch[16].empty = false & !roleC[i].commit & judge(ch[16].msg,roleC[i].C,msgs[0]) 
==>
var flag_pat1:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[16].msg;
   isPat1(msg, flag_pat1);
   if(flag_pat1) then
     destruct1(msg,roleC[i].loceapm);
     if(matchNonce(roleC[i].loceapm, roleC[i].eapm))then
       ch[16].empty:=true;
       clear ch[16].msg;
       roleC[i].st := C10;
     endif;
   endif;
   put "roleC[i] in st9\n";
end;
rule " roleC10 "
roleC[i].st = C10 & ch[17].empty = true & !roleC[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons1(roleC[i].sucm,msg,msgNo);
   ch[17].empty := false;
   ch[17].msg := msg;
   ch[17].sender := roleC[i].C;
   ch[17].receiver := Intruder;
   roleC[i].st := C1;
   put "roleC[i] in st10\n";
   roleC[i].commit := true;
end;
endruleset;

ruleset i:roleDNums do
rule " roleD1 "
roleD[i].st = D1 & ch[3].empty = false & !roleD[i].commit & judge(ch[3].msg,roleD[i].D,msgs[0]) 
==>
var flag_pat22:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[3].msg;
   isPat22(msg, flag_pat22);
   if(flag_pat22) then
     destruct22(msg,roleD[i].locx1,roleD[i].locseafn,roleD[i].locausfn);
     if(matchTmp(roleD[i].locx1, roleD[i].x1) & matchNonce(roleD[i].locseafn, roleD[i].seafn) & matchNonce(roleD[i].locausfn, roleD[i].ausfn))then
       ch[3].empty:=true;
       clear ch[3].msg;
       roleD[i].st := D2;
     endif;
   endif;
   put "roleD[i] in st1\n";
end;
rule " roleD2 "
roleD[i].st = D2 & ch[4].empty = true & !roleD[i].commit 
==>
var msg:Message;
    msgNo:indexType;
begin
   clear msg;
   cons1(roleD[i].start,msg,msgNo);
   ch[4].empty := false;
   ch[4].msg := msg;
   ch[4].sender := roleD[i].D;
   ch[4].receiver := Intruder;
   roleD[i].st := D1;
   put "roleD[i] in st2\n";
   roleD[i].commit := true;
end;
endruleset;


---rule of intruder to get msg from ch[1] 
rule "intruderGetMsgFromCh[1]" 
  ch[1].empty = false & ch[1].sender != Intruder ==>
  var flag_pat4:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[1].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat4(msg,flag_pat4);
    if (flag_pat4) then
      if(!exist(pat4Set,msgNo)) then
        pat4Set.length:=pat4Set.length+1;
        pat4Set.content[pat4Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[1].empty := true;
      clear ch[1].msg;
    endif;
    put "intruder get msg from ch[1].\n";
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

---rule of intruder to get msg from ch[11] 
rule "intruderGetMsgFromCh[11]" 
  ch[11].empty = false & ch[11].sender != Intruder ==>
  var flag_pat12:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[11].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat12(msg,flag_pat12);
    if (flag_pat12) then
      if(!exist(pat12Set,msgNo)) then
        pat12Set.length:=pat12Set.length+1;
        pat12Set.content[pat12Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[11].empty := true;
      clear ch[11].msg;
    endif;
    put "intruder get msg from ch[11].\n";
  end;

---rule of intruder to get msg from ch[15] 
rule "intruderGetMsgFromCh[15]" 
  ch[15].empty = false & ch[15].sender != Intruder ==>
  var flag_pat1:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[15].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat1(msg,flag_pat1);
    if (flag_pat1) then
      if(!exist(pat1Set,msgNo)) then
        pat1Set.length:=pat1Set.length+1;
        pat1Set.content[pat1Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[15].empty := true;
      clear ch[15].msg;
    endif;
    put "intruder get msg from ch[15].\n";
  end;

---rule of intruder to get msg from ch[2] 
rule "intruderGetMsgFromCh[2]" 
  ch[2].empty = false & ch[2].sender != Intruder ==>
  var flag_pat15:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[2].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat15(msg,flag_pat15);
    if (flag_pat15) then
      if(!exist(pat15Set,msgNo)) then
        pat15Set.length:=pat15Set.length+1;
        pat15Set.content[pat15Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[2].empty := true;
      clear ch[2].msg;
    endif;
    put "intruder get msg from ch[2].\n";
  end;

---rule of intruder to get msg from ch[6] 
rule "intruderGetMsgFromCh[6]" 
  ch[6].empty = false & ch[6].sender != Intruder ==>
  var flag_pat17:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[6].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat17(msg,flag_pat17);
    if (flag_pat17) then
      if(!exist(pat17Set,msgNo)) then
        pat17Set.length:=pat17Set.length+1;
        pat17Set.content[pat17Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[6].empty := true;
      clear ch[6].msg;
    endif;
    put "intruder get msg from ch[6].\n";
  end;

---rule of intruder to get msg from ch[8] 
rule "intruderGetMsgFromCh[8]" 
  ch[8].empty = false & ch[8].sender != Intruder ==>
  var flag_pat19:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[8].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat19(msg,flag_pat19);
    if (flag_pat19) then
      if(!exist(pat19Set,msgNo)) then
        pat19Set.length:=pat19Set.length+1;
        pat19Set.content[pat19Set.length]:=msgNo;
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
  var flag_pat5:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[10].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat5(msg,flag_pat5);
    if (flag_pat5) then
      if(!exist(pat5Set,msgNo)) then
        pat5Set.length:=pat5Set.length+1;
        pat5Set.content[pat5Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[10].empty := true;
      clear ch[10].msg;
    endif;
    put "intruder get msg from ch[10].\n";
  end;

---rule of intruder to get msg from ch[12] 
rule "intruderGetMsgFromCh[12]" 
  ch[12].empty = false & ch[12].sender != Intruder ==>
  var flag_pat12:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[12].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat12(msg,flag_pat12);
    if (flag_pat12) then
      if(!exist(pat12Set,msgNo)) then
        pat12Set.length:=pat12Set.length+1;
        pat12Set.content[pat12Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[12].empty := true;
      clear ch[12].msg;
    endif;
    put "intruder get msg from ch[12].\n";
  end;

---rule of intruder to get msg from ch[14] 
rule "intruderGetMsgFromCh[14]" 
  ch[14].empty = false & ch[14].sender != Intruder ==>
  var flag_pat13:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[14].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat13(msg,flag_pat13);
    if (flag_pat13) then
      if(!exist(pat13Set,msgNo)) then
        pat13Set.length:=pat13Set.length+1;
        pat13Set.content[pat13Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[14].empty := true;
      clear ch[14].msg;
    endif;
    put "intruder get msg from ch[14].\n";
  end;

---rule of intruder to get msg from ch[16] 
rule "intruderGetMsgFromCh[16]" 
  ch[16].empty = false & ch[16].sender != Intruder ==>
  var flag_pat1:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[16].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat1(msg,flag_pat1);
    if (flag_pat1) then
      if(!exist(pat1Set,msgNo)) then
        pat1Set.length:=pat1Set.length+1;
        pat1Set.content[pat1Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[16].empty := true;
      clear ch[16].msg;
    endif;
    put "intruder get msg from ch[16].\n";
  end;

---rule of intruder to get msg from ch[18] 
rule "intruderGetMsgFromCh[18]" 
  ch[18].empty = false & ch[18].sender != Intruder ==>
  var flag_pat1:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[18].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat1(msg,flag_pat1);
    if (flag_pat1) then
      if(!exist(pat1Set,msgNo)) then
        pat1Set.length:=pat1Set.length+1;
        pat1Set.content[pat1Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[18].empty := true;
      clear ch[18].msg;
    endif;
    put "intruder get msg from ch[18].\n";
  end;

---rule of intruder to get msg from ch[3] 
rule "intruderGetMsgFromCh[3]" 
  ch[3].empty = false & ch[3].sender != Intruder ==>
  var flag_pat20:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[3].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat20(msg,flag_pat20);
    if (flag_pat20) then
      if(!exist(pat20Set,msgNo)) then
        pat20Set.length:=pat20Set.length+1;
        pat20Set.content[pat20Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[3].empty := true;
      clear ch[3].msg;
    endif;
    put "intruder get msg from ch[3].\n";
  end;

---rule of intruder to get msg from ch[5] 
rule "intruderGetMsgFromCh[5]" 
  ch[5].empty = false & ch[5].sender != Intruder ==>
  var flag_pat1:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[5].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat1(msg,flag_pat1);
    if (flag_pat1) then
      if(!exist(pat1Set,msgNo)) then
        pat1Set.length:=pat1Set.length+1;
        pat1Set.content[pat1Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[5].empty := true;
      clear ch[5].msg;
    endif;
    put "intruder get msg from ch[5].\n";
  end;

---rule of intruder to get msg from ch[9] 
rule "intruderGetMsgFromCh[9]" 
  ch[9].empty = false & ch[9].sender != Intruder ==>
  var flag_pat5:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[9].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat5(msg,flag_pat5);
    if (flag_pat5) then
      if(!exist(pat5Set,msgNo)) then
        pat5Set.length:=pat5Set.length+1;
        pat5Set.content[pat5Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[9].empty := true;
      clear ch[9].msg;
    endif;
    put "intruder get msg from ch[9].\n";
  end;

---rule of intruder to get msg from ch[13] 
rule "intruderGetMsgFromCh[13]" 
  ch[13].empty = false & ch[13].sender != Intruder ==>
  var flag_pat11:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[13].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat11(msg,flag_pat11);
    if (flag_pat11) then
      if(!exist(pat11Set,msgNo)) then
        pat11Set.length:=pat11Set.length+1;
        pat11Set.content[pat11Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[13].empty := true;
      clear ch[13].msg;
    endif;
    put "intruder get msg from ch[13].\n";
  end;

---rule of intruder to get msg from ch[17] 
rule "intruderGetMsgFromCh[17]" 
  ch[17].empty = false & ch[17].sender != Intruder ==>
  var flag_pat1:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[17].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat1(msg,flag_pat1);
    if (flag_pat1) then
      if(!exist(pat1Set,msgNo)) then
        pat1Set.length:=pat1Set.length+1;
        pat1Set.content[pat1Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[17].empty := true;
      clear ch[17].msg;
    endif;
    put "intruder get msg from ch[17].\n";
  end;

---rule of intruder to get msg from ch[4] 
rule "intruderGetMsgFromCh[4]" 
  ch[4].empty = false & ch[4].sender != Intruder ==>
  var flag_pat1:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[4].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat1(msg,flag_pat1);
    if (flag_pat1) then
      if(!exist(pat1Set,msgNo)) then
        pat1Set.length:=pat1Set.length+1;
        pat1Set.content[pat1Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[4].empty := true;
      clear ch[4].msg;
    endif;
    put "intruder get msg from ch[4].\n";
  end;

---rule of intruder to emit msg into ch[6].
ruleset i: msgLen do
  ruleset j: roleANums do
    rule "intruderEmitMsgIntoCh[6]"
      IntruEmit5 = true & roleA[j].st = A2 & ch[6].empty=true & i <= pat17Set.length & pat17Set.content[i] != 0 & Spy_known[pat17Set.content[i]] & !emit[pat17Set.content[i]] ---& matchPat(msgs[pat17Set.content[i]], sPat17Set)
      ==>
      begin
         clear ch[6];
        ch[6].msg:=msgs[pat17Set.content[i]];
        ch[6].sender:=Intruder;
        ch[6].receiver:=roleA[j].A;
        ch[6].empty:=false;
        emit[pat17Set.content[i]] := true;
        IntruEmit6 := true;
        put "intruder emit msg into ch[6].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[10].
ruleset i: msgLen do
  ruleset j: roleANums do
    rule "intruderEmitMsgIntoCh[10]"
      IntruEmit9 = true & roleA[j].st = A4 & ch[10].empty=true & i <= pat5Set.length & pat5Set.content[i] != 0 & Spy_known[pat5Set.content[i]] & !emit[pat5Set.content[i]] ---& matchPat(msgs[pat5Set.content[i]], sPat5Set)
      ==>
      begin
         clear ch[10];
        ch[10].msg:=msgs[pat5Set.content[i]];
        ch[10].sender:=Intruder;
        ch[10].receiver:=roleA[j].A;
        ch[10].empty:=false;
        emit[pat5Set.content[i]] := true;
        IntruEmit10 := true;
        put "intruder emit msg into ch[10].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[14].
ruleset i: msgLen do
  ruleset j: roleANums do
    rule "intruderEmitMsgIntoCh[14]"
      IntruEmit13 = true & roleA[j].st = A6 & ch[14].empty=true & i <= pat13Set.length & pat13Set.content[i] != 0 & Spy_known[pat13Set.content[i]] & !emit[pat13Set.content[i]] ---& matchPat(msgs[pat13Set.content[i]], sPat13Set)
      ==>
      begin
         clear ch[14];
        ch[14].msg:=msgs[pat13Set.content[i]];
        ch[14].sender:=Intruder;
        ch[14].receiver:=roleA[j].A;
        ch[14].empty:=false;
        emit[pat13Set.content[i]] := true;
        IntruEmit14 := true;
        put "intruder emit msg into ch[14].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[18].
ruleset i: msgLen do
  ruleset j: roleANums do
    rule "intruderEmitMsgIntoCh[18]"
      IntruEmit17 = true & roleA[j].st = A8 & ch[18].empty=true & i <= pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] & !emit[pat1Set.content[i]] ---& matchPat(msgs[pat1Set.content[i]], sPat1Set)
      ==>
      begin
         clear ch[18];
        ch[18].msg:=msgs[pat1Set.content[i]];
        ch[18].sender:=Intruder;
        ch[18].receiver:=roleA[j].A;
        ch[18].empty:=false;
        emit[pat1Set.content[i]] := true;
        IntruEmit18 := true;
        put "intruder emit msg into ch[18].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[1].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[1]"
       roleB[j].st = B1 & ch[1].empty=true & i <= pat4Set.length & pat4Set.content[i] != 0 & Spy_known[pat4Set.content[i]] & !emit[pat4Set.content[i]] ---& matchPat(msgs[pat4Set.content[i]], sPat4Set)
      ==>
      begin
         clear ch[1];
        ch[1].msg:=msgs[pat4Set.content[i]];
        ch[1].sender:=Intruder;
        ch[1].receiver:=roleB[j].B;
        ch[1].empty:=false;
        emit[pat4Set.content[i]] := true;
        IntruEmit1 := true;
        put "intruder emit msg into ch[1].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[5].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[5]"
      IntruEmit4 = true & roleB[j].st = B3 & ch[5].empty=true & i <= pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] & !emit[pat1Set.content[i]] ---& matchPat(msgs[pat1Set.content[i]], sPat1Set)
      ==>
      begin
         clear ch[5];
        ch[5].msg:=msgs[pat1Set.content[i]];
        ch[5].sender:=Intruder;
        ch[5].receiver:=roleB[j].B;
        ch[5].empty:=false;
        emit[pat1Set.content[i]] := true;
        IntruEmit5 := true;
        put "intruder emit msg into ch[5].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[7].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[7]"
      IntruEmit6 = true & roleB[j].st = B5 & ch[7].empty=true & i <= pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] & !emit[pat1Set.content[i]] ---& matchPat(msgs[pat1Set.content[i]], sPat1Set)
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

---rule of intruder to emit msg into ch[9].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[9]"
      IntruEmit8 = true & roleB[j].st = B7 & ch[9].empty=true & i <= pat5Set.length & pat5Set.content[i] != 0 & Spy_known[pat5Set.content[i]] & !emit[pat5Set.content[i]] ---& matchPat(msgs[pat5Set.content[i]], sPat5Set)
      ==>
      begin
         clear ch[9];
        ch[9].msg:=msgs[pat5Set.content[i]];
        ch[9].sender:=Intruder;
        ch[9].receiver:=roleB[j].B;
        ch[9].empty:=false;
        emit[pat5Set.content[i]] := true;
        IntruEmit9 := true;
        put "intruder emit msg into ch[9].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[11].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[11]"
      IntruEmit10 = true & roleB[j].st = B9 & ch[11].empty=true & i <= pat12Set.length & pat12Set.content[i] != 0 & Spy_known[pat12Set.content[i]] & !emit[pat12Set.content[i]] ---& matchPat(msgs[pat12Set.content[i]], sPat12Set)
      ==>
      begin
         clear ch[11];
        ch[11].msg:=msgs[pat12Set.content[i]];
        ch[11].sender:=Intruder;
        ch[11].receiver:=roleB[j].B;
        ch[11].empty:=false;
        emit[pat12Set.content[i]] := true;
        IntruEmit11 := true;
        put "intruder emit msg into ch[11].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[13].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[13]"
      IntruEmit12 = true & roleB[j].st = B11 & ch[13].empty=true & i <= pat11Set.length & pat11Set.content[i] != 0 & Spy_known[pat11Set.content[i]] & !emit[pat11Set.content[i]] ---& matchPat(msgs[pat11Set.content[i]], sPat11Set)
      ==>
      begin
         clear ch[13];
        ch[13].msg:=msgs[pat11Set.content[i]];
        ch[13].sender:=Intruder;
        ch[13].receiver:=roleB[j].B;
        ch[13].empty:=false;
        emit[pat11Set.content[i]] := true;
        IntruEmit13 := true;
        put "intruder emit msg into ch[13].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[15].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[15]"
      IntruEmit14 = true & roleB[j].st = B13 & ch[15].empty=true & i <= pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] & !emit[pat1Set.content[i]] ---& matchPat(msgs[pat1Set.content[i]], sPat1Set)
      ==>
      begin
         clear ch[15];
        ch[15].msg:=msgs[pat1Set.content[i]];
        ch[15].sender:=Intruder;
        ch[15].receiver:=roleB[j].B;
        ch[15].empty:=false;
        emit[pat1Set.content[i]] := true;
        IntruEmit15 := true;
        put "intruder emit msg into ch[15].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[17].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[17]"
      IntruEmit16 = true & roleB[j].st = B15 & ch[17].empty=true & i <= pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] & !emit[pat1Set.content[i]] ---& matchPat(msgs[pat1Set.content[i]], sPat1Set)
      ==>
      begin
         clear ch[17];
        ch[17].msg:=msgs[pat1Set.content[i]];
        ch[17].sender:=Intruder;
        ch[17].receiver:=roleB[j].B;
        ch[17].empty:=false;
        emit[pat1Set.content[i]] := true;
        IntruEmit17 := true;
        put "intruder emit msg into ch[17].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[2].
ruleset i: msgLen do
  ruleset j: roleCNums do
    rule "intruderEmitMsgIntoCh[2]"
      IntruEmit1 = true & roleC[j].st = C1 & ch[2].empty=true & i <= pat15Set.length & pat15Set.content[i] != 0 & Spy_known[pat15Set.content[i]] & !emit[pat15Set.content[i]] ---& matchPat(msgs[pat15Set.content[i]], sPat15Set)
      ==>
      begin
         clear ch[2];
        ch[2].msg:=msgs[pat15Set.content[i]];
        ch[2].sender:=Intruder;
        ch[2].receiver:=roleC[j].C;
        ch[2].empty:=false;
        emit[pat15Set.content[i]] := true;
        IntruEmit2 := true;
        put "intruder emit msg into ch[2].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[4].
ruleset i: msgLen do
  ruleset j: roleCNums do
    rule "intruderEmitMsgIntoCh[4]"
      IntruEmit3 = true & roleC[j].st = C3 & ch[4].empty=true & i <= pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] & !emit[pat1Set.content[i]] ---& matchPat(msgs[pat1Set.content[i]], sPat1Set)
      ==>
      begin
         clear ch[4];
        ch[4].msg:=msgs[pat1Set.content[i]];
        ch[4].sender:=Intruder;
        ch[4].receiver:=roleC[j].C;
        ch[4].empty:=false;
        emit[pat1Set.content[i]] := true;
        IntruEmit4 := true;
        put "intruder emit msg into ch[4].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[8].
ruleset i: msgLen do
  ruleset j: roleCNums do
    rule "intruderEmitMsgIntoCh[8]"
      IntruEmit7 = true & roleC[j].st = C5 & ch[8].empty=true & i <= pat19Set.length & pat19Set.content[i] != 0 & Spy_known[pat19Set.content[i]] & !emit[pat19Set.content[i]] ---& matchPat(msgs[pat19Set.content[i]], sPat19Set)
      ==>
      begin
         clear ch[8];
        ch[8].msg:=msgs[pat19Set.content[i]];
        ch[8].sender:=Intruder;
        ch[8].receiver:=roleC[j].C;
        ch[8].empty:=false;
        emit[pat19Set.content[i]] := true;
        IntruEmit8 := true;
        put "intruder emit msg into ch[8].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[12].
ruleset i: msgLen do
  ruleset j: roleCNums do
    rule "intruderEmitMsgIntoCh[12]"
      IntruEmit11 = true & roleC[j].st = C7 & ch[12].empty=true & i <= pat12Set.length & pat12Set.content[i] != 0 & Spy_known[pat12Set.content[i]] & !emit[pat12Set.content[i]] ---& matchPat(msgs[pat12Set.content[i]], sPat12Set)
      ==>
      begin
         clear ch[12];
        ch[12].msg:=msgs[pat12Set.content[i]];
        ch[12].sender:=Intruder;
        ch[12].receiver:=roleC[j].C;
        ch[12].empty:=false;
        emit[pat12Set.content[i]] := true;
        IntruEmit12 := true;
        put "intruder emit msg into ch[12].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[16].
ruleset i: msgLen do
  ruleset j: roleCNums do
    rule "intruderEmitMsgIntoCh[16]"
      IntruEmit15 = true & roleC[j].st = C9 & ch[16].empty=true & i <= pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] & !emit[pat1Set.content[i]] ---& matchPat(msgs[pat1Set.content[i]], sPat1Set)
      ==>
      begin
         clear ch[16];
        ch[16].msg:=msgs[pat1Set.content[i]];
        ch[16].sender:=Intruder;
        ch[16].receiver:=roleC[j].C;
        ch[16].empty:=false;
        emit[pat1Set.content[i]] := true;
        IntruEmit16 := true;
        put "intruder emit msg into ch[16].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[3].
ruleset i: msgLen do
  ruleset j: roleDNums do
    rule "intruderEmitMsgIntoCh[3]"
      IntruEmit2 = true & roleD[j].st = D1 & ch[3].empty=true & i <= pat20Set.length & pat20Set.content[i] != 0 & Spy_known[pat20Set.content[i]] & !emit[pat20Set.content[i]] ---& matchPat(msgs[pat20Set.content[i]], sPat20Set)
      ==>
      begin
         clear ch[3];
        ch[3].msg:=msgs[pat20Set.content[i]];
        ch[3].sender:=Intruder;
        ch[3].receiver:=roleD[j].D;
        ch[3].empty:=false;
        emit[pat20Set.content[i]] := true;
        IntruEmit3 := true;
        put "intruder emit msg into ch[3].\n";
      end;
  endruleset;
endruleset;
--- enconcat and deconcat rules for pat: concat(supi.ue)

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

--- encrypt and decrypt rules of pat: aenc{supi.ue}pk(D), for intruder
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

--- enconcat and deconcat rules for pat: concat(ausf.certC.seafn)

ruleset i:msgLen do 
  rule "deconcat 5" --pat5
    i<=pat5Set.length & pat5Set.content[i] != 0 & Spy_known[pat5Set.content[i]]   &
    !(Spy_known[msgs[pat5Set.content[i]].concatPart[1]]&Spy_known[msgs[pat5Set.content[i]].concatPart[2]]&Spy_known[msgs[pat5Set.content[i]].concatPart[3]])
    ==>
    var msgPat1,msgPat2,msgPat3:indexType;
        flagPat1,flagPat2,flagPat3:boolean;
    begin
      put "rule deconcat5\n";
      if (!Spy_known[msgs[pat5Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat5Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat5Set.content[i]].concatPart[1];
        isPat1(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat1Set,msgPat1)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat5Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat5Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat5Set.content[i]].concatPart[2];
        isPat1(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat1Set,msgPat2)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat5Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat5Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat5Set.content[i]].concatPart[3];
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
    ruleset i: roleANums do
    rule "enconcat 5"	---pat5
      roleA[i].st = A4 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      i3<=pat1Set.length & Spy_known[pat1Set.content[i3]] &
      matchPat(construct5By111(pat1Set.content[i1],pat1Set.content[i2],pat1Set.content[i3]), sPat5Set)&
      !Spy_known[constructIndex5By111(pat1Set.content[i1],pat1Set.content[i2],pat1Set.content[i3])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat5\n";
        concatMsgNo := constructIndex5By111(pat1Set.content[i1],pat1Set.content[i2],pat1Set.content[i3]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct5By111(pat1Set.content[i1],pat1Set.content[i2],pat1Set.content[i3]);
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
endruleset;

--- encrypt and decrypt rules of pat: aenc{prekey}pk(C), for intruder
ruleset i:msgLen do 
  rule "adecrypt 6"	---pat6
    i<=pat6Set.length & pat6Set.content[i] != 0 & Spy_known[pat6Set.content[i]] &
    !Spy_known[msgs[pat6Set.content[i]].aencMsg]&
    Spy_known[inverseKeyIndex(msgs[msgs[pat6Set.content[i]].aencKey])]  ==>
    var key_inv:Message;
	      msgPat1:indexType;
	      flag_pat1:boolean;	      num:indexType;
    begin
      put "rule adecrypt6\n";
      key_inv := inverseKey(msgs[msgs[pat6Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat6Set.content[i]].aencMsg]:=true;
        msgPat1:=msgs[pat6Set.content[i]].aencMsg;
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
    rule "aencrypt 6"	---pat6
      roleB[i1].st = B9 &      i<=pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] &
      j<=pat3Set.length & pat3Set.content[j] != 0 & Spy_known[pat3Set.content[j]] &
      matchPat(construct6By13(pat1Set.content[i],pat3Set.content[j]), sPat6Set) &
      !Spy_known[constructIndex6By13(pat1Set.content[i],pat3Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt6\n";
        if (msgs[pat3Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex6By13(pat1Set.content[i],pat3Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct6By13(pat1Set.content[i],pat3Set.content[j]);
             msgs[encMsgNo] := encMsg;
          endif;
          if (!exist(pat6Set,encMsgNo)) then
            pat6Set.length := pat6Set.length+1;
            pat6Set.content[pat6Set.length]:=encMsgNo;
          endif;
          Spy_known[encMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(start.ue1.ausf.certC)

ruleset i:msgLen do 
  rule "deconcat 7" --pat7
    i<=pat7Set.length & pat7Set.content[i] != 0 & Spy_known[pat7Set.content[i]]   &
    !(Spy_known[msgs[pat7Set.content[i]].concatPart[1]]&Spy_known[msgs[pat7Set.content[i]].concatPart[2]]&Spy_known[msgs[pat7Set.content[i]].concatPart[3]]&Spy_known[msgs[pat7Set.content[i]].concatPart[4]])
    ==>
    var msgPat1,msgPat2,msgPat3,msgPat4:indexType;
        flagPat1,flagPat2,flagPat3,flagPat4:boolean;
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
      if (!Spy_known[msgs[pat7Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat7Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat7Set.content[i]].concatPart[3];
        isPat1(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat1Set,msgPat3)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat3;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat7Set.content[i]].concatPart[4]]) then
        Spy_known[msgs[pat7Set.content[i]].concatPart[4]]:=true;
        msgPat4 := msgs[pat7Set.content[i]].concatPart[4];
        isPat1(msgs[msgPat4],flagPat4);
        if (flagPat4) then
          if(!exist(pat1Set,msgPat4)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat4;
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
    rule "enconcat 7"	---pat7
      roleB[i].st = B9 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      i3<=pat1Set.length & Spy_known[pat1Set.content[i3]] &
      i4<=pat1Set.length & Spy_known[pat1Set.content[i4]] &
      matchPat(construct7By1111(pat1Set.content[i1],pat1Set.content[i2],pat1Set.content[i3],pat1Set.content[i4]), sPat7Set)&
      !Spy_known[constructIndex7By1111(pat1Set.content[i1],pat1Set.content[i2],pat1Set.content[i3],pat1Set.content[i4])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat7\n";
        concatMsgNo := constructIndex7By1111(pat1Set.content[i1],pat1Set.content[i2],pat1Set.content[i3],pat1Set.content[i4]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct7By1111(pat1Set.content[i1],pat1Set.content[i2],pat1Set.content[i3],pat1Set.content[i4]);
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
endruleset;
endruleset;

--- Sign and verify rules of pat: sign{start.ue1.ausf.certC}sk(A), for intruder
ruleset i:msgLen do 
  rule "destructSignRule 9"	---pat9
    i<=pat9Set.length & pat9Set.content[i] != 0 & Spy_known[pat9Set.content[i]] &
    !Spy_known[msgs[pat9Set.content[i]].signMsg]&
    Spy_known[inverseKeyIndex(msgs[msgs[pat9Set.content[i]].signKey])]  ==>
    var key_inv:Message;
	      msgPat7:indexType;
	      flag_pat7:boolean;
    begin
      put "rule destructSignRule9\n";
      Spy_known[msgs[pat9Set.content[i]].signMsg]:=true;
      msgPat7:=msgs[pat9Set.content[i]].signMsg;
      isPat7(msgs[msgPat7],flag_pat7);
      if (flag_pat7) then
       if (!exist(pat7Set,msgPat7)) then
         pat7Set.length:=pat7Set.length+1;
         pat7Set.content[pat7Set.length]:=msgPat7;
       endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "constructSign 9"	---pat9
      roleB[i1].st = B9 &      i<=pat7Set.length & pat7Set.content[i] != 0 & Spy_known[pat7Set.content[i]] &
      j<=pat8Set.length & pat8Set.content[j] != 0 & Spy_known[pat8Set.content[j]] &
      matchPat(construct9By78(pat7Set.content[i],pat8Set.content[j]), sPat9Set) &
      !Spy_known[constructIndex9By78(pat7Set.content[i],pat8Set.content[j])] 
    ==>
      var signMsgNo:indexType;
      signMsg:Message;
      begin
        put "rule constructSign9\n";
        if (msgs[pat8Set.content[j]].k.encType=SK) then
          signMsgNo := constructIndex9By78(pat7Set.content[i],pat8Set.content[j]);
          if signMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             signMsg := construct9By78(pat7Set.content[i],pat8Set.content[j]);
             msgs[signMsgNo] := signMsg;
          endif;
          if (!exist(pat9Set,signMsgNo)) then
            pat9Set.length := pat9Set.length+1;
            pat9Set.content[pat9Set.length]:=signMsgNo;
          endif;
          Spy_known[signMsgNo] := true;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- hash and dehash rules of pat: hash{aenc{prekey}pk(C).certA.sign(start.ue1.ausf.certC,sk(A)).senc{start.ue1.ausf.certC}hash(ue1.ausf.prekey)}, for intruder
ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "constructHash 10"  --pat10
      roleB[i1].st = B9 &      i<=pat5Set.length & pat5Set.content[i] != 0 & Spy_known[pat5Set.content[i]] &
      matchPat(construct10By5(pat5Set.content[i]), sPat10Set) &
      !Spy_known[constructIndex10By5(pat5Set.content[i])]
      ==>
      var hashMsgNo:indexType;
      hashMsg:Message;
      begin
        put "rule constructHash 10\n";
        hashMsgNo := constructIndex10By5(pat5Set.content[i]);
        if hashMsgNo = msg_end + 1 then
          msg_end := msg_end + 1;
          hashMsg := construct10By5(pat5Set.content[i]);
          msgs[hashMsgNo] := hashMsg;
        endif;
        Spy_known[hashMsgNo]:=true;
        if (!exist(pat10Set,hashMsgNo)) then
          pat10Set.length:=pat10Set.length+1;
          pat10Set.content[pat10Set.length]:=hashMsgNo;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- encrypt and decrypt rules of pat senc(start.ue1.ausf.certC,hash(ue1.ausf.prekey))
ruleset i:msgLen do
  rule "sdecrypt 11" --pat11
    i<=pat11Set.length & pat11Set.content[i] != 0
    & Spy_known[pat11Set.content[i]] & !Spy_known[msgs[pat11Set.content[i]].sencMsg]
    ==>
    var key_inv:Message;
	      msgPat7,keyNo:indexType;
	      flag_pat7:boolean;
    begin
      put "rule sdecrypt11\n";
      key_inv := inverseKey(msgs[msgs[pat11Set.content[i]].sencKey]);
      get_msgNo(key_inv,keyNo);
      if (key_inv.k.encType = MsgK & Spy_known[keyNo]) then
        Spy_known[msgs[pat11Set.content[i]].sencMsg]:=true;
        msgPat7:=msgs[pat11Set.content[i]].sencMsg;
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
    rule "sencrypt 11"  --pat11
      roleB[i1].st = B9 &      i<=pat7Set.length & pat7Set.content[i] != 0 & Spy_known[pat7Set.content[i]] &
      j<=pat10Set.length & pat10Set.content[j] != 0 & Spy_known[pat10Set.content[j]] &
      matchPat(construct11By710(pat7Set.content[i],pat10Set.content[j]), sPat11Set) &
      !Spy_known[constructIndex11By710(pat7Set.content[i],pat10Set.content[j])] 
       ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule sencrypt11\n";
        if (msgs[pat10Set.content[j]].k.encType=MsgK) then
          encMsgNo := constructIndex11By710(pat7Set.content[i],pat10Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg:= construct11By710(pat7Set.content[i],pat10Set.content[j]);
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

--- enconcat and deconcat rules for pat: concat(aenc{prekey}pk(C).certA.sign(start.ue1.ausf.certC,sk(A)).senc{start.ue1.ausf.certC}hash(ue1.ausf.prekey))

ruleset i:msgLen do 
  rule "deconcat 12" --pat12
    i<=pat12Set.length & pat12Set.content[i] != 0 & Spy_known[pat12Set.content[i]]   &
    !(Spy_known[msgs[pat12Set.content[i]].concatPart[1]]&Spy_known[msgs[pat12Set.content[i]].concatPart[2]]&Spy_known[msgs[pat12Set.content[i]].concatPart[3]]&Spy_known[msgs[pat12Set.content[i]].concatPart[4]])
    ==>
    var msgPat1,msgPat2,msgPat3,msgPat4:indexType;
        flagPat1,flagPat2,flagPat3,flagPat4:boolean;
    begin
      put "rule deconcat12\n";
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat12Set.content[i]].concatPart[1];
        isPat6(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat6Set,msgPat1)) then
             pat6Set.length:=pat6Set.length+1;
             pat6Set.content[pat6Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat12Set.content[i]].concatPart[2];
        isPat1(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat1Set,msgPat2)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat12Set.content[i]].concatPart[3];
        isPat9(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat9Set,msgPat3)) then
             pat9Set.length:=pat9Set.length+1;
             pat9Set.content[pat9Set.length] := msgPat3;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat12Set.content[i]].concatPart[4]]) then
        Spy_known[msgs[pat12Set.content[i]].concatPart[4]]:=true;
        msgPat4 := msgs[pat12Set.content[i]].concatPart[4];
        isPat11(msgs[msgPat4],flagPat4);
        if (flagPat4) then
          if(!exist(pat11Set,msgPat4)) then
             pat11Set.length:=pat11Set.length+1;
             pat11Set.content[pat11Set.length] := msgPat4;
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
    rule "enconcat 12"	---pat12
      roleB[i].st = B9 &      i1<=pat6Set.length & Spy_known[pat6Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      i3<=pat9Set.length & Spy_known[pat9Set.content[i3]] &
      i4<=pat11Set.length & Spy_known[pat11Set.content[i4]] &
      matchPat(construct12By61911(pat6Set.content[i1],pat1Set.content[i2],pat9Set.content[i3],pat11Set.content[i4]), sPat12Set)&
      !Spy_known[constructIndex12By61911(pat6Set.content[i1],pat1Set.content[i2],pat9Set.content[i3],pat11Set.content[i4])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat12\n";
        concatMsgNo := constructIndex12By61911(pat6Set.content[i1],pat1Set.content[i2],pat9Set.content[i3],pat11Set.content[i4]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct12By61911(pat6Set.content[i1],pat1Set.content[i2],pat9Set.content[i3],pat11Set.content[i4]);
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

--- enconcat and deconcat rules for pat: concat(m1.seafn)

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
        isPat14(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat14Set,msgPat1)) then
             pat14Set.length:=pat14Set.length+1;
             pat14Set.content[pat14Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat15Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat15Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat15Set.content[i]].concatPart[2];
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
    ruleset i: roleCNums do
    rule "enconcat 15"	---pat15
      roleC[i].st = C1 &      i1<=pat14Set.length & Spy_known[pat14Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      matchPat(construct15By141(pat14Set.content[i1],pat1Set.content[i2]), sPat15Set)&
      !Spy_known[constructIndex15By141(pat14Set.content[i1],pat1Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat15\n";
        concatMsgNo := constructIndex15By141(pat14Set.content[i1],pat1Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct15By141(pat14Set.content[i1],pat1Set.content[i2]);
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

--- enconcat and deconcat rules for pat: concat(x2.seafn)

ruleset i:msgLen do 
  rule "deconcat 17" --pat17
    i<=pat17Set.length & pat17Set.content[i] != 0 & Spy_known[pat17Set.content[i]]   &
    !(Spy_known[msgs[pat17Set.content[i]].concatPart[1]]&Spy_known[msgs[pat17Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat17\n";
      if (!Spy_known[msgs[pat17Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat17Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat17Set.content[i]].concatPart[1];
        isPat16(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat16Set,msgPat1)) then
             pat16Set.length:=pat16Set.length+1;
             pat16Set.content[pat16Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat17Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat17Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat17Set.content[i]].concatPart[2];
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
    ruleset i: roleANums do
    rule "enconcat 17"	---pat17
      roleA[i].st = A2 &      i1<=pat16Set.length & Spy_known[pat16Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      matchPat(construct17By161(pat16Set.content[i1],pat1Set.content[i2]), sPat17Set)&
      !Spy_known[constructIndex17By161(pat16Set.content[i1],pat1Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat17\n";
        concatMsgNo := constructIndex17By161(pat16Set.content[i1],pat1Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct17By161(pat16Set.content[i1],pat1Set.content[i2]);
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

--- enconcat and deconcat rules for pat: concat(x3.seafn)

ruleset i:msgLen do 
  rule "deconcat 19" --pat19
    i<=pat19Set.length & pat19Set.content[i] != 0 & Spy_known[pat19Set.content[i]]   &
    !(Spy_known[msgs[pat19Set.content[i]].concatPart[1]]&Spy_known[msgs[pat19Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
    begin
      put "rule deconcat19\n";
      if (!Spy_known[msgs[pat19Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat19Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat19Set.content[i]].concatPart[1];
        isPat18(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat18Set,msgPat1)) then
             pat18Set.length:=pat18Set.length+1;
             pat18Set.content[pat18Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat19Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat19Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat19Set.content[i]].concatPart[2];
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
    ruleset i: roleCNums do
    rule "enconcat 19"	---pat19
      roleC[i].st = C5 &      i1<=pat18Set.length & Spy_known[pat18Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      matchPat(construct19By181(pat18Set.content[i1],pat1Set.content[i2]), sPat19Set)&
      !Spy_known[constructIndex19By181(pat18Set.content[i1],pat1Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat19\n";
        concatMsgNo := constructIndex19By181(pat18Set.content[i1],pat1Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct19By181(pat18Set.content[i1],pat1Set.content[i2]);
          msgs[concatMsgNo] := concatMsg;
        endif;
        Spy_known[concatMsgNo]:=true;
        if (!exist(pat19Set,concatMsgNo)) then
          pat19Set.length:=pat19Set.length+1;
          pat19Set.content[pat19Set.length]:=concatMsgNo;
        endif;
      end;
  endruleset;
endruleset;
endruleset;

--- enconcat and deconcat rules for pat: concat(m1.seafn.ausfn)

ruleset i:msgLen do 
  rule "deconcat 20" --pat20
    i<=pat20Set.length & pat20Set.content[i] != 0 & Spy_known[pat20Set.content[i]]   &
    !(Spy_known[msgs[pat20Set.content[i]].concatPart[1]]&Spy_known[msgs[pat20Set.content[i]].concatPart[2]]&Spy_known[msgs[pat20Set.content[i]].concatPart[3]])
    ==>
    var msgPat1,msgPat2,msgPat3:indexType;
        flagPat1,flagPat2,flagPat3:boolean;
    begin
      put "rule deconcat20\n";
      if (!Spy_known[msgs[pat20Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat20Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat20Set.content[i]].concatPart[1];
        isPat14(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat14Set,msgPat1)) then
             pat14Set.length:=pat14Set.length+1;
             pat14Set.content[pat14Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat20Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat20Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat20Set.content[i]].concatPart[2];
        isPat1(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat1Set,msgPat2)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat2;
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
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do
  ruleset i3: msgLen do 
    ruleset i: roleDNums do
    rule "enconcat 20"	---pat20
      roleD[i].st = D1 &      i1<=pat14Set.length & Spy_known[pat14Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      i3<=pat1Set.length & Spy_known[pat1Set.content[i3]] &
      matchPat(construct20By1411(pat14Set.content[i1],pat1Set.content[i2],pat1Set.content[i3]), sPat20Set)&
      !Spy_known[constructIndex20By1411(pat14Set.content[i1],pat1Set.content[i2],pat1Set.content[i3])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat20\n";
        concatMsgNo := constructIndex20By1411(pat14Set.content[i1],pat1Set.content[i2],pat1Set.content[i3]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct20By1411(pat14Set.content[i1],pat1Set.content[i2],pat1Set.content[i3]);
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

--- enconcat and deconcat rules for pat: concat(x1.seafn.ausfn)

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
        isPat21(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat21Set,msgPat1)) then
             pat21Set.length:=pat21Set.length+1;
             pat21Set.content[pat21Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat22Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat22Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat22Set.content[i]].concatPart[2];
        isPat1(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat1Set,msgPat2)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat2;
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
    rule "enconcat 22"	---pat22
      i1<=pat21Set.length & Spy_known[pat21Set.content[i1]] &
      i2<=pat1Set.length & Spy_known[pat1Set.content[i2]] &
      i3<=pat1Set.length & Spy_known[pat1Set.content[i3]] &
      matchPat(construct22By2111(pat21Set.content[i1],pat1Set.content[i2],pat1Set.content[i3]), sPat22Set)&
      !Spy_known[constructIndex22By2111(pat21Set.content[i1],pat1Set.content[i2],pat1Set.content[i3])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat22\n";
        concatMsgNo := constructIndex22By2111(pat21Set.content[i1],pat1Set.content[i2],pat1Set.content[i3]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct22By2111(pat21Set.content[i1],pat1Set.content[i2],pat1Set.content[i3]);
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

startstate
  roleA[1].A := UE;
  roleA[1].B := SEAF;
  roleA[1].C := Intruder;
  roleA[1].D := UDM;
  roleA[1].supi := supi;
  roleA[1].ue := ue;
  roleA[1].ue1 := ue1;
  roleA[1].prekey := prekey;
  roleA[1].certA := certA;
  roleA[1].eapm := eapm;
  roleA[1].st := A1;
  roleA[1].commit := false;
  roleA[1].seafn := anyNonce;
  roleA[1].ausf := anyNonce;
  roleA[1].ausfn := anyNonce;
  roleA[1].sucm := anyNonce;
  roleA[1].certC := anyNonce;
  roleA[1].start := anyNonce;
  roleA[1].x10.msgType := tmp;
  roleA[1].x10.tmpPart := 0;
  roleA[1].m1.msgType := tmp;
  roleA[1].m1.tmpPart := 0;
  roleA[1].x2.msgType := tmp;
  roleA[1].x2.tmpPart := 0;
  roleA[1].x3.msgType := tmp;
  roleA[1].x3.tmpPart := 0;
  roleA[1].x1.msgType := tmp;
  roleA[1].x1.tmpPart := 0;

  roleB[1].A := UE;
  roleB[1].B := SEAF;
  roleB[1].C := Intruder;
  roleB[1].seafn := seafn;
  roleB[1].st := B1;
  roleB[1].commit := false;
  roleB[1].supi := anyNonce;
  roleB[1].ue := anyNonce;
  roleB[1].ue1 := anyNonce;
  roleB[1].prekey := anyNonce;
  roleB[1].certA := anyNonce;
  roleB[1].eapm := anyNonce;
  roleB[1].ausf := anyNonce;
  roleB[1].ausfn := anyNonce;
  roleB[1].sucm := anyNonce;
  roleB[1].certC := anyNonce;
  roleB[1].start := anyNonce;
  roleB[1].D := anyAgent;
  roleB[1].x10.msgType := tmp;
  roleB[1].x10.tmpPart := 0;
  roleB[1].m1.msgType := tmp;
  roleB[1].m1.tmpPart := 0;
  roleB[1].x2.msgType := tmp;
  roleB[1].x2.tmpPart := 0;
  roleB[1].x3.msgType := tmp;
  roleB[1].x3.tmpPart := 0;
  roleB[1].x1.msgType := tmp;
  roleB[1].x1.tmpPart := 0;

  roleC[1].A := UE;
  roleC[1].B := Intruder;
  roleC[1].C := AUSF;
  roleC[1].D := UDM;
  roleC[1].ausf := ausf;
  roleC[1].ausfn := ausfn;
  roleC[1].sucm := sucm;
  roleC[1].certC := certC;
  roleC[1].st := C1;
  roleC[1].commit := false;
  roleC[1].supi := anyNonce;
  roleC[1].ue := anyNonce;
  roleC[1].ue1 := anyNonce;
  roleC[1].prekey := anyNonce;
  roleC[1].certA := anyNonce;
  roleC[1].eapm := anyNonce;
  roleC[1].seafn := anyNonce;
  roleC[1].start := anyNonce;
  roleC[1].x10.msgType := tmp;
  roleC[1].x10.tmpPart := 0;
  roleC[1].m1.msgType := tmp;
  roleC[1].m1.tmpPart := 0;
  roleC[1].x2.msgType := tmp;
  roleC[1].x2.tmpPart := 0;
  roleC[1].x3.msgType := tmp;
  roleC[1].x3.tmpPart := 0;
  roleC[1].x1.msgType := tmp;
  roleC[1].x1.tmpPart := 0;

  roleD[1].A := UE;
  roleD[1].B := SEAF;
  roleD[1].C := AUSF;
  roleD[1].D := UDM;
  roleD[1].start := start;
  roleD[1].st := D1;
  roleD[1].commit := false;
  roleD[1].supi := anyNonce;
  roleD[1].ue := anyNonce;
  roleD[1].ue1 := anyNonce;
  roleD[1].prekey := anyNonce;
  roleD[1].certA := anyNonce;
  roleD[1].eapm := anyNonce;
  roleD[1].seafn := anyNonce;
  roleD[1].ausf := anyNonce;
  roleD[1].ausfn := anyNonce;
  roleD[1].sucm := anyNonce;
  roleD[1].certC := anyNonce;
  roleD[1].x10.msgType := tmp;
  roleD[1].x10.tmpPart := 0;
  roleD[1].m1.msgType := tmp;
  roleD[1].m1.tmpPart := 0;
  roleD[1].x2.msgType := tmp;
  roleD[1].x2.tmpPart := 0;
  roleD[1].x3.msgType := tmp;
  roleD[1].x3.tmpPart := 0;
  roleD[1].x1.msgType := tmp;
  roleD[1].x1.tmpPart := 0;


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
    IntruEmit4 := false;
    IntruEmit5 := false;
    IntruEmit6 := false;
    IntruEmit7 := false;
    IntruEmit8 := false;
    IntruEmit9 := false;
    IntruEmit10 := false;
    IntruEmit11 := false;
    IntruEmit12 := false;
    IntruEmit13 := false;
    IntruEmit14 := false;
    IntruEmit15 := false;
    IntruEmit16 := false;
    IntruEmit17 := false;
    IntruEmit18 := false;
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
    D_known[i] := false;
  endfor;

  for i:indexType do 
    Spy_known[i] := false;
  endfor;
  msg_end:=msg_end+1;
  msgs[msg_end].msgType := key;
  msgs[msg_end].k.ag:=Intruder;
  msgs[msg_end].k.encType:=SK;
  msgs[msg_end].length := 1;
  pat8Set.length := pat8Set.length + 1; 
  pat8Set.content[pat8Set.length] :=msg_end;
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
    pat8Set.length := pat8Set.length + 1;
    pat8Set.content[pat8Set.length] :=msg_end;
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
    pat8Set.length := pat8Set.length + 1;
    pat8Set.content[pat8Set.length] :=msg_end;
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
    pat8Set.length := pat8Set.length + 1;
    pat8Set.content[pat8Set.length] :=msg_end;
    C_known[msg_end] := true;
  endfor;
  for i : roleDNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleD[i].D;
    msgs[msg_end].k.encType:=PK;
    msgs[msg_end].length := 1;
    pat3Set.length := pat3Set.length + 1;
    pat3Set.content[pat3Set.length] :=msg_end;
    Spy_known[msg_end] := true;
    D_known[msg_end] := true;
  endfor;
  for i : roleDNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleD[i].D;
    msgs[msg_end].k.encType:=SK;
    msgs[msg_end].length := 1;
    pat8Set.length := pat8Set.length + 1;
    pat8Set.content[pat8Set.length] :=msg_end;
    D_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    constructSpat4(roleB[i].supi,roleB[i].ue,roleB[i].D, gnum);
  endfor;
  for i : roleBNums do
    constructSpat1(roleB[i].ue1, gnum);
  endfor;
  for i : roleBNums do
    constructSpat12(roleB[i].prekey,roleB[i].C,roleB[i].certA,roleB[i].start,roleB[i].ue1,roleB[i].ausf,roleB[i].certC,roleB[i].A, gnum);
  endfor;
  for i : roleBNums do
    constructSpat1(roleB[i].eapm, gnum);
  endfor;
  for i : roleCNums do
    constructSpat15(roleC[i].m1,roleC[i].seafn, gnum);
  endfor;
  for i : roleANums do
    constructSpat17(roleA[i].x2,roleA[i].seafn, gnum);
  endfor;
  for i : roleCNums do
    constructSpat19(roleC[i].x3,roleC[i].seafn, gnum);
  endfor;
  for i : roleANums do
    constructSpat5(roleA[i].ausf,roleA[i].certC,roleA[i].seafn, gnum);
  endfor;
  for i : roleCNums do
    constructSpat12(roleC[i].prekey,roleC[i].C,roleC[i].certA,roleC[i].start,roleC[i].ue1,roleC[i].ausf,roleC[i].certC,roleC[i].A, gnum);
  endfor;
  for i : roleANums do
    constructSpat13(roleA[i].x10, gnum);
  endfor;
  for i : roleCNums do
    constructSpat1(roleC[i].eapm, gnum);
  endfor;
  for i : roleANums do
    constructSpat1(roleA[i].sucm, gnum);
  endfor;
  for i : roleDNums do
    constructSpat20(roleD[i].m1,roleD[i].seafn,roleD[i].ausfn, gnum);
  endfor;
  for i : roleBNums do
    constructSpat1(roleB[i].start, gnum);
  endfor;
  for i : roleBNums do
    constructSpat5(roleB[i].ausf,roleB[i].certC,roleB[i].ausfn, gnum);
  endfor;
  for i : roleBNums do
    constructSpat11(roleB[i].start,roleB[i].ue1,roleB[i].ausf,roleB[i].certC,roleB[i].prekey, gnum);
  endfor;
  for i : roleBNums do
    constructSpat1(roleB[i].sucm, gnum);
  endfor;
  for i : roleCNums do
    constructSpat1(roleC[i].start, gnum);
  endfor;

end;

invariant "weakC"
  forall i: roleANums do
    roleA[i].st = A6 
    ->
    (exists j: roleCNums do
      ---roleC[j].commit = true &
      roleC[i].ausf = roleA[j].ausf
    endexists)
  endforall;

invariant "secrecy" 
forall i:indexType do
    (msgs[i].msgType=nonce & msgs[i].noncePart=prekey)
     ->
     Spy_known[i] = false
end;
