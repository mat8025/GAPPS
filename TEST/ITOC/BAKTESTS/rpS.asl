//%*********************************************** 
//*  @script rpS.asl 
//* 
//*  @comment test class member set/access 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sun Mar  3 12:41:16 2019 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
  include "debug.asl"; 
  
  debugON();
  setdebug(1,@pline,@~trace,@~showresults,1);

filterFileDebug(REJECT_,"ic_wic","scope_e","scopesindex","parset_e","ic_stack","ic_getsiv");

filterFileDebug(REJECT_,"ic_store","args_e","args_process_e"); // addto list?


filterFuncDebug(REJECT_,"SprocSM","checkProcName","getMemberSiv","checkLoop")
  CheckIn(); 
  
  Nhouses = 0;
class house {
    
    int rooms; 
    int floors; 
    int area; 
    int number;
    
    CMF setrooms(val) {

      rooms = val;
    
      <<" $_proc  $_cobj set rooms  $rooms  for house $number  \n"; 
      return rooms; 
     }
    
    CMF setfloors(val){
      if (floors > 0) {
        floors = val; 
        area = floors * 200; 
        }
      return area; 
      }

    CMF getrooms() {
         <<"getrooms $_cobj $rooms for house  $number \n"
         return rooms;
    }
    
    CMF print() {
      <<" $_cobj has %V $floors and  $rooms $area\n"; 
      }
    
    
    CMF house()  {
      floors = 2; 
      rooms = 4; 
      area = floors * 200;
      number= Nhouses;
      Nhouses++;

      <<"cons $Nhouses for $_cobj setting  $floors  $rooms $area $number\n"; 
      }
    
    }
  //===============================//
  proc  checkRooms( rmchk)
  {

     crooms = rmchk +1;
     

     return crooms;
 }

 //===============================//

    house AA;

 AAr= AA->getrooms() ;
  <<"%V $AAr \n"
 CheckNum(AAr,4);




    house AS;
    house BS;
    house CS;
    house DS;    

  ASr= AS->getrooms() ;
  <<"%V $ASr \n"

   ASr= AS->setrooms(7) ;
  <<"%V $ASr \n"

  ASr= AS->getrooms() ;
  <<"%V $ASr \n"

 CheckNum(ASr,7);


  DSr= DS->getrooms() ;
  <<"%V $DSr \n"
 CheckNum(DSr,4); 



   BSr= BS->setrooms(8) ;
  <<"%V $BSr \n"

 CheckNum(BSr,8); 

   CSr= CS->setrooms(9) ;
  <<"%V $CSr \n"

 CheckNum(CSr,9); 

CSr= CS->getrooms() ;
  
<<"%V $CSr \n"

 CheckNum(CSr,9); 

   DSr= DS->setrooms(10) ;
  <<"%V $DSr \n"

 CheckNum(DSr,10); 

  DSr= DS->getrooms() ;
  <<"%V $DSr \n"

 CheckNum(DSr,10); 
  

//////////////////////////////////////////////////////////////
   ASr= AS->getrooms() ;
  <<"%V $ASr \n"

   BSr= BS->getrooms() ;
  <<"%V $BSr \n"

  res = BSr + ASr;
<<"%V $res\n"

   x=DS->setrooms(BS->getrooms() + CS->setrooms(AS->getrooms())) ;

<<"%V $x  should be $res ?\n"


  CheckNum(x,res); 


   DSr= DS->getrooms() ;
  <<"%V $DSr \n"

   CheckNum(DSr,res); 


   y=DS->setrooms(BS->getrooms() + CS->setrooms(checkRooms(AS->getrooms()))) ;

<<"%V $y  should be $res +1 ?\n"
   CheckNum(y,res+1); 


   ASr= AS->getrooms() ;
  <<"%V $ASr \n"

   res2= BS->getrooms() ;
  <<"%V $BSr $res2 \n"

   CheckNum(BSr,res2); 

   CSr= CS->getrooms() ;
  <<"%V $CSr \n"
  CheckNum(CSr,ASr+1);




  CheckOut(); 
  exit(); 
