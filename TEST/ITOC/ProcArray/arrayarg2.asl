/* 
 *  @script arrayarg2.asl 
 * 
 *  @comment test proc array args 
 *  @release CARBON 
 *  @vers 1.38 Sr Strontium [asl 6.3.61 C-Li-Pm] 
 *  @date 11/23/2021 08:29:29          
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                            

#include "debug"

<<"%V $_dblevel\n"

//sdb(_dblevel,@~trace)

if (_dblevel >0) {
   debugON()
}
  

chkIn();

//sdb(_dblevel,@~trace)
   
aaa: <<"aaa label !\n"

<<"b4 break point !\n"

//~b <<"at my break point !\n"
<<" this is the  brk_pt \n" ; // needs to stop before executing this statement

//~c <<" this is the  brk_pt \n" ; // needs to stop before executing this statement

<<"after break point !\n"

   proc Woo(int vect[],int k)
   {
   <<"$_proc    $k\n"
     vect<-pinfo();
     

     Z.pinfo() ;
     
<<"IN %V $vect \n"; 
<<"IN  %V $Z\n"


      vect.pinfo();
      vect[1] = 47; 
      vect[2] = 79;
      vect[3] = 80;
      
      vect.pinfo(); 

     <<"OUT %V $vect \n";
     <<"OUT %V $Z\n"
     Z.pinfo()

     rvec = vect;
     <<"OUT %V $rvec \n";
      Z.pinfo()
     return rvec; 
     }
   
///////////////  Array name ////////////////////////////////////////
   Z = Vgen(INT_,10,0,1); 
   
   <<"init $Z\n"; 
   
   Z[0] = 36; 
   Z[1] = 53; 
   Z[9] = 28; 
   
  <<"before calling proc $Z\n"; 
   
   Y=Woo(&Z,3); 
   
   <<"after calling proc $Z\n"; 

    Z.pinfo()

   chkN(Z[1],47);
   chkN(Z[2],79);
   chkN(Z[3],80);       
   
   chkN(Z[9],28); 
   
   <<"Array Name return vec $Y\n"; 
   
   chkStage("ArrayName"); 

///////////////  &Array ////////////////////////////////////////
   
//  showStatements(1)
//iread()
   
   
   Z = Vgen(INT_,10,0,1); 
   
   Z[0] = 36;
   Z[1] = 53;    
   Z[9] = 28; 
   
 // Z[0] = 36  // FIX TBD last element offset is being used as function para offset!!
   

   <<"preZ $Z\n"; 

    pinfo(Z); 

// Y = foo(&Z,3)  // TBF-------- Y

    YA = &Z[3];

    pinfo(YA)

    YA.pinfo()


    Y = Woo(&Z[0],3)  // FIXED -------- Y is now created correctly with the return vector; 
   
   <<"postZ $Z\n"; 

   Z.pinfo(); 

   chkN(Z[1],47);
   chkN(Z[2],79);
   chkN(Z[3],80);      
   chkN(Z[9],28); 
   
   chkStage("&Array");



   
   Z = vgen(INT_,10,0,1); 

   Z[0] = 36;
   Z[1] = 53;    
   Z[9] = 28; 
   
   <<"////////////////////////////////////////\npreZ $Z\n"; 
<<"call using &Z[3] \n"

   Y2= Woo(&Z[3],4);
   
   pinfo(Z)
   
   <<"postZ $Z\n";


//~c <<" this is the  brk_pt \n" ; // needs to stop before executing this statement   

   chkN(Z[4],47);
   chkN(Z[5],79);
   chkN(Z[6],80);      

   chkN(Z[9],28);
   
   chkStage("&Array[3]"); 

   <<"return Y2 vec $Y2\n";
   
   chkN(Y2[1],47);
   chkN(Y2[2],79);    
   chkN(Y2[6],28);


   chkStage("ArrayReturn"); 
   
   
   chkOut();
   
