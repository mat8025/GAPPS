/// 
//// asl filter code

Svar Ip;
Svar F;
fs= ' ';

/// Begin Section

   begin: <<"List\n" 
   
/// Main Input Loop

  while (1) { 
      Ip=readline(); 
      if (feof()) break; 
      F= Split(Ip,fs); 


///>>> code insert  

    nm= Scut(F[0],-1);
    if (sstr(Ip,"binary")!=-1) {
    <<"$nm\n";
    !!"rm -f $nm";
    };


///<<< end code insert  

 } /// end filter  

/// End Section

   end: <<"Finish***************\n";
