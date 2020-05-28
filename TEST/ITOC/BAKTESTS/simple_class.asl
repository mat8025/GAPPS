


setdebug(1)

class Dil {

public:

 int mn;
 int A[20];
 CMF Print() 
 {
   <<"$mn\n"
   <<"$A[0]\n"
 }


 CMF Set(val)
 {
      mn = val
 }

 CMF Dil()
 {
    mn = 0;
 }

}



Dil D

 D->Print()

 D->Set(47)

 D->Print()


Dil E

 E->Print()

 E->Set(79)

 E->Print()

 E->A[0] = 80

 E->Print()

