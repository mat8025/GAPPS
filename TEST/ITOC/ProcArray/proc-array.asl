
///
///
///


   int Voo(int veci[],int k)
   {
     veci->info(1); 
     k->info(1);
     //Z->info(1) ;
     
<<"IN %V $k $veci \n"; 
//<<"IN  %V $Z\n"

      veci[1] = 47; 
      veci[2] = 79;
      veci[3] = 80;      
      veci->info(1); 


     <<"OUT %V $veci \n";


     rvec = veci[1];
     <<"OUT %V $rvec \n"; 
     return rvec; 
     }


vecM = vgen(INT_,10,0,1)

<<"$vecM \n"

int j = 77;

 fret = Voo(vecM,j) ;

<<"$vecM \n"

<<"%V$fret\n"
/*
float x = 46;

 bret = Voo(x,j) ;

<<"%V$bret\n"
// will give not found Proc -- which is correct - not coded
*/