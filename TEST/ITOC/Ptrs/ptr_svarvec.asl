/* 
 *  @script ptr_svarvec.asl 
 * 
 *  @comment test ptr access to vec 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.55 C-Li-Cs] 
 *  @date 10/12/2021 22:09:01 
 *  @cdate Wed Jun 26 08:46:49 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                         
   

#include "debug"



  if (_dblevel >0) {
    debugON()
   }
   
allowErrors(-1) ; // keep going

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

   ps<-pinfo()
 
   ps = &S;

<<"$S\n"

   ps<-pinfo()

   S<-pinfo()

   val = ps[2];

chkStr(val,"tres")



   <<"%V $val\n";
   val<-pinfo(); 

   val = ps[3];
   S<-pinfo()
   ps<-pinfo();

   <<"$val\n";

chkStr(val,"bien")

   val = ps[4];
   S<-pinfo()
   ps<-pinfo();

   <<"$val\n";

   val = ps[4];

   ps<-pinfo();

   <<"$val\n";



  i= 4;
   
   sval= ps[i];

  ps<-pinfo();

<<"%V$sval\n"
chkStr(sval,"avec")



   sz=Caz(S);

   S<-pinfo()

    i= 4;
   
   sval= ps[i];
   
   ps<-pinfo()
   
<<"%V <|$sval|> \n"
  chkStr(sval,"avec")





   sval= ps[1];
   ps<-pinfo()
   <<"%V <|$sval|> \n"


chkStr(sval,"va")


   for (i=0;i<sz;i++) {
     
     sval= ps[i];
     
     <<"<$i> $sval \n"; 
      chkStr(sval,S[i])
     }
   
   <<"\n";
      ps<-pinfo();
<<"$S\n"
     ps[3] = "mal"

<<"$S\n"
     S<-pinfo()
   
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
S<-pinfo()
     for (i=0;i<sz;i++) {
     
      sval= ps[i];
     
     <<"<$i> $sval  $S[i]  $ps[i]\n";

      chkStr(sval,S[i])
  //   sval<-pinfo(); 
     }

     chkStr(ps[1],"va")
     chkStr(ps[3],"mal")     
     chkStr(S[4],"trop")
     chkStr(S[5],"merci")     


   chkStage("str vecs - get value")

   chkOut(); 
   
  
   
   
