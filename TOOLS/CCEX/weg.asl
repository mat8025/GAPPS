// WEDG

SetPCW("writeexe","writepic")

// open all libs needed


OpenDll("math","plot","stat")

 if (! CheckGWM()) {

      SpawnGwm("xxx")

 }


SetDebug(2)

Class Wed 
{
public:
 int n;
 float wm;
 float wc;
 float Wt[];
 float Aexm[];
 float Wexm[];
 int Cbc[];
 int Day[]

 CMF Print()
 {
   for (j=0; j < n; j++) {
   <<" $j $Wt[j] $Aexm[j] \n"
   }
 }


 CMF Linfit()
 {

  lfp = lfit(Day[0:n-1],Wt[0:n-1])
<<" %v $lfp \n"
  wc = lfp[0]
  wm = lfp[1]
<<" %V $wc $wm \n"
 }

 CMF Plot()
 {
   symsz = 7
   Setgwob(wedwo,"usescales",0,"clipborder","red")
   PlotGW(wedwo,"line",0,start_wt,ndays,targ_wt,"pink")
   for (j=0; j < n; j++) {
      PlotGW(wedwo,"symbol",Day[j],Wt[j],"tri",symsz,"red",0,1)
//      PlotPoint(wedwo,j,Wt[j],"red")
 <<" $Wt[j] \n"
   }

   pew = wm * 60.0 + wc

   PlotGW(wedwo,"line",0,start_wt,ndays,pew,"orange")

   axnum(wedwo, 1)
   //axnum(wedwo, 4, min_wt, start_wt, 10, -1, "g")
   axnum(wedwo, 4)
   axnum(wedwo,3)

//   Setgwob(wedwo,"usescales",1)


   for (j=0; j < n; j++) {
      PlotGW(exerwo,"symbol",Day[j],Aexm[j],"diamond",symsz,"blue",0,1)
      PlotGW(exerwo,"symbol",Day[j],Wexm[j],"diamond",symsz,"red",0,1)
      PlotGW(enerwo,"symbol",Day[j],Cbc[j],"diamond",symsz,"green",0,1)
   }

   DrawXY(exerwo,Day[0:n-1],Aexm[0:n-1])
   DrawXY(exerwo,Day[0:n-1],Wexm[0:n-1])
   DrawXY(enerwo,Day[0:n-1],Cbc[0:n-1])

  
   //axnum(wedwo,2,0,200,20,3.5,"g")
   axnum(wedwo,2)
   axnum(enerwo, 2)
   axnum(exerwo, 2)
   setgwob(wedwo, "clipborder", "brown")
 setgwob(enerwo, "clipborder", "brown")
 setgwob(exerwo, "clipborder", "brown")

 }

} 



// get data
A=ofr("weg.dat")

 Wed wed


 wed->n = 0;
// date wt  exmins  extype  cc

Wd=""
wt = 200.0
exm = 0.0
 int j =0

 last_tm = 0
 wday = 0
 while (1) {
  nwr = Wd->Read(A)
   if (nwr == -1)
     break
   if (scmp(Wd[0],"#",1)) {
//<<" found comment line $Wd \n"
   }
   else {
//   <<" $Wd \n"
//   wt = atof(Wd[1])   


   wed->Wt[j] =  atof(Wd[1])   
   wed->Aexm[j] = atof(Wd[2])

   if (nwr >= 6) {
    wed->Wexm[j] = atof(Wd[5])
   }
   else {
    wed->Wexm[j] = 2.0
   }

               ad=  "$Wd[0] 00:00:00"
   wed->Cbc[j] = Wd[4]
   tm3 = dateconvert(ad,"\%m/\%d/\%y \%H:\%M:\%S")
   ndays = (tm3 - last_tm) / (24 *60 *60)

   if (last_tm == 0) {
      ndays = 0
   }
   wday += ndays
   wed->Day[j] = wday
   j++
   wed->n = j
   last_tm = tm3
<<"$ad $wday \n"
   }
 }




//<<" $wed->Wt[] \n"
//<<" $wed->n \n"

  wed->Print()
  wed->Linfit()

if (! CheckGWM()) {

   STOP!

}

//////////////////////////////   GRAPHIC SETUP /////////////////////////////////

top_wt = 210
min_wt = 150
targ_wt = 165
start_wt = 200
ndays = 50

    vp= CreateGwindow("title","WEDG","scales",-5,min_wt,ndays,top_wt,"savescales",0)

    SetGwindow(vp,"resize",0.1,0.05,0.95,0.75,0)
    SetGwindow(vp,"clip",0.0,0.0,0.99,0.99,"drawon","pixmapoff","save","clipborder")
    SetGwindow(vp,"scales",-5,0,ndays,500.0,"savescales",1)


  wedwo=CreateGWOB(vp,"GRAPH","resize",0,0.05,0.05,0.95,0.35,"name","WED","color","white","drawon","pixmapoff","save")

  setgwob(wedwo,"usescales",0,"scales",-5,min_wt,ndays,top_wt)
  setgwob(wedwo,"usescales",1,"scales",-5,0.0,ndays,300.0)

  setgwob(wedwo,"clear","clip", 0.1,0.15,0.9,0.9, "setmod",1)
  setgwob(wedwo,"clear","clipborder","brown","save")

  enerwo=CreateGWOB(vp,"GRAPH","resize",0,0.05,0.36,0.95,0.66,"name","CAC","color","white","drawon","pixmapoff","save")
  setgwob(enerwo,"usescales",0,"scales",-5,0.0,ndays,1000.0)
  setgwob(enerwo,"clear","clip", 0.1,0.1,0.9,0.9, "setmod",1)
  setgwob(enerwo,"clear","clipborder","brown","save")


  exerwo=CreateGWOB(vp,"GRAPH","resize",0,0.05,0.67,0.95,0.99,"name","EXE","color","white","drawon","pixmapoff","save")
  setgwob(exerwo,"usescales",0,"scales",-5,0.0,ndays,180.0)
  setgwob(exerwo,"clear","clip", 0.1,0.1,0.9,0.9, "setmod",1)
  setgwob(exerwo,"clear","clipborder","brown","save")
//////////////////////////////////////////////////////////////////////////




  wed->Plot()


CLASS Event
{
 public:
   Svar msg;
   int minfo[20];
   float wms[20];
   float ems[16];
   int wid
   int button
 #  method list


   CMF Wait()
   {
     msg= MessageWait(minfo,ems)

//<<" $msg[*] $minfo\n"

      wms=GetMouseState()
      wid = wms[0]
      button = wms[2]
   }    

   CMF Read()
   {

     msg= MessageRead(minfo,ems)
      wms=GetMouseState()
//<<" $wms \n"
      wid = wms[0]
      button = wms[2]
   }
}


Event E
while (1) {

        SetGwindow(vp,"activate")
  
        E->Read()

    msg = E->msg
       update =0

    if ( ! (msg @= "NO_MSG") ) {

          if (msg @= "REDRAW") {
            wed->Plot()
          }

          if (msg @= "RESIZE") {
            wed->Plot()
          }

          if (msg @= "q") {
           <<" QUIT !! \n"
             break
          }
    }

    sleep(1)

}


STOP!
