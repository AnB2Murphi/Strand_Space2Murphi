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
  NonceType : enum{anyNonce, Na};
  ConstType : enum{anyNumber, g, p, x, y, xi, yi};
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
   A : AgentType;
   B : AgentType;
   m2 : Message;
   m1 : Message;
   m3 : Message;
   g : ConstType;
   p : ConstType;
   x : ConstType;
   y : ConstType;
   xi : ConstType;
   yi : ConstType;
   locNa : NonceType;
   locA : AgentType;
   locB : AgentType;
   locm2 : Message;
   locm1 : Message;
   locm3 : Message;
   locg : ConstType;
   locp : ConstType;
   locx : ConstType;
   locy : ConstType;
   locxi : ConstType;
   locyi : ConstType;
   st: AStatus;
   commit : boolean;
  end;
  RoleB : record
   Na : NonceType;
   A : AgentType;
   B : AgentType;
   m2 : Message;
   m1 : Message;
   m3 : Message;
   g : ConstType;
   p : ConstType;
   x : ConstType;
   y : ConstType;
   xi : ConstType;
   yi : ConstType;
   locNa : NonceType;
   locA : AgentType;
   locB : AgentType;
   locm2 : Message;
   locm1 : Message;
   locm3 : Message;
   locg : ConstType;
   locp : ConstType;
   locx : ConstType;
   locy : ConstType;
   locxi : ConstType;
   locyi : ConstType;
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

function construct2By11(msgNo11, msgNo12:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = e) then
       if (msgs[i].expMsg1 = msgNo11 & msgs[i].expMsg2 = msgNo12) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := e;
     msg.expMsg1 := msgNo11;
     msg.expMsg2 := msgNo12;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex2By11(msgNo11, msgNo12:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = e) then
       if (msgs[i].expMsg1 = msgNo11 & msgs[i].expMsg2 = msgNo12) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end+1;
   endif;
   return index;
  end;
function construct3By21(msgNo21, msgNo12:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = mod) then
       if (msgs[i].modMsg1 = msgNo21 & msgs[i].modMsg2 = msgNo12) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := mod;
     msg.modMsg1 := msgNo21;
     msg.modMsg2 := msgNo12;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex3By21(msgNo21, msgNo12:indexType):indexType;
  var index : indexType;
  msg:Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = mod) then
       if (msgs[i].modMsg1 = msgNo21 & msgs[i].modMsg2 = msgNo12) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
      index:=msg_end + 1;
   endif;
   return index;
  end;
--- Sorry, construct_function of this pattern has not been written!

--- Sorry, construct_function of this pattern has not been written!

function construct6By41(msgNo41, msgNo12:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = e) then
       if (msgs[i].expMsg1 = msgNo41 & msgs[i].expMsg2 = msgNo12) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := e;
     msg.expMsg1 := msgNo41;
     msg.expMsg2 := msgNo12;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex6By41(msgNo41, msgNo12:indexType):indexType;
  var index : indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = e) then
       if (msgs[i].expMsg1 = msgNo41 & msgs[i].expMsg2 = msgNo12) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
     index := msg_end+1;
   endif;
   return index;
  end;
function construct7By61(msgNo61, msgNo12:indexType):Message;
  var index : indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = mod) then
       if (msgs[i].modMsg1 = msgNo61 & msgs[i].modMsg2 = msgNo12) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := mod;
     msg.modMsg1 := msgNo61;
     msg.modMsg2 := msgNo12;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex7By61(msgNo61, msgNo12:indexType):indexType;
  var index : indexType;
  msg:Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = mod) then
       if (msgs[i].modMsg1 = msgNo61 & msgs[i].modMsg2 = msgNo12) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
      index:=msg_end + 1;
   endif;
   return index;
  end;
function construct8By57(msgNo51, msgNo72:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo51 & msgs[i].sencKey = msgNo72) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := senc;
     msg.sencMsg := msgNo51;
     msg.sencKey := msgNo72;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex8By57(msgNo51, msgNo72:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo51 & msgs[i].sencKey = msgNo72) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
      index:= msg_end + 1;
   endif;
   return index;
  end;
--- Sorry, construct_function of this pattern has not been written!

--- Sorry, construct_function of this pattern has not been written!

function construct11By107(msgNo101, msgNo72:indexType):Message;
  var index: indexType;
      msg : Message;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo101 & msgs[i].sencKey = msgNo72) then
         index := i;
         msg := msgs[index];
       endif;
     endif;
   endfor;
   if (index = 0) then 
     msg.msgType := senc;
     msg.sencMsg := msgNo101;
     msg.sencKey := msgNo72;
     msg.length := 1;
   endif;
   return msg;
  end;
function constructIndex11By107(msgNo101, msgNo72:indexType):indexType;
  var index: indexType;
  begin
   index := 0;
   for i :indexType do
     if (msgs[i].msgType = senc) then
       if (msgs[i].sencMsg = msgNo101 & msgs[i].sencKey = msgNo72) then
         index := i;
       endif;
     endif;
   endfor;
   if (index = 0) then 
      index:= msg_end + 1;
   endif;
   return index;
  end;
---pat1: g 
procedure lookAddPat1(g:ConstType; Var msg:Message; Var num : indexType);
 Var index : indexType;
 begin
    index:=0;
    for i: indexType do
     if (msgs[i].msgType = number) then
       if (msgs[i].constPart = g) then
         index:=i;
       endif;
     endif;
    endfor;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := number;
      msgs[index].constPart:=g; 
      msgs[index].length := 1;
    endif;
    num:=index;
    msg:=msgs[index];
   end;

---pat1: g 
procedure isPat1(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = number) then
    flag1 := true;
    endif;
    flag := flag1;
  end;

---spat1: g 
procedure constructSpat1(g:ConstType; Var num: indexType);
  Var i, index : indexType;
  begin
   index:=0;
   i := 1;
   while(i<= msg_end) do
      if (msgs[i].msgType = number) then
        if (msgs[i].constPart = g) then
          index := i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := number;
      msgs[index].constPart := g;
      msgs[index].length := 1;
    endif;
    sPat1Set.length := sPat1Set.length + 1;
    sPat1Set.content[sPat1Set.length] := index;
    num := index;
  end;

---pat2: exp(g,x) 
procedure lookAddPat2(g:ConstType; x:ConstType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat1(g,msg1,i1);
   lookAddPat1(x,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = e) then
       if (msgs[i].expMsg1 = i1 & msgs[i].expMsg2 = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := e;
     msgs[index].expMsg1 := i1; 
     msgs[index].expMsg2 := i2; 
     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat2: exp(g,x) 
procedure isPat2(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = e then
      isPat1(msgs[msg.expMsg1],flagPart1);
      isPat1(msgs[msg.expMsg2],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat2: exp(g,x) 
procedure constructSpat2(g:ConstType; x:ConstType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat1(g, i1);
    constructSpat1(x, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = e) then
        if (msgs[i].expMsg1 = i1 & msgs[i].expMsg2 = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := e;
      msgs[index].expMsg1 := i1; 
      msgs[index].expMsg2 := i2; 
      msgs[index].length := 1;
    endif;
    sPat2Set.length := sPat2Set.length + 1;
    sPat2Set.content[sPat2Set.length] := index;
    num := index;
  end;

---pat3: mod(exp(g,x),p) 
procedure lookAddPat3(g:ConstType; x:ConstType; p:ConstType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat2(g, x,msg1,i1);
   lookAddPat1(p,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = mod) then
       if (msgs[i].modMsg1 = i1 & msgs[i].modMsg2 = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := mod;
     msgs[index].modMsg1 := i1; 
     msgs[index].modMsg2 := i2; 
     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat3: mod(exp(g,x),p) 
procedure isPat3(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = mod then
      isPat2(msgs[msg.modMsg1],flagPart1);
      isPat1(msgs[msg.modMsg2],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat3: mod(exp(g,x),p) 
procedure constructSpat3(g:ConstType; x:ConstType; p:ConstType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat2(g, x, i1);
    constructSpat1(p, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = mod) then
        if (msgs[i].modMsg1 = i1 & msgs[i].modMsg2 = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := mod;
      msgs[index].modMsg1 := i1; 
      msgs[index].modMsg2 := i2; 
      msgs[index].length := 1;
    endif;
    sPat3Set.length := sPat3Set.length + 1;
    sPat3Set.content[sPat3Set.length] := index;
    num := index;
  end;

---pat4: m2 
procedure lookAddPat4(m2:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[m2.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat4: m2 
procedure isPat4(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat4: m2 
procedure constructSpat4(m2:Message; Var num: indexType);
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
    sPat4Set.length := sPat4Set.length + 1;
    sPat4Set.content[sPat4Set.length] := index;
    num := index;
  end;

---pat5: Na 
procedure lookAddPat5(Na:NonceType; Var msg:Message; Var num : indexType);
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

---pat5: Na 
procedure isPat5(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag1 := false;
    if (msg.msgType = nonce) then
      flag1 := true;
    endif;
    flag := flag1;
  end;

---spat5: Na 
procedure constructSpat5(Na:NonceType; Var num: indexType);
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
    sPat5Set.length := sPat5Set.length + 1;
    sPat5Set.content[sPat5Set.length] := index;
    num := index;
  end;

---pat6: exp(m2,x) 
procedure lookAddPat6(m2:Message; x:ConstType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat4(m2,msg1,i1);
   lookAddPat1(x,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = e) then
       if (msgs[i].expMsg1 = i1 & msgs[i].expMsg2 = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := e;
     msgs[index].expMsg1 := i1; 
     msgs[index].expMsg2 := i2; 
     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat6: exp(m2,x) 
procedure isPat6(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = e then
      isPat4(msgs[msg.expMsg1],flagPart1);
      isPat1(msgs[msg.expMsg2],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat6: exp(m2,x) 
procedure constructSpat6(m2:Message; x:ConstType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat4(m2, i1);
    constructSpat1(x, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = e) then
        if (msgs[i].expMsg1 = i1 & msgs[i].expMsg2 = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := e;
      msgs[index].expMsg1 := i1; 
      msgs[index].expMsg2 := i2; 
      msgs[index].length := 1;
    endif;
    sPat6Set.length := sPat6Set.length + 1;
    sPat6Set.content[sPat6Set.length] := index;
    num := index;
  end;

---pat7: mod(exp(m2,x),p) 
procedure lookAddPat7(m2:Message; x:ConstType; p:ConstType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat6(m2, x,msg1,i1);
   lookAddPat1(p,msg2,i2);
   for i : indexType do
     if (msgs[i].msgType = mod) then
       if (msgs[i].modMsg1 = i1 & msgs[i].modMsg2 = i2) then
          index:=i;
       endif;
     endif;
   endfor;
   if(index=0) then
     msg_end := msg_end + 1 ;
     index := msg_end;
     msgs[index].msgType := mod;
     msgs[index].modMsg1 := i1; 
     msgs[index].modMsg2 := i2; 
     msgs[index].length := 1;
   endif;
   num:=index;
   msg:=msgs[index];
  end;

---pat7: mod(exp(m2,x),p) 
procedure isPat7(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = mod then
      isPat6(msgs[msg.modMsg1],flagPart1);
      isPat1(msgs[msg.modMsg2],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat7: mod(exp(m2,x),p) 
procedure constructSpat7(m2:Message; x:ConstType; p:ConstType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat6(m2, x, i1);
    constructSpat1(p, i2);
    i := 1;
    while(i <= msg_end) do
      if (msgs[i].msgType = mod) then
        if (msgs[i].modMsg1 = i1 & msgs[i].modMsg2 = i2) then
           index:=i;
        endif;
      endif;
      i := i+1;
    endwhile;
    if(index=0) then
      msg_end := msg_end + 1 ;
      index := msg_end;
      msgs[index].msgType := mod;
      msgs[index].modMsg1 := i1; 
      msgs[index].modMsg2 := i2; 
      msgs[index].length := 1;
    endif;
    sPat7Set.length := sPat7Set.length + 1;
    sPat7Set.content[sPat7Set.length] := index;
    num := index;
  end;

---pat8: senc{Na}mod(exp(m2,x),p) 
procedure lookAddPat8(Na:NonceType; m2:Message; x:ConstType; p:ConstType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat5(Na,msg1,i1);
   lookAddPat7(m2, x, p,msg2,i2);
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

---pat8: senc{Na}mod(exp(m2,x),p) 
procedure isPat8(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = senc then
      isPat5(msgs[msg.sencMsg],flagPart1);
      isPat7(msgs[msg.sencKey],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat8: senc{Na}mod(exp(m2,x),p) 
procedure constructSpat8(Na:NonceType; m2:Message; x:ConstType; p:ConstType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat5(Na, i1);
    constructSpat7(m2, x, p, i2);
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

---pat9: m1 
procedure lookAddPat9(m1:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[m1.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat9: m1 
procedure isPat9(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat9: m1 
procedure constructSpat9(m1:Message; Var num: indexType);
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
    sPat9Set.length := sPat9Set.length + 1;
    sPat9Set.content[sPat9Set.length] := index;
    num := index;
  end;

---pat10: m3 
procedure lookAddPat10(m3:Message; Var msg:Message; Var num : indexType);
  Var index : indexType;
  begin
    get_msgNo(msgs[m3.tmpPart],index); 
    num:=index;
    msg:=msgs[index];
  end;

---pat10: m3 
procedure isPat10(msg:Message; Var flag:boolean);
  var flag1 : boolean;
  begin
    flag := true;
  end;

---spat10: m3 
procedure constructSpat10(m3:Message; Var num: indexType);
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
    sPat10Set.length := sPat10Set.length + 1;
    sPat10Set.content[sPat10Set.length] := index;
    num := index;
  end;

---pat11: senc{m3}mod(exp(m2,x),p) 
procedure lookAddPat11(m3:Message; m2:Message; x:ConstType; p:ConstType; Var msg:Message; Var num : indexType);
  Var msg1, msg2: Message;
      index,i1,i2:indexType;
  begin
   index:=0;
   lookAddPat10(m3,msg1,i1);
   lookAddPat7(m2, x, p,msg2,i2);
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

---pat11: senc{m3}mod(exp(m2,x),p) 
procedure isPat11(msg:Message; Var flag:boolean);
  var flag1,flagPart1,flagPart2 : boolean;
  begin
    flag1 := false;
    flagPart1:=false;
    flagPart2:=false;
    if msg.msgType = senc then
      isPat10(msgs[msg.sencMsg],flagPart1);
      isPat7(msgs[msg.sencKey],flagPart2);
      if flagPart1 & flagPart2 then
        flag1 := true;
      endif;
    endif;
    flag := flag1;
  end;

---spat11: senc{m3}mod(exp(m2,x),p) 
procedure constructSpat11(m3:Message; m2:Message; x:ConstType; p:ConstType; Var num: indexType);
  Var i,index,i1,i2:indexType;
  begin
    index:=0;
    constructSpat10(m3, i1);
    constructSpat7(m2, x, p, i2);
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

procedure cons1(g:ConstType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat1(g,msg,num);
  end;
procedure destruct1(msg:Message; Var g:ConstType);
  begin
    g:=msg.constPart;
  end;
procedure cons2(g:ConstType; x:ConstType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat2(g, x,msg,num);
  end;
procedure destruct2(msg:Message; Var g:ConstType; Var x:ConstType);
  begin
    g:=msgs[msg.expMsg1].constPart;
    x:=msgs[msg.expMsg2].constPart;
  end;
procedure cons3(g:ConstType; x:ConstType; p:ConstType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat3(g, x, p,msg,num);
  end;
procedure destruct3(msg:Message; Var g:ConstType; Var x:ConstType; Var p:ConstType);
  var mi1,mi2:indexType;
      modMsg1,modMsg2:Message;
    begin
    clear modMsg1;
    clear modMsg2;
    mi1:=msg.modMsg1;
    mi2:=msg.modMsg2;
    modMsg1:=msgs[mi1];
    modMsg2:=msgs[mi2];
    destruct2(modMsg1,g, x);
    destruct1(modMsg2,p);
  end;
procedure cons4(m2:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat4(m2,msg,num);
  end;
procedure destruct4(msg:Message; Var m2:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    m2:=msg;
    m2.tmpPart:=msgNo;
  end;
procedure cons5(Na:NonceType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat5(Na,msg,num);
  end;
procedure destruct5(msg:Message; Var Na:NonceType);
  begin
    Na:=msg.noncePart;
  end;
procedure cons6(m2:Message; x:ConstType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat6(m2, x,msg,num);
  end;
procedure destruct6(msg:Message; Var m2:Message; Var x:ConstType);
  begin
    m2:=msgs[msg.expMsg1];
    x:=msgs[msg.expMsg2].constPart;
  end;
procedure cons7(m2:Message; x:ConstType; p:ConstType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat7(m2, x, p,msg,num);
  end;
procedure destruct7(msg:Message; Var m2:Message; Var x:ConstType; Var p:ConstType);
  var mi1,mi2:indexType;
      modMsg1,modMsg2:Message;
    begin
    clear modMsg1;
    clear modMsg2;
    mi1:=msg.modMsg1;
    mi2:=msg.modMsg2;
    modMsg1:=msgs[mi1];
    modMsg2:=msgs[mi2];
    destruct6(modMsg1,m2, x);
    destruct1(modMsg2,p);
  end;
procedure cons8(Na:NonceType; m2:Message; x:ConstType; p:ConstType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat8(Na, m2, x, p,msg,num);
  end;
procedure destruct8(msg:Message; Var Na:NonceType; Var m2:Message; Var x:ConstType; Var p:ConstType);
  var k1:Message;
      sencMsg:Message;
   begin
      clear sencMsg;
      k1 := msgs[msg.sencKey];
      sencMsg := msgs[msg.sencMsg];
      Na:=msg.noncePart;
      destruct7(k1,m2, x, p);
   end;
procedure cons9(m1:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat9(m1,msg,num);
  end;
procedure destruct9(msg:Message; Var m1:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    m1:=msg;
    m1.tmpPart:=msgNo;
  end;
procedure cons10(m3:Message; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat10(m3,msg,num);
  end;
procedure destruct10(msg:Message; Var m3:Message);
  var msgNo:indexType;
  begin
    get_msgNo(msg,msgNo);
    m3:=msg;
    m3.tmpPart:=msgNo;
  end;
procedure cons11(m3:Message; m2:Message; x:ConstType; p:ConstType; Var msg:Message; Var num:indexType);
  begin
    clear msg;
    clear num;    lookAddPat11(m3, m2, x, p,msg,num);
  end;
procedure destruct11(msg:Message; Var m3:Message; Var m2:Message; Var x:ConstType; Var p:ConstType);
  var k1:Message;
      sencMsg:Message;
   begin
      clear sencMsg;
      k1 := msgs[msg.sencKey];
      sencMsg := msgs[msg.sencMsg];
      destruct10(sencMsg,m3);
      destruct7(k1,m2, x, p);
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
   cons3(roleA[i].g,roleA[i].x,roleA[i].p,msg,msgNo);
   ch[1].empty := false;
   ch[1].msg := msg;
   ch[1].sender := roleA[i].A;
   ch[1].receiver := Intruder;
   roleA[i].st := A2;
   put "roleA[i] in st1\n";
end;
rule " roleA2 "
roleA[i].st = A2 & ch[2].empty = false & !roleA[i].commit & judge(ch[2].msg,roleA[i].A,roleA[i].m2) 
==>
var flag_pat4:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[2].msg;
   isPat4(msg, flag_pat4);
   if(flag_pat4) then
     destruct4(msg,roleA[i].locm2);
     if(matchTmp(roleA[i].locm2, roleA[i].m2))then
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
   cons8(roleA[i].Na,roleA[i].m2,roleA[i].x,roleA[i].p,msg,msgNo);
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
roleB[i].st = B1 & ch[1].empty = false & !roleB[i].commit & judge(ch[1].msg,roleB[i].B,roleB[i].m1) 
==>
var flag_pat9:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[1].msg;
   isPat9(msg, flag_pat9);
   if(flag_pat9) then
     destruct9(msg,roleB[i].locm1);
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
   cons3(roleB[i].g,roleB[i].y,roleB[i].p,msg,msgNo);
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
var flag_pat11:boolean;
    msg:Message;
begin
   clear msg;
   msg := ch[3].msg;
   isPat11(msg, flag_pat11);
   if(flag_pat11 & B_known[msg.sencKey]) then
     destruct11(msg,roleB[i].locm3,roleB[i].locm2,roleB[i].locx,roleB[i].locp);
     if(matchTmp(roleB[i].locm3, roleB[i].m3) & matchTmp(roleB[i].locm2, roleB[i].m2) & matchNumber(roleB[i].locx, roleB[i].x) & matchNumber(roleB[i].locp, roleB[i].p))then
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
  var flag_pat3:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[1].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat3(msg,flag_pat3);
    if (flag_pat3) then
      if(!exist(pat3Set,msgNo)) then
        pat3Set.length:=pat3Set.length+1;
        pat3Set.content[pat3Set.length]:=msgNo;
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
  var flag_pat8:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[3].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat8(msg,flag_pat8);
    if (flag_pat8) then
      if(!exist(pat8Set,msgNo)) then
        pat8Set.length:=pat8Set.length+1;
        pat8Set.content[pat8Set.length]:=msgNo;
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
  var flag_pat3:boolean;
      msgNo:indexType;
      msg:Message;
  begin
    msg := ch[2].msg;
    get_msgNo(msg, msgNo);
    msg.tmpPart := msgNo;
    isPat3(msg,flag_pat3);
    if (flag_pat3) then
      if(!exist(pat3Set,msgNo)) then
        pat3Set.length:=pat3Set.length+1;
        pat3Set.content[pat3Set.length]:=msgNo;
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
      IntruEmit1 = true & roleA[j].st = A2 & ch[2].empty=true & i <= pat3Set.length & pat3Set.content[i] != 0 & Spy_known[pat3Set.content[i]] & !emit[pat3Set.content[i]] ---& matchPat(msgs[pat3Set.content[i]], sPat3Set)
      ==>
      begin
         clear ch[2];
        ch[2].msg:=msgs[pat3Set.content[i]];
        ch[2].sender:=Intruder;
        ch[2].receiver:=roleA[j].A;
        ch[2].empty:=false;
        emit[pat3Set.content[i]] := true;
        IntruEmit2 := true;
        put "intruder emit msg into ch[2].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[1].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[1]"
       roleB[j].st = B1 & ch[1].empty=true & i <= pat3Set.length & pat3Set.content[i] != 0 & Spy_known[pat3Set.content[i]] & !emit[pat3Set.content[i]] ---& matchPat(msgs[pat3Set.content[i]], sPat3Set)
      ==>
      begin
         clear ch[1];
        ch[1].msg:=msgs[pat3Set.content[i]];
        ch[1].sender:=Intruder;
        ch[1].receiver:=roleB[j].B;
        ch[1].empty:=false;
        emit[pat3Set.content[i]] := true;
        IntruEmit1 := true;
        put "intruder emit msg into ch[1].\n";
      end;
  endruleset;
endruleset;

---rule of intruder to emit msg into ch[3].
ruleset i: msgLen do
  ruleset j: roleBNums do
    rule "intruderEmitMsgIntoCh[3]"
      IntruEmit2 = true & roleB[j].st = B3 & ch[3].empty=true & i <= pat8Set.length & pat8Set.content[i] != 0 & Spy_known[pat8Set.content[i]] & !emit[pat8Set.content[i]] ---& matchPat(msgs[pat8Set.content[i]], sPat8Set)
      ==>
      begin
         clear ch[3];
        ch[3].msg:=msgs[pat8Set.content[i]];
        ch[3].sender:=Intruder;
        ch[3].receiver:=roleB[j].B;
        ch[3].empty:=false;
        emit[pat8Set.content[i]] := true;
        IntruEmit3 := true;
        put "intruder emit msg into ch[3].\n";
      end;
  endruleset;
endruleset;
--- construct exp and destruct exp rules of pat exp(g,x)
ruleset i:msgLen do
  rule "destructExp 2" --pat2
    i<=pat2Set.length & pat2Set.content[i] != 0
    & Spy_known[pat2Set.content[i]] &  Spy_known[msgs[pat2Set.content[i]].expMsg1] & !Spy_known[msgs[pat2Set.content[i]].expMsg2] 
    ==>
    var msgPat1:indexType;
	      flag_pat1:boolean;
    begin
      put "rule decrypt exp 2\n";
      Spy_known[msgs[pat2Set.content[i]].expMsg2]:=true;
      msgPat1:=msgs[pat2Set.content[i]].expMsg2;
      isPat1(msgs[msgPat1],flag_pat1);
      if (flag_pat1) then
        if (!exist(pat1Set,msgPat1)) then
          pat1Set.length:=pat1Set.length+1;
          pat1Set.content[pat1Set.length]:=msgPat1;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "constructExp 2"  --pat2
      roleB[i1].st = B1 &      i<=pat1Set.length & pat1Set.content[i] != 0 & Spy_known[pat1Set.content[i]] &
      j<=pat1Set.length & pat1Set.content[j] != 0 & Spy_known[pat1Set.content[j]] &
      matchPat(construct2By11(pat1Set.content[i],pat1Set.content[j]), sPat2Set) &
      !Spy_known[constructIndex2By11(pat1Set.content[i],pat1Set.content[j])] 
      ==>
      var expMsgNo:indexType;
      expMsg:Message;
      begin
        put "rule constructExp 2\n";
        expMsgNo := constructIndex2By11(pat1Set.content[i],pat1Set.content[j]);
        if expMsgNo = msg_end + 1 then 
          msg_end := msg_end + 1;
          expMsg := construct2By11(pat1Set.content[i],pat1Set.content[j]);
          msgs[expMsgNo] := expMsg;
        endif;
        Spy_known[expMsgNo]:=true;
        if (!exist(pat2Set,expMsgNo)) then
          pat2Set.length:=pat2Set.length+1;
          pat2Set.content[pat2Set.length]:=expMsgNo;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- construct mod and destruct mod rules of pat mod(exp(g,x),p)
ruleset i:msgLen do
  rule "destructMod 3" --pat3
    i<=pat3Set.length & pat3Set.content[i] != 0
    & Spy_known[pat3Set.content[i]] & (!Spy_known[msgs[pat3Set.content[i]].modMsg1] | !Spy_known[msgs[pat3Set.content[i]].modMsg2])
     
    ==>
    var msgPat2,msgPat1:indexType;
	      flag_pat2,flag_pat1:boolean;
    begin
      put "rule decrypt mod 3\n";
      if (!Spy_known[msgs[pat3Set.content[i]].modMsg1]) then
        Spy_known[msgs[pat3Set.content[i]].modMsg1]:=true;
        msgPat2:=msgs[pat3Set.content[i]].modMsg1;
        isPat2(msgs[msgPat2],flag_pat2);
        if (flag_pat2) then
          if (!exist(pat2Set,msgPat2)) then
            pat2Set.length:=pat2Set.length+1;
            pat2Set.content[pat2Set.length]:=msgPat2;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat3Set.content[i]].modMsg2]) then
        Spy_known[msgs[pat3Set.content[i]].modMsg2]:=true;
        msgPat1:=msgs[pat3Set.content[i]].modMsg2;
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
    rule "constructMod 3"  --pat3
      roleB[i1].st = B1 &      i<=pat2Set.length & pat2Set.content[i] != 0 & Spy_known[pat2Set.content[i]] &
      j<=pat1Set.length & pat1Set.content[j] != 0 & Spy_known[pat1Set.content[j]] &
      matchPat(construct3By21(pat2Set.content[i],pat1Set.content[j]), sPat3Set) &
      !Spy_known[constructIndex3By21(pat2Set.content[i],pat1Set.content[j])]
      ==>
      var modMsgNo:indexType;
      modMsg:Message;
      begin
        put "rule constructMod 3\n";
        modMsgNo := constructIndex3By21(pat2Set.content[i],pat1Set.content[j]);
        if modMsgNo = msg_end + 1 then
          msg_end := msg_end + 1;
          modMsg := construct3By21(pat2Set.content[i],pat1Set.content[j]);
          msgs[modMsgNo] := modMsg;
        endif;
        Spy_known[modMsgNo]:=true;
        if (!exist(pat3Set,modMsgNo)) then
          pat3Set.length:=pat3Set.length+1;
          pat3Set.content[pat3Set.length]:=modMsgNo;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- construct exp and destruct exp rules of pat exp(m2,x)
ruleset i:msgLen do
  rule "destructExp 6" --pat6
    i<=pat6Set.length & pat6Set.content[i] != 0
    & Spy_known[pat6Set.content[i]] &  Spy_known[msgs[pat6Set.content[i]].expMsg1] & !Spy_known[msgs[pat6Set.content[i]].expMsg2] 
    ==>
    var msgPat4,msgPat1:indexType;
	      flag_pat4,flag_pat1:boolean;
    begin
      put "rule decrypt exp6\n";
      Spy_known[msgs[pat6Set.content[i]].expMsg2]:=true;
      msgPat1:=msgs[pat6Set.content[i]].expMsg2;
      isPat1(msgs[msgPat1],flag_pat1);
      if (flag_pat1) then
        if (!exist(pat1Set,msgPat1)) then
          pat1Set.length:=pat1Set.length+1;
          pat1Set.content[pat1Set.length]:=msgPat1;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
    ruleset i1: roleBNums do
    rule "constructExp 6"  --pat6
      roleB[i1].st = B3 &      i<=pat4Set.length & pat4Set.content[i] != 0 & Spy_known[pat4Set.content[i]] &
      j<=pat1Set.length & pat1Set.content[j] != 0 & Spy_known[pat1Set.content[j]] &
      matchPat(construct6By41(pat4Set.content[i],pat1Set.content[j]), sPat6Set) &
      !Spy_known[constructIndex6By41(pat4Set.content[i],pat1Set.content[j])] 
      ==>
      var expMsgNo:indexType;
      expMsg:Message;
      begin
        put "rule constructExp 6\n";
        expMsgNo := constructIndex6By41(pat4Set.content[i],pat1Set.content[j]);
        if expMsgNo = msg_end + 1 then 
          msg_end := msg_end + 1;
          expMsg := construct6By41(pat4Set.content[i],pat1Set.content[j]);
          msgs[expMsgNo] := expMsg;
        endif;
        Spy_known[expMsgNo]:=true;
        if (!exist(pat6Set,expMsgNo)) then
          pat6Set.length:=pat6Set.length+1;
          pat6Set.content[pat6Set.length]:=expMsgNo;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- construct mod and destruct mod rules of pat mod(exp(m2,x),p)
ruleset i:msgLen do
  rule "destructMod 7" --pat7
    i<=pat7Set.length & pat7Set.content[i] != 0
    & Spy_known[pat7Set.content[i]] & (!Spy_known[msgs[pat7Set.content[i]].modMsg1] | !Spy_known[msgs[pat7Set.content[i]].modMsg2])
     
    ==>
    var msgPat6,msgPat1:indexType;
	      flag_pat6,flag_pat1:boolean;
    begin
      put "rule decrypt mod 7\n";
      if (!Spy_known[msgs[pat7Set.content[i]].modMsg1]) then
        Spy_known[msgs[pat7Set.content[i]].modMsg1]:=true;
        msgPat6:=msgs[pat7Set.content[i]].modMsg1;
        isPat6(msgs[msgPat6],flag_pat6);
        if (flag_pat6) then
          if (!exist(pat6Set,msgPat6)) then
            pat6Set.length:=pat6Set.length+1;
            pat6Set.content[pat6Set.length]:=msgPat6;
          endif;
        endif;
      endif;
      if (!Spy_known[msgs[pat7Set.content[i]].modMsg2]) then
        Spy_known[msgs[pat7Set.content[i]].modMsg2]:=true;
        msgPat1:=msgs[pat7Set.content[i]].modMsg2;
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
    rule "constructMod 7"  --pat7
      roleB[i1].st = B3 &      i<=pat6Set.length & pat6Set.content[i] != 0 & Spy_known[pat6Set.content[i]] &
      j<=pat1Set.length & pat1Set.content[j] != 0 & Spy_known[pat1Set.content[j]] &
      matchPat(construct7By61(pat6Set.content[i],pat1Set.content[j]), sPat7Set) &
      !Spy_known[constructIndex7By61(pat6Set.content[i],pat1Set.content[j])]
      ==>
      var modMsgNo:indexType;
      modMsg:Message;
      begin
        put "rule constructMod 7\n";
        modMsgNo := constructIndex7By61(pat6Set.content[i],pat1Set.content[j]);
        if modMsgNo = msg_end + 1 then
          msg_end := msg_end + 1;
          modMsg := construct7By61(pat6Set.content[i],pat1Set.content[j]);
          msgs[modMsgNo] := modMsg;
        endif;
        Spy_known[modMsgNo]:=true;
        if (!exist(pat7Set,modMsgNo)) then
          pat7Set.length:=pat7Set.length+1;
          pat7Set.content[pat7Set.length]:=modMsgNo;
        endif;
      end;
  endruleset;
  endruleset;
endruleset;

--- encrypt and decrypt rules of pat senc(Na,mod(exp(m2,x),p))
ruleset i:msgLen do
  rule "sdecrypt 8" --pat8
    i<=pat8Set.length & pat8Set.content[i] != 0
    & Spy_known[pat8Set.content[i]] & !Spy_known[msgs[pat8Set.content[i]].sencMsg]
    ==>
    var key_inv:Message;
	      msgPat5,keyNo:indexType;
	      flag_pat5:boolean;
    begin
      put "rule sdecrypt8\n";
      key_inv := inverseKey(msgs[msgs[pat8Set.content[i]].sencKey]);
      get_msgNo(key_inv,keyNo);
      if (key_inv.k.encType = MsgK & Spy_known[keyNo]) then
        Spy_known[msgs[pat8Set.content[i]].sencMsg]:=true;
        msgPat5:=msgs[pat8Set.content[i]].sencMsg;
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
    rule "sencrypt 8"  --pat8
      roleB[i1].st = B3 &      i<=pat5Set.length & pat5Set.content[i] != 0 & Spy_known[pat5Set.content[i]] &
      j<=pat7Set.length & pat7Set.content[j] != 0 & Spy_known[pat7Set.content[j]] &
      matchPat(construct8By57(pat5Set.content[i],pat7Set.content[j]), sPat8Set) &
      !Spy_known[constructIndex8By57(pat5Set.content[i],pat7Set.content[j])] 
       ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule sencrypt8\n";
        if (msgs[pat7Set.content[j]].k.encType=MsgK) then
          encMsgNo := constructIndex8By57(pat5Set.content[i],pat7Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg:= construct8By57(pat5Set.content[i],pat7Set.content[j]);
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

--- encrypt and decrypt rules of pat senc(m3,mod(exp(m2,x),p))
ruleset i:msgLen do
  rule "sdecrypt 11" --pat11
    i<=pat11Set.length & pat11Set.content[i] != 0
    & Spy_known[pat11Set.content[i]] & !Spy_known[msgs[pat11Set.content[i]].sencMsg]
    ==>
    var key_inv:Message;
	      msgPat10,keyNo:indexType;
	      flag_pat10:boolean;
    begin
      put "rule sdecrypt11\n";
      key_inv := inverseKey(msgs[msgs[pat11Set.content[i]].sencKey]);
      get_msgNo(key_inv,keyNo);
      if (key_inv.k.encType = MsgK & Spy_known[keyNo]) then
        Spy_known[msgs[pat11Set.content[i]].sencMsg]:=true;
        msgPat10:=msgs[pat11Set.content[i]].sencMsg;
        isPat10(msgs[msgPat10],flag_pat10);
        if (flag_pat10) then
          if (!exist(pat10Set,msgPat10)) then
            pat10Set.length:=pat10Set.length+1;
            pat10Set.content[pat10Set.length]:=msgPat10;
          endif;
        endif;
      endif;
    end;
endruleset;

ruleset i:msgLen do 
  ruleset j:msgLen do 
        rule "sencrypt 11"  --pat11
      i<=pat10Set.length & pat10Set.content[i] != 0 & Spy_known[pat10Set.content[i]] &
      j<=pat7Set.length & pat7Set.content[j] != 0 & Spy_known[pat7Set.content[j]] &
      matchPat(construct11By107(pat10Set.content[i],pat7Set.content[j]), sPat11Set) &
      !Spy_known[constructIndex11By107(pat10Set.content[i],pat7Set.content[j])] 
       ==>
      var encMsgNo:indexType;
      encMsg:Message;
      begin
        put "rule sencrypt11\n";
        if (msgs[pat7Set.content[j]].k.encType=MsgK) then
          encMsgNo := constructIndex11By107(pat10Set.content[i],pat7Set.content[j]);
          if encMsgNo = msg_end + 1 then 
             msg_end :=msg_end + 1;
             encMsg:= construct11By107(pat10Set.content[i],pat7Set.content[j]);
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

startstate
  roleA[1].A := Alice;
  roleA[1].B := Intruder;
  roleA[1].g := g;
  roleA[1].p := p;
  roleA[1].x := x;
  roleA[1].Na := Na;
  roleA[1].st := A1;
  roleA[1].commit := false;
  roleA[1].m2.msgType := tmp;
  roleA[1].m2.tmpPart := 0;
  roleA[1].m1.msgType := tmp;
  roleA[1].m1.tmpPart := 0;
  roleA[1].m3.msgType := tmp;
  roleA[1].m3.tmpPart := 0;
  roleA[1].y := anyNumber;
  roleA[1].xi := anyNumber;
  roleA[1].yi := anyNumber;

  roleB[1].B := Bob;
  roleB[1].A := Intruder;
  roleB[1].g := g;
  roleB[1].p := p;
  roleB[1].y := y;
  roleB[1].st := B1;
  roleB[1].commit := false;
  roleB[1].Na := anyNonce;
  roleB[1].m2.msgType := tmp;
  roleB[1].m2.tmpPart := 0;
  roleB[1].m1.msgType := tmp;
  roleB[1].m1.tmpPart := 0;
  roleB[1].m3.msgType := tmp;
  roleB[1].m3.tmpPart := 0;
  roleB[1].x := anyNumber;
  roleB[1].xi := anyNumber;
  roleB[1].yi := anyNumber;


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
  pat12Set.length := pat12Set.length + 1; 
  pat12Set.content[pat12Set.length] :=msg_end;
  Spy_known[msg_end] := true;
  
  msg_end:=msg_end+1;
  msgs[msg_end].msgType := number;
  msgs[msg_end].constPart :=g;
  msgs[msg_end].length := 1;
  pat1Set.length := pat1Set.length + 1; 
  pat1Set.content[pat1Set.length] :=msg_end;
  Spy_known[msg_end] := true;
  
  msg_end:=msg_end+1;
  msgs[msg_end].msgType := number;
  msgs[msg_end].constPart :=p;
  msgs[msg_end].length := 1;
  pat1Set.length := pat1Set.length + 1; 
  pat1Set.content[pat1Set.length] :=msg_end;
  Spy_known[msg_end] := true;
  
  msg_end:=msg_end+1;
  msgs[msg_end].msgType := number;
  msgs[msg_end].constPart :=xi;
  msgs[msg_end].length := 1;
  pat1Set.length := pat1Set.length + 1; 
  pat1Set.content[pat1Set.length] :=msg_end;
  Spy_known[msg_end] := true;
  
  msg_end:=msg_end+1;
  msgs[msg_end].msgType := number;
  msgs[msg_end].constPart :=yi;
  msgs[msg_end].length := 1;
  pat1Set.length := pat1Set.length + 1; 
  pat1Set.content[pat1Set.length] :=msg_end;
  Spy_known[msg_end] := true;
    for i : roleBNums do
    constructSpat3(roleB[i].g,roleB[i].x,roleB[i].p, gnum);
  endfor;
  for i : roleBNums do
    constructSpat8(roleB[i].Na,roleB[i].m2,roleB[i].x,roleB[i].p, gnum);
  endfor;
  for i : roleANums do
    constructSpat3(roleA[i].g,roleA[i].y,roleA[i].p, gnum);
  endfor;

end;

invariant "secrecy1" 
forall i:indexType do
    (msgs[i].msgType=nonce & msgs[i].noncePart=Na)
     ->
     Spy_known[i] = false
end;
