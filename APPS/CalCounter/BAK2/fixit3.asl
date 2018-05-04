setdebug(1,"keep","trace")
filterDEbug(0,"l1_store","l1_store_svar","storeCopyVar","store","storeintoarray","getexp","paramexpand")


proc adjustReclc(wans, vf)
{
<<"$_proc\n"

irs = wans;
<<"%V $(typeof(irs)) $irs[::]\n"
    for (i=0; i< Ncols; i++) {
<<"<$i>  $irs[i] \n"
    }

a = atof(irs[1]) * vf;
<<"%V$a\n"

  irs[1] = "$a";
  
  //irs[1] = "%6.2f$a"
  
for (i = 3; i < 10; i++) {
 a = atof(irs[i]) * vf;
<<"%V$a\n"
  irs[i] = "%6.2f$a"
}


  for (i=0; i< Ncols; i++) {
<<"<$i>  $irs[i] \n"
    }

  wans = irs;
<<"svar copy bak to wans\n"
  for (i=0; i< Ncols; i++) {
<<"<$i>  $wans[i] \n"
    }
<<"ele copy bak to wans\n"
  for (i=0; i< Ncols; i++) {
     wans[i] = irs[i];
<<"<$i>  $wans[i] \n"
    }

}
//===================================

proc adjustRec(svar wans, vf)
{
<<"$_proc\n"


<<"%V $(typeof(wans)) $wans[::]\n"
    for (i=0; i< Ncols; i++) {
<<"<$i>  $wans[i] \n"
    }

//a = atof(wans[1]) * vf;
//<<"%V$a\n"

//  wans[1] = "%6.2f$a";

// TBF xic vers correct -- ic not
for (i = 1; i < 10; i++) {
  if (i != 2) {
  a = atof(wans[i]) * vf;
  cs = "%6.2f$a"
  wans[i] = cs;
  wans[i] = "%6.2f$a"

  
<<"<$i>%V$a $wans[i]\n"
}
}


  for (i=0; i< Ncols; i++) {
<<"<$i>  $wans[i] \n"
    }

}
//===================================

int Ncols;
proc doQ(f)
{
<<"$_proc\n"

svar Wans;

  Wans = Split("BUTTER_UNSALTED                     1 TBSP 100 0 11 0 31 7.1  14");

<<"$Wans\n"
 Ncols = Caz(Wans);
 
  for (i=0; i< Ncols; i++) {
<<"<$i>  $Wans[i] \n"
    }

     adjustRec(Wans,f);


  for (i=0; i< Ncols; i++) {
<<"<$i>  $Wans[i] \n"
    }

<<"<$Wans[1]> \n"

  b= atof(Wans[1])
  
  checkFNum(b,0.10)

  b= atof(Wans[9])
  
  checkFNum(b,1.40)


}
//


f = 0.1;

/{
svar Wans;

  Wans = Split("BUTTER_UNSALTED                     1 TBSP 100 0 11 0 31 7.1  14");

<<"$Wans\n"
 Ncols = Caz(Wans);
 
  for (i=0; i< Ncols; i++) {
<<"<$i>  $Wans[i] \n"
    }
/}
  //  adjustRec(f);

checkIn()

    doQ(f);



checkOut()

/{

  for (i=0; i< Ncols; i++) {
<<"<$i>  $Wans[i] \n"
    }

irs = Wans;
<<"%V $(typeof(irs)) $irs[::]\n"
    for (i=0; i< Ncols; i++) {
<<"<$i>  $irs[i] \n"
    }

a = atof(irs[1]) * f;
<<"%V$a\n"

  irs[1] = "$a";
  
  //irs[1] = "%6.2f$a"
  
for (i = 3; i < 10; i++) {
 a = atof(irs[i]) * f;
<<"%V$a\n"
  irs[i] = "%6.2f$a"
}


  for (i=0; i< Ncols; i++) {
<<"<$i>  $irs[i] \n"
    }

  Wans = irs;
<<"svar copy bak to Wans\n"
  for (i=0; i< Ncols; i++) {
<<"<$i>  $Wans[i] \n"
    }
<<"ele copy bak to Wans\n"
  for (i=0; i< Ncols; i++) {
     Wans[i] = irs[i];
<<"<$i>  $Wans[i] \n"
    }

/}