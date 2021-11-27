//%*********************************************** 
//*  @script findval.asl 
//* 
//*  @comment test findval SF 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.70 C-He-Yb]                               
//*  @date Wed Sep  2 09:33:15 2020 
//*  @cdate 1/1/2002 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
<<"Running $_script\n"
///
///
///

# test ASL function findval
#include "debug.asl";



if (_dblevel >0) {
   debugON()
//filterFileDebug(ALLOWALL_,"yyy");  // all files
//filterFuncDebug(ALLOWALL_,"xxx") ; // all funcs should see all DBC debug

}

chkIn(_dblevel)



////  debug ON


//#define ASK ans=iread();
#define ASK ;

<<"hey mark onward ever upward - higher and higher!!\n"


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



   ivec = findVal(Csum,0,0,-1,1,0,"<")

   le = ivec[0];
   if (le == -1) {
     le = 0;
   }
<<"%V $ivec $le\n"

chkN(le,4)




I= Igen(20,0,1)


<<" $I \n"

//<<" $I[3:7] \n"

int fi;

int si = 0;

//int found[];

//found.info(1)

found= findval(I,6,si,-1,1,0)

nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"


fi = found[0]

<<"%V $fi \n"


chkN(fi,6)

//chkOut(); exit();

found= findval(I,8,si,-1,1,0)


nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"


fi = found[0]

<<"%V $fi \n"


chkN(fi,8)






   found= findval(I,6,si,-1,1,LTE_)

nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"

fi = found[0];

<<"%V $fi \n"


chkN(fi,6)




   found= I.findval(7,si,-1,-1,1)

fi = found[0];

chkN(fi,7)

<<"%V $fi \n"



si = 19;

   found= I.findval(17,si,-1,-1,1)
<<" $(Cab(found))  \n"
   fi = found[0];

<<"%V $fi \n"

chkN(fi,-1)

si = -1;
   found= I.findval(17,si,0,0)

   fi = found[0];

<<"%V $fi \n"
chkN(fi,17)


si = 19;

   found= I.findval(17,si,-1,0)


<<"%V $fi \n"
chkN(fi,17)



si = 19;

//   found= I.findval(17,-1,-1,1,'>=')

   found= I.findval(17,-1,-1,0,1,GTE_)

nd= Cab(found);
sz = Caz(found);
<<"%V $nd $sz $(Cab(found))  \n"

<<"%V $found  \n"

<<"%V $fi \n"
chkN(fi,17)


F= Fgen(20,0,1);


<<" $F \n"

<<" $F[3:7] \n"

si = 0;


found= findval(F,8,si,-1,1,0)

fi = found[0];

<<"$found $fi \n"

chkN(fi,8)

   found= F.findval(7,si,-1,1,0)

fi = found[0];

<<"$found $fi \n"

chkN(fi,7)

chkOut();
exit();
