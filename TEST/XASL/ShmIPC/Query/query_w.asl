//%*********************************************** 
//*  @script query.asl 
//* 
//*  @comment test query window options and placement 
//*  @release CARBON 
//*  @vers 1.8 O Oxygen                                                    
//*  @date Wed May  1 17:26:52 2019 
//*  @cdate 1/1/2002 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///  Test Query Window
///
                                                                      
<|Use_=
Demo  of query window

///////////////////////
|>
                                                               

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}





#include "graphic"





A=ofw("Food.m")
<<[A],"title Food\n"
<<[A],"item Meat C_MENU Meats Pork\n"
<<[A],"help which meat\n"
<<[A],"item txt? C_INTER Text\n"
<<[A],"help input some text\n"
<<[A],"help \n"
cf(A)


A=ofw("Meats.m")
<<[A],"title Meats\n"
<<[A],"item Pork M_VALUE Pork\n"
<<[A],"help which meat\n"
<<[A],"item Duck M_VALUE Duck\n"
<<[A],"help duck\n"

cf(A)

#include "gevent.asl"; 

   vp = cWi(@title,"QUERY")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)
    sWi(vp,@resize,0.1,0.1,0.45,0.95,0)
    sWi(vp,@clip,0.1,0.2,0.95,0.8)


   tdwo= cWo(vp, @BV,@resize_fr,0.01,0.01,0.14,0.1,@name,"TaskDistance")
   sWo(tdwo,@color,WHITE_,@style,"SVB",@redraw);

    sWi(vp,@redraw)

    titleButtonsQRD(vp);



   vp2 = cWi(@title,"QUERY2")

    sWi(vp2,@pixmapoff,@drawoff,@save,@bhue,WHITE_)
    sWi(vp2,@resize,0.5,0.1,0.95,0.95,0)
    sWi(vp2,@clip,0.1,0.2,0.95,0.8)

   tdwo2= cWo(vp2, @BV,@resize_fr,0.01,0.01,0.14,0.1,@name,"TBD")
   sWo(tdwo2,@color,WHITE_,@style,"SVB",@redraw);

   tdwo3= cWo(vp, @TEXT,@resize_fr,0.01,0.8,0.9,0.95,@name,"TEXT")
   sWo(tdwo3,@value,"Some text here",@fonthue,BLACK_,@drawon,@redraw);
sWo(tdwo3,@bhue,WHITE_,@scales,0,0,1,1)
 sWo(tdwo3,@font,"big")

   tdwo4= cWo(vp2, @TEXT,@resize_fr,0.01,0.8,0.9,0.95,@name,"TEXT")
   sWo(tdwo4,@value,"Some text here",@fonthue,BLACK_,@drawon,@redraw);
   sWo(tdwo4,@bhue,WHITE_,@scales,0,0,1,1)
 sWo(tdwo4,@clipsize,0.1,0.1,0.9,0.9,@clipbhue,LILAC_)

 sWo(tdwo4,@font,"small")
    sWi(vp2,@redraw)




/*
<<" using menu function \n"
ans=popamenu("Food.m");

<<"  menu returns  %V $ans \n"

  sipause(2);

  
<<" has menu disappeared ?\n"
ans = decision_w("CHECK","did menu disappear ?", "YES", "NO" )



ans = exeGwmFunc("decisionw","CHECK","did decisionw appear ?", "YES", "NO" )

<<"%V$ans\n"

*/


<<" using query function \n"
ans="what";

ans = queryw("QUERY?","Something?","$ans");

<<"you typed $ans \n"

  sipause(1);


<<"next a query loop !\n"

// ans = exeGwmFunc("queryw","Question?","AnotherThing1?","$ans");


//<<"you typed $ans \n"

  

  kloop = 1;

 qwx = 200;
 qwy = 300;

 while (1) {

  <<" using query function - wait on click $kloop \n"

    eventWait();

  <<"got event %V $_etype $_erx  $_ery $_ex $_ey $_ebutton\n"
  // then center? query window at that position

//   ans = exeGwmFunc("queryw","Question?","AnotherThing $kloop ?","$ans", qwx, qwy);

   txt = queryw("Question?","AnotherThing $kloop ?","$ans", _ex, _ey);
  
//   titleMessage(ans);
//     sWo(tdwo3,@font,MEDIUM_,@textr,"$ans",0.0,0.4,0,0,MAGENTA_);



  <<"$kloop you typed $ans \n"
  qwy -= 10;
  qwx += 200;
  //sipause(1);

  if (scmp(ans,"salida")) {
      break;
  }

  if (scmp(ans,"quit")) {
      break;
  }

    sWi(vp,@redraw)
        sWi(vp2,@redraw)

  sWo(tdwo3,@print,"PR_DEF\n");
    
    sWo(tdwo3,@textr,"$txt",0.0,0.1,0,0,BLACK_);

   sWo(tdwo4,@print,"PR_ABC\n");   

   sWo(tdwo4,@textr,"$txt",0.0,0.1,0,0,BLACK_);

kloop++;
 }

 <<" and we have quit the loop\n"


exitgs();