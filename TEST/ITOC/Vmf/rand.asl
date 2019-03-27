//%*********************************************** 
//*  @script rand.asl 
//* 
//*  @comment test rand vmf 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Mon Mar 25 08:42:34 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//*
//***********************************************%
   
/{/* 



   
/}*/
   
   P = Rand(6,42,0,0); 
   
   <<"$P\n"; 
   P->sort(); 
   <<"$P\n"; 
   
   V= Rand(20,100); 
   
   
   <<"$V\n"; 
   
   R= vgen(FLOAT_,30,0,1); 
   <<"$R\n"; 
   
   R->rand(); 
   
   <<"$R\n"; 
   
   R->sort(); 
   <<"$R\n"; 
   
   last_ma = 1000;
   ma = 1000;
   max_hits =0;
   Ntrys = 10;
   nwins = 0;
   int HITS[7];   
   int Winners[+10]; 
   Tim=fineTime();

checkIn()

   for (i=0; i < Ntrys; i++) {
     
//     rs=randseed(0); 
     
     T = Rand(6,42,0,0); 
     
     
     T->sort(); 
     
     mm=minmax(T)
     <<"%V$mm\n"
     checkNum(mm[0],42.0,LTE_)
     
     I=Cmp(P,T); 

     hits =0;
     if (I[0] != -1) {
         sz=Caz(I); 
         hits = sz;
         D= P-T; 
         E= Abs(D); 	 
         ma = Sum(E);
      }

      HITS[hits] += 1;

         if (hits == 6) {
           <<"Winner! <$i> \n"; 
           Winners[nwins] = i;
           nwins++;
           }

         if (hits > max_hits) {
           max_hits = hits;
       <<"<$i> hits $hits\n";
       <<"$I\n"; 
       <<"$P\n"; 
       <<"$T\n"; 
        <<"$E\n"; 
          }


      if (ma < last_ma) {
       <<"<$i>  $ma\n"; 
       <<"$I\n"; 
       <<"$P\n"; 
       <<"$T\n"; 
        <<"$E\n"; 
       last_ma = ma;
       }
     
     if ( (i % 2000) == 0) {
       dt= fineTimeSince(Tim,1); 
       secs = dt/1000000.0;
       tim=time(); 
       <<"$i $tim $secs $last_ma $max_hits $nwins $HITS\n"; 
       }
     
     }
   
   
   <<"%V $Ntrys $max_hits $last_ma $nwins\n";
   <<"%V $HITS\n"
   <<"$Winners\n"; 
checkOut()
exit(); 
