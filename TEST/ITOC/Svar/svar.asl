/* 
 *  @script svar.asl 
 * 
 *  @comment test svar dec/assign reassign 
 *  @release CARBON 
 *  @vers 1.5 B Boron [asl 6.3.60 C-Li-Nd] 
 *  @date 11/17/2021 10:03:22          
 *  @cdate 1/1/2010 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                     
Str Use_= "Demo svar type use";


#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }


   db_ask = 1
   allowErrors(-1);
 //  sdb(1,"soe")
   chkIn(_dblevel);
   
   chkT(1)
   
 //allowDB("spe_,ic",1)

   Svar E[] = { "the first ten elements are:", "H", "He", "Li", "Be" ,"B" ,"C", "N", "O", "F", "Ne"  };

   <<"$E\n";

   <<"$E[1] \n";

   E.pinfo();

   ans=ask("Svar array filled OK",db_ask)


   Siv F(SVAR_);

   F  = split ("uno dos tres" );

   F.pinfo();
   
   Siv Q(INT_,67);

   Q.pinfo();
  
//Siv Ivec(INT_,10,0,1,2);
    Siv Ivec(INT_,1,10,0,1);
    

   Ivec.pinfo();

   chkStr(E[1],"H");

   <<"$E[2] \n";

   svar  S[] = {"una larga noche"};

   <<"%V $S\n";

   svar  S1 = "una larga noche";

   <<"%V $S1\n";

   chkStr(S1[0], "una larga noche");

   S1.pinfo();

   <<" $(typeof(S)) $(Caz(S)) \n";

   S[1] = "el gato mira la puerta";

   S[2] = "espera ratones";

   <<"%V $S[2] \n";

   //Svar E3[] = { "third row elements are:", "Na", "Mg", "Al", "Si" ,"P" ,"S", "Cl", "Ar" };
   Svar E3 = { "third row elements are:", "Na", "Mg", "Al", "Si" ,"P" ,"S", "Cl", "Ar" };

   E3.pinfo()
   
   ans=ask("Svar array filled OK",1)

<<"$E[3:6] \n";



   W= E[3:7];

   <<"$(typeof(W)) \n";

   <<"$W\n";

   <<"$W[1]\n";

   chkStr(W[1],"Be");

   W[3:4] = E[7:8];

   <<"%V$W \n";

   T= E[1:9];

   <<"$T\n";

   sz=T.Caz();

   <<"$sz\n";

   chkN(sz,9);

   T= E[4:9];

   <<"$T\n";

   T.pinfo();

   sz=T.Caz();

   <<"$sz\n";

   R= E[4:9];

   <<"$R\n";

   R.pinfo();

   sz=R.Caz();

   <<"$sz\n";

   chkN(sz,6);

   chkStage("svar array ele");

   IV = vgen(INT_,10,0,1);

   <<"IV: $IV\n";

   RS= Split("$IV");

   RS.pinfo();

   <<"RS: $RS\n";

   S.pinfo();

   S= Split("$IV");

   S.pinfo();

   <<"$S\n";

   chkStr(S[1],"1");

   chkStr(S[2],"2");

   chkStr(S[3],"3");

   chkStr(S[9],"9");

   <<"$S[1:7]\n";

   chkStage ("assign via Split");

   VF = vgen(FLOAT_,10,1,0.5);

   <<"%V $VF\n";
//TSV="%6.2f$(VF*2)"

   TSV="$(VF*2)";

   <<"%V$TSV\n";

   <<"Que $(vgen(DOUBLE_,10,1,0.5) )\n";

   TS= "%6.2f$(vgen(FLOAT_,10,1,0.5))";

   <<"%V$TS\n";

   T= Split(TS);

   <<"$T\n";

float TFV[] = vgen(FLOAT_,10,1,0.5);

<<"TFV  %6.2f $TFV\n";

<<"%V  %6.3f $TFV[2]\n";

   T= Split("%6.2f$(vgen(FLOAT_,10,1,0.5))");

   <<"T: $T\n";

   T.pinfo();

<<" $T[1] $T[2] $T[3] \n"



   chkStr(T[1],"1.50");

   chkStr(T[2],"2.00");

   chkStr(T[3],"2.50");

   chkStage ("assign via Split print");
//

   T1= S[1:7:];

   <<"$T1\n";

   <<"%V$S\n";

   R= Split("47 79 80 81 82 83 84 85 86 87");

   R.pinfo();

   <<"$R\n";

   S[1:4:] = R;

   <<"%V$S\n";

   <<"$S[1]  $S[2] \n";

   S.pinfo();

   chkStr(S[1],"47");

   chkStr(S[2],"79");

   chkStage ("lh range assign");

   <<"$S\n";

   S[1:8:2] = R;

   <<"$S\n";

   chkStr(S[1],"47");

   chkStr(S[3],"79");

   chkStr(S[5],"80");

   chkStage ("lh range stride 2 assign");

   S[1:4:] = R[1:4];

   <<"$S\n";

   chkStr(S[1],"79");

   chkStr(S[2],"80");

   chkStage ("lh range assign and rh range");

   S= Split("$IV");

   S[1:8:2] = R[1:8:2];

   chkStr(S[1],"79");

   chkStr(S[3],"81");

   <<"$S\n";

   chkStage ("lh range assign and rh range -both stride 2");
//////////////////////////////////////////

   W[0] = "hey";

   <<"%v $W[0] \n";

   W[1] = "marcos";

   <<"%v $W[1] \n";

   <<"%v $W[0] \n";

   W[2] = "puedes";

   <<" $W \n";

   W[3] = "hacer";

   <<"%v $W[0] \n";

   W[4] = "tus";

   W[5] = "metas";

   W[6] = "amigo";

   W[7] = "?";
// W[8] = "?"

   <<"W[0::]  $W[0::] \n";

   <<"W[2::]  $W[2::]\n";

   T= W[2:-1:];

   <<"T $T\n";

   <<"%V$T[0]\n";

   <<"T[1] $T[1]\n";

   chkStr(T[0],"puedes");

   chkStr(T[0],W[2]);
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

   cov= getEnvVar("ITEST");

   if (! (cov @=""))

   {

     civ= atoi(cov);

     <<"%V $cov $civ\n";

     }

   str le;

   Mol = ( "JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" ) ;

   <<"$(typeof(Mol)) size $(caz(Mol))  \n";

   <<"List is $Mol \n";

   sz = caz(Mol);

   <<"%V$sz\n";

   chkN(sz,12);

   <<"first month $Mol[0]\n";

   <<"second month $Mol[1]\n";

   <<"twelveth month $Mol[11]\n";

   Mol.pinfo();

   le12 = Mol[11];

   <<"$(typeof(le12)) %V$le12\n";

   le = Mol[0];

   <<"$(typeof(le)) %V$le\n";

   chkStr(le,"JAN");

   <<"le checked\n";

   <<"%V $Mol[0] \n";

   chkStr(Mol[0],"JAN");

   <<"Mol[0] checked\n";

   le = Mol[1];

   <<"%V$le $Mol[1] checked\n";

   <<"$(typeof(le)) \n";

   chkStr(le,"FEB");

   <<"$(typeof(le)) %V$le\n";

   chkStr("FEB",Mol[1]);

   <<"$Mol[1] Mol[1] checked\n";

   chkStr(Mol[1],"FEB");
//checkProgress()

   <<" DONE Lists \n";
//////////////////////////////////

   Svar Mo[] = {"JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" };
//Svar Mo = {"JAN","FEB","MAR","APR" ,"MAY","JUN", "JUL", "AUG", "SEP", "OCT", "NOV" , "DEC" }

  <<" Mo $(typeof(Mo)) \n";

  sz= Caz(Mo);

  <<" Mo %V$sz \n";

  <<"$Mo[0] \n";

  <<"$Mo[1] \n";

  for (i = 0; i < 12 ; i++) {

  <<"$i $Mo[i] \n";

  }

  chkStr(Mo[0],"JAN");

  chkStr(Mo[11],"DEC");

  int A[] = {0,1,2,3,4,5,6,7,8};

  <<"$A\n";

  <<"sz $(Caz(A)) cab $(Cab(A))\n";

  chkN(A[1],1);

  chkN(A[8],8);

  IV= vgen(INT_,20,0,1);

  <<"$IV \n";

  T= itoa(IV) ; // does not deliver svar array;

  T.pinfo();

  <<"$T\n";

  M=Split("$IV");

  M.pinfo();

  <<"$M \n";

  <<"$M[3] $M[7]\n";

  IV2= atoi(M);

  <<"$IV2\n";

  IV2.pinfo();
//R= M[3::]   // TBF xic does not use default for range end

 ans= ask(" IV2 type ?",0)

  R= M[3:-1:];

  <<"$R \n";

  R.pinfo();

  <<"%V$R\n";

  <<"last? $R[-1]\n";

  chkStr(R[0],"3");
//chkStr(R[-1],"19")

  IV3= atoi(R);

<<"%V $IV3\n"


  IV3.pinfo();

  ans=ask("IV3 int?",1)

  <<"%V $IV3\n";

  <<"last ele IV[-1] $IV[-1] \n";

  chkN(IV3[0],3);

  chkN(IV3[1],4);

  chkN(IV3[-1],19);

  IV3 *= 2;

  chkN(IV3[0],6);

  <<"%V $IV3\n";
  
//M[3::] = atoi(IV3)

  M[0] = itoa(47)    // error int --> string

  M[0] = "47";

  <<"$M\n";

  chkStr(M[0],"47");

  R[0] = "79";

  R[1] = "80";

  R[2] = "82";

  chkStr(R[0],"79");

  M[3:6:] = R[0:3:];

  chkStr(M[3],"79");

  chkStr(M[4],R[1]);

  chkStr(M[4],"80");

  chkStr(M[5],"82");

  <<"$R\n";

  <<"$M\n";
////////////////////

  IV4=vgen(INT_,10,45,1);

  <<"$IV4\n";

  chkN(IV4[0],45);

  chkN(IV4[1],46);

  <<"%V $IV4\n";

  <<"%V $IV3\n";

  IV3[3:12:1] = IV4[0:9:];


  <<"%V $IV3\n";

  IV3.pinfo();
  ans=ask("IV3 int?",1)  

  chkN(IV3[0],6);

  chkN(IV3[3],45);

  chkN(IV3[4],46);

  <<"$IV3\n";

  IV4 = IV3;

  IV4[3:12:1] = 52;

  <<"$IV4\n";

  IV3[3:12:1] *= 2;

  <<"$IV3\n";

  <<"M $M \n";

  //IV3= atoi(M);
// allowDB("spe_,rdp,ds,ic",1)
  IV3= M;   // should give error !! - now does 3/16/24

  <<"$IV3\n";

  IV3.pinfo()

  kt = pinfo(IV3,TYPE_INFO_)
  <<" %V $kt\n"

 chkStr(kt,"INT")



  ans=ask("IV3=M   int? $kt error",1)

  kt = pinfo(IV3,OFFS_INFO_)
  <<" %V $kt\n"


   IV3.pinfo()
  
  chkN(IV3[0], 6);



  IV3.pinfo();
//IV3= atoi(M[3::])

   IV3[0] = 99;
<<"$M[4:-2]\n"

  IVA3= atoi(M[3:-1:]);


// should be an error
  //IV3= M[3:-1:];

 IV3= atoi(M[3:-1:]); // TBF does not do the range specified


<<"%V $M\n"

<<"M[] == $M\n"


<<"%V$M[3:-1]\n"

<<"%V $IV3\n";

<<"%V $IVA3\n";

  

  iv3 = IV3[0];

  iv4 = IV3[4];

 iv3.pinfo()

   IV3.pinfo();
   
   IV3[2].pinfo()

  <<" %V $iv3  $iv4 $IV3[0]\n"

//  chkN(atoi(IV3[0]), 79);

chkStr(IV3[0], "79");

  //chkN(IV3[0],79); // TBF 3/15/24  strv v number should still work but warn atol compare


  IV3.pinfo()

  if (IV3[0] == 79) {

  <<"OK $IV[0:-1:2] \n";

  }

  //chkOut(1)

  chkStage("declare");
/////////////////////////  svar proc ///////////////////////////
///
/// svar as proc arg
/// 

  void pSv (svar SV)
  {
//<<" $SV\n"

  SV.pinfo();

  static int k = 1;

  str w2;

  sz = Caz(SV);

  <<"%V $sz $SV[2] \n";

  w2 = SV[2];

  <<"%V $k $w2\n";

  if (k==1) {

  chkStr(w2,"we");

  }

  else if (k==2) {

  chkStr(w2,"is");

  }

  else if (k==3) {

  chkStr(w2,"40,07.00,N");

  ang =getDeg(SV[2]);

  <<"%V $ang\n";

  ang = getDeg(SV[3]);

  <<"%V $ang\n";

  }

  k++;

  }
//===========
//chkOut()

  S = Split("how did we get here");

  S.pinfo();

  pSv(S);

  TS2 = Split("again how is this happening");

  TS2.pinfo();

  pSv(TS2);
//===========

  proc getDeg (str the_ang)
  {
  str the_dir;
  float la;
  str wd;

  <<"in $_proc  $the_ang\n";

  the_parts = Split(the_ang,",");
      //<<"%V$the_parts \n"
//FIX    float the_deg = atof(the_parts[0])

  wd = the_parts[0];

  the_deg = atof(wd);

  sz= Caz(the_deg);

  <<" %V$sz $(typeof(the_deg)) $(Cab(the_deg))  \n";
//    float the_min = atof(the_parts[1])

  wd = the_parts[1];

  the_min = atof(wd);

  <<"%V$the_deg $the_min \n";

  sz= Caz(the_min);

  <<" %V$sz $(typeof(the_min))   $(Cab(the_min)) \n";

  the_dir = the_parts[2];

  y = the_min/60.0;

  la = the_deg + y;

  if ((the_dir @= "E") || (the_dir @= "S")) {

  la *= -1;

  }

  <<"%V $la  $y  \n";

  <<"%V $(caz(la))  $(Cab(la)) \n";

  return (la);

  }
//===============================//
//======================
/*
  class Turnpt
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
  cmf Set (svar wval)
  {
  <<"$_proc $(typeof(wval)) $wval[::] \n"
//<<"%V$_cproc  %i$_cobj   %i$wval \n"
     //sz = wval->Caz()
  sz = Caz(wval);
 // <<"%V$sz \n"
  <<"$sz 0: $wval[0] 1: $wval[1] 2: $wval[2] 3: $wval[3] 4: $wval[4] \n"
      //   <<"$wval[0]\n"
       //  <<"$(typeof(wval))\n"
       //ans = iread("-->");
  Place = wval[0];
  <<"%V$Place\n"
  Idnt =  wval[1];
  <<"%V$Idnt\n"
 //    <<"%V$wval[2]\n"
  Lat = wval[2];
     //   <<"%V$Lat  <| $wval[2] |>\n"
     //   <<"%V$wval[3]\n"	 
  Lon = wval[3];
     //       <<"%V$Lon  <| $wval[3] |>\n" 
  Alt = wval[4];
  rway = wval[5];
  Radio = atof(wval[6]);
  tptype = wval[7];
  <<"%V$Lat $Lon \n"
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
  P.pinfo()
  pSv(P)
  Turnpt  Tp;
  Tp->Set(P);
  P= Split("AngelFire    	AXX	36,24.75,N	105,18.00,W	8383	17/35	122.8	TA")
  Tp->Set(P);
 */


  chkStage("Proc");
//==============================//

  Svar Opts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,",",");

  <<"$Opts \n";

  chkStr("all",Opts[0]);

  chkStr("matrix",Opts[2]);

  //str Sr ="all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,proc,switch,types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help";

Str Sr ="all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,proc,switch,types,func";

  len = slen(Sr);

  <<"%V $len\n";

  <<"%V $Sr\n";

  svar Mopts[] = Split(Sr,",");

  <<"%V %(5,, ,\n)$Mopts[::] \n";

//allowDB("spe_,rdp,ds,svar,ic",1)
  chkStr("all",Mopts[0]);

  chkStr("matrix",Mopts[2]);

  Svar Sopts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex",",");

  <<"%V $Sopts \n";

  chkStr("bops",Sopts[4]);

  chkStr("class",Sopts[8]);

  Svar Popts[] = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,proc,switch,types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help",",");

//

 //allowDB("spe_,pex,ds,ic,split",1)

// Svar Popts = Split("all,array,matrix,bugs,bops,vops,sops,fops,class,declare,include,exp,if,logic,for,do,paraex,proc,switch,types,func,command",",");


   Popts.pinfo()
   

  <<"%V $Popts \n";

 <<"%V $Popts[1] $Popts[4]\n"

  <<" $Popts[6]  $Popts[7]\n"] 

    <<" $Popts[8:12]  \n"] 

  chkStr("array",Popts[1]);

  Ropts = Popts[13:21]

  Ropts.pinfo()

  <<"%V $Ropts \n";

  chkStage("Split");

  chkOut();

//===***===//
