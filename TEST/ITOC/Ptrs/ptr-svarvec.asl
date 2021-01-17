//%*********************************************** 
//*  @script ptr-svarvec.asl 
//* 
//*  @comment test ptr access to vec 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.73 C-He-Ta]                             
//*  @date Wed Sep 23 20:15:50 2020 
//*  @cdate Wed Jun 26 08:46:49 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%
   
#include "debug"


/*
sdb(1,@pline,@trace)

filterFileDebug(ALLOWALL_,"xxx")
filterFuncDebug(ALLOW_,"CheckProcFunc")
filterFuncDebug(ALLOWALL_,"xxx")
*/

   chkIn(_dblevel);
   
   svar S;
   
   S[0] = "Ca";
   S[1] = "va";
   S[2] = "tres";
   S[3] = "bien";
   S[4] = "avec";
   S[5] = "elle";
   
   
   <<"$S[5] \n"; 

   svar sval;
   
   ptr  ps; 

   ps->info(1)
 
   ps = &S;

<<"$S\n"

   ps->info(1)

   S->info(1)

   val = ps[2];

chkStr(val,"tres")
ps->info(1)


   <<"%V $val\n";


   val->info(1); 



   val = ps[3];

   ps->info(1);

   <<"$val\n";

chkStr(val,"bien")

  i= 4;
   
   sval= ps[i];

  ps->info(1);

<<"%V$sval\n"
chkStr(sval,"avec")

exit()

   sz=Caz(S);

   S->info(1)

    i= 4;
   
   sval= ps[i];
   
   ps->info(1)
   
<<"%V <|$sval|> \n"
  chkStr(sval,"avec")





   sval= ps[1];
   ps->info(1)
   <<"%V <|$sval|> \n"


chkStr(sval,"va")


   for (i=0;i<sz;i++) {
     
     sval= ps[i];
     
     <<"<$i> $sval \n"; 
      chkStr(sval,S[i])
     }
   
   <<"\n";
      ps->info(1);
<<"$S\n"
     ps[3] = "mal"

<<"$S\n"
     S->info(1)
   
     chkStr(S[3],"mal")

<<"%V $S[3]\n"


     sval= ps[3];
     nval = S[3];

<<"%V $sval $nval $ps[3]\n"




     sval= ps[4];
     nval = S[4];

<<"%V $sval $nval $ps[4]\n"

     ps[4] = "trop"     
     ps[5] = "merci"

<<"CHECKING   ps[3] $ps[3]\n"

     chkStr(ps[3],"mal")
     chkStr(ps[5],"merci")          

<<"CHECKING   ps[3] $ps[3]\n"

      sz=Caz(S);
<<" S sz $sz \n"
S->info(1)
     for (i=0;i<sz;i++) {
     
      sval= ps[i];
     
     <<"<$i> $sval  $S[i]  $ps[i]\n";

      chkStr(sval,S[i])
  //   sval->info(1); 
     }

     chkStr(ps[1],"va")
     chkStr(ps[3],"mal")     
     chkStr(S[4],"trop")
     chkStr(S[5],"merci")     


   chkStage("str vecs - get value")

   chkOut(); 
   
  
   
   
