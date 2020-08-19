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

include "debug.asl"

debugON();
CheckIn()



a=1
b=1
c=1

  if ( a && b && c) {
<<"%V $a $b $c all +ve\n" 
    checkTrue(1)
  }



  if ( a \
  && c){
<<"fold 0 %V $a $b $c all +ve\n"
    checkTrue(1)
  }



  if ( a \
  && b \
  && c){
<<"fold 1 %V $a $b $c all +ve\n"
    checkTrue(1)
  }
 else {
<<"%V $a $b $c not all +ve\n" 
  }





  if ( a \  
  && b \     
  && c) {
      checkTrue(1)
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
      checkTrue(0)
<<"fold 3 %V $a $b $c all +ve\n" 
  }
  else {
      checkTrue(1)
<<"fold 3%V $a $b $c not all +ve\n" 
  }




c = 0;

  if ( a \
  && b \   
  && c)  {
      checkTrue(0)
<<"fold 4 %V $a $b $c all +ve\n" 
  }
  else {
      checkTrue(1)
<<"fold 4 %V $a $b $c not all +ve\n" 
  }






 is_comment =0;
 is_proc =0;
 is_if  =0;

 cs ="ABCDefg"
 sl = slen(cs)
 
 if ( !is_comment && !is_proc && !is_if  && (sl > 0) && (  sstr(";/{}\\",cs,1) == -1) ) { 
    checkTrue(1)
  <<"all tests true %V is_comment && $is_proc && $is_if $sl\n" 

 }




 if ( !is_comment && !is_proc && !is_if  && (sl > 0) \
      && (  sstr(";/{}\\",cs,1) == -1) )
      { 
    checkTrue(1)
  <<"fold 5 all tests true %V is_comment && $is_proc && $is_if $sl\n" 

 }
 else {
<<"fold 5 not correct!\n";
 }



 if ( !is_comment && !is_proc && !is_if  && (sl > 0) &&\  
     (  sstr(";/{}\\",cs,1) == -1) )  {
         checkTrue(1)

  <<"fold 6 all tests true %V is_comment && $is_proc && $is_if $sl\n" 

 }
 else {
<<"fold 6 not correct!\n";
 }




 if ( !is_comment && !is_proc && \
      !is_if  && (sl > 0) && \      
     (  sstr(";/{}\\",cs,1) == -1) )      { 
    checkTrue(1)
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
    checkTrue(1)
  <<"fold 8 all tests true %V is_comment && $is_proc && $is_if $sl\n" 

 }
 else {
     checkTrue(0)
<<"fold 8 not correct!  WS after fold control?\n";
 }


checkOut()

