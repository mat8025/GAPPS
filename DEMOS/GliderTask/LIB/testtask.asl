///
///
///


#define DBG <<

include "tpclass"


setDebug(1,@keep,@filter,0,@trace);

Taskpt TP[10];

Turnpt  Wtp[10];


tp_file = "turnpts.dat";  // open turnpoint file 


  if (tp_file @= "") {
    tp_file = "turnptsSM.dat"  // open turnpoint file 
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

<<" Read in Turnpts!\n"


//////////////
<<"///////////////////////////\n"
           Wtp[0]->Print();
	   kp = 1;
<<"$kp\n"	   
	   Wtp[kp]->Print();

	   kp = 3;
<<"$kp\n"	   
 Wtp[kp]->Print();
<<"///////////////////////////\n"


     itaskp = 0;
     ntp = 0;



   for (i = 0; i < Ntpts; i++) {
        pval = Wtp[i]->GetPlace();
	  TP[i]->Place = pval; // OB array LHS
	 // TP[i]->Place = Wtp[i]->GetPlace();
	  TP[i]->Place = Wtp[i]->Place;

          TP[i]->Print();
   }
<<"////////\n"
   for (i = 0; i < Ntpts; i++) {
	  TP[i]->Ladeg =  Wtp[i]->Ladeg;
          TP[i]->Print();
   }
<<"////////\n"
   for (i = 0; i < Ntpts; i++) {
	  TP[i]->Longdeg =  Wtp[i]->Longdeg;
          TP[i]->Print();
   }
<<"////////\n"


   for (i = 0; i < Ntpts; i++) {

           Wtp[ntp]->Print();
       pval = Wtp[ntp]->GetPlace();
//           valo = Wtp[ntp]->Longdeg;
        vala = Wtp[ntp]->Ladeg;
	    
//	   <<"<$ntp> %V $pval $vala $valo\n"
//	   Wtp[ntp]->Longdeg = 105.6;
          //TP[itaskp]->Longdeg = valo;   
         TP[itaskp]->Ladeg = vala;
        TP[itaskp]->Place = pval; // OB array LHS

     //TP[itaskp]->Place = Wtp[ntp]->GetPlace();
    // TP[itaskp]->Longdeg = Wtp[ntp]->Longdeg;
   //  TP[itaskp]->Ladeg = Wtp[ntp]->Ladeg;  //OB LHS/RHS
/{

             vala = Wtp[ntp]->Longdeg; // Wtp OB array RHS

           TP[itaskp]->Longdeg = vala; // TP OB array LHS
	     
           

	   
	   <<"%V $vala $TP[itaskp]->Ladeg \n"
           TP[itaskp]->Ladeg = 0.0;
	   



	     
          //
/}
           TP[itaskp]->Print();
          
	  itaskp++;
          ntp++;
     }


exit()