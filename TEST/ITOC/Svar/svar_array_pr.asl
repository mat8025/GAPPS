
///
///
///
   include "debug"; 
   debugON(); 
   
   

   setdebug(1,@pline,@keep,@trace); 
   
svar E[] = { "the first ten elements are:", "H", "He", "Li", "Be" ,"B" ,"C", "N", "O", "F", "Ne"  };
   
   
   <<"$E\n"; 
   <<"$E[1] \n";
   <<"$E[7] \n";

  <<"$E[2:7] \n"

D= E[2:7];

<<"$D\n";


W="$E[2:7]"

<<"%v$W\n"

W="$E"

<<"%v$W\n"

 for (i=1;i<=100; i++) {

   E[i]= pt(i)

 }



<<"%(1 ,,\n)$E[20:30] \n"


<<"%(1 ,,\n)$E[30:40] \n"


<<"%(1 ,,\n)$E[40:50] \n"

<<"%(1 ,,\n)$E[50:60] \n"


<<"%(1 ,,\n)$E[10:100:5] \n"