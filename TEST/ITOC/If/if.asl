//%*********************************************** 
//*  @script if.asl 
//* 
//*  @comment test ifnest 
//*  @release CARBON 
//*  @vers 1.8 O Oxygen [asl 6.2.98 C-He-Cf]                             
//*  @date Mon Dec 21 20:46:11 2020                           
//*  @cdate Sat Apr 18 21:48:17 2020 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

#include "debug"

debugON()

chkIn(_dblevel)


i = 0;
j = 2;

chkN(j,2);

 if (i == 2) {
   <<" $i == 2 \n"
   j = 1;
 }
 else if (i > 2) {
  <<" $i > 2 \n"
    j = -4
 }
 else {
   j = -2
  <<" $i < 2 \n"
 }


<<"%V $j\n"
chkN(j,-2)
  j = -1
 chkN(j,-1) 

//checkOut()
//exit()


i = 3
j = 0;


 if (i == 2) {
   <<" $i == 2 \n"
   j = 1;
 }
 else if (i > 2) {
  <<" $i > 2 \n"
  j = 2
 }
 else {
  <<" $i < 2 \n"
  j = -1
 }

chkN(j,2)


i = 0
j = 0;


 if (i == 2) {
   <<"the if $i == 2 \n"
   j = 1;
 }
 else if (i > 2) {
  <<"the-else-if $i > 2 \n"
  j = 2
 }
 else {
  <<"the else $i < 2 \n"
  
  j = -1
 }

<<"%V $j\n"
chkN(j,-1)



N = getArgI()
<<" supplied arg is [ $N ] testing for <,=, or > than 1\n"

prog = GetScript()
<<" ${prog} \n"
<<" ${prog}: \n"

#{

  Test If variations

#}



itest = 1
a = 2


//<<" $a $gt $eq $lt \n"

 gt = 0
 eq = 0
 lt = 0

 if (a > 0) {
   gt =1
 }

 chkN(a,2)
 chkN(gt,1)

<<"%V $a > 0 ? \t: $lt $eq $gt \n"
 gt = 0
 eq = 0
 lt = 0



<<" test eqv to \n"

  a = 0;
  
 if (a == 0) {
   eq = 1
  }

 chkN(a,0)
 chkN(eq,1)

 <<"%V $a == 0 ? \t: $lt $eq $gt \n"

 a--
 
 gt = 0
 eq = 0
 lt = 0

 if (a < 0) {   
   lt = 1; 
 }


 chkN(lt,1)

<<"%V $a < 0 ? \t: $lt $eq $gt \n"


 
 a--

 tot = gt + lt + eq

 



 a =1
<<" \n"


 gt = 0
 eq = 0
 lt = 0

 if (a > 0) 
   gt =1


 chkN(gt,1)


<<"%v $a ? 0 \t: $lt $eq $gt \n"
 a--



 if (a == 0) 
   eq = 1

 chkN(eq,1)

<<"%v $a ? 0 \t: $lt $eq $gt \n"
 a--

 if (a < 0)    
   lt = 1; 

 chkN(lt,1)

<<"%v $a ? 0 \t: $lt $eq $gt \n"
 a--

 tot = gt + lt + eq

 a =1



 while (a > -2) {
<<" first in while \n"
 gt = 0
 eq = 0
 lt = 0
<<" before first if in while \n"
 if (a > 0) {
   gt =1
 }
<<" after first if in while \n"

 if (a == 0) {
   eq = 1
  }

 if (a < 0) {   
   lt = 1; 
 }

 tot = gt + lt + eq


<<"%v $a ? 0 \t: $lt $eq $gt \n"
 a--
<<" last st in while \n"

 }

 a = 1

<<" \n"


 while (a > -2) {

 gt = 0
 eq = 0
 lt = 0

 if (a > 0) 
   gt =1


 if (a == 0)
   eq = 1
  

 if (a < 0) 
   lt = 1
<<" missed ? \n"

<<"%v $a ? 0 \t: $lt $eq $gt \n"
 tot = gt + lt + eq

 a--
 }



islt = 0
isgt = 0
iseq = 0
nwr = 1

N = 1 
bad = 0

  if (N > 1 ) 
      bad++    


  if (N > 1 )  chkN(N,0)

  if (N < 1 )  chkN(N,0)


  if (N == 1 )  chkN(N,1)


 checkStage("if-0")




float ICAO_SA[10][4]

ICAO_SA[0][0] = 3 

<<"%I $ICAO_SA[0][0] \n"

ICAO_SA[0][3] = 7 

<<"%I $ICAO_SA[0][3] \n"

ICAO_SA[2][3] = 18 

<<"%I $ICAO_SA[2][3] \n"


 CheckFNum(ICAO_SA[2][3],18,6)
 CheckFNum(ICAO_SA[0][3],7,6)


 i = 1
 k = 2


ICAO_SA[i][k] = 69 

ICAO_SA[k][i] = 73 

<<"%I $ICAO_SA[i][k] \n"

<<"%I $ICAO_SA[k][i] \n"


CheckFNum(ICAO_SA[i][k],69,6)
CheckFNum(ICAO_SA[k][i],73,6)

y = k * 2 

<<"%I $y \n"

ICAO_SA[k][i] = (k * 2) 

<<"$ICAO_SA[k][i]  should be 4 !\n"

<<"$ICAO_SA\n"

CheckFNum(ICAO_SA[k][i],4,6)

ICAO_SA[k][i] = 5

<<"$ICAO_SA\n"

<<"%V$ICAO_SA[k][i]  should be 5 !\n"

ICAO_SA[k][i] = (k * 3) 

<<"$ICAO_SA[k][i]  should be 6 !\n"

<<"$ICAO_SA\n"
j= (k * 3) 
ICAO_SA[k][i] = 707

<<"$ICAO_SA\n"
j = 787
ICAO_SA[k][i+1] = j

<<"$ICAO_SA\n"

CheckFNum(ICAO_SA[k][i+1],787,3)


ICAO_SA[k][i] = k

<<"%I $ICAO_SA[k][i]  should be $k !\n"


chkN(ICAO_SA[k][i],k)





i = 5

    ICAO_SA[i][k] = i * 2;

<<"%I $ICAO_SA[i][k] \n"

chkN(ICAO_SA[i][k], (i *2))


<<" ///////////// \n"
  k = 3;

  for (i = 1; i < 10; i++) {

<<" $i $k \n"

    ICAO_SA[i][k] = i * 2;

<<"%v $ICAO_SA[i][k] \n"

    z = i * 2;

    y = ICAO_SA[i][k];

<<"%v $y \n"

<<"$i $k $z $y \n"

//FIXME   <<" %4r${ICAO_SA[i][0:2]} \n"

  }




i = 6

<<"%I $ICAO_SA[i][k] \n"
<<" ///////////// \n"
//FIXME <<"%4r $ICAO_SA \n"

<<" %(\t->\s,,\s<-\n)$ICAO_SA \n"
checkStage("if 1")





//uint j = 429000000
//uint j = 120000000
//uint j = 120000000

d = pow(2,8) -5
<<"%V$d \n"


uint k5 =  2^3

<<"%V$k5 \n"


uint j5 = d

<<"%v$j5 \n"


uint ts_secs = j5-4


chkN(ts_secs,(j5-4))

uint last_ts_secs = j5

   <<"%V $ts_secs  $last_ts_secs \n"

chkN(last_ts_secs,j5)

int n = 0

<<"%v $n \n"

chkN(0,n)


 for (i= 0; i < 5; i++) {


   if (ts_secs == last_ts_secs) {

   <<"%V $ts_secs == $last_ts_secs \n"

   n++

   }

   ts_secs++

 <<"%V $i $ts_secs \n"

 }


chkN(1,n)

checkStage (" if - 5")

//%*********************************************** 
//*  @script if6.asl 
//* 
//*  @comment if syntax tests 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Mon Apr  8 09:56:09 2019 
//*  @cdate Mon Apr  8 09:56:09 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



 do_all = 1

 do_bops = 1

<<"%V $do_all $do_bops \n"

  if ((do_all == 6)) {

     <<"is %v $do_all == 6 TRUE? is TRUE\n"

  }
  else {

    <<" ELSE %v $do_all != 6 TRUE? is TRUE\n"
       chkN(1,do_all)
  }

  do_all = 6

  if (do_all == 6) {

     <<"is %v $do_all == 6 TRUE? is TRUE\n"
       chkN(6,do_all)
  }
  else {

    <<" ELSE %v $do_all != 6 TRUE? is TRUE\n"

  }







  if (do_all) {

     <<"is %v $do_all value TRUE is correct?\n"
       chkN(6,do_all)
  }
  else {

     <<" ELSE %v $do_all is FALSE is correct?\n"

  }

  if (do_bops) {

     <<"is %v $do_bops value TRUE is correct?\n"
       chkN(1,do_bops)
  }
  else {

     <<" ELSE %v $do_bops is FALSE is correct?\n"

  }





  if ((do_all == 4)) {

     <<"is %v $do_all == 4 TRUE? is TRUE\n"

  }
  else {

   <<" ELSE %v $do_all != 4 TRUE? is TRUE\n"
       chkN(6,do_all)
  }




  if ( do_bops == 2 ) {

     <<"%v $do_bops == 2 TRUE? is TRUE\n"
  }
  else {

     <<"%v $do_bops == 2 TRUE? is FALSE\n"

  }


  if (do_bops || do_all) {

     <<"%V $do_bops ||  $do_all TRUE? is TRUE\n"
  }
  else {

     <<"%V $do_bops ||  $do_all FALSE? is TRUE\n"

  }


  do_bops = 0

<<"%v $do_bops   FALSE \n"



  if ( do_bops || do_all) {

     <<"%V $do_bops ||  $do_all TRUE? is TRUE\n"
       chkN(0,do_bops)
  }
  else {

     <<"%V $do_bops ||  $do_all FALSE? is TRUE\n"

  }


  do_bops = 2

  if (do_bops && do_all) {

     <<"%V $do_bops &&  $do_all \n"
       chkN(2,do_bops)
  }
  else {

  <<"%V $do_bops &&  $do_all is FALSE\n"

  }


CheckStage("if -6")



//%*********************************************** 
//*  @script ifnest.asl 
//* 
//*  @comment test ifnest and sindent 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Mon Apr  8 09:07:32 2019 
//*  @cdate Mon Apr  8 09:07:32 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
   
   
//N = atoi( _clarg[1])
   

   
   N =5; 
   <<" $N  testing for <,=, or > than 1\n"; 
   nwr = 4; 
   jlt =0;
   jeq = 0;
   jgt = 0;
   j = 1; 
   M = N + 3; 
   if (N > j) {
     while (j <= M) {
       
       if (nwr == 4) {
         if (N > j )
         {
           <<"$N > $j \n"; 
           jlt++;
           j++; 
           <<"%v $j $jlt do we see this if true line ?\n"; 
           }
         else if (N ==j)  {
           <<"$N == $j \n"; 
           j++; 
           jeq++;
           <<"%v $j == $N do we see this else if line ?\n"; 
           }
         else {
           <<"$N < $j \n"; 
           j++; 
           jgt++;
           <<"%v $j $jgt do we see this else line ?\n"; 
           }
         }
       }
     }
   else {
     <<" N<=j \n"; 
     }
   
   
   chkN(jlt,4); 
   chkN(jeq,1); 
   chkN(jgt,3); 
   
   <<"%V $jlt $jeq $jgt\n"; 
   checkStage("if - nest"); 
   
//%*********************************************** 
//*  @script if_fold.asl 
//* 
//*  @comment if syntax tests 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Mon Apr  8 13:59:31 2019 
//*  @cdate Mon Apr  8 09:56:09 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%






a=1
b=1
c=1

  if ( a && b && c) {
<<"%V $a $b $c all +ve\n" 
    chkT(1)
  }



  if ( a \
  && c){
<<"fold 0 %V $a $b $c all +ve\n"
    chkT(1)
  }



  if ( a \
  && b \
  && c){
<<"fold 1 %V $a $b $c all +ve\n"
    chkT(1)
  }
 else {
<<"%V $a $b $c not all +ve\n" 
  }





  if ( a \  
  && b \     
  && c) {
      chkT(1)
<<"fold 2 %V $a $b $c all +ve\n" 
  }
 else {
<<"%V $a $b $c not all +ve\n" 
  }



b = 0;

  if ( a \
  && b \
  && c)
  
  {
      chkT(0)
<<"fold 3 %V $a $b $c all +ve\n" 
  }
  else {
      chkT(1)
<<"fold 3%V $a $b $c not all +ve\n" 
  }




c = 0;

  if ( a \
  && b \   
  && c)  {
      chkT(0)
<<"fold 4 %V $a $b $c all +ve\n" 
  }
  else {
      chkT(1)
<<"fold 4 %V $a $b $c not all +ve\n" 
  }






 is_comment =0;
 is_proc =0;
 is_if  =0;

 cs ="ABCDefg"
 sl = slen(cs)
 
 if ( !is_comment && !is_proc && !is_if  && (sl > 0) && (  sstr(";/{}\\",cs,1) == -1) ) { 
    chkT(1)
  <<"all tests true %V is_comment && $is_proc && $is_if $sl\n" 

 }




 if ( !is_comment && !is_proc && !is_if  && (sl > 0) \
      && (  sstr(";/{}\\",cs,1) == -1) )
      { 
    chkT(1)
  <<"fold 5 all tests true %V is_comment && $is_proc && $is_if $sl\n" 

 }
 else {
<<"fold 5 not correct!\n";
 }



 if ( !is_comment && !is_proc && !is_if  && (sl > 0) &&\  
     (  sstr(";/{}\\",cs,1) == -1) )  {
         chkT(1)

  <<"fold 6 all tests true %V is_comment && $is_proc && $is_if $sl\n" 

 }
 else {
<<"fold 6 not correct!\n";
 }




 if ( !is_comment && !is_proc && \
      !is_if  && (sl > 0) && \      
     (  sstr(";/{}\\",cs,1) == -1) )      { 
    chkT(1)
  <<"fold 7 all tests true %V is_comment && $is_proc && $is_if $sl\n" 

 }
 else {
<<"fold 7 not correct!  WS after fold control?\n";
 }


 if ( !is_comment \
      && !is_proc \
      && !is_if  \
      && (sl > 0) \
      && (  sstr(";/{}\\",cs,1) == -1) )
 { 
    chkT(1)
  <<"fold 8 all tests true %V is_comment && $is_proc && $is_if $sl\n" 

 }
 else {
     chkT(0)
<<"fold 8 not correct!  WS after fold control?\n";
 }


checkStage("if - fold")

///
///

proc woo(str c_dir)
{
int la = 1

str the_dir ="W"

   the_dir = c_dir

// FIXIT --- XIC won't do the second -unless the first pass did the second comparision

   if (the_dir @= "E") {
<<"East is East \n"
         la = 90;
   }

   if (the_dir @= "S") {
<<"South is South \n"
         la = 180;
   }

   if (the_dir @= "W") {
<<"West is West \n"
         la = 270
   }

   if (the_dir @= "N") {
<<"North is Cold \n"
         la = 360
   }

<<"%V$c_dir $the_dir $la \n"

   return la
}




k = woo("E")


<<"$k\n"
chkN(k,90)

k = woo("S")

chkN(k,180)

<<"$k\n"


k = woo("W")
chkN(k,270)

k = woo("N")
chkN(k,360)

<<"$k\n"

checkStage("logic chain")



///
///
///


 fname = _clarg[1];


 sv = "";


<<"sv $(typeof(sv))  <|$sv|> \n"

<<"ca1 <|$fname|>\n"

 tf= (fname @= "");

<<"$(typeof(tf)) %V $tf \n"

 int ntf = 0;
 ntf= !(fname @= "");

<<"$(typeof(ntf)) %V $ntf \n"

 stf= scmp(fname,"");

<<"$(typeof(stf)) %V $stf \n"





int ans = 0;

if (ans) {

<<"ans != 0 %V $ans\n"

}
else {

<<" correct $ans == 0\n"
chkN(ans,0)
}



if (!ans) {

<<"correct ans == 0 !ans %V $ans\n"
chkN(ans,0)
}
else {

<<"incorrect  $ans != 0\n"

}


if (!(ans)) {

<<"correct ans == 0 !ans %V $ans\n"

}
else {

<<" $ans != 0\n"

}

if (!(ans == 1)) {

<<"correct !(ans == 1) %V $ans\n"
chkN(ans,0)
}
else {

<<" $ans != 0\n"

}




if (fname @= "") {

<<"ca1 <|$fname|> is NULL\n"

}


if ((fname @= "") != 1) {

<<"ca1 <|$fname|> has value1\n"

}
else {

<<"ca1 <|$fname|> is NULL\n"
}

if (!(fname @= "")) {

<<"ca1 <|$fname|> has value2\n"

}
else {

<<"ca1 <|$fname|> is NULL\n"
}


chkStage("chk null")



chkOut()
