
//%*********************************************** 
//*  @script wex_compute.asl 
//* 
//*  @comment  
//*  @release CARBON

//*  @vers 1.1 H Hydrogen                                                 
//*  @date Sat Dec 29 09:06:02 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%

xhrs = 0;

void computeWL(long wlsday, long wleday)
{
/// use input of juldays
/// find the number of exe hours
// read the number of cals burnt during exercise
// compute the number of lbs burnt

int i;

   Nsel_exemins = 0
   Nsel_exeburn = 0.0

   Nxy_obs = 0

   Nsel_lbs = 0.0
<<"$_proc %V $wlsday $wleday  $Nobs\n"

   for (i = 0; i < Nobs ; i++) {
        aday = LDVEC[i] - bday;
     if (aday >= wlsday) {

        Nxy_obs++

        Nsel_exeburn += EXEBURN[i]
        Nsel_exemins += EXTV[i]
//<<"%V $i $Nsel_exeburn $Nsel_exemins $wlsday  $LDVEC[i]  $bday\n"
     }

     if (aday > wleday) 
             break; 
   }

   Nsel_lbs = Nsel_exeburn/ 4000.0

   xhrs = (Nsel_exemins/60.0)

<<"%V$Nxy_obs %6.2f $Nsel_exemins $(Nsel_exemins/60.0) $Nsel_exeburn $Nsel_lbs $xhrs\n"

}
//=========================

void getDay(long dayv)
{

 int m_day;
 m_day= dayv + bday;
 float cbm;
 float xtm;
 float wtm;
 int dt;
 str mdy;

    mdy = julmdy(m_day);
    sWo(dtmwo,@value,mdy,@redraw);
    wtm = 0.0;
     sWo(wtmwo,@value,wtm,@redraw);
          sWo(cbmwo,@value,0,@redraw);
     sWo(xtmwo,@value,0,@redraw);
     sWo(obswo,@value,0,@redraw);
     
   for (i = 0; i < Nobs ; i++) {

//<<" $i $dayv  $mday $LDVEC[i] \n"

     if (LDVEC[i] == m_day) {

    xtm = EXTV[i]
    wtm  = WTVEC[i]
    cbm  = CALBURN[i]
 




     dt = dayv -Sday;
     <<"%V $tjd $bday $Sday $mdy\n"
   <<"FOUND $i %V $dayv $Sday $dt  $wtm $xtm $cbm\n"
     sWo(obswo,@value,dt+1,@redraw);
     sWo(xtmwo,@value,xtm,@redraw);
     sWo(wtmwo,@value,wtm,@redraw);
     sWo(cbmwo,@value,cbm,@redraw);

      break;
     }
  }

}


//[EM]=================================//
<<"Included compute module\n"
