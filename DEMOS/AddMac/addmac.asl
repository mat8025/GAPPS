//%*********************************************** 
//*  @script addmac.asl 
//* 
//*  @comment adding machine 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Tue Oct  1 05:07:22 2019 
//*  @cdate Mon Sep 30 08:58:13 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
///
///
///

Record RF[>20];

total = 0.0;
cash = 0.0
i = 1;

////
 nargs = argc()
 if (nargs >1) {

  billname = _clarg[1]
  <<"read in $billname\n"
  A=ofr(billname)
  ///////////////
  RF= readRecord(A,@del,',') ;   // RF record created
  cf(A);

  Nrecs = Caz(RF);
  Ncols = Caz(RF,1);

<<"num of records $Nrecs  num cols $Ncols\n";

   for (i= 0; i < 3; i++) {
       nc = Caz(RF,i);
<<"<$i> $nc $RF[i] \n";
    }


   for (i= Nrecs-3; i < Nrecs; i++) {
       nc = Caz(RF,i);
<<"<$i> $nc $RF[i] \n";
    }


  //////////////

 }





////

 i = Nrecs;

 while (1) {

  item = iread("$i what?:")
  <<"$item \n"

  if (item @= "done") {
      break;
  }

  RF[i][0] = item;
  
  amt = iread(" howmuch\$:")
  <<"$amt \n"

  cash = atof(amt)

  total += cash;
  RF[i][1] = "$(Fround(cash,2))";
  <<"$i $RF[i][0] $cash $total\n"
   i++;
   
 }

 A=ofw("bill.txt")
 CheckTotal = 0.0;

N = 40

 for (k= 0; k < i; k++) {
 wrd = RF[k][0]
 len = slen(wrd)
if (len < N) {
n= N-len
ws=nsc(n," ")
wrd= scat(wrd,ws)
}
   j= k+1;
   <<"$j\t <| $RF[k][1], |> \n"
   cash = atof(RF[k][1]);
   cash = Fround(cash,2);
  <<"$j\t$wrd\t$cash, \n"
  <<[A]"$wrd,$cash, \n"
  
 CheckTotal += atof(RF[k][1]);
 }

 CheckTotal = Fround(CheckTotal,2)


 <<" %V$CheckTotal\n"

cf(A)
