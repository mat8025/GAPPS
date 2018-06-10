///
///
///


#define DBG <<

include "tpclass"


setDebug(1,@keep,@filter,0,@~trace);

Taskpt Tasktp[10];

Turnpt  Wtp[10];


tp_file = "turnpts.dat";  // open turnpoint file 


  if (tp_file @= "") {
    tp_file = "turnpts.dat"  // open turnpoint file 
   }

  A=ofr(tp_file)
  

  if (A == -1) {
    exit(-1," can't find turnpts file \n");
  }



 //  Read in a Task via command line
  Ntaskpts = 0;
  Ntp = 0;

 svar Wval;

         C=readline(A);
	 C=readline(A);

  Ntpts = 7;

while (1) {

            nwr = Wval->Read(A)

            if (nwr == -1) {
	      break
            }
	    
            if (nwr > 6) { 
//<<"$Wval[0]\n";
             Wtp[Ntp]->Set(Wval);
             Wtp[Ntp]->Print();

             Ntp++;
            }
      if (Ntp >= Ntpts)
          break;
  }



//////////////
<<"///////////////////////////\n"
           Wtp[0]->Print();
	   kp = 1;
<<"$kp\n"	   
	   Wtp[kp]->Print();
	   
<<"///////////////////////////\n"


     itaskp = 0;
     ntp = 0;

setDebug(1,@trace);

   for (i = 0; i < Ntpts; i++) {
        pval = Wtp[i]->GetPlace();
	  Tasktp[i]->Place = pval; // OB array LHS
	 // Tasktp[i]->Place = Wtp[i]->GetPlace();
	  Tasktp[i]->Place = Wtp[i]->Place;

          Tasktp[i]->Print();
   }
<<"////////\n"
   for (i = 0; i < Ntpts; i++) {
	  Tasktp[i]->Ladeg =  Wtp[i]->Ladeg;
          Tasktp[i]->Print();
   }
<<"////////\n"
   for (i = 0; i < Ntpts; i++) {
	  Tasktp[i]->Longdeg =  Wtp[i]->Longdeg;
          Tasktp[i]->Print();
   }
<<"////////\n"


   for (i = 0; i < Ntpts; i++) {

           Wtp[ntp]->Print();
       pval = Wtp[ntp]->GetPlace();
//           valo = Wtp[ntp]->Longdeg;
        vala = Wtp[ntp]->Ladeg;
	    
//	   <<"<$ntp> %V $pval $vala $valo\n"
//	   Wtp[ntp]->Longdeg = 105.6;
          //Tasktp[itaskp]->Longdeg = valo;   
         Tasktp[itaskp]->Ladeg = vala;
        Tasktp[itaskp]->Place = pval; // OB array LHS

     //Tasktp[itaskp]->Place = Wtp[ntp]->GetPlace();
    // Tasktp[itaskp]->Longdeg = Wtp[ntp]->Longdeg;
   //  Tasktp[itaskp]->Ladeg = Wtp[ntp]->Ladeg;  //OB LHS/RHS
/{


	  


             vala = Wtp[ntp]->Longdeg; // Wtp OB array RHS

           Tasktp[itaskp]->Longdeg = vala; // TP OB array LHS
	     
           

	   
	   <<"%V $vala $Tasktp[itaskp]->Ladeg \n"
           Tasktp[itaskp]->Ladeg = 0.0;
	   



	     
          //
/}
           Tasktp[itaskp]->Print();
          
	  itaskp++;
          ntp++;
     }


exit()