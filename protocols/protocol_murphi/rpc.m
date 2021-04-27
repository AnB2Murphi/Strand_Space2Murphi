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

  AgentType : enum{anyAgent,Intruder, Alice, Bob}; ---Intruder 
  NonceType : enum{anyNonce, Na, Nb, Nb1, kab};
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

  AStatus: enum{A1,A2,A3,A4};
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
   Nb : NonceType;
   Nb1 : NonceType;
   kab : NonceType;
   A : AgentType;
   B : AgentType;


   locNa : NonceType;
   locNb : NonceType;
   locNb1 : NonceType;
   lockab : NonceType;
   locA : AgentType;
   locB : AgentType;
   
   
   st: AStatus;
   commit : boolean;
  end;
  RoleB : record
   Na : NonceType;
   Nb : NonceType;
   Nb1 : NonceType;
   kab : NonceType;
   A : AgentType;
   B : AgentType;


   locNa : NonceType;
   locNb : NonceType;
   locNb1 : NonceType;
   lockab : NonceType;
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

  A_known : Array[indexType] of boolean;
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

--- Sorry, construct_function of this pattern has not been written!

function construct4By23(msgNo21, msgNo32:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo21 & msgs[i].sencKey = msgNo32) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := senc;
     msg.sencMsg := msgNo21;
     msg.sencKey := msgNo32;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex4By23(msgNo21, msgNo32:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo21 & msgs[i].sencKey = msgNo32) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
      index:= msg_end + 1;
   endif;
   return index;
  end;
function construct5By14(msgNo1,msgNo2:indexType):Message;
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

function constructIndex5By14(msgNo1,msgNo2:indexType):indexType;
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

function construct6By22(msgNo1,msgNo2:indexType):Message;
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

function constructIndex6By22(msgNo1,msgNo2:indexType):indexType;
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

function construct7By63(msgNo61, msgNo32:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo61 & msgs[i].sencKey = msgNo32) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := senc;
     msg.sencMsg := msgNo61;
     msg.sencKey := msgNo32;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex7By63(msgNo61, msgNo32:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo61 & msgs[i].sencKey = msgNo32) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
      index:= msg_end + 1;
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

---pat2: Na 
procedure lookAddPat2(Na:NonceType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
      index:=0;
      for i: indexType do
        if(msgs[i].msgType=nonce) then
          if(msgs[i].noncePart=Na) then
            index:=i;
          endif;
        endif;
      endfor;
      if(index=0) then
        msg_end := msg_end + 1 ;
        index := msg_end;
        msgs[index].msgType := nonce;
        msgs[index].noncePart:=Na; 
        msgs[index].length := 1;
      endif;
      num:=index;
      msg:=msgs[index];
  end;

---pat2: Na 
procedure isPat2(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = nonce) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat2: Na 
procedure constructSpat2(Na:NonceType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = nonce) then
        if (msgs[i].noncePart = Na) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := nonce;
      msgs[index].noncePart := Na;
      msgs[index].length := 1;
    endif;
    sPat2Set.length := sPat2Set.length + 1;
    sPat2Set.content[sPat2Set.length] := index;
    num := index;
  end;

---pat3: k(A,B) 
procedure lookAddPat3(Asymk1:AgentType; Bsymk2:AgentType; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    index := 0;
    for i :indexType do
      if (msgs[i].msgType = key) then 
        if (msgs[i].k.encType = Symk & msgs[i].k.ag1 = Asymk1 & msgs[i].k.ag2 = Bsymk2) then
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
      msgs[index].k.ag2:=Bsymk2;
    endif;
    num := index;
    msg := msgs[index];
  end;

---pat3: k(A,B) 
procedure isPat3(msg:Message; Var flag:boolean);
  var flag1:boolean;
  begin
    flag1:=false;
    if msg.msgType = key & msg.k.encType = Symk then
      flag1:=true;
    endif;
    flag:=flag1;
  end;

---spat3: k(A,B) 
procedure constructSpat3(Asymk1:AgentType; Bsymk2:AgentType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = key & msgs[i].k.encType = Symk) then
        if (msgs[i].k.ag1 = Asymk1 & msgs[i].k.ag2 = Bsymk2) then
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
      msgs[index].k.ag2 := Bsymk2;
      msgs[index].length := 1;
    endif;
    sPat3Set.length := sPat3Set.length + 1;
    sPat3Set.content[sPat3Set.length] := index;
    num := index;
  end;

---pat4: senc{Na}k(A,B) 
procedure lookAddPat4(Na:NonceType; Asymk1:AgentType; Bsymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(Na,msg1,i1);
   lookAddPat3(Asymk1, Bsymk2,msg2,i2);
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

---pat4: senc{Na}k(A,B) 
procedure isPat4(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = senc then
      isPat2(msgs[msg.sencMsg],flagPart1);
      isPat3(msgs[msg.sencKey],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat4: senc{Na}k(A,B) 
procedure constructSpat4(Na:NonceType; Asymk1:AgentType; Bsymk2:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat2(Na, i1);
    constructSpat3(Asymk1, Bsymk2, i2);
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
    sPat4Set.length := sPat4Set.length + 1;
    sPat4Set.content[sPat4Set.length] := index;
    num := index;
  end;

---pat5: A.senc{Na}k(A,B) 
procedure lookAddPat5(A:AgentType; Na:NonceType; Asymk1:AgentType; Bsymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(A, msg1, i1);
   lookAddPat4(Na, Asymk1, Bsymk2, msg2, i2);
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

---pat5: A.senc{Na}k(A,B) 
procedure isPat5(msg:Message; Var flag:boolean);
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
---spat5: A.senc{Na}k(A,B) 
procedure constructSpat5(A:AgentType; Na:NonceType; Asymk1:AgentType; Bsymk2:AgentType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat1(A, i1);
    constructSpat4(Na, Asymk1, Bsymk2, i2);
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

---pat6: Na.Nb 
procedure lookAddPat6(Na:NonceType; Nb:NonceType; Var msg:Message; Var num : indexType);
  Var msg1,msg2: Message;
     index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(Na, msg1, i1);
   lookAddPat2(Nb, msg2, i2);
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

---pat6: Na.Nb 
procedure isPat6(msg:Message; Var flag:boolean);
  var flag1, flagPart1,flagPart2: boolean;
  begin
     flag1 := false;
     flagPart1 := false;
     flagPart2 := false;
     if(msg.msgType = concat) then
        isPat2(msgs[msg.concatPart[1]],flagPart1);
        isPat2(msgs[msg.concatPart[2]],flagPart2);
       if (flagPart1 & flagPart2) then 
         flag1 := true;
       endif;
     endif;
     flag := flag1;
  end;
---spat6: Na.Nb 
procedure constructSpat6(Na:NonceType; Nb:NonceType; Var num: indexType);
  Var i,index, i1, i2:indexType;
  begin
    index:=0;
    constructSpat2(Na, i1);
    constructSpat2(Nb, i2);
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

---pat7: senc{Na.Nb}k(A,B) 
procedure lookAddPat7(Na:NonceType; Nb:NonceType; Asymk1:AgentType; Bsymk2:AgentType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat6(Na, Nb,msg1,i1);
   lookAddPat3(Asymk1, Bsymk2,msg2,i2);
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

---pat7: senc{Na.Nb}k(A,B) 
procedure isPat7(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = senc then
      isPat6(msgs[msg.sencMsg],flagPart1);
      isPat3(msgs[msg.sencKey],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat7: senc{Na.Nb}k(A,B) 
procedure constructSpat7(Na:NonceType; Nb:NonceType; Asymk1:AgentType; Bsymk2:AgentType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat6(Na, Nb, i1);
    constructSpat3(Asymk1, Bsymk2, i2);
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
    sPat7Set.length := sPat7Set.length + 1;
    sPat7Set.content[sPat7Set.length] := index;
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
procedure cons2(Na:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat2(Na,msg,num);
  end;
procedure destruct2(msg:Message; Var Na:NonceType);
  begin
    Na:=msg.noncePart;
  end;
procedure cons3(Asymk1:AgentType; Bsymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat3(Asymk1, Bsymk2,msg,num);
  end;
procedure destruct3(msg:Message; Var Asymk1:AgentType; Var Bsymk2:AgentType);
  var k1:KeyType;
      msg1:Message;
   begin
      clear msg1;
      k1 := msg.k;
      Asymk1 := k1.ag1;
      Bsymk2 := k1.ag2;
   end;
procedure cons4(Na:NonceType; Asymk1:AgentType; Bsymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat4(Na, Asymk1, Bsymk2,msg,num);
  end;
procedure destruct4(msg:Message; Var Na:NonceType; Var Asymk1:AgentType; Var Bsymk2:AgentType);
  var k1:KeyType;
      sencMsg:Message;
   begin
      clear sencMsg;
      k1 := msgs[msg.sencKey].k;
      Asymk1:=k1.ag1;
      Bsymk2:=k1.ag2;
      sencMsg:=msgs[msg.sencMsg];
      Na:=sencMsg.noncePart;
   end;
procedure cons5(A:AgentType; Na:NonceType; Asymk1:AgentType; Bsymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat5(A, Na, Asymk1, Bsymk2,msg,num);
  end;
procedure destruct5(msg:Message; Var A:AgentType; Var Na:NonceType; Var Asymk1:AgentType; Var Bsymk2:AgentType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    A := msgNum1.ag;
    msgNum2 := msgs[msg.concatPart[2]];
    destruct4(msgNum2,Na, Asymk1, Bsymk2)
  end;
procedure cons6(Na:NonceType; Nb:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat6(Na, Nb,msg,num);
  end;
procedure destruct6(msg:Message; Var Na:NonceType; Var Nb:NonceType);
  Var msgNum1,msgNum2: Message;
      k: KeyType;
  begin
    msgNum1 := msgs[msg.concatPart[1]];
    Na := msgNum1.noncePart;
    msgNum2 := msgs[msg.concatPart[2]];
    Nb := msgNum2.noncePart
  end;
procedure cons7(Na:NonceType; Nb:NonceType; Asymk1:AgentType; Bsymk2:AgentType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat7(Na, Nb, Asymk1, Bsymk2,msg,num);
  end;
procedure destruct7(msg:Message; Var Na:NonceType; Var Nb:NonceType; Var Asymk1:AgentType; Var Bsymk2:AgentType);
  var k1:KeyType;
      sencMsg:Message;
      sencKey:Message;
      begin
       sencMsg:=msgs[msg.sencMsg];
       sencKey:=msgs[msg.sencKey];
       destruct6(sencMsg,Na, Nb);
       destruct3(sencKey,Asymk1, Bsymk2);
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
   cons5(roleA[i].A,roleA[i].Na,roleA[i].A,roleA[i].B,msg,msgNo);
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
var flag_pat7:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[2].msg;
   isPat7(msg, flag_pat7);
   if(flag_pat7 & A_known[msg.sencKey]) then
     destruct7(msg,roleA[i].locNa,roleA[i].locNb,roleA[i].locA,roleA[i].locB);
     if(matchNonce(roleA[i].locNa, roleA[i].Na) & matchNonce(roleA[i].locNb, roleA[i].Nb) & matchAgent(roleA[i].locA, roleA[i].A) & matchAgent(roleA[i].locB, roleA[i].B))then
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
   cons4(roleA[i].Nb,roleA[i].A,roleA[i].B,msg,msgNo);
   ch[3].empty := false;
   ch[3].msg := msg;
   ch[3].sender := roleA[i].A;
   ch[3].receiver := Intruder;
   roleA[i].st := A4;
   put "roleA[i] in st3\n";
end;
rule " roleA4 "
roleA[i].st = A4 & ch[4].empty = false & !roleA[i].commit & judge(ch[4].msg,roleA[i].A,msgs[0]) 
==>
var flag_pat7:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[4].msg;
   isPat7(msg, flag_pat7);
   if(flag_pat7 & A_known[msg.sencKey]) then
     destruct7(msg,roleA[i].lockab,roleA[i].locNb1,roleA[i].locA,roleA[i].locB);
     if(matchNonce(roleA[i].lockab, roleA[i].kab) & matchNonce(roleA[i].locNb1, roleA[i].Nb1) & matchAgent(roleA[i].locA, roleA[i].A) & matchAgent(roleA[i].locB, roleA[i].B))then
       ch[4].empty:=true;
       clear ch[4].msg;
       roleA[i].st := A1;
     endif;
   endif;
   put "roleA[i] in st4\n";
   roleA[i].commit := true;
end;
endruleset;

ruleset i:roleBNums do
rule " roleB1 "
roleB[i].st = B1 & ch[1].empty = false & !roleB[i].commit & judge(ch[1].msg,roleB[i].B,msgs[0]) 
==>
var flag_pat5:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[1].msg;
   isPat5(msg, flag_pat5);
   if(flag_pat5) then
     destruct5(msg,roleB[i].locA,roleB[i].locNa,roleB[i].locA,roleB[i].locB);
     if(matchAgent(roleB[i].locA, roleB[i].A) & matchNonce(roleB[i].locNa, roleB[i].Na) & matchAgent(roleB[i].locA, roleB[i].A) & matchAgent(roleB[i].locB, roleB[i].B))then
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
   cons7(roleB[i].Na,roleB[i].Nb,roleB[i].A,roleB[i].B,msg,msgNo);
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
var flag_pat4:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[3].msg;
   isPat4(msg, flag_pat4);
   if(flag_pat4 & B_known[msg.sencKey]) then
     destruct4(msg,roleB[i].locNb,roleB[i].locA,roleB[i].locB);
     if(matchNonce(roleB[i].locNb, roleB[i].Nb) & matchAgent(roleB[i].locA, roleB[i].A) & matchAgent(roleB[i].locB, roleB[i].B))then
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
   cons7(roleB[i].kab,roleB[i].Nb1,roleB[i].A,roleB[i].B,msg,msgNo);
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
  var flag_pat5:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[1].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat5(msg,flag_pat5);
    if (flag_pat5) then
      if(!exist(pat5Set,msgNo)) then
        pat5Set.length:=pat5Set.length+1;
        pat5Set.content[pat5Set.length]:=msgNo;
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
  var flag_pat4:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[3].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat4(msg,flag_pat4);
    if (flag_pat4) then
      if(!exist(pat4Set,msgNo)) then
        pat4Set.length:=pat4Set.length+1;
        pat4Set.content[pat4Set.length]:=msgNo;
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
  var flag_pat7:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[2].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat7(msg,flag_pat7);
    if (flag_pat7) then
      if(!exist(pat7Set,msgNo)) then
        pat7Set.length:=pat7Set.length+1;
        pat7Set.content[pat7Set.length]:=msgNo;
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
  var flag_pat7:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[4].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat7(msg,flag_pat7);
    if (flag_pat7) then
      if(!exist(pat7Set,msgNo)) then
        pat7Set.length:=pat7Set.length+1;
        pat7Set.content[pat7Set.length]:=msgNo;
        Spy_known[msgNo] := true;
      endif;
      ch[4].empty := true;
      clear ch[4].msg;
    endif;
    put "intruder get msg from ch[4].\n";
  end;

---rule of intruder to emit msg into ch[2].
ruleset i: msgLen do
  ruleset j: roleANums do
    rule "intruderEmitMsgIntoCh[2]"
      IntruEmit1 = true & roleA[j].st = A2 & ch[2].empty=true & i <= pat7Set.length & pat7Set.content[i] != 0 & Spy_known[pat7Set.content[i]] & !emit[pat7Set.content[i]] ---& matchPat(msgs[pat7Set.content[i]], sPat7Set)
      ==>
      begin
         clear ch[2];
        ch[2].msg:=msgs[pat7Set.content[i]];
        ch[2].sender:=Intruder;
        ch[2].receiver:=roleA[j].A;
        ch[2].empty:=false;
        emit[pat7Set.content[i]] := true;
        IntruEmit2 := true;
        put "intruder emit msg into ch[2].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[4].
ruleset i: msgLen do
  ruleset j: roleANums do
    rule "intruderEmitMsgIntoCh[4]"
      IntruEmit3 = true & roleA[j].st = A4 & ch[4].empty=true & i <= pat7Set.length & pat7Set.content[i] != 0 & Spy_known[pat7Set.content[i]] & !emit[pat7Set.content[i]] ---& matchPat(msgs[pat7Set.content[i]], sPat7Set)
      ==>
      begin
         clear ch[4];
        ch[4].msg:=msgs[pat7Set.content[i]];
        ch[4].sender:=Intruder;
        ch[4].receiver:=roleA[j].A;
        ch[4].empty:=false;
        emit[pat7Set.content[i]] := true;
        IntruEmit4 := true;
        put "intruder emit msg into ch[4].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[1].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[1]"
       roleB[j].st = B1 & ch[1].empty=true & i <= pat5Set.length & pat5Set.content[i] != 0 & Spy_known[pat5Set.content[i]] & !emit[pat5Set.content[i]] ---& matchPat(msgs[pat5Set.content[i]], sPat5Set)
      ==>
      begin
         clear ch[1];
        ch[1].msg:=msgs[pat5Set.content[i]];
        ch[1].sender:=Intruder;
        ch[1].receiver:=roleB[j].B;
        ch[1].empty:=false;
        emit[pat5Set.content[i]] := true;
        IntruEmit1 := true;
        put "intruder emit msg into ch[1].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[3].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[3]"
      IntruEmit2 = true & roleB[j].st = B3 & ch[3].empty=true & i <= pat4Set.length & pat4Set.content[i] != 0 & Spy_known[pat4Set.content[i]] & !emit[pat4Set.content[i]] ---& matchPat(msgs[pat4Set.content[i]], sPat4Set)
      ==>
      begin
         clear ch[3];
        ch[3].msg:=msgs[pat4Set.content[i]];
        ch[3].sender:=Intruder;
        ch[3].receiver:=roleB[j].B;
        ch[3].empty:=false;
        emit[pat4Set.content[i]] := true;
        IntruEmit3 := true;
        put "intruder emit msg into ch[3].\n";
      end;
  endruleset;
endruleset;
--- encrypt and decrypt rules of pat senc(Na,k(A,B))
ruleset i:msgLen do
  rule "sdecrypt 4" --pat4
    i<=pat4Set.length & pat4Set.content[i] != 0
    & Spy_known[pat4Set.content[i]] & !Spy_known[msgs[pat4Set.content[i]].sencMsg] & Spy_known[inverseKeyIndex(msgs[msgs[pat4Set.content[i]].sencKey])]
    ==>
    var key_inv:Message;
	      msgPat2,keyNo:indexType;
	      flag_pat2:boolean;
    begin
      put "rule sdecrypt4\n";
      key_inv := inverseKey(msgs[msgs[pat4Set.content[i]].sencKey]);
      get_msgNo(key_inv,keyNo);
      if ( (key_inv.k.encType = Symk & (key_inv.k.ag1 = Intruder | key_inv.k.ag2 = Intruder)) | Spy_known[keyNo]) then
        Spy_known[msgs[pat4Set.content[i]].sencMsg]:=true;
        msgPat2:=msgs[pat4Set.content[i]].sencMsg;
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
    rule "sencrypt 4"  --pat4
      roleB[i1].st = B1 &      i<=pat2Set.length & pat2Set.content[i] != 0 & Spy_known[pat2Set.content[i]] &
      j<=pat3Set.length & pat3Set.content[j] != 0 & Spy_known[pat3Set.content[j]] &
      matchPat(construct4By23(pat2Set.content[i],pat3Set.content[j]), sPat4Set) &
      !Spy_known[constructIndex4By23(pat2Set.content[i],pat3Set.content[j])] 
       ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule sencrypt4\n";
        if (msgs[pat3Set.content[j]].k.encType=Symk) then
          encMsgNo := constructIndex4By23(pat2Set.content[i],pat3Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg:= construct4By23(pat2Set.content[i],pat3Set.content[j]);
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

--- enconcat and deconcat rules for pat: concat(A.senc{Na}k(A,B))

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
      roleB[i].st = B1 &      i1<=pat1Set.length & Spy_known[pat1Set.content[i1]] &
      i2<=pat4Set.length & Spy_known[pat4Set.content[i2]] &
      matchPat(construct5By14(pat1Set.content[i1],pat4Set.content[i2]), sPat5Set)&
      !Spy_known[constructIndex5By14(pat1Set.content[i1],pat4Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat5\n";
        concatMsgNo := constructIndex5By14(pat1Set.content[i1],pat4Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct5By14(pat1Set.content[i1],pat4Set.content[i2]);
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

--- enconcat and deconcat rules for pat: concat(Na.Nb)

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
        isPat2(msgs[msgPat2],flagPat2);
        if (flagPat2) then
          if(!exist(pat2Set,msgPat2)) then
             pat2Set.length:=pat2Set.length+1;
             pat2Set.content[pat2Set.length] := msgPat2;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i1: msgLen do
  ruleset i2: msgLen do 
    ruleset i: roleANums do
    rule "enconcat 6"	---pat6
      roleA[i].st = A2 &      i1<=pat2Set.length & Spy_known[pat2Set.content[i1]] &
      i2<=pat2Set.length & Spy_known[pat2Set.content[i2]] &
      matchPat(construct6By22(pat2Set.content[i1],pat2Set.content[i2]), sPat6Set)&
      !Spy_known[constructIndex6By22(pat2Set.content[i1],pat2Set.content[i2])] 
      ==>
      var concatMsgNo:indexType;
      concatMsg:Message;
      begin
        put "rule enconcat6\n";
        concatMsgNo := constructIndex6By22(pat2Set.content[i1],pat2Set.content[i2]);
        if concatMsgNo = msg_end + 1 then 
          msg_end :=msg_end + 1;
          concatMsg:= construct6By22(pat2Set.content[i1],pat2Set.content[i2]);
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

--- encrypt and decrypt rules of pat senc(Na.Nb,k(A,B))
ruleset i:msgLen do
  rule "sdecrypt 7" --pat7
    i<=pat7Set.length & pat7Set.content[i] != 0
    & Spy_known[pat7Set.content[i]] & !Spy_known[msgs[pat7Set.content[i]].sencMsg] & Spy_known[inverseKeyIndex(msgs[msgs[pat7Set.content[i]].sencKey])]
    ==>
    var key_inv:Message;
	      msgPat6,keyNo:indexType;
	      flag_pat6:boolean;
    begin
      put "rule sdecrypt7\n";
      key_inv := inverseKey(msgs[msgs[pat7Set.content[i]].sencKey]);
      get_msgNo(key_inv,keyNo);
      if ( (key_inv.k.encType = Symk & (key_inv.k.ag1 = Intruder | key_inv.k.ag2 = Intruder)) | Spy_known[keyNo]) then
        Spy_known[msgs[pat7Set.content[i]].sencMsg]:=true;
        msgPat6:=msgs[pat7Set.content[i]].sencMsg;
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
    ruleset i1: roleANums do
    rule "sencrypt 7"  --pat7
      roleA[i1].st = A2 &      i<=pat6Set.length & pat6Set.content[i] != 0 & Spy_known[pat6Set.content[i]] &
      j<=pat3Set.length & pat3Set.content[j] != 0 & Spy_known[pat3Set.content[j]] &
      matchPat(construct7By63(pat6Set.content[i],pat3Set.content[j]), sPat7Set) &
      !Spy_known[constructIndex7By63(pat6Set.content[i],pat3Set.content[j])] 
       ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule sencrypt7\n";
        if (msgs[pat3Set.content[j]].k.encType=Symk) then
          encMsgNo := constructIndex7By63(pat6Set.content[i],pat3Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg:= construct7By63(pat6Set.content[i],pat3Set.content[j]);
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

startstate
  roleA[1].A := Alice;
  roleA[1].B := Bob;
    roleA[1].Na := Na;
  roleA[1].st := A1;
  roleA[1].commit := false;
  roleA[1].Nb := anyNonce;
  roleA[1].Nb1 := anyNonce;
  roleA[1].kab := anyNonce;

  roleB[1].A := Alice;
  roleB[1].B := Bob;
    roleB[1].Nb := Nb;
  roleB[1].Nb1 := Nb1;
  roleB[1].kab := kab;
  roleB[1].st := B1;
  roleB[1].commit := false;
  roleB[1].Na := anyNonce;


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
  pat8Set.length := pat8Set.length + 1; 
  pat8Set.content[pat8Set.length] :=msg_end;
  Spy_known[msg_end] := true;
    for i : roleANums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag1 := roleA[i].A;
    msgs[msg_end].k.ag2 := roleA[i].B;
    msgs[msg_end].k.encType:=Symk;
    msgs[msg_end].length := 1;
    pat3Set.length := pat3Set.length + 1;
    pat3Set.content[pat3Set.length] :=msg_end;
    Spy_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    msg_end := msg_end+1;
    msgs[msg_end].msgType := key;
    msgs[msg_end].k.ag1 := roleA[i].A;
    msgs[msg_end].k.ag2 := roleA[i].B;
    msgs[msg_end].k.encType:=Symk;
    msgs[msg_end].length := 1;
    pat3Set.length := pat3Set.length + 1;
    pat3Set.content[pat3Set.length] :=msg_end;
    Spy_known[msg_end] := true;
  endfor;
  for i : roleBNums do
    constructSpat5(roleB[i].A,roleB[i].Na,roleB[i].A,roleB[i].B, gnum);
  endfor;
  for i : roleBNums do
    constructSpat4(roleB[i].Nb,roleB[i].A,roleB[i].B, gnum);
  endfor;
  for i : roleANums do
    constructSpat7(roleA[i].Na,roleA[i].Nb,roleA[i].A,roleA[i].B, gnum);
  endfor;
  for i : roleANums do
    constructSpat7(roleA[i].kab,roleA[i].Nb1,roleA[i].A,roleA[i].B, gnum);
  endfor;

end;

invariant "secrecy" 
forall i:indexType do
    (msgs[i].msgType=nonce & msgs[i].noncePart=kab)
     ->
     Spy_known[i] = false
end;
