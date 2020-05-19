//%*********************************************** 
//*  @script svar.asl 
//* 
//*  @comment test svar dec/assign reassign 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Tue May 14 09:06:45 2019 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%

   checkIn(_dblevel);
   
   svar  S = "una larga noche"; 
   
   <<"%V $S\n"; 
   
   <<" $(typeof(S)) $(Caz(S)) \n"; 
   
   S[1] = "el gato mira la puerta"; 
   
   S[2] = "espera ratones"; 
   
   <<"%V $S[2] \n"; 
   
   
   svar E[] = { "the first ten elements are:", "H", "He", "Li", "Be" ,"B" ,"C", "N", "O", "F", "Ne"  };
   svar E3[] = { "third row elements are:", "Na", "Mg", "Al", "Si" ,"P" ,"S", "Cl", "Ar" };
   
   
   <<"$E\n"; 
   <<"$E[1] \n"; 
   
   checkStr(E[1],"H"); 
   
   <<"$E[2] \n"; 
   
   <<"$E[3:6] \n"; 
   
   
   W= E[3:7];
   
   <<"$(typeof(W)) \n"; 
   <<"$W\n"; 
   
   <<"$W[1]\n"; 
   checkStr(W[1],"Be");
   
   W[3:4] = E[7:8];
   
   
   <<"%V$W \n"; 
   
   T= E[1:9]; 
   
   <<"$T\n"; 
   sz=T->Caz(); 
   <<"$sz\n"; 
   
   checkNum(sz,9); 
   
   T= E[4:9]; 
   
   <<"$T\n"; 
   T->info(1)
   sz=T->Caz(); 


   <<"$sz\n";


   R= E[4:9]; 
   
   <<"$R\n"; 
   R->info(1)
   sz=R->Caz(); 


   <<"$sz\n"; 
   
   checkNum(sz,6); 
   

   checkStage("svar array ele");


//%*********************************************** 
//*  @script svar_range.asl 
//* 
//*  @comment test svar range use 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Sun Apr  7 08:51:31 2019 
//*  @cdate Sun Apr  7 08:51:31 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


IV = vgen(INT_,10,0,1)


S= Split("$IV")

S->info(1)

<<"$S\n"

checkStr(S[1],"1")
checkStr(S[2],"2")
checkStr(S[3],"3")

checkStage ("assign via Split")


T= Split("%6.2f$(vgen(FLOAT_,10,0,0.5))")

<<"$T\n"

checkStr(T[1],"0.50")
checkStr(T[2],"1.00")
checkStr(T[3],"1.50")

checkStage ("assign via Split print")




//

<<"$S\n"
<<"$S[1:7]\n"

T1= S[1:7:]

<<"$T1\n"




R= Split("47 79 80 81 82 83 84 85 86 87")

<<"$R\n"


S[1:4:] = R


<<"$S\n"

checkStr(S[1],"47")
checkStr(S[2],"79")


checkStage ("lh range assign")






<<"$S\n"

S[1:8:2] = R


<<"$S\n"

checkStr(S[1],"47")
checkStr(S[3],"79")
checkStr(S[5],"80")

checkStage ("lh range stride 2 assign")




S[1:4:] = R[1:4]

<<"$S\n"

checkStr(S[1],"79")
checkStr(S[2],"80")
checkStage ("lh range assign and rh range")


S= Split("$IV")

S[1:8:2] = R[1:8:2]


checkStr(S[1],"79")
checkStr(S[3],"81")

<<"$S\n"

checkStage ("lh range assign and rh range -both stride 2")






//////////////////////////////////////////




W[0] = "hey"


<<"%v $W[0] \n"

 W[1] = "marcos"

<<"%v $W[1] \n"

<<"%v $W[0] \n"

 W[2] = "puedes"

<<" $W \n"

 W[3] = "hacer"


<<"%v $W[0] \n"


 W[4] = "tus"

 W[5] = "metas"

 W[6] = "amigo"


 W[7] = "?"

// W[8] = "?"

<<"W[0::]  $W[0::] \n"



<<"W[2::]  $W[2::]\n"


T= W[2::]

<<"T $T\n"

<<"T[0] $T[0]\n"

<<"T[1] $T[1]\n"

checkStr(T[0],"puedes")
checkStr(T[0],W[2])

/////////////////////////
//%*********************************************** 
//*  @script svar_declare.asl 
//* 
//*  @comment test list declare 
//*  @release CARBON 
//*  @vers 1.41 Nb Niobium                                                 
//*  @date Mon Apr  8 09:51:04 2019 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
#



civ = 0;

cov= getEnvVar("ITEST")
if (! (cov @=""))
{
civ= atoi(cov)
<<"%V $cov $civ\n"
}




str le;

Mol = ( "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" ) ;

<<"$(typeof(Mol)) size $(caz(Mol))  \n"

<<"List is $Mol \n"

sz = caz(Mol)

<<"%V$sz\n";

checkNum(sz,12)


<<"first month $Mol[0]\n"

<<"second month $Mol[1]\n"

<<"twelveth month $Mol[11]\n"

le12 = Mol[11];

<<"$(typeof(le12)) %V$le12\n"

le = Mol[0]

<<"$(typeof(le)) %V$le\n"

checkStr(le,"JAN")

<<"le checked\n"
<<"%V $Mol[0] \n"
checkStr(Mol[0],"JAN")

<<"Mol[0] checked\n"

le = Mol[1]
<<"%V$le $Mol[1] checked\n"
<<"$(typeof(le)) \n"


checkStr(le,"FEB")

<<"$(typeof(le)) %V$le\n"

checkStr("FEB",Mol[1])

<<"$Mol[1] Mol[1] checked\n"

checkStr(Mol[1],"FEB")



//checkProgress()

<<" DONE Lists \n"
//////////////////////////////////




Svar Mo[] = {"JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" }
//Svar Mo = {"JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" }


<<" Mo $(typeof(Mo)) \n"

sz= Caz(Mo)

<<" Mo %V$sz \n"

<<"$Mo[0] \n"

<<"$Mo[1] \n"

for (i = 0; i < 12 ; i++) {

  <<"$i $Mo[i] \n"

}

checkStr(Mo[0],"JAN")

checkStr(Mo[11],"DEC")


int A[] = {0,1,2,3,4,5,6,7,8}

<<"$A\n"

<<"sz $(Caz(A)) cab $(Cab(A))\n"

checkNum(A[1],1)
checkNum(A[8],8)




IV= vgen(INT_,20,0,1)

<<"$IV \n"




T= itoa(IV) // does not deliver svar array

T->info(1)
<<"$T\n"

M=Split("$IV")

M->info(1)
<<"$M \n"


<<"$M[3] $M[7]\n"

IV2= atoi(M)

<<"$IV2\n"

IV2->Info(1);



R= M[3::]

<<"$R \n"
R->info(1)



IV3= atoi(R)

<<"$IV3\n"
checkNum(IV3[0],3)

IV3 *= 2;

checkNum(IV3[0],6)

<<"$IV3\n"

//M[3::] = atoi(IV3)

//M[0] = 47  // error int --> string

M[0] = "47"  

<<"$M\n"


checkStr(M[0],"47")

R[0] = "79"
R[1] = "80"
R[2] = "82"

checkStr(R[0],"79")

M[3:6:] = R[0:3:]

checkStr(M[3],"79")
checkStr(M[4],R[1])
checkStr(M[4],"80")
checkStr(M[5],"82")


<<"$R\n"
<<"$M\n"

////////////////////

IV4=vgen(INT_,10,45,1)
<<"$IV4\n"

checkNum(IV4[0],45)
checkNum(IV4[1],46)

<<"$IV3\n"



IV3[3:12:1] = IV4[0:9:];
checkNum(IV3[0],6)

checkNum(IV3[3],45)
checkNum(IV3[4],46)



<<"$IV3\n"

IV4 = IV3	
IV4[3:12:1] = 52;

<<"$IV4\n"

IV3[3:12:1] *= 2;

<<"$IV3\n"

<<"M $M \n"



IV3= atoi(M)

<<"$IV3\n"

checkNum(IV3[0], 47)
checkNum(IV3[1], 1)
checkNum(IV3[2], 2)


IV3->Info(1);

IV3= atoi(M[3::])

<<"$IV3\n"

IV3->Info(1);

checkNum(IV3[0], 79)

 if (IV3[0] == 79) {
<<"OK $IV[0:-1:2] \n"
 }


checkStage("declare")
/////////////////////////  svar proc ///////////////////////////

///
/// svar as proc arg
/// 


proc pS (svar SV)
{

static int k = 1;

<<"$(typeof(SV)) $SV[::]\n"
sz = Caz(SV)

<<"%V $sz $SV[2] \n"

w2 = SV[2];
<<"$k %V $w2\n"

if (k==1) {
checkStr(w2,"we")
}
else if (k==2) {
checkStr(w2,"is")
}
else if (k==3) {
 checkStr(w2,"40,07.00,N")
 ang =getDeg(SV[2]);
 <<"%V $ang\n"
 ang = getDeg(SV[3]);
 <<"%V $ang\n" 
}

 k++;

}
//===========


checkOut()

S = Split("how did we get here")

<<"$(typeof(S)) $S[::]\n"

pS(S)

T = Split("again how is this happening")

pS(T)

//===========

proc getDeg (str the_ang)
    {
      str the_dir;
      float la;
      str wd;
      <<"in $_proc  $the_ang\n"
	

    the_parts = Split(the_ang,",")

      //<<"%V$the_parts \n"


//FIX    float the_deg = atof(the_parts[0])
   wd = the_parts[0];
    the_deg = atof(wd)

      sz= Caz(the_deg);
<<" %V$sz $(typeof(the_deg)) $(Cab(the_deg))  \n"

//    float the_min = atof(the_parts[1])
   wd = the_parts[1];
    the_min = atof(wd)

    <<"%V$the_deg $the_min \n"

      sz= Caz(the_min);

      <<" %V$sz $(typeof(the_min))   $(Cab(the_min)) \n"

    the_dir = the_parts[2];

    y = the_min/60.0;

    la = the_deg + y

      if ((the_dir @= "E") || (the_dir @= "S")) {
         la *= -1
      }

    <<"%V $la  $y  \n"

 <<"%V $(caz(la))  $(Cab(la)) \n"
      
    return (la);
 }

//===============================//

//======================
CLASS Turnpt 
 {

 public:

  str Lat;
  str Lon;
  str Place;
  str Idnt;
  str rway;
  str tptype;
  
  str Cltpt;
  float Radio;

  float Alt;
  float Ladeg;
  float Longdeg;

//  method list

  CMF Set (wval) 
   {

DBG"$_proc $(typeof(wval)) $wval[::] \n"

//<<"%V$_cproc  %i$_cobj   %i$wval \n"
     //sz = wval->Caz()

      sz = Caz(wval);      
 // <<"%V$sz \n"
DBG"$sz 0: $wval[0] 1: $wval[1] 2: $wval[2] 3: $wval[3] 4: $wval[4] \n"
    
   
      //   <<"$wval[0]\n"
       //  <<"$(typeof(wval))\n"
       //ans = iread("-->");
     Place = wval[0];
    
DBG"%V$Place\n"


     Idnt =  wval[1];
 DBG"%V$Idnt\n"
 //    <<"%V$wval[2]\n"
checkStr(Idnt,"jmt")     
     Lat = wval[2];

     //   <<"%V$Lat  <| $wval[2] |>\n"

     //   <<"%V$wval[3]\n"	 
     Lon = wval[3];

     //       <<"%V$Lon  <| $wval[3] |>\n" 
     
     Alt = wval[4];
     
     rway = wval[5];
     
     Radio = atof(wval[6]);

     tptype = wval[7];

DBG"%V$Lat $Lon \n"
     //  <<" $(typeof(Lat)) \n"
     // <<" $(typeof(Lon)) \n"
     //  <<" $(typeof(Ladeg)) \n"	 

    Ladeg =  getDeg(Lat);

     //       <<" $(typeof(Longdeg)) \n"	 
     Longdeg = getDeg(Lon);

<<"%V $Ladeg $Longdeg \n"

      }


}
//=================================

 P=split("Jamestwn    	jmt	40,07.00,N	105,24.00,W	8470	0/0	_	T ");

pS(P)

Turnpt  Tp;
 
 Tp->Set(P);

 P= Split("AngelFire    	AXX	36,24.75,N	105,18.00,W	8383	17/35	122.8	TA")
 
 Tp->Set(P);
 

checkStage("Proc")

//%*********************************************** 
//*  @script svar_hash.asl 
//* 
//*  @comment svar as hash table 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Tue May  7 19:17:52 2019 
//*  @cdate 1/1/2010 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%


Svar ST

tsz = 30;
nplace = 2

ST->table("HASH",tsz,nplace) // makes Svar a hash type -- could extend table

key = "Hastings"
ival = 1066
index=ST->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"



key = "Agincourt"
ival =  1415
index=ST->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"

key = "Waterloo"
ival =  1815
index=ST->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"

key = "Gettysburg"
ival =  1863
index=ST->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"


key= "Trafalgar"
ival = 1805
index=ST->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"

key= "Somme"
ival = 1916
index=ST->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"

key= "Verdun"
ival = 1916
index=ST->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"

key= "Midway"
ival = 1942
index=ST->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"


key= "Stalingrad"
ival = 1942
index=ST->addkeyval(key,ival) // returns index
<<"%V$key $ival $index\n"



val = ST->lookup(key)

<<"$key  $val\n"

key= "Hastings"
val = ST->lookup(key)

<<"$key  $val\n"

key= "Gettysburg"
val = ST->lookup(key)

<<"$key  $val\n"

sz= ST->caz()
<<"$sz $S[0] \n"
sdb(1,@~pline)
 for (i=0; i <sz; i += 2) {
    // if (scmp(S[i],"") == 0) {
     if (!scmp(S[i],"") ) {
       <<"$i $S[i] $S[i+1]\n"
    }
  }

checkStr(val,"1863")
key= "Stalingrad"
val = ST->lookup(key)
checkStr(val,"1942")

checkStage("Hash")


Svar Opts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,",",");

<<"$Opts \n"


checkStr("all",Opts[0]);

checkStr("matrix",Opts[2]);

str Sr ="all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,proc,switch,types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help";

len = slen(Sr);

<<"%V $len\n"

<<"%V $Sr\n"

Svar Mopts[] = Split(Sr,",");

<<"%V %(5,, ,\n)$Mopts[::] \n"

checkStr("all",Mopts[0]);

checkStr("matrix",Mopts[2]);


Svar Sopts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,",",");


<<"%V $Sopts \n"


checkStr("bops",Sopts[4]);

checkStr("class",Sopts[8]);


Svar Popts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,proc,switch,types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help",",");


<<"%V $Popts \n"

checkStr("array",Popts[1]);

checkStage("Split")
checkOut();


