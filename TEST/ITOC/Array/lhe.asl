/* 
 *  @script lhe.asl 
 * 
 *  @comment test LHS array ele access 
 *  @release CARBON 
 *  @vers 1.39 Y Yttrium [asl 6.3.59 C-Li-Pr] 
 *  @date 11/14/2021 20:21:44          
 *  @cdate 1/1/2007 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                               
///
///
///

<|Use_=
   Demo  of LHS array ele access
|>

#include "debug"

   if (_dblevel >0) {

     debugON();

     <<"$Use_\n";

     }

   chkIn();

   Data = vgen(INT_,10,-5,1);

   <<"$Data \n";

   <<"$Data[1:3] \n";

   <<"$Data[1]\n";

   <<"$Data[2]\n";

   <<"$Data[3]\n";
//query()

   Data.pinfo();

   <<"$Data \n";

   chkN(Data[1],-4);

   k= Data[1];

   <<"%V $k $Data[1]\n";

   H= vgen(INT_,10,0,1);

   M= vgen(INT_,10,0,1);

   <<"%V $H \n";

   Data[3] = 36;

   <<"$Data \n";

   chkN(Data[3],36);

   chkN(Data[2],-3);
   allowDB("spe_exp,spe_args,array_parse,parse,rdp,ic_",1)

   Data.pinfo();
  
   i = 2;
   ival = i
   j = 4;

   Data[i] = 80;

   <<"$Data \n";

   Data.pinfo();

   ival = Data[i]

   ask("%V $i  $Data[i]  $ival ",0)

   chkN(Data[i],80);


   


   H[8] = 76;

   H[9] = 77;

   <<"%V$H\n";
   Data[3] = H[1];

   chkN(Data[3],1)

 

   //Data[(H[1] *1)] = 47;

   <<"%V $H[8] \n"

   Hindex = H[7]-75
   
   <<"%V $Hindex \n"

   Data[(H[8]-75)] = 47;

  <<"%V $Data \n"
   
   Data.pinfo();

   <<"%V $Data[1]\n";
   ans=ask("$Data[1] == 47?",0)

   H.pinfo()
   
   <<"%V$H\n";

   <<"%V$Data \n";

   <<"H $H\n";

   chkN(Data[1],47)

   

   Data[H[2]] = 65

   <<"%V$Data \n";

   Data[H[3]] = H[9]

   H.pinfo()
    
   ans=ask("$Data[2] == 65?",0)

chkN(Data[2],65)

//   chkOut(-1)

   Data[H[4]] = H[M[8]];

   <<"$Data \n";

   Data.pinfo();

   chkN(Data[1],47);

   <<"$Data[1] $Data[2] \n";

   d= 47;

   e= Data[1];

   Arglist=testargs(Data[1],e,d);

   <<"%(1,,,\n)$Arglist\n";

   <<"%(1, ,,\n)$(testargs(Data[1],e,d))\n";

   Data.pinfo();

   <<" $Data \n";

   chkN(Data[2],65);

   chkN(Data[3],77);

   chkN(Data[4],76);

   Data[H[4]] = H[8];

   <<"%V $M[8]\n";

   <<"$Data \n";

   chkN(Data[4],76);

   int MD[3][3];

   MD[1][2] = 7;

   <<"$MD \n";

   Data[MD[1][2]]  = 37;

   chkN(Data[7],37);

   <<"$Data \n";

  // chkOut();

 //  exit();

    k = 0;
///////////////////////////////////////////////////////

   Data[1] = 47;

   <<"$Data \n";

   <<"$Data[1] \n";

   chkN(Data[1],47);

   k = 2;

   Data[k] = 79;

   <<"$Data[2] $Data[k]\n";

   chkN(Data[2],79);

   chkN(Data[k],79);

   int Lvec[10];

   int LP[10];

   Data[j] = 26;

   <<"$Data \n";

   <<" %(1,,,,)$Data \n";

   chkN(Data[4],26);

   Data[1] = k;

   Data[2] = Data[1];

   Data.pinfo();

   <<"$Data \n";

   <<"$Data[::] \n";

   <<"%V$i $j\n";

   Data[j] = Data[i];

   <<"$Data \n";

   <<"%V$Data[2]  $k $i\n";

   chkN(Data[2],k);

   m = 7;

   Data[i] = 80;

   Data[j] = 26;

   <<"$Data \n\n";

   b = 67;

   k = 1;

   Data[1] = k;

   Data[2] = Data[1];

   <<"%V $Data[1] $Data[2] $k $i\n";

   chkN(Data[1],k);

   chkN(Data[2],k);
   br = 0;
   while (k < 7) {

     k++;



     Data[1] = k;  // OK 

     Data[2] = Data[1] ;  // XIC broke RH shold be push val not location

     Data.pinfo()


     <<"%V $Data[1] $Data[2] $k $i\n";  // XIC broke 
     ask("%V $Data[1] == $Data[2] == $k ?",0)     


     chkN(Data[1],k);

     chkN(Data[2],k);

     <<"$Data \n";

     <<"%V$i $j\n";

     Data[j] = Data[i];

     <<"$Data \n";

     br = (k >= 4) ;   // TBF 9/21/24  br not set
     
     <<"%V $br $k >= 4 so break\n"
     // TBF 9/21/24   if eval broke?
     if (k > 5) {
     <<"%V $k > 5 so if break\n"
         break;
     }
     <<" breakout $k\n"
     }

   chkOut();

//===***===//
