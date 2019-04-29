///
/// timer
///


 T=FineTime()
 <<" $T \n"
 uint dt;
 uint dsecs;
 uint mins =0;
 uint secs;
 
 ts =time();
 
   <<"$ts  $mins : $secs  $dsecs $dt \n"  
while (1) {

   dt= FineTimeSince(T)
   sleep (1);
   
   dsecs = dt/1000000;
   mins = dsecs/60;
   secs = (dsecs % 60);
    ts_now =time();
   <<"$ts_now $mins : $secs  $dsecs $dt \r"  
   fflush(1);
 }





/// ulong math not working?