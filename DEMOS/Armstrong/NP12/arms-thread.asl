//%*********************************************** 
//*  @script arms-thread.asl 
//* 
//*  @comment thread vers of find armstrong 
//*  @release CARBON 
//*  @vers 1.5 B Boron                                                     
//*  @date Sat May  4 10:24:26 2019 
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


   proc arm_launch( afn, adn, tstart, tname)
   {

     pan pstart =0;
     pan pend =0;
     tstart =  Start;
     pstart = Start;
     pend =   Start + Step;
     
     Start = pend;
     //pid = 667;
     pid=!!&"asl findarm_report $np $pstart $pend "; 
     
     afn = "P_np_${np}_${pid}.log"; 
     adn = "P_np_${np}_${pid}_nums"; 
     
     <<"$tname : $pid asl findarm_report $np $pstart $pend \n"; 
     
     return pid
    }

//=====================================//
   
   proc arm_t1()
   {
     
     
     tid1 = GthreadGetId(); 
     nanosleep(1,10); 
     
     <<"  I am in $_proc $tid1\n"; 
   // which thread am I
     
        
     
     int j =0; 
     
     int kk = 0; 
     cnt_down = 0;


     str armfname = "xxx"; 
     str armdone_fn = "yyy";
     
     myname = "$_proc";
     
     //pan mystart = 0;
     pan mystart ;

    mystart = 0;

     pid =arm_launch(&armfname, &armdone_fn, &mystart, myname)

      nanosleep(3,50000);
  
     <<" $armfname  $armdone_fn $mystart $pid\n"

     
     
     while (kk < 3) {
       j++;
       
       fsz=fexist(armfname);
       donesz=fexist(armdone_fn);
       how_far = "0"
       if (fsz >0) {
        A=ofr(armfname);
          if (A != -1) {
           S=readfile(A)
	   sz=Caz(S)
	   //<<"$S[0] $S[sz-1]\n"
	   C=Split(S[sz-1])
	  // <<"$C[5]\n"
	   how_far = C[5]
           cf(A)
          }
       }
       
       <<"$myname : $j $pid $mystart $how_far $fsz $donesz \n"; 
       
       if (donesz > 10) {
         donesz = 0;
         armdone_fn ="xxx"; 
         if (Start < Endnum) {
             pid =arm_launch(&armfname, &armdone_fn, &mystart, myname);
             <<" $armfname  $armdone_fn $pid\n";
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
     int j =0; 
     int nt;

     str armfname = "xxx"; 
     str armdone_fn = "yyy"; 
     myname = "$_proc";
     
     pan mystart = 0;
     
     pid =arm_launch(&armfname, &armdone_fn, &mystart, myname)

     <<" $armfname  $armdone_fn $pid\n"
     while (1) {
       
       fsz=fexist(armfname);
       donesz=fexist(armdone_fn);

       how_far = "0"
       if (fsz >0) {
        A=ofr(armfname);
          if (A != -1) {
           S=readfile(A)
	   sz=Caz(S)
	   //<<"$S[0] $S[sz-1]\n"
	   C=Split(S[sz-1])
	  // <<"$C[5]\n"
	   how_far = C[5]
           cf(A)
          }
       }
       
       <<"$myname : $j $pid $mystart $how_far $fsz $donesz \n"; 
       
       
       j++; 
       
       if (donesz > 10) {
         donesz = 0;
         armdone_fn ="xxx"; 
         if (Start < Endnum) {
           pid =arm_launch(&armfname, &armdone_fn, &mystart, myname);
	    <<" $armfname  $armdone_fn $pid \n"
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
     int j =0; 
     int nt;
     
     str armfname = "xxx"; 
     str armdone_fn = "yyy"; 

     myname = "$_proc";
     
      pan mystart;
      mystart = 0;
	  
     
     pid =arm_launch(&armfname, &armdone_fn, &mystart, myname)

     <<" $armfname  $armdone_fn $pid\n"
     
     while (1) {
       
       fsz=fexist(armfname);
       donesz=fexist(armdone_fn);
       // how far
       
       how_far = "0"
       if (fsz >0) {
        A=ofr(armfname);
          if (A != -1) {
           S=readfile(A)
	   sz=Caz(S)
	   //<<"$S[0] $S[sz-1]\n"
	   C=Split(S[sz-1])
	  // <<"$C[5]\n"
	   how_far = C[5]
           cf(A)
          }
       }

      <<"$myname : $j $pid $mystart $how_far $fsz $donesz \n";
       
       j++; 
       
       if (donesz > 10) {
         donesz = 0;
         armdone_fn ="xxx"; 
         if (Start < Endnum) {

          pid =arm_launch(&armfname, &armdone_fn, &mystart, myname)

     <<" $armfname  $armdone_fn $pid\n"
           
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
   
   int np = 8;

   na = argc()

   if (na > 1) {
       np = atoi(_clarg[1])
   }

   pan begin;
   pan step;
   begin =1;
   step = 1;
   
   for (i=0; i < (np-1) ;i++) {
     begin *= 10;
     begin += 1;
     step *= 10; 
     }
   
   pan Step = step;
   
   
//pan Start = begin;
   
   pan Start = 0;
   
   Start = step;
   
//pan Endnum = (np * Step + Step)
   
   Endnum = (10 * Step) ;
   
   <<"%V $np $Start $begin $Step $Endnum \n"; 



   tid = GthreadGetId();
   
   <<"in  main thread thead id is $tid \n"; 
    tname = "arm_t1"; 
   
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
