   
   
//N = atoi( _clarg[1])
   
   checkIn(); 
   
   N =5; 
   <<" $N  testing for <,=, or > than 1\n"; 
   nwr = 4; 
   jlt =0; 
   jeq = 0; 
   jgt = 0; 
   j = 1; 
   M = N + 3; 
   if (N > j) {
     while (j <= M) {
       
       if (nwr == 4) {
         if (N > j )
         {
           <<"$N > $j \n"; 
           jlt++; 
           j++; 
           <<"%v $j $jlt do we see this if true line ?\n"; 
           }
         else if (N ==j)  {
           <<"$N == $j \n"; 
           j++; 
           jeq++; 
           <<"%v $j == $N do we see this else if line ?\n"; 
           }
         else {
           <<"$N < $j \n"; 
           j++; 
           jgt++; 
           <<"%v $j $jgt do we see this else line ?\n"; 
           }
         }
       }
     }
   else {
     <<" N<=j \n"; 
     }
   
   
   checkNum(jlt,4); 
   checkNum(jeq,1); 
   checkNum(jgt,3); 
   
   <<"%V $jlt $jeq $jgt\n"; 
   checkOut(); 
   
