//%*********************************************** 
//*  @script vmf.asl 
//* 
//*  @comment test vmf - var member function 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Mon Apr 13 11:35:45 2020 
//*  @cdate Sat Apr 11 23:11:04 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_");

setdebug(1,@pline,@trace)

//  all or some ?


CheckIn()


int do_all = 1;
int do_cut = 0;
int do_white = 0;
int do_rotate = 0;
int do_substitute = 0;
int do_trim = 0;
int do_prune = 0;
int do_bubblesort = 0;
int do_rand = 0;
int do_caz = 0;

if (do_cut || do_all) {

int I[] ;

I= Igen(20,0,1)

<<" $I \n"

 I[14]->Set(747)

<<" $I\n"

I[5:13:2]->Set(50,1)

<<"$I \n"

C = Igen(4,12,1)

<<" $C \n"

I->cut(C)



<<" $I \n"

CheckNum(I[12],16)






float F[]

F= Fgen(20,0,1)

sz = Caz(F)
<<"$sz $F \n"
//<<"%,j%{5<,\,>\n}%6.1f$F\n"

<<"%6.1f $F\n"

C = Igen(4,12,1)

<<"%V $C \n"

F->cut(C)


<<"%6.1f  $F \n"
CheckFNum(I[12],16,6)


<<" $I[::] \n"

I[3:8]->cut()

<<" $I[::] \n"
CheckNum(I[3],52)

F[3:8]->cut()

<<" %6.1f $F[::] \n"
CheckFNum(F[3],9,6)

F[3]->cut()

<<" %6.1f $F[::] \n"
checkStage("cut")

}




float FS[]

FS= Fgen(20,0,1)

sz = Caz(FS)

FS[3]->obid()

id = FS[3]->obid()

<<" $id \n"
checkStage("obid")

//=============================/
if (do_white || do_all) {
/{/*
Dewhite(S)
Dewhites a string variable (or array of strings)
S->Dewhite() - dewhites a string
S[a:b]->Dewhite()
would dewhite a range of an array of strings - where S is an array 
/}*/



svar  T = "123 456   789  "
T[1] = T[0]
T[2] = T[1]

for (i=3;i<=10;i++) {
T[i] = T[0]
}


<<"%(1,,,\n)$T \n"


T[2]->dewhite()

ns="123 456   789  ";

checkstr(T[2],"123456789")
checkstr(T[0],ns)

checkstr(T[0],"123 456   789  ")

<<"%(1,,,|>\n)$T \n"


T[4:6]->dewhite()

<<"%(1,<|,,|>\n)$T \n"

checkstr(T[4],"123456789")
checkstr(T[6],"123456789")

len=slen(T[8])
len2=slen(ns)
<<"%V$len $len2\n"
checkstr(T[8],ns)

<<"<|$T[8]|>\n"
<<"<|$ns|>\n"


k=scmp(T[8],ns)
<<"%V$len $len2 $k\n"

checkStage("dewhite")
}
//===========================//

if (do_rotate || do_all) {
//%*********************************************** 
//*  @script rotate.asl 
//* 
//*  @comment test rotate vector 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//*
//***********************************************%

/{/*
 rotate

rotate(vec, dir, nsteps)
or
Vec->rotate(dir,nsteps)

Vector is rotated in direction (1 forward , -1 backward) for nsteps

/////
/}*/




IV = vgen(INT_,20,0,1)

<<"$IV\n"

checkNum(IV[0],0)

IV->rotate(1,3)


<<"$IV\n"

checkNum(IV[0],17)

IV->rotate(-1,4)


<<"$IV\n"

checkNum(IV[0],1)

rotate(IV,1,5)

<<"$IV\n"

checkNum(IV[0],16)
checkStage("rotate")
}

//=================//

if (do_substitute || do_all) {
//%*********************************************** 
//*  @script substitute.asl 
//* 
//*  @comment test substitute func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
/{/*

substitute

substitutes string w3 into w1 for  first occurence of w2 returns the result.
substitute

/////
V->SubStitute(this_str,with_str)
 Substitutes a sub string with another  in the  string variable V 


/}*/



svar  TS = "123456789"

for (i=1;i<=10;i++) {
TS[i] = TS[0]
}


<<"%(1,,,\n)$TS \n"


TS[2]->Substitute("456","ABC")

checkstr(TS[1],"123456789")
checkstr(TS[2],"123ABC789")

<<"%(1,,,\n)$TS \n"

TS[4:6]->Substitute("789","DEF")

checkstr(TS[4],"123456DEF")
checkstr(TS[6],"123456DEF")

TS[::]->Substitute("123","XYZ")

for (i=0;i<=10;i++) {
checkstr(TS[i],"XYZ",3)
}
<<"%(1,,,\n)$TS \n"

TS[3]->Substitute("XYZ","AAA")

//TS[4]->Substitute("XYZ",BBB)  // use to check error flag in svarg
// error in args - skip function

TS[4]->Substitute("XYZ","BBB")


TS[5]->Substitute("XYZ","CCC")

TS->Sort()

<<"%(1,,,\n)$TS \n"
checkStr(TS[0],"AAA",3)


checkStage("substitute")
}

if (do_trim || do_all) {

//%*********************************************** 
//*  @script trim.asl 
//* 
//*  @comment test trim func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
/{/*
Trim(S)
Trims a string variable (or array of strings)
S->Trim(nc) - trims chaaracters from head or tail of string
S[a:b]->Trim(- 4)
would trim four chars from end of  a range of an array of strings - where S is an array
S->Trim(4)
would trim four chars from nead of  a range of an array of strings - where S is an array 


/}*/


svar  S = "una larga noche"

<<"%V $S\n"

<<" $(typeof(S)) $(Caz(S)) \n"

S[1] = "el gato mira la puerta"

S[2] = "espera ratones"

S[3] = "123456789"
<<"%V $S[2] \n"

<<"%(1,,,\n)$S \n"

S->trim(-3)

<<"%(1,,,\n)$S \n"

checkstr(S[3],"123456")

S[3]->trim(3)

checkstr(S[3],"456")



S->trim(3)



checkstr(S[3],"")




<<"%(1,,,\n)$S \n"



checkStage("Trim")
}

if (do_all || do_prune) {

//%*********************************************** 
//*  @script prune.asl 
//* 
//*  @comment test prune func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
/{/*

Prune(S)
Prunes a string variable (or array of strings) to a specified length
S->Prune(length) - trims characters from head or tail of string until a vspecified length
 no action if stem already less than of equal to required length
S[a:b]->Prune(-4)
would prune  from tail of  a range of an array of strings - where S is an array
S->Prune(4)
would prune from head of string until required length

/}*/


svar  TP = "123456789"
TP[1] = TP[0]
TP[2] = TP[1]
for (i=3;i<=10;i++) {
TP[i] = TP[0]
}
<<"%(1,,,\n)$TP \n"

TP[1]->Prune(-3)

checkstr(TP[1],"123")

<<"%(1,,,\n)$TP \n"

TP[2]->Prune(3)

checkstr(TP[2],"789")

<<"%(1,,,\n)$TP \n"

TP[4:6]->Prune(-5)

<<"%(1,,,\n)$TP \n"

checkstr(TP[4],"12345")
checkstr(TP[5],"12345")
checkstr(TP[6],"12345")
checkstr(TP[7],"123456789")

checkStage("Prune")
}

if (do_all || do_bubblesort) {
//%*********************************************** 
//*  @script bubblesort.asl 
//* 
//*  @comment test bubblesort vmf 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//*
//***********************************************%

/{/*
BubbleSort

bubblesort(Vec)
performs bubble sort on a vector returns the sorted vector.
Should work on all types.
can be used as Vec->BubbleSort() returns 1 if sorted.
/}*/




I = vgen(INT_,30,0,1)

<<"$I \n"

checkNum(I[1],1)
checkNum(I[29],29)

I->reverse()

<<"$I \n"
checkNum(I[1],28)
checkNum(I[29],0)


I->bubbleSort()

<<"$I \n"

checkNum(I[1],1)
checkNum(I[29],29)

rs= scat("Now ", " Shuffle ");
<<"$rs\n"


I->shuffle(20)

<<"$I \n"

I->bubbleSort()

<<"$I \n"

checkNum(I[1],1)
checkNum(I[29],29)

checkStage("bubblesort")
}
//======================//
if (do_all || do_rand) {
//%*********************************************** 
//*  @script rand.asl 
//* 
//*  @comment test rand vmf 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Mon Mar 25 08:42:34 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//*
//***********************************************%
   
/{/* 



   
/}*/
   
   P = Rand(6,42,0,0); 
   
   <<"$P\n"; 
   P->sort(); 
   <<"$P\n"; 
   
   V= Rand(20,100); 
   
   
   <<"$V\n"; 
   
   R= vgen(FLOAT_,30,0,1); 
   <<"$R\n"; 
   
   R->rand(); 
   
   <<"$R\n"; 
   
   R->sort(); 
   <<"$R\n"; 
   
   last_ma = 1000;
   ma = 1000;
   max_hits =0;
   Ntrys = 10;
   nwins = 0;
   int HITS[7];   
   int Winners[+10]; 
   Tim=fineTime();

   for (i=0; i < Ntrys; i++) {
     
//     rs=randseed(0); 
     
     TR = Rand(6,42,0,0); 
     
     
     TR->sort(); 
     
     mm=minmax(TR)
     <<"%V$mm\n"
     checkNum(mm[0],42.0,LTE_)
     
     I=Cmp(P,TR); 

     hits =0;
     if (I[0] != -1) {
         sz=Caz(I); 
         hits = sz;
         D= P-TR; 
         E= Abs(D); 	 
         ma = Sum(E);
      }

      HITS[hits] += 1;

         if (hits == 6) {
           <<"Winner! <$i> \n"; 
           Winners[nwins] = i;
           nwins++;
           }

         if (hits > max_hits) {
           max_hits = hits;
       <<"<$i> hits $hits\n";
       <<"$I\n"; 
       <<"$P\n"; 
       <<"$TR\n"; 
        <<"$E\n"; 
          }


      if (ma < last_ma) {
       <<"<$i>  $ma\n"; 
       <<"$I\n"; 
       <<"$P\n"; 
       <<"$TR\n"; 
        <<"$E\n"; 
       last_ma = ma;
       }
     
     if ( (i % 2000) == 0) {
       dt= fineTimeSince(Tim,1); 
       secs = dt/1000000.0;
       tim=time(); 
       <<"$i $tim $secs $last_ma $max_hits $nwins $HITS\n"; 
       }
     
     }
   
   
   <<"%V $Ntrys $max_hits $last_ma $nwins\n";
   <<"%V $HITS\n"
   <<"$Winners\n"; 

checkStage("rand")

}

//==================//
if (do_all || do_caz) {

//%*********************************************** 
//*  @script caz.asl 
//* 
//*  @comment test Caz func 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%///

/{/*
Caz,Csz ~ check size, check array size

/////
Caz(A) of Caz(&A)
returns current size (number of elements) where A is an  vectoror matrix
Caz(&i) 
would return 0  when i is a scalar.

Caz(A[1:9:2]) returns 5 
the subscripted size 
assuming A has at least 10 elements.


/}*/



int DC[5];

DC[1] = 1

DC[4] = 4

int d;

d = 79;

<<" $d scalar $(Sizeof(d))\n"

asz= Csz(&d)

<<"array size of $d $(typeof(d))  is: $asz \n"

nd = Cnd(&d)
<<"number of dimensions are: $nd \n"
checkNum(nd,0)

ab = Cab(&d)
<<"bounds are: $ab \n"
checkNum(ab,0)


checkNum(asz,0)
DC->info(1)
asz= Csz(&DC)
//<<"%V$asz\n"
//DC->info(1)

<<"array size of $DC $(typeof(DC))  is: $asz \n"
checkNum(asz,5)
nd = Cnd(&DC)
<<"number of dimensions are: $nd \n"
checkNum(nd,1)

ab = Cab(&DC)
<<"bounds are: $ab \n"
checkNum(ab,5)


////////////////////////////////

<<"\n Svar vector \n"

Svar SC;

<<"$SC scalar $(Sizeof(SC))\n"

SC[0] = "hey"

SC[1] = "mark"

asz= Csz(SC)

<<"$asz  $(Cab(SC))\n"

<<"\n vector \n"

int A[6]  = { 1,2,4,9,8,6 }

a= A[0]

<<"$a\n"
<<"$A\n"

asz= Csz(A)
<<"array size (number of elements) is: $asz \n"
checkNum(asz,6);

nd = Cnd(A)
<<"number of dimensions are: $nd \n"
checkNum(nd,1)
ab = Cab(A)



<<"bounds are: $ab \n"


<<" $(Caz(A)) $(typeof(A)) \n"


//<<"%I $A \n"   // will crash why?

 d= Cab(A)

<<"%V $d \n"


/////////////////////////////////////////
<<"////\n Two dimensions \n"
// FIXME  -- won't fill in rows

int  B[6] = { 0,3,2,-1,1,-2} ;

 <<"%V $B\n"


asz= Csz(B)
<<"array size (number of elements) is: $asz \n"
checkNum(asz,6);
nd2 = Cnd(B)
<<"number of dimensions are: $nd2 \n"
checkNum(nd2,1)
ab = Cab(B)

<<"bounds are: $ab \n"

 d= Cab(B)

<<"%V $d \n"


  B->redimn(2,3)


asz= Csz(B)
<<"array size (number of elements) is: $asz \n"
checkNum(asz,6);
nd2 = Cnd(B)
<<"number of dimensions are: $nd2 \n"
checkNum(nd2,2)
ab = Cab(B)

<<"bounds are: $ab \n"

 d= Cab(B);

/{/*

 int C[3][3][3] = { { {0,1,2}, {3,4,5}, {6,7,8} },
                    { {9,10,11}, {12,13,14}, {15,16,17} },
		    { {18,19,20}, {21,22,23}, {24,25,26}}
		    };
                        


int  B[2][3] 
  k= 0;
  for (i = 0; i < 2; i++) {
   for (j = 0; j < 3; j++) {
     B[i][j] = k++;
   }
}


b = B[0][0]
<<"$b\n"

b = B[0][2]
<<"$b\n"




asz= Csz(B)
<<"array size (number of elements) is: $asz \n"

nd2 = Cnd(B)
<<"number of dimensions are: $nd2 \n"

ab = Cab(B)

<<"bounds are: $ab \n"

 d= Cab(B)

<<"%V $d \n"
/}*/

checkStage("caz")
}

checkOut()



checkStage("xxx")

