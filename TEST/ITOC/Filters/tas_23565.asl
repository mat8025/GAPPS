/// 
//// asl filter code

Svar Ip;
Svar F;
fs= ' ';

/// Begin Section 2

  <<"hello\n"
begin: 
/// Main Input Loop  4

  while (1) { 
      Ip=readline(); 
      if (feof()) break; 
      F= Split(Ip,fs); 


///>>> code insert  

nm=scut(F[0],-4) 
<<"$nm \n" 


///<<< end code insert  6

 } /// end filter  

/// End Section  $ka

end: 
   <<"bye\n"
/// End Filter  8

