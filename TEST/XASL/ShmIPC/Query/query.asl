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
 include "debug.asl"; 
 include "gevent.asl"; 
 debugON()

include "graphic"


setdebug(1)


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



   vp = cWi(@title,"QUERY")

    sWi(vp,@pixmapoff,@drawoff,@save,@bhue,WHITE_)

    sWi(vp,@clip,0.1,0.2,0.95,0.9)

    sWi(vp,@redraw)

    titleButtonsQRD(vp);



/{
<<" using menu function \n"
ans=popamenu("Food.m");

<<"  menu returns  %V $ans \n"

  sipause(2);

  
<<" has menu disappeared ?\n"
ans = decision_w("CHECK","did menu disappear ?", "YES", "NO" )



ans = exeGwmFunc("decisionw","CHECK","did decisionw appear ?", "YES", "NO" )

<<"%V$ans\n"

/}


<<" using query function \n"
ans="what";

ans = queryw("QUERY?","Something?","$ans");

<<"you typed $ans \n"

  sipause(1);


<<"next a query loop !\n"

// ans = exeGwmFunc("queryw","Question?","AnotherThing1?","$ans");


//<<"you typed $ans \n"

  sipause(1);

  kloop = 1;

 qwx = 200;
 qwy = 300;

 while (1) {

  <<" using query function - wait on click \n"

    eventWait();

  <<"got event %V $_etype $_erx  $_ery $_ex $_ey $_ebutton\n"
  // then center? query window at that position
    eventWait();
//   ans = exeGwmFunc("queryw","Question?","AnotherThing $kloop ?","$ans", qwx, qwy);

   ans = queryw("Question?","AnotherThing $kloop ?","$ans", _ex, _ey);
   titleMessage(ans);
   

  <<"$kloop you typed $ans \n"
  qwy -= 10;
  qwx += 200;
  sipause(1);

  if (scmp(ans,"salida")) {
      break;
  }

  if (scmp(ans,"quit")) {
      break;
  }
  
  kloop++;
 }

 <<" and we have quit the loop\n"


gsexit();