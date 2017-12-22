///
///
///

# test ASL function findval
CheckIn()
//#define ASK ans=iread();
#define ASK ;


setdebug(1)

I= Igen(20,0,1)


<<" $I \n"

//<<" $I[3:7] \n"

int fi;

int si = 0;

found= findval(I,6,si,1,0)

nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"


fi = found[0]

<<"%V $fi \n"


CheckNum(fi,6)

ASK
found= findval(I,8,si,1,0)


nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"


fi = found[0]

<<"%V $fi \n"


CheckNum(fi,8)



ASK


   found= findval(I,6,si,1,1,LTE_)

nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"

fi = found[0];

<<"%V $fi \n"


CheckNum(fi,6)

ASK


   found= I->findval(7,si,1,0)

fi = found[0];

CheckNum(fi,7)

<<"%V $fi \n"

ASK

si = 19;

   found= I->findval(17,si,-1,0)
<<" $(Cab(found))  \n"
   fi = found[0];

<<"%V $fi \n"

CheckNum(fi,17)
ASK
si = -1;
   found= I->findval(17,si,-1,0)

   fi = found[0];

<<"%V $fi \n"
CheckNum(fi,17)
ASK

si = 19;

   found= I->findval(17,si,-1,0)


<<"%V $fi \n"
CheckNum(fi,17)
ASK

F= Fgen(20,0,1);


<<" $F \n"

<<" $F[3:7] \n"

si = 0;


found= findval(F,8,si,1,0)

fi = found[0];

<<"$found $fi \n"

CheckNum(fi,8)

   found= F->findval(7,si,1,0)

fi = found[0];

<<"$found $fi \n"

CheckNum(fi,7)

CheckOut();
exit();
