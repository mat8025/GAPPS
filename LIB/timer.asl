//%*********************************************** 
//*  @script timer.asl 
//* 
//*  @comment create a timer -using sleep 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                                  
//*  @date Fri Jan 10 01:56:37 2020 
//*  @cdate 1/1/2018 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

///
/// timer - should reference system clock to adjust
///


 t_mins = atoi (_clarg[1])

<<"%V $t_mins \n"


 T=FineTime()
 <<" $T \n"
 uint dt;
 uint dsecs;
 uint mins =0;
 uint secs;
 
 ts =time();

t_secs = t_mins * 60;

   <<"$ts  $mins : $secs  $dsecs $dt \n"  

int cdts = t_secs

while (1) {

   dt= FineTimeSince(T)
   sleep (1);
   cdts -= 1;
   dsecs = dt/1000000;
   mins = dsecs/60;
   secs = (dsecs % 60);
    ts_now =time();
    // have to adust secs duration with ref to system clock
 //  <<"$ts_now $mins : $secs  $dsecs $dt \r"
   <<"$ts_now $mins : $secs  $dsecs $cdts\r"  
   fflush(1);
   if (mins >= t_mins) {
       break
   }
}

   bell()
  <<"Times Up! $mins \n"
    sleep(1)
    bell()




/// ulong math not working?