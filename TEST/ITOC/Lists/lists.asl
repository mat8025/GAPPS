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

#include "debug"

   if (_dblevel >0) {

     debugON();

     }
//<<[2]"running lists $_script\n"     

   chkIn();

   ws = getScript();

   <<"%V $ws  $_script\n";

    allowDB("spe,ds,ic_call,pex,vmf", 1)

    List LS(STRV_);

    LS.pinfo()

    LS.insert( LIEND_,"restart", "math", "modules")

    LS.pinfo()
    
   <<"$LS \n"

   sli = LS.getLitem(LIBEG_);

   sli.pinfo();

<<"hot item is $sli \n";

   chkStr(sli,"restart")
   
   sli = LS.getLitem(1);

   sli.pinfo();

<<"hot item is $sli \n";

   chkStr(sli,"math")

  sli = LS.getLitem(-1);

   sli.pinfo();

<<"hot item is $sli \n";

   chkStr(sli,"modules")



   //chkOut(1)

   List L0(STRV_);

    L0.insert(LIEND_, "a", "minimal" , "list" );

    L0.pinfo();

<<"$L0 \n"



    li = L0.getLitem(-1);
    li.pinfo();

<<"hot item is $li \n";

    li1 = L0.getLitem(1);

<<"%V $li1 \n";

 chkStr(li1,"minimal");

 chkStr(li,"list");

chkOut(1)



   List CrashList(STRV_)  ; // empty list;

   <<"%V$CrashList \n";

   CrashList.LiDelete(0);

   List FailedList(STRV_)  ; // empty list --- bug first item null?;

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
  List L1(STRV_);
  L1.insert(LIEND_, "a", "small" , "list" , "1", "2", "3", "4", "5" ,"6" ,"yellow", "green", "blue" ,"indigo", "violet");



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
 Str fw



  fw = L1.getLitem(9);  // 

  fw.pinfo();

  chkStr(fw,"yellow");



  //fw = L1[9];  // can we access list as an array ?

  //<<"$fw\n";

  //chkStr(fw,"yellow");

  fw= L1.getLitem(0);

  <<"$fw\n";

  <<"%V$fw $(typeof(fw))\n";

  chkStr(fw,"a");

  l1sz = Caz(L1);

  <<"%V$l1sz\n";

  fw = L1.getLitem(-1) ; // get last item

  <<"%V$fw $(typeof(fw))\n";

  chkStr(fw,"violet");



  for (i= 0; i < l1sz; i++) {

   ww= L1[i];

   <<"$i $ww\n";

   }

  //chkStage("list - element access");
  List L2(STRV_);
  L2.insert(LIEND_,"The", "colors", "of" ,"the", "rainbow", "are", "red", "orange", "yellow", "green", "blue" ,"indigo", "violet" );

  <<"L2 = $L2 \n";
   List L3(STRV_);

  L3 = L2;  // copy list - has to be declared first? --- not working TBF 10/23/23

  L2.pinfo()
  
  L3.pinfo()
  
  <<"%V  $L3 \n";
  
  fw = L3.getLitem(0)

  <<"%V$fw $(typeof(fw))\n";

  chkStr(fw,"The");

  fw = L3.getLitem(4)

  <<"%V$fw $(typeof(fw))\n";

  chkStr(fw,"rainbow");



//////////////////////

// FIXED!! -- FIXME not overwriting

  <<"L2.L1 = $L1 \n";

  <<"%(,= , ,)s${L1} \n";

  L1.pinfo()

  L1.reverse();

  L1.pinfo()

  askit(1)

  <<"%(,= , ,)Vs${L1} \n";
 //n=L1.Shuffle(100)

  L1.Shuffle(100);

  <<"shuffle %V$L1  \n";

  L1.Shuffle(20);

  <<"shuffle %V$L1  \n";

  fw = L1[0];

  L3 = L1;

  <<"L3 = $L3 \n";
  List L(STRV_);
  L.insert(LIEND_, "say", "what", "can" ,"I", "do", "now", "with", "this", "amazingly", "lovely" ,"list" );

  <<"L = %s$L \n";

   L.pinfo();
   




 // fw = L[0];

  allowDB("spe,pex", 1)

  fw = L.getLitem(0)


  <<"%V$fw $(typeof(fw))\n";

  chkStr(fw,"say");

  L.reverse();

// OK here

  fw = L.getLitem(0)


 <<"%V$fw $(typeof(fw))\n";
   L.pinfo()
<<" $L \n"

  chkStr(fw,"list");



  <<"L = $L \n";

//chkOut(); // OK?

//<<"%v$L[1:4] \n";
 L.pinfo();
 
<<"$L[1:3] \n";


  <<"%V $L[1:-3] \n";

  <<"%V $L \n";

//chkOut(); // bad here

// L3 = L.getList(1:7) ?  1:7:2

  L3 = L[1:7];

  <<" $(typeof(L3)) \n";

  <<"%V $L3 \n";

  fw = L3[0];

  <<"fw $fw\n";

  chkStr(fw,"lovely");

 <<"%V $L3 \n";

ans=ask("L3 fulllist?",0)

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

  L.pinfo()

<<"%V $L \n"

  L3 = L[1:6];  ///  ==> L3 = L(1,6)

  L3.pinfo()

<<"%V $L3 \n"

ans=ask("L3 fulllist?",0)


  L3 = L[1:-2];  ///  ==> L3 = L(1,-2)

  L3.pinfo()

<<"%V $L3 \n"

ans=ask("L3 fulllist?",0)





  w2l3 = L3[2]

  L3.pinfo()

  <<"%V $w2l3 \n";



  chkOut(1)



  // L3 = L.getRange(1,-2)



  <<"1:-2 %V$L3 \n";
// L3 = L[6:1:]

  L3 = L[6:1];

  <<"6.1%V$L3 \n";

  L3 = L[-3:2:-1];

  <<"-3->2 %V$L3 \n";

  <<" %V $L3[1:7:2] \n";
// FIXME <<" %V$L3[-3:1:-1] \n"
// FIMXME
//<<"%v\s$L3[-1:0:] \n"
//iread(";>")

  m = Caz(L);

  <<" %V $m \n";

  chkN(m,11);

  L.pinfo()

  n=L.Sort(-1);

  <<"%v $n swops \n"

  L.pinfo()


  n=L.Sort();

  <<"%v $n swops \n"

  L.pinfo()



  <<"%v$L \n";

  askit(1)

//  chkOut() ;  // ?? xtst empty
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

  chkOut(1);
  
//////////////////// TBD //////////////////////
//  FIX XIC is doing a copypush_siv and push_siv - should just be copypush_siv

//===***===//
