///
///  sindent
///

setdebug(1,@keep,@~pline,@~step,@~trace,@showresults,1);
filterFuncDebug(ALLOWALL_,"proc");
filterFileDebug(ALLOWALL_,);

// tidy up code

char ns[];

char c;
int ln = 0;

is_comment = 0;

 nw = 5;

str NL1;
svar NL2;

while (1) {

 is_comment = 0;

 L = readline(0);
 

 if (ferror(0) == EOF_ERROR_)
   break;


  ln++;



<<[2]"$L\n" ;

 nc = Caz(L)
 sl = Slen(L);

 if (sl >= 1) {

  scpy(ns,eatWhiteEnds(L));
  <<[2]"check comment $ns[0] $ns[1] \n"
  
  if ((ns[0] == 47) && (ns[1] == '/')) {
   is_comment = 1;
   <<[2]"comment $L\n"
  }
  else {
  ws = dewhite(L)
  if (slen(ws) == 0) {
   <<[2]"empty? $sl  $L\n"
   is_comment = 1;
  }
 }

 //NL=eatWhiteEnds(L);
 // L = NL;
 }

 ind = sl -1;



 ns = sele(L,ind,1)
 c= ns[0];
 
 <<[2]"$ln  $c $sl $ind %s $c \n";

 s1 = ";{}/\\" ; 

//k = sstr(s1,c,1)

k = sstr(";{}/\\",c,1)
 
// <<[2]"$L $sl %c$c %d$k\n"
NL="";
if (slen(L) >0) {
NL=eatWhiteEnds(L);
}

is_cbe = 0;
is_cbs = 0;


if (slen(NL) > 0) {

is_cbs = scmp(NL,"{",-1,0,0);

is_cbe = scmp(NL,"}",-1,0,0);
}
<<[2]"<|$L|> <|$NL|> %V $nw $is_cbs $is_cbe \n"

is_proc = scmp(NL,"proc",4,0);

tws = nsc(nw," ");
 if (is_cbs) {
  nw += 2;
  //<<[2]"PROC %v$nw \n"
  <<[2]"CBS %v$nw \n"
 }
 
 if (is_cbe) {
   
  nw -= 2;
  <<[2]"CBE %v$nw \n"
 }


  len = slen(NL);
  conline = 0;
  if (len > 60) {
      <<[2]"SPLIT $NL \n"
      //index =sstr(NL,",",1);

// use ,
      iv = sstr(NL,",",1,1);
      <<[2]"found? $iv\n"
      index = iv[0];
      if (index == -1) {
         index = -1;
      }
      else {
       sz=Caz(iv);
       wi = sz/2;
       index = iv[wi];
       if (index != -1)
         index++;
       else
         index = -1;
     }

// else use space
      if (index == -1) {
      // but space not quoted !"
      iv = sstr(NL," ",1,1);
      <<[2]"found? $iv\n"
      index = iv[0];
      if (index == -1) {
         index = -1;
      }
      else {
       sz=Caz(iv);
       wi = sz/2;
       index = iv[wi];
       if (index != -1)
         index++;
       else
         index = -1;
     }
     }

    if (index != -1) {
    <<[2]"SPLIT  %v $index\n"; 
    scpy(NL1,NL,index);
    <<[2]"%V $NL1 \n"
    scpy(NL2,sele(NL,index,len-index));
        <<[2]"%V $NL2 \n"
    conline =1;
    }
   
  }
 
 
 if ( !is_comment && !is_proc &&(sl > 0) && (  sstr(";/{}\\",c,1) == -1) ) {
 <<[2]" needs ; $L\n";
   if (conline) {
       <<"$tws$NL1		\\\n"
       <<"$tws  \t\t$NL2; \n"
   }
   else {
   <<"$tws$NL; \n"
   }
   
 }
 else if (is_comment) {
 <<"$L\n"
 }
 else {
   if (conline) {
       <<"$tws$NL1		\\  \n"
       <<"$tws       $NL2; \n"
   }
   else {
 <<"$tws$NL\n"
  }
}



 //if (ln > 5)    break;
}

tws = nsc(nw,"x");
<<[2]"%V$nw $tws\n"


