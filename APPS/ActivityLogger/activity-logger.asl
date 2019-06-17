//%*********************************************** 
//*  @script activity-logger.asl 
//* 
//*  @comment log/track activities thru the week 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Mon Jun 17 12:32:27 2019 
//*  @cdate Mon Jun 17 12:32:27 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%


 include "debug"
 
 scriptDBON();
 debugON();
 sdb(1,@~keep,@~pline)


 include "gevent"
 include "gss.asl"
 include "hv.asl"


 include "activity-procs.asl" // has to come after gss to overload 

//  menu for how long -
A=ofw("Howlong.m")
 <<[A],"title HowLong\n"
 <<[A],"item 0m M_VALUE 0\n"
 <<[A],"item 5m M_VALUE 5\n"
 <<[A],"item 10m M_VALUE 10\n"
 <<[A],"item 15m M_VALUE 15\n"
 <<[A],"item 30m M_VALUE 30\n"
 <<[A],"item 45m M_VALUE 45\n"
 <<[A],"help 45m\n"
 <<[A],"item 1hr M_VALUE 60\n"
 <<[A],"help 1 hour\n"
 <<[A],"item 90m M_VALUE 90\n"
 <<[A],"help hour and half\n"
 <<[A],"item 2hr M_VALUE 120\n"
 <<[A],"help two hours\n" 
 <<[A],"item 4hr M_VALUE 240\n"
 <<[A],"help 4 hours\n"
 <<[A],"item ? C_INTER "?"\n"
 <<[A],"help set mins\n"
 cf(A)

 fname = _clarg[1];


  if (fname @= "")  {
      fname = "Language/language.csv"
  }


 Graphic = CheckGwm()

     if (!Graphic) {
        X=spawngwm()
     }

 Graphic = CheckGwm()

 if (! Graphic) {

 <<"can't go graphic!! exiting\n"
    exit()
 }

OpenDll("plot") ; //  should be automatic



include "tbqrd.asl" 

include "activity-screen.asl"


fsz=fexist(fname,0);
ok =0;
 if (fsz > 0) {

   ok = readTheActivity(fname);

 }

if (!ok) {
   <<"file not found" // 
   exit(-1) // 
}

   sz = Caz(R);
   rows = sz;
   cols = Caz(R,0);
   ncols = cols;
   ncols1 = Caz(R,1);

  for (i = 0; i < rows;i++) {
<<"[${i}] $R[i]\n"
   }

<<"%V $rows $cols \n"

use_incl_vers = 1;

   sWo(cellwo,@setrowscols,rows+2,cols+1);


   if (use_incl_vers) {
      colorRows(rows,cols);
   }


    sWo(cellwo,@cellval,R);
    sWo(cellwo,@setrowscols,rows+2,cols+1);
    sWo(cellwo,@selectrowscols,0,rows-1,0,cols); // must select section to view


    sWi(vp,@redraw)
 
    sWo(ssmods,@redraw)
    sWo(cellwo,@setcolsize,3,0,1);
    sWo(cellwo,@redraw);


   ok=_ele_vers->info(1)
   <<"%V $ok\n"
   sWo(txtwo,@textr,"version $_ele_vers",0.1,0.2);

   sWi(vp,@redraw);

  int mr =0;
  int mc = 0;
  the_row = 1;

   while (1) {

          
     eventWait();
          mr = _erow;
	  mc = _ecol;
	  
          if (mr > 0) {
             the_row = mr;
          }


     if (_ewoid == cellwo) {

       if (_ebutton == LEFT_ && mr > 0) {
       if ((mc >0) && (mc < 8)) {
       <<"%V $mc \n"
         HowLong(mr,mc);
       }
       sWo(cellwo,@redraw);
       }
     }
     else {


      if (_ename @= "PRESS") {
<<[_DB]"PRESS $_ename  $_ewoname !\n"
 
          if (!(_ewoname @= "")) {
          
             $_ewoname();
 
<<[_DB]" after indirect callback\n"
 
            }
         }
    }

}


exit()





/{/*

  basically log hrs/mins daily per activity --- weekly total
  files are csv
  read/save the activity file (e.g. language.csv -- containing rows of separate activities
  e.g. guitar, piano, ...

  can edit previous weeks

  app - checks current week -- if start loads template 
  app - can add to template 
  if current week  file found - loads for edit or entry

  can load activity file by menu and tty input
  will sum totals into last col


/}*/