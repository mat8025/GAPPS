

<|Use_=
 view and select turnpts
 create read tasks   
///////////////////////
|>

                                                                        
#include "debug"

if (_dblevel >0) {
  debugON()
    <<"$Use_\n"   
}




void TaskDistance()
{
   // is there a start?
<<"$_proc  $Ntaskpts \n"
Taskpts<-pinfo()
   k = 1;
  index = Taskpts[k];
<<"%V $k $index  \n";

   k = 0;
  index = Taskpts[k];
<<"%V $k $index  \n";

!a

   // num of taskpts

<<"%V $Ntaskpts \n"
Taskpts<-pinfo()
   int index =0;


   for (k= 0; k < Ntaskpts; k++) {
        index = Taskpts[k]
<<"%V $k $index $Taskpts[k] \n";

   }


!a


}
//==============================//

int Taskpts[>10];
int Ntaskpts = 0;
index = 7;
for (i= 0; i <5; i++) {

  Taskpts[Ntaskpts] = index;

  index++;
  Ntaskpts++;
  
}

Taskpts<-pinfo()

   for (k= 0; k < Ntaskpts; k++) {
     index = Taskpts[k];
<<"%V $k $index $Taskpts[k] \n";
   }


 TaskDistance();



exit()