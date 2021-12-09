/* 
 *  @script lists.asl 
 * 
 *  @comment test list functionality 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.63 C-Li-Eu] 
 *  @date 11/27/2021 23:47:05          
 *  @cdate Sun Apr 12 19:06:46 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                
///
///
///
#include "debug";

   if (_dblevel >0) {

     debugON();

     }
//<<[2]"running lists $_script\n"     

   chkIn(_dblevel);

   ws = getScript();

   <<"%V $ws  $_script\n";

    L0 = ( "a", "minimal" , "list" );

    L0.pinfo();

<<"$L0 \n"



    li = L0.getLitem(-1);
    li.pinfo();

<<"hot item is $li \n";

    li1 = L0[1];

<<"%V $li1 \n";

chkStr(li1,"minimal");

chkStr(li,"list");




   CrashList = ( "",  )  ; // empty list;

   <<"%V$CrashList \n";

   CrashList.LiDelete(0);

   FailedList = ( "",  )  ; // empty list --- bug first item null?;

   FailedList.LiDelete(0);

   <<" $ws \n";

   <<"%V$CrashList \n";

   <<"%V$FailedList \n";



   int J[] = { 1,2,3,4 };

  J.pinfo();

  m = Caz(J);

  <<"%V$m \n";

  <<"%V$J\n";

  chkN(m,4,GTE_);

  L1 = ( "a", "small" , "list" , "1", "2", "3", "4", "5" ,"6" ,"yellow", "green", "blue" ,"indigo", "violet");



  <<"%V$L1 \n";
  <<"%V$L1[2] \n";

  li = L1.getLitem()

<<"%V$li \n";

  L1.pinfo()


  l0 = L1[0];

  <<"$l0\n";

  l0.pinfo();

  str ww;

  ww= L1[1];

  <<"$ww\n";
// str fw



  str fw = L1[9];  // fails;

  fw.pinfo();

  chkStr(fw,"yellow");



  fw = L1[9];  

  <<"$fw\n";

  chkStr(fw,"yellow");

  fw= L1[0];

  <<"$fw\n";

  <<"%V$fw $(typeof(fw))\n";

  chkStr(fw,"a");

  l1sz = Caz(L1);

  <<"%V$l1sz\n";

  fw = L1[l1sz-1];

  <<"%V$fw $(typeof(fw))\n";

  chkStr(fw,"violet");



  for (i= 0; i < l1sz; i++) {

   ww= L1[i];

   <<"$i $ww\n";

   }

  //chkStage("list - element access");

  L2 = ( "The", "colors", "of" ,"the", "rainbow", "are", "red", "orange", "yellow", "green", "blue" ,"indigo", "violet" );

  <<"L2 = $L2 \n";

  L1 = L2;

  <<"L1 = $L1 \n";



  fw = L1[0];

  <<"%V$fw $(typeof(fw))\n";

  chkStr(fw,"The");
// FIXED!! -- FIXME not overwriting

  <<"L2.L1 = $L1 \n";

  <<"%(,= , ,)Vs${L1} \n";

  L1.reverse();



  <<"%(,= , ,)Vs${L1} \n";
 //n=L1.Shuffle(100)

  L1.Shuffle(100);

  <<"shuffle %V$L1  \n";

  L1.Shuffle(20);

  <<"shuffle %V$L1  \n";

  fw = L1[0];

  L3 = L1;

  <<"L3 = $L3 \n";

  L = ( "say", "what", "can" ,"I", "do", "now", "with", "this", "amazingly", "lovely" ,"list" );

  <<"L = %s$L \n";

   L.pinfo();
   




  fw = L[0];

  <<"%V$fw $(typeof(fw))\n";

  chkStr(fw,"say");

  L.reverse();

// OK here

  fw = L[0];




  chkStr(fw,"list");



  <<"L = $L \n";

//chkOut(); // OK?

//<<"%v$L[1:4] \n";
 L.pinfo();
 
<<"$L[1:3] \n";


  <<"%v\s$L[1:-3] \n";

  <<"%V$L \n";

//chkOut(); // bad here

  L3 = L[1:7];

  <<" $(typeof(L3)) \n";

  <<"%V$L3 \n";

  fw = L3[0];

  <<"fw $fw\n";

  chkStr(fw,"lovely");


  litem = "focus";

  n= L.Insert(litem);

  <<"insert %V$L    $n\n";

  sz= caz(L);

  <<"%v $sz \n";

  litem = "on-working";

  n= L.Insert(litem,-1);

  <<"insert %V$L    $n\n";

  sz= caz(L);

  <<"%v $sz \n";

  litem = "first";

  n= L.Insert(0,litem);

  <<"insert %V$L    $n\n";

  sz= caz(L);

  <<"%v $sz \n";

  fw = L[0];

  <<"%V $fw \n";

  chkStr(fw,"first");

 chkOut();

  L3 = L[1:-2];

  <<"1:-2 %V$L3 \n";
// L3 = L[6:1:]

  L3 = L[6:1];

  <<"6.1%V$L3 \n";

  L3 = L[-3:2:-1];

  <<"-3->2%V$L3 \n";

  <<" %V$L3[1:7:2] \n";
// FIXME <<" %V$L3[-3:1:-1] \n"
// FIMXME
//<<"%v\s$L3[-1:0:] \n"
//iread(";>")

  m = Caz(L);

  <<" %v$m \n";

  chkN(m,11);

  n=L.Sort();

  <<"%v$L \n";
  chkOut() ;  // ?? xtst empty
  <<"L is a $(typeof(L)) \n";
//iread(";>")

  L4 = ( "say", "what", "can" ,"I", "do", "now", "with", "this", "amazingly", "lovely" ,"list" );

  <<"%v $L4 \n";


  L4.Reverse();

  <<"$L4 \n";

  <<"%vs$L4[1] \n";

  <<"%vs$L4[2] \n";

  <<"%vs$L4[3] \n";

  <<"last element ? %vs $L4[-1] \n";
//iread(";>")
# TDB make subscript work  --- DONE

  <<"%vs$L4[1:4] \n";

  <<"%v$L4 \n";
//svar sl = L[3]

  sl = L[3];

  <<"%V$sl \n";
//iread(";>")

  k= 5;

  <<" %v$k \n";

  <<"%vs$L[k] \n";

  L.Reverse();

  <<"reversed %V$L[0:3] \n";

  <<"reversed %vs$L[0:-2] \n";

  <<"reversed %vs$L[1:-3] \n";
//iread(";>")

  L.Reverse();

  <<"reversed %V$L \n";
//iread(";>")

  L.Shuffle(20);

  <<"shuffle %V$L  \n";
//iread(";>")

  L.Sort();

  <<"sorted %V$L  \n";
//iread(";>")

  L.Reverse();

  <<"reversed %vs$L \n";
// int ns=L.Sort()

  int ns;

  ns=L.Sort();

  <<"$(typeof(ns)) $ns \n";

  <<"sorted %V$L   swaps $ns\n";
//iread(";>")

  L.Reverse();

  <<"reversed %vs$L \n";

  ns=L.Sort();

  <<"sorted %v$L   swaps $ns\n";

  <<"$(typeof(ns)) $ns \n";

  n=L.Shuffle(20);

  <<"shuffle %V$L  \n";

  n=L.Sort();

  <<"sorted %V$L   swaps $n\n";

  n=L.Shuffle(100);

  <<"shuffle %V$L  \n";

  n=L.Sort();

  <<"sorted %V$L   swaps $n\n";
//iread(";>")

  litem = "focus";

  n= L.Insert(litem);

  <<"insert %V$L    $n\n";

  chkOut();
  
//////////////////// TBD //////////////////////
//  FIX XIC is doing a copypush_siv and push_siv - should just be copypush_siv

//===***===//
