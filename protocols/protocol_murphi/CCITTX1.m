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

  AgentType : enum{anyAgent,Alice, Intruder}; ---Intruder 
  NonceType : enum{anyNonce, Na, Ta, Xa, Ya};
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

  AStatus: enum{A1};
  BStatus: enum{B1};

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
   A : AgentType;
   B : AgentType;


   locNa : NonceType;
   locTa : NonceType;
   locXa : NonceType;
   locYa : NonceType;
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
   A : AgentType;
   B : AgentType;


   locNa : NonceType;
   locTa : NonceType;
   locXa : NonceType;
   locYa : NonceType;
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

  A_known : Array[indexType] of boolean;
  B_known : Array[indexType] of boolean;
  Spy_known: Array[indexType] of boolean;
  IntruEmit1 : boolean;
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

function construct3By2(msgNo21:indexType):Message;
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

function constructIndex3By2(msgNo21:indexType):indexType;
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

--- Sorry, construct_function of this pattern has not been written!

function construct5By34(msgNo31, msgNo42:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo31 & msgs[i].aencKey = msgNo42) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo31;
     msg.aencKey := msgNo42;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex5By34(msgNo31, msgNo42:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo31 & msgs[i].aencKey = msgNo42) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct6By25(msgNo1,msgNo2:indexType):Message;
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

function constructIndex6By25(msgNo1,msgNo2:indexType):indexType;
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

function construct8By67(msgNo61, msgNo72:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo61 & msgs[i].aencKey = msgNo72) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo61;
     msg.aencKey := msgNo72;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex8By67(msgNo61, msgNo72:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo61 & msgs[i].aencKey = msgNo72) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct9By22128(msgNo1,msgNo2,msgNo3,msgNo4,msgNo5:indexType):Message;
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

function constructIndex9By22128(msgNo1,msgNo2,msgNo3,msgNo4,msgNo5:indexType):indexType;
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

function construct10By94(msgNo91, msgNo42:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo91 & msgs[i].aencKey = msgNo42) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := aenc;
     msg.aencMsg := msgNo91;
     msg.aencKey := msgNo42;
     msg.length := 1;
   endif;
   return msg;
  end;

function constructIndex10By94(msgNo91, msgNo42:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = aenc) then
       if (msgs[i].aencMsg = msgNo91 & msgs[i].aencKey = msgNo42) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end + 1;
   endif;
   return index;
  end;

function construct11By110(msgNo1,msgNo2:indexType):Message;
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

function constructIndex11By110(msgNo1,msgNo2:indexType):indexType;
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

---pat3: hash(Ya) 
procedure lookAddPat3(Ya:NonceType; Var msg:Message; Var num : indexType);
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

---pat3: hash(Ya) 
procedure isPat3(msg:Message; Var flag:boolean);
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

---spat3: hash(Ya) 
procedure constructSpat3(Ya:NonceType; Var num: indexType);
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
    sPat3Set.length := sPat3Set.length + 1;
    sPat3Set.content[sPat3Set.length] := index;
    num := index;
  end;

---pat4: sk(A) 
procedure lookAddPat4(ASk:AgentType; Var msg:Message; Var num : indexType);
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

---pat4: sk(A) 
procedure isPat4(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
      flag1 := false;
      if (msg.msgType = key & msg.k.encType = SK) then
        flag1 := true;
      endif;
      flag := flag1;
  end;

---spat4: sk(A) 
procedure constructSpat4(ASk:AgentType; Var num: indexType);
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
    sPat4Set.length := sPat4Set.length + 1;
    sPat4Set.content[sPat4Set.length] := index;
    num := index;
  end;

---pat5: aenc{hash(Ya)}sk(A) 
procedure lookAddPat5(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat3(Ya,msg1,i1);
   lookAddPat4(ASk,msg2,i2);
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

---pat5: aenc{hash(Ya)}sk(A) 
procedure isPat5(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat3(msgs[msg.aencMsg],flagPart1);
      isPat4(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat5: aenc{hash(Ya)}sk(A) 
procedure constructSpat5(Ya:NonceType; ASk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat3(Ya, i1);
    constructSpat4(ASk, i2);
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
    sPat5Set.length := sPat5Set.length + 1;
    sPat5Set.content[sPat5Set.length] := index;
    num := index;
  end;

---pat6: Ya.aenc{hash(Ya)}sk(A) 
procedure lookAddPat6(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(Ya, msg1, i1);
   lookAddPat5(Ya, ASk, msg2, i2);
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

---pat6: Ya.aenc{hash(Ya)}sk(A) 
procedure isPat6(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat2(msgs[msg.concatPart[1]],flagPart1);
        isPat5(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat6: Ya.aenc{hash(Ya)}sk(A) 
procedure constructSpat6(Ya:NonceType; ASk:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat2(Ya, i1);
    constructSpat5(Ya, ASk, i2);
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

---pat7: pk(B) 
procedure lookAddPat7(BPk:AgentType; Var msg:Message; Var num : indexType);
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

---pat7: pk(B) 
procedure isPat7(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = key & msg.k.encType = PK) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat7: pk(B) 
procedure constructSpat7(BPk:AgentType; Var num: indexType);
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
    sPat7Set.length := sPat7Set.length + 1;
    sPat7Set.content[sPat7Set.length] := index;
    num := index;
  end;

---pat8: aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure lookAddPat8(Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat6(Ya, ASk,msg1,i1);
   lookAddPat7(BPk,msg2,i2);
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

---pat8: aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure isPat8(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat6(msgs[msg.aencMsg],flagPart1);
      isPat7(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat8: aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure constructSpat8(Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat6(Ya, ASk, i1);
    constructSpat7(BPk, i2);
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
    sPat8Set.length := sPat8Set.length + 1;
    sPat8Set.content[sPat8Set.length] := index;
    num := index;
  end;

---pat9: Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure lookAddPat9(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2,msg3,msg4,msg5: Message;
     index,i1,i2,i3,i4,i5:indexType;
  begin
   index:=0;
   lookAddPat2(Ta, msg1, i1);
   lookAddPat2(Na, msg2, i2);
   lookAddPat1(B, msg3, i3);
   lookAddPat2(Xa, msg4, i4);
   lookAddPat8(Ya, ASk, BPk, msg5, i5);
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

---pat9: Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure isPat9(msg:Message; Var flag:boolean);
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
        isPat8(msgs[msg.concatPart[5]],flagPart5);
       if (flagPart1 & flagPart2 & flagPart3 & flagPart4 & flagPart5) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat9: Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B) 
procedure constructSpat9(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index, i1, i2, i3, i4, i5:indexType;
  begin
    index:=0;
    constructSpat2(Ta, i1);
    constructSpat2(Na, i2);
    constructSpat1(B, i3);
    constructSpat2(Xa, i4);
    constructSpat8(Ya, ASk, BPk, i5);
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
    sPat9Set.length := sPat9Set.length + 1;
    sPat9Set.content[sPat9Set.length] := index;
    num := index;
  end;

---pat10: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure lookAddPat10(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat9(Ta, Na, B, Xa, Ya, ASk, BPk,msg1,i1);
   lookAddPat4(ASk,msg2,i2);
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

---pat10: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure isPat10(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1 := false;
    flagPart2 := false;
    if (msg.msgType = aenc) then
      isPat9(msgs[msg.aencMsg],flagPart1);
      isPat4(msgs[msg.aencKey],flagPart2);
      if (flagPart1 & flagPart2) then 
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat10: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure constructSpat10(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat9(Ta, Na, B, Xa, Ya, ASk, BPk, i1);
    constructSpat4(ASk, i2);
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

---pat11: A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure lookAddPat11(A:AgentType; Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(A, msg1, i1);
   lookAddPat10(Ta, Na, B, Xa, Ya, ASk, BPk, msg2, i2);
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

---pat11: A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure isPat11(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat1(msgs[msg.concatPart[1]],flagPart1);
        isPat10(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat11: A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A) 
procedure constructSpat11(A:AgentType; Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(A, i1);
    constructSpat10(Ta, Na, B, Xa, Ya, ASk, BPk, i2);
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
    sPat11Set.length := sPat11Set.length + 1;
    sPat11Set.content[sPat11Set.length] := index;
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
procedure cons3(Ya:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat3(Ya,msg,num);
  end;
procedure destruct3(msg:Message; Var Ya:NonceType);
  var msgNo:indexType;
  hashMsg:Message;
  begin
    hashMsg:=msgs[msg.hashMsg];
    destruct2(hashMsg,Ya);
  end;
procedure cons4(ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat4(ASk,msg,num);
  end;
procedure cons5(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat5(Ya, ASk,msg,num);
  end;
procedure destruct5(msg:Message; Var Ya:NonceType; Var ASk:AgentType);
  var k1:KeyType;
      msg1:Message;
   begin
      clear msg1;
      k1 := msgs[msg.aencKey].k;
      ASk := k1.ag;      msg1:=msgs[msg.aencMsg];
    destruct3(msg1,Ya);
   end;
procedure cons6(Ya:NonceType; ASk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat6(Ya, ASk,msg,num);
  end;
procedure destruct6(msg:Message; Var Ya:NonceType; Var ASk:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    Ya := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct5(msgNum2,Ya, ASk)
  end;
procedure cons7(BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat7(BPk,msg,num);
  end;
procedure cons8(Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat8(Ya, ASk, BPk,msg,num);
  end;
procedure destruct8(msg:Message; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    BPk := k1.ag;    aencMsg:=msgs[msg.aencMsg];
    destruct6(aencMsg,Ya, ASk);
  end;
procedure cons9(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat9(Ta, Na, B, Xa, Ya, ASk, BPk,msg,num);
  end;
procedure destruct9(msg:Message; Var Ta:NonceType; Var Na:NonceType; Var B:AgentType; Var Xa:NonceType; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
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
    destruct8(msgNum5,Ya, ASk, BPk)
  end;
procedure cons10(Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat10(Ta, Na, B, Xa, Ya, ASk, BPk,msg,num);
  end;
procedure destruct10(msg:Message; Var Ta:NonceType; Var Na:NonceType; Var B:AgentType; Var Xa:NonceType; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  var k1:KeyType;
      aencMsg:Message;
      begin
    clear aencMsg;
    k1:=msgs[msg.aencKey].k;
    ASk := k1.ag;    aencMsg:=msgs[msg.aencMsg];
    destruct9(aencMsg,Ta, Na, B, Xa, Ya, ASk, BPk);
  end;
procedure cons11(A:AgentType; Ta:NonceType; Na:NonceType; B:AgentType; Xa:NonceType; Ya:NonceType; ASk:AgentType; BPk:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat11(A, Ta, Na, B, Xa, Ya, ASk, BPk,msg,num);
  end;
procedure destruct11(msg:Message; Var A:AgentType; Var Ta:NonceType; Var Na:NonceType; Var B:AgentType; Var Xa:NonceType; Var Ya:NonceType; Var ASk:AgentType; Var BPk:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    A := msgNum1.ag;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct10(msgNum2,Ta, Na, B, Xa, Ya, ASk, BPk)
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
   cons11(roleA[i].A,roleA[i].Ta,roleA[i].Na,roleA[i].B,roleA[i].Xa,roleA[i].Ya,roleA[i].A,roleA[i].B,msg,msgNo);
   ch[1].empty := false;
   ch[1].msg := msg;
   ch[1].sender := roleA[i].A;
   ch[1].receiver := Intruder;
   roleA[i].st := A1;
   put "roleA[i] in st1\n";
   roleA[i].commit := true;
end;
endruleset;

ruleset i:roleBNums do
rule " roleB1 "
roleB[i].st = B1 & ch[1].empty = false & !roleB[i].commit & judge(ch[1].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat11:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[1].msg;
   isPat11(msg, flag_pat11);
   if(flag_pat11) then
     destruct11(msg,roleB[i].locA,roleB[i].locTa,roleB[i].locNa,roleB[i].locB,roleB[i].locXa,roleB[i].locYa,roleB[i].locA,roleB[i].locB);
     if(matchAgent(roleB[i].locA, roleB[i].A) & matchNonce(roleB[i].locTa, roleB[i].Ta) & matchNonce(roleB[i].locNa, roleB[i].Na) & matchAgent(roleB[i].locB, roleB[i].B) & matchNonce(roleB[i].locXa, roleB[i].Xa) & matchNonce(roleB[i].locYa, roleB[i].Ya) & matchAgent(roleB[i].locA, roleB[i].A) & matchAgent(roleB[i].locB, roleB[i].B))then
       ch[1].empty:=true;
       clear ch[1].msg;
       roleB[i].st := B1;
     endif;
   endif;
   put "roleB[i] in st1\n";
   roleB[i].commit := true;
end;
endruleset;


---rule of intruder to get msg from ch[1] 
rule "intruderGetMsgFromCh[1]" 
  ch[1].empty = false & ch[1].sender != Intruder ==>
  var flag_pat11:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[1].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat11(msg,flag_pat11);
    if (flag_pat11) then
      if(!exist(pat11Set,msgNo)) then
        pat11Set.length:=pat11Set.length+1;
        pat11Set.content[pat11Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[1].empty := true;
      clear ch[1].msg;
    endif;
    put "intruder get msg from ch[1].\n";
  end;

---rule of intruder to emit msg into ch[1].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[1]"
       roleB[j].st = B1 & ch[1].empty=true & i <= pat11Set.length & pat11Set.content[i] != 0 & Spy_known[pat11Set.content[i]] & !emit[pat11Set.content[i]] ---& matchPat(msgs[pat11Set.content[i]], sPat11Set)
      ==>
      begin
         clear ch[1];
        ch[1].msg:=msgs[pat11Set.content[i]];
        ch[1].sender:=Intruder;
        ch[1].receiver:=roleB[j].B;
        ch[1].empty:=false;
        emit[pat11Set.content[i]] := true;
        IntruEmit1 := true;
        put "intruder emit msg into ch[1].\n";
      end;
  endruleset;
endruleset;
--- hash and dehash rules of pat: hash{A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A)}, for intruder
ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "constructHash 3"  --pat3
      roleB[i1].st = B1 &      i<=pat2Set.length & pat2Set.content[i] != 0 & Spy_known[pat2Set.content[i]] &
      matchPat(construct3By2(pat2Set.content[i]), sPat3Set) &
      !Spy_known[constructIndex3By2(pat2Set.content[i])]
      ==>
      var hashMsgNo:indexType;
      hashMsg:Message;
      begin
        put "rule constructHash 3\n";
        hashMsgNo := constructIndex3By2(pat2Set.content[i]);
        if hashMsgNo = msg_end + 1 then
          msg_end := msg_end + 1;
          hashMsg := construct3By2(pat2Set.content[i]);
          msgs[hashMsgNo] := hashMsg;
        endif;
        Spy_known[hashMsgNo]:=true;
        if (!exist(pat3Set,hashMsgNo)) then
          pat3Set.length:=pat3Set.length+1;
          pat3Set.content[pat3Set.length]:=hashMsgNo;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{hash(Ya)}sk(A), for intruder
ruleset i:msgLen do 
  rule "adecrypt 5"	---pat5
    i<=pat5Set.length & pat5Set.content[i] != 0 & Spy_known[pat5Set.content[i]] &
    !Spy_known[msgs[pat5Set.content[i]].aencMsg]
        ==>
    var key_inv:Message;
	      msgPat3:indexType;
	      flag_pat3:boolean;	      num:indexType;
    begin
      put "rule adecrypt5\n";
      key_inv := inverseKey(msgs[msgs[pat5Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat5Set.content[i]].aencMsg]:=true;
        msgPat3:=msgs[pat5Set.content[i]].aencMsg;
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
    rule "aencrypt 5"	---pat5
      roleB[i1].st = B1 &      i<=pat3Set.length & pat3Set.content[i] != 0 & Spy_known[pat3Set.content[i]] &
      j<=pat4Set.length & pat4Set.content[j] != 0 & Spy_known[pat4Set.content[j]] &
      matchPat(construct5By34(pat3Set.content[i],pat4Set.content[j]), sPat5Set) &
      !Spy_known[constructIndex5By34(pat3Set.content[i],pat4Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt5\n";
        if (msgs[pat4Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex5By34(pat3Set.content[i],pat4Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct5By34(pat3Set.content[i],pat4Set.content[j]);
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

--- enconcat and deconcat rules for pat: concat(Ya.aenc{hash(Ya)}sk(A))

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
        isPat2(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat2Set,msgPat1)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat1;
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
      roleB[i].st = B1 &      i1<=pat2Set.length & Spy_known[pat2Set.content[i1]] &
      i2<=pat5Set.length & Spy_known[pat5Set.content[i2]] &
      matchPat(construct6By25(pat2Set.content[i1],pat5Set.content[i2]), sPat6Set)&
      !Spy_known[constructIndex6By25(pat2Set.content[i1],pat5Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat6\n";
        concatMsgNo := constructIndex6By25(pat2Set.content[i1],pat5Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct6By25(pat2Set.content[i1],pat5Set.content[i2]);
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

--- encrypt and decrypt rules of pat: aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B), for intruder
ruleset i:msgLen do 
  rule "adecrypt 8"	---pat8
    i<=pat8Set.length & pat8Set.content[i] != 0 & Spy_known[pat8Set.content[i]] &
    !Spy_known[msgs[pat8Set.content[i]].aencMsg]&
    Spy_known[inverseKeyIndex(msgs[msgs[pat8Set.content[i]].aencKey])]  ==>
    var key_inv:Message;
	      msgPat6:indexType;
	      flag_pat6:boolean;	      num:indexType;
    begin
      put "rule adecrypt8\n";
      key_inv := inverseKey(msgs[msgs[pat8Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat8Set.content[i]].aencMsg]:=true;
        msgPat6:=msgs[pat8Set.content[i]].aencMsg;
        isPat6(msgs[msgPat6],flag_pat6);
        if (flag_pat6) then
          if (!exist(pat6Set,msgPat6)) then
            pat6Set.length:=pat6Set.length+1;
            pat6Set.content[pat6Set.length]:=msgPat6;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "aencrypt 8"	---pat8
      roleB[i1].st = B1 &      i<=pat6Set.length & pat6Set.content[i] != 0 & Spy_known[pat6Set.content[i]] &
      j<=pat7Set.length & pat7Set.content[j] != 0 & Spy_known[pat7Set.content[j]] &
      matchPat(construct8By67(pat6Set.content[i],pat7Set.content[j]), sPat8Set) &
      !Spy_known[constructIndex8By67(pat6Set.content[i],pat7Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt8\n";
        if (msgs[pat7Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex8By67(pat6Set.content[i],pat7Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct8By67(pat6Set.content[i],pat7Set.content[j]);
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

--- enconcat and deconcat rules for pat: concat(Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B))

ruleset i:msgLen do 
  rule "deconcat 9" --pat9
    i<=pat9Set.length & pat9Set.content[i] != 0 & Spy_known[pat9Set.content[i]]   &
    !(Spy_known[msgs[pat9Set.content[i]].concatPart[1]]&Spy_known[msgs[pat9Set.content[i]].concatPart[2]]&Spy_known[msgs[pat9Set.content[i]].concatPart[3]]&Spy_known[msgs[pat9Set.content[i]].concatPart[4]]&Spy_known[msgs[pat9Set.content[i]].concatPart[5]])
    ==>
    var msgPat1,msgPat2,msgPat3,msgPat4,msgPat5:indexType;
        flagPat1,flagPat2,flagPat3,flagPat4,flagPat5:boolean;
    begin
      put "rule deconcat9\n";
      if (!Spy_known[msgs[pat9Set.content[i]].concatPart[1]]) then
        Spy_known[msgs[pat9Set.content[i]].concatPart[1]]:=true;
        msgPat1 := msgs[pat9Set.content[i]].concatPart[1];
        isPat2(msgs[msgPat1],flagPat1);
        if (flagPat1) then
          if(!exist(pat2Set,msgPat1)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat1;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat9Set.content[i]].concatPart[2]]) then
        Spy_known[msgs[pat9Set.content[i]].concatPart[2]]:=true;
        msgPat2 := msgs[pat9Set.content[i]].concatPart[2];
        isPat2(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat2Set,msgPat2)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat9Set.content[i]].concatPart[3]]) then
        Spy_known[msgs[pat9Set.content[i]].concatPart[3]]:=true;
        msgPat3 := msgs[pat9Set.content[i]].concatPart[3];
        isPat1(msgs[msgPat3],flagPat3);
        if (flagPat3) then
          if(!exist(pat1Set,msgPat3)) then
             pat1Set.length:=pat1Set.length+1;
             pat1Set.content[pat1Set.length] := msgPat3;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat9Set.content[i]].concatPart[4]]) then
        Spy_known[msgs[pat9Set.content[i]].concatPart[4]]:=true;
        msgPat4 := msgs[pat9Set.content[i]].concatPart[4];
        isPat2(msgs[msgPat4],flagPat4);
        if (flagPat4) then
          if(!exist(pat2Set,msgPat4)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat4;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat9Set.content[i]].concatPart[5]]) then
        Spy_known[msgs[pat9Set.content[i]].concatPart[5]]:=true;
        msgPat5 := msgs[pat9Set.content[i]].concatPart[5];
        isPat8(msgs[msgPat5],flagPat5);
        if (flagPat5) then
          if(!exist(pat8Set,msgPat5)) then
             pat8Set.length:=pat8Set.length+1;
             pat8Set.content[pat8Set.length] := msgPat5;
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
    rule "enconcat 9"	---pat9
      roleB[i].st = B1 &      i1<=pat2Set.length & Spy_known[pat2Set.content[i1]] &
      i2<=pat2Set.length & Spy_known[pat2Set.content[i2]] &
      i3<=pat1Set.length & Spy_known[pat1Set.content[i3]] &
      i4<=pat2Set.length & Spy_known[pat2Set.content[i4]] &
      i5<=pat8Set.length & Spy_known[pat8Set.content[i5]] &
      matchPat(construct9By22128(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat8Set.content[i5]), sPat9Set)&
      !Spy_known[constructIndex9By22128(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat8Set.content[i5])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat9\n";
        concatMsgNo := constructIndex9By22128(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat8Set.content[i5]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct9By22128(pat2Set.content[i1],pat2Set.content[i2],pat1Set.content[i3],pat2Set.content[i4],pat8Set.content[i5]);
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
endruleset;
endruleset;
endruleset;
endruleset;

--- encrypt and decrypt rules of pat: aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A), for intruder
ruleset i:msgLen do 
  rule "adecrypt 10"	---pat10
    i<=pat10Set.length & pat10Set.content[i] != 0 & Spy_known[pat10Set.content[i]] &
    !Spy_known[msgs[pat10Set.content[i]].aencMsg]
        ==>
    var key_inv:Message;
	      msgPat9:indexType;
	      flag_pat9:boolean;	      num:indexType;
    begin
      put "rule adecrypt10\n";
      key_inv := inverseKey(msgs[msgs[pat10Set.content[i]].aencKey]);
      get_msgNo(key_inv,num);
      if (key_inv.k.ag = Intruder | Spy_known[num]) then
        Spy_known[msgs[pat10Set.content[i]].aencMsg]:=true;
        msgPat9:=msgs[pat10Set.content[i]].aencMsg;
        isPat9(msgs[msgPat9],flag_pat9);
        if (flag_pat9) then
          if (!exist(pat9Set,msgPat9)) then
            pat9Set.length:=pat9Set.length+1;
            pat9Set.content[pat9Set.length]:=msgPat9;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "aencrypt 10"	---pat10
      roleB[i1].st = B1 &      i<=pat9Set.length & pat9Set.content[i] != 0 & Spy_known[pat9Set.content[i]] &
      j<=pat4Set.length & pat4Set.content[j] != 0 & Spy_known[pat4Set.content[j]] &
      matchPat(construct10By94(pat9Set.content[i],pat4Set.content[j]), sPat10Set) &
      !Spy_known[constructIndex10By94(pat9Set.content[i],pat4Set.content[j])] 
    ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule aencrypt10\n";
        if (msgs[pat4Set.content[j]].k.encType=PK) then
          encMsgNo := constructIndex10By94(pat9Set.content[i],pat4Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg := construct10By94(pat9Set.content[i],pat4Set.content[j]);
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

--- enconcat and deconcat rules for pat: concat(A.aenc{Ta.Na.B.Xa.aenc{Ya.aenc{hash(Ya)}sk(A)}pk(B)}sk(A))

ruleset i:msgLen do 
  rule "deconcat 11" --pat11
    i<=pat11Set.length & pat11Set.content[i] != 0 & Spy_known[pat11Set.content[i]]   &
    !(Spy_known[msgs[pat11Set.content[i]].concatPart[1]]&Spy_known[msgs[pat11Set.content[i]].concatPart[2]])
    ==>
    var msgPat1,msgPat2:indexType;
        flagPat1,flagPat2:boolean;
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
        isPat10(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat10Set,msgPat2)) then
             pat10Set.length:=pat10Set.length+1;
             pat10Set.content[pat10Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleBNums do
    rule "enconcat 11"	---pat11
      roleB[i].st = B1 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat10Set.length & Spy_known[pat10Set.content[i2]] &
      matchPat(construct11By110(pat1Set.content[i1],pat10Set.content[i2]), sPat11Set)&
      !Spy_known[constructIndex11By110(pat1Set.content[i1],pat10Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat11\n";
        concatMsgNo := constructIndex11By110(pat1Set.content[i1],pat10Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct11By110(pat1Set.content[i1],pat10Set.content[i2]);
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

startstate
  roleA[1].A := Alice;
  roleA[1].B := Intruder;
  roleA[1].Na := Na;
  roleA[1].Ta := Ta;
  roleA[1].Xa := Xa;
  roleA[1].Ya := Ya;
  roleA[1].st := A1;
  roleA[1].commit := false;

  roleB[1].A := Alice;
  roleB[1].st := B1;
  roleB[1].commit := false;
  roleB[1].Na := anyNonce;
  roleB[1].Ta := anyNonce;
  roleB[1].Xa := anyNonce;
  roleB[1].Ya := anyNonce;
  roleB[1].B := anyAgent;


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
    IntruEmit1 := false;
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
  pat4Set.length := pat4Set.length + 1; 
  pat4Set.content[pat4Set.length] :=msg_end;
  Spy_known[msg_end] := true;
    for i : roleANums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleA[i].A;
    msgs[msg_end].k.encType:=PK;
    msgs[msg_end].length := 1;
    pat7Set.length := pat7Set.length + 1;
    pat7Set.content[pat7Set.length] :=msg_end;
    Spy_known[msg_end] := true;
    A_known[msg_end] := true;
  endfor;
  for i : roleANums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleA[i].A;
    msgs[msg_end].k.encType:=SK;
    msgs[msg_end].length := 1;
    pat4Set.length := pat4Set.length + 1;
    pat4Set.content[pat4Set.length] :=msg_end;
    A_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleB[i].B;
    msgs[msg_end].k.encType:=PK;
    msgs[msg_end].length := 1;
    pat7Set.length := pat7Set.length + 1;
    pat7Set.content[pat7Set.length] :=msg_end;
    Spy_known[msg_end] := true;
    B_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag := roleB[i].B;
    msgs[msg_end].k.encType:=SK;
    msgs[msg_end].length := 1;
    pat4Set.length := pat4Set.length + 1;
    pat4Set.content[pat4Set.length] :=msg_end;
    B_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    constructSpat11(roleB[i].A,roleB[i].Ta,roleB[i].Na,roleB[i].B,roleB[i].Xa,roleB[i].Ya,roleB[i].A,roleB[i].B, gnum);
  endfor;

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
