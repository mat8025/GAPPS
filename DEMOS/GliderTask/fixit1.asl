///
///
///


#define DBG <<

include "tpclass"


setDebug(1,@keep,@filter,0);
Turnpt  Wtp[10];



tp_file = "turnpts.dat"  // open turnpoint file 


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
  
  while (1) {

            nwr = Wval->Read(A)

            if (nwr == -1) {
	      break
            }
	    
            if (nwr > 6) { 
//<<"$Wval[0]\n";
             Wtp[Ntp]->Set(Wval);

             Wtp[Ntp]->Print()

             Ntp++;
            }
      if (Ntp > 9)
          break;
  }


//////////////

Taskpt Tasktp[10];
     itaskp = 0;
     ntp = 0;

   for (i = 0; i < 10; i++) {

           nval = Wtp[ntp]->GetPlace();

           Tasktp[itaskp]->Place = nval;

             vala = Wtp[ntp]->Longdeg;
	     Tasktp[itaskp]->Longdeg = vala;
           vala = Wtp[ntp]->Ladeg;

	   Tasktp[itaskp]->Ladeg = vala;
	   <<"%V $vala $Tasktp[itaskp]->Ladeg \n"
           Tasktp[itaskp]->Ladeg = 0.0;
	   
           Tasktp[itaskp]->Ladeg = Wtp[ntp]->Ladeg;


	     
          //Tasktp[itaskp]->Longdeg = Wtp[ntp]->Longdeg;

           Tasktp[itaskp]->Print();
          
	  itaskp++;
          ntp++;
     }


exit()