//%*********************************************** 
//*  @script arms-thread.asl 
//* 
//*  @comment thread vers of find armstrong 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                                
//*  @date Sat May  4 06:54:29 2019 
//*  @cdate Sat May  4 06:54:29 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
   
   
   include "debug.asl"; 
   debugOFF(); 
// option to output to a file
   
///
///
///   np start end
///   compute suitable  step
   
///  main thread launches n worker threads
///  each thread locks to find next start then spawns off panarm
///  when panarm done threads finds new start -- or exits
///

   
   proc arm_t1()
   {
     
     
     tid1 = GthreadGetId(); 
     nanosleep(1,10); 
     
     <<"  I am in $_proc $tid1\n"; 
   // which thread am I
     
     ulong pstart;
     ulong pend;
     
     pstart = Start;
     pend =   Start + Step;
     
     Start = pend;
     
     pid=!!&"asl findarm_report $np $pstart $pend "; 
     
     armfname = "P_np_${np}_${pid}.log"; 
     armdone_fn = "P_np_${np}_${pid}_nums"; 
     
     <<"$_proc : $pid asl findarm_report $np $pstart $pend \n"; 
     
     int j =0; 
     
     int kk = 0; 
     cnt_down = 0;
     
     while (kk < 3) {
       j++;
       
       fsz=fexist(armfname);
       donesz=fexist(armdone_fn);
       
       <<"$_proc : $j $Start $pid $fsz $donesz \n"; 
       
       if (donesz > 10) {
         pstart = Start;
         donesz = 0;
         armdone_fn ="xxx"; 
         if (pstart < Endnum) {
           pend =   Start + Step;
           
           Start = pend;
           
           pid=!!&"asl findarm_report $np $pstart $pend "; 
           
           <<"$_proc $pid asl findarm_report $np $pstart $pend \n"; 
           
           armfname = "P_np_${np}_${pid}.log"; 
           armdone_fn = "P_np_${np}_${pid}_nums"; 
           
           }
         else {
           cnt_down = 1;
           }
         
         }
       
       
       if (cnt_down) {
         <<"cnt_down $(3-kk)\n"; 
         kk++;
         
         }
       
       nanosleep(3,50000); 
       
       }
     
     <<" DONE  $_proc exiting  $tid1 \n"; 
     
     GthreadExit(); 
     
     }
//=============================================
   
   proc arm_t2()
   {
     
     
     tid2 = GthreadGetId(); 
     nanosleep(1,10); 
 // which thread am I
     <<" in $_proc $tid2\n"; 
     int jf2 =0; 
     int nt;
     
     ulong pstart;
     ulong pend;
     
     pstart = Start;
     pend =   Start + Step;
     
     Start = pend;
     
     pid=!!&"asl findarm_report $np $pstart $pend "; 
     
     armfname = "P_np_${np}_${pid}.log"; 
     armdone_fn = "P_np_${np}_${pid}_nums"; 
     
     <<"$_proc : $pid asl findarm_report $np $pstart $pend \n"; 
     
     while (1) {
       
       fsz=fexist(armfname);
       donesz=fexist(armdone_fn);
       <<"$_proc : $jf2 $Start $pid $fsz $donesz\n"; 
       
       jf2++; 
       
       if (donesz > 10) {
         pstart = Start;
         donesz = 0;
         armdone_fn ="xxx"; 
         if (pstart < Endnum) {
           pend =   Start + Step;
           Start = pend;
           
           pid=!!&"asl findarm_report $np $pstart $pend "; 
           
           <<"$_proc : $pid asl findarm_report $np $pstart $pend \n"; 
           
           armfname = "P_np_${np}_${pid}.log"; 
           armdone_fn = "P_np_${np}_${pid}_nums"; 
           
           }
         else {
           break;
           }
         }
       nanosleep(3,200); 
       }
     
     <<" DONE $_proc exiting  $tid2 \n"; 
     
     GthreadExit(); 
     

     }
//======================================================
   
   
   proc arm_t3()
   {
     
     
     tid = GthreadGetId(); 
     nanosleep(1,10); 
 // which thread am I
     <<" in $_proc $tid\n"; 
     int jf2 =0; 
     int nt;
     
     ulong pstart;
     ulong pend;
     
     pstart = Start;
     pend =   Start + Step;
     
     Start = pend;
     
     pid=!!&"asl findarm_report $np $pstart $pend "; 
     
     armfname = "P_np_${np}_${pid}.log"; 
     armdone_fn = "P_np_${np}_${pid}_nums"; 
     
     <<"$_proc : $pid asl findarm_report $np $pstart $pend \n"; 
     
     while (1) {
       
       fsz=fexist(armfname);
       donesz=fexist(armdone_fn);
       <<"$_proc : $jf2 $Start $pid $fsz $donesz\n"; 
       
       jf2++; 
       
       if (donesz > 10) {
         pstart = Start;
         donesz = 0;
         armdone_fn ="xxx"; 
         if (pstart < Endnum) {
           pend =   Start + Step;
           Start = pend;
           
           pid=!!&"asl findarm_report $np $pstart $pend "; 
           
           <<"$_proc : $pid asl findarm_report $np $pstart $pend \n"; 
           
           armfname = "P_np_${np}_${pid}.log"; 
           armdone_fn = "P_np_${np}_${pid}_nums"; 
           
           }
         else {
           break;
           }
         }
       nanosleep(3,200); 
       }
     
     <<" DONE  $_proc exiting  $tid \n"; 
     
     GthreadExit(); 
     
     }
//======================================================
   
   
   ok = 0; 
   
   int np = 9;
   ulong begin;
   begin =1;
   step = 1;
   
   for (i=0; i < (np-1) ;i++) {
     begin *= 10;
     begin += 1;
     step *= 10; 
     }
   
   ulong Step = step;
   
   
//ulong Start = begin;
   
   ulong Start = 0;
   
   Start = step;
   
//ulong Endnum = (np * Step + Step)
   
   Endnum = (10 * Step) ;
   
   <<"%V $np $Start $begin $Step $Endnum \n"; 
   
   tid = GthreadGetId();
   
   <<"in  main thread thead id is $tid \n"; 
   
   
   id = gthreadcreate("arm_t1"); 
   
   //gthreadsetpriority(id,20,"RR")
   
   mypr = gthreadgetpriority(id); 
   
   <<"created thread %V $id $mypr\n"; 
   
   tname = "arm_t2"; 
   
   id2 = gthreadCreate(tname); 
   
   <<" should be main thread after creating thread $tname  $id2 \n"; 
   nt = gthreadHowMany(); 
   
   wtid = GthreadGetId(); 
   
   
   tname = "arm_t3"; 
   
   id3 = gthreadCreate(tname); 
   
   
   nt = gthreadHowMany(); 
   
   <<" should be main thread after creating thread $tname  $id3 \n"; 
   
   for (m = 0 ; m < 20; m++) {
     nt = gthreadHowMany(); 
     nanosleep(1,30); 
     <<"main loop  $m  $nt \n"; 
     if (nt > 1) {
       break;
       }
     }
   
   
   wtid = GthreadGetId(); 
   
   nt = gthreadHowMany(); 
   
   <<" should be back in main thread %V $wtid $nt \n"; 
   
   for (m = 0 ; m < 10; m++) {
     nt = gthreadHowMany(); 
     nanosleep(0,50000); 
     <<" main thread loop %V$wtid $m $nt \n"; 
     if (nt <= 1)  {
       break; 
       }
     }
   
   <<" should be back in main thread waiting \n"; 
   
   gthreadwait(); 
   
   wtid = GthreadGetId(); 
   
   <<"  in main thread   $wtid after all other threads $nt have finished\n"; 
   
   !!"ls np_${np}_*"; 
   
   
   exit(); 
