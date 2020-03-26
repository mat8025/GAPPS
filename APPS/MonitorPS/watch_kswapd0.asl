//%*********************************************** 
//*  @script watch_kswapd0.asl 
//* 
//*  @comment monitor high use cpu 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Tue Mar 24 19:21:34 2020 
//*  @cdate Tue Mar 24 19:21:34 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

   float f;
   float mem;
   int k = 0;
   int ks = 0;
   int high = 0
   float highest = 0.0;
   float RAVE[10];



   while (1) {
     
//T=!!"ps -eo pcpu,pid,user,args | sort -k1 -r -n | head -1000 |grep pulseaudio "
//T=!!"ps -C kswapd0 -o \%cpu,\%mem,cmd"
     
     
     T=!!"ps aux | grep kswapd0"; 
     
     sz= Caz(T); 
     
     f = 0.0; 
     mem = 0.0;
     
     for (i= 0; i < sz ; i++) {
       
       R=split(T[i]); 
       
       fs = R[2]; 
       f += atof(fs); 
       ms= R[3]; 
       mem += atof(ms); 
       
       }
     
//     <<"$(utime()) cpu $f mem $mem\n"; 
     
     
     if (f >60) {
       <<" kswapd0 lot of swapping -- killing culprit - chrome?\n"; 
       !!"zap chrome "; 
       }
     
     
     sleep(1); 
     
//T=!!"ps -C chrome -o \%cpu,\%mem,cmd "
     T=!!"ps aux | grep chrome "; 
     
     f =0.0;
     mem = 0.0; 
//<<"$(typeof(T)) %$T\n"
     sz= Caz(T); 
//<<"%V$sz\n"
     
     for (i= 0; i < sz ; i++) {
      
//<<"$T[i]\n"
       
       R=split(T[i]); 
       sz= Caz(R); 
//<<"%V$sz\n"
       fs = R[2]; 
       f += atof(fs); 
       ms= R[3]; 
       mem += atof(ms); 

     } 
     

     if (f > highest) {
         highest = f
     }


        RAVE[ks] = f;
	ks++
	if (ks >= 10) {
         ks = 0;
        }
	
        ave= Mean(RAVE);

<<"$sz $(utime()) total cpu $f mem $mem   $ave\n"; 

     if (f >70) {
       <<" $high lot of swapping -- killing culprit - chrome?\n"; 

<<"$f   ---> asl zap.asl chrome ";
        high++;
        if (high > 15) {
       !!"asl zap.asl chrome ";
        }
     }
     else {
         high = 0
      }
     
     sleep(5); 
     fflush(1); 
}

//////
