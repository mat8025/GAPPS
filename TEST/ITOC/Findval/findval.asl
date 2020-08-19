///
///
///

# test ASL function findval

chkIn()
//#define ASK ans=iread();
#define ASK ;

<<"hey mark onward ever upward - higher and higher!!\n"

setdebug(1,"~pline","steponerror")

Csum=vgen(FLOAT_,10,0)



Csum[4] = 1;
<<"$Csum\n"
   ivec = findVal(Csum,0,0,-1,1,0,LT_)

   le = ivec[0];
   if (le == -1) {
     le = 0;
   }
<<"%V $ivec $le\n"

chkN(le,4)

ASK

   ivec = findVal(Csum,0,0,-1,1,0,"<")

   le = ivec[0];
   if (le == -1) {
     le = 0;
   }
<<"%V $ivec $le\n"

chkN(le,4)

ASK


I= Igen(20,0,1)


<<" $I \n"

//<<" $I[3:7] \n"

int fi;

int si = 0;

found= findval(I,6,si,-1,1,0)

nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"


fi = found[0]

<<"%V $fi \n"


chkN(fi,6)

ASK
found= findval(I,8,si,-1,1,0)


nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"


fi = found[0]

<<"%V $fi \n"


chkN(fi,8)



ASK


   found= findval(I,6,si,-1,1,LTE_)

nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"

fi = found[0];

<<"%V $fi \n"


chkN(fi,6)

ASK


   found= I->findval(7,si,-1,-1,1)

fi = found[0];

chkN(fi,7)

<<"%V $fi \n"

ASK

si = 19;

   found= I->findval(17,si,-1,-1,1)
<<" $(Cab(found))  \n"
   fi = found[0];

<<"%V $fi \n"

chkN(fi,-1)
ASK
si = -1;
   found= I->findval(17,si,0,0)

   fi = found[0];

<<"%V $fi \n"
chkN(fi,17)
ASK

si = 19;

   found= I->findval(17,si,-1,0)


<<"%V $fi \n"
chkN(fi,17)
ASK


si = 19;

//   found= I->findval(17,-1,-1,1,'>=')

   found= I->findval(17,-1,-1,0,1,GTE_)

nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"

<<"%V $fi \n"
chkN(fi,17)
ASK





F= Fgen(20,0,1);


<<" $F \n"

<<" $F[3:7] \n"

si = 0;


found= findval(F,8,si,-1,1,0)

fi = found[0];

<<"$found $fi \n"

chkN(fi,8)

   found= F->findval(7,si,-1,1,0)

fi = found[0];

<<"$found $fi \n"

chkN(fi,7)

chkOut();
exit();
