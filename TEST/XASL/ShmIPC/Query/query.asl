///
///  Test Query Window
///

 if (!checkGWM()) {
    Xgm = spawnGWM()
  }

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


<<" using menu function \n"
ans=popamenu("Food.m");

<<"  menu returns  %V $ans \n"

  sipause(2);

  
<<" has menu disappeared ?\n"
ans = decision_w("CHECK","did menu disappear ?", "YES", "NO" )



ans = exeGwmFunc("decisionw","CHECK","did decisionw appear ?", "YES", "NO" )

<<"%V$ans\n"


exit()

<<" using query function \n"
ans="what";

ans = queryw("QUERY?","Something?","$ans");

<<"you typed $ans \n"

  sipause(1);


<<"next a query loop !\n"
<<" using query function \n"

 ans = exeGwmFunc("queryw","Question?","AnotherThing1?","$ans");


<<"you typed $ans \n"

  sipause(1);


exitgs();



kloop = 1;

while (1) {

<<" using query function \n"
// this does not work in xic
 ans = exeGwmFunc("queryw","Question?","AnotherThing $kloop ?","$ans");


<<"$kloop you typed $ans \n"

  sipause(1);

  if (scmp(ans,"quit")) {
      break;
  }
  
  kloop++;
}

<<" and we have quit the loop\n"

gsexit();