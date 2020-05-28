/// 
//// asl filter code


filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_","hop_");

Svar Ip;
Svar F;
fs= ' ';

/// Begin Section 2

  <<"hello\n"
begin: 
/// Main Input Loop  4
 int kr =0;
  while (1) {
  kr++;
 // <<"%V$kr\n"
      Ip=readline(); 
      if (feof()) {
<<"seen eof \n"
       break; 
      }
     F= Split(Ip,fs); 


///>>> code insert  

nm=scut(F[0],-4) 
<<"$nm \n" 


///<<< end code insert  6

 }
 /// end filter  

/// End Section  

end: 
   <<"bye\n"
/// End Filter  8

