//%*********************************************** 
//*  @script rpS.asl 
//* 
//*  @comment test class member set/access 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.48 C-He-Cd]                             
//*  @date Tue May 19 07:41:22 2020 
/*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
  chkIn(_dblevel); 
  
  Nhouses = 0;


<<"init %V $Nhouses\n"




class house {
    
    int rooms; 
    int floors; 
    int area; 
    int number;
    
    cmf setrooms(int val) {
      <<" $_proc  $_cobj $val \n"; 
      rooms = val;
    
      <<" $_proc  $_cobj set rooms  $rooms  for house $number  \n"; 
      return rooms; 
     }
    
    cmf setfloors(int val){
      if (floors > 0) {
        floors = val; 
        area = floors * 200; 
        }
      return area; 
      }

    cmf getrooms() {
         <<"getrooms $_cobj $rooms for house  $number \n"
         return rooms;
    }

    cmf getarea() {
         area = floors * 200;
         <<"getarea $_cobj $area for house  $number \n"
         return area;
    }

    cmf getfloors() {
         <<"getfloors $_cobj $floors for house  $number \n"
         return floors;
    }
    
    cmf print() {
      <<" $_cobj has %V $floors and  $rooms $area\n"; 
      }
    
    
    cmf house()  {
      floors = 2; 
      rooms = 4; 
      area = -1;
      number= Nhouses;
      Nhouses++;

      <<"cons $Nhouses for $_cobj setting  $floors  $rooms $area $number\n"; 
      }
    
    }
  //===============================//

// crash unless type of rmchk specified -- want to work anyway -- default gen type
proc  checkRooms( int rmchk)
  {
     crooms = rmchk +1;

     return crooms;
 }

 //===============================//

   house AA;

   AAr= AA->getrooms() ;
  <<"%V $AAr \n"
   chkN(AAr,4);


   AAr=AA->setrooms(7) ;
 <<"%V $AAr \n"
   chkN(AAr,7);

   AAr= AA->getrooms() ;
  <<"%V $AAr \n"
   chkN(AAr,7);

    house AS;


   ASr= AS->getrooms() ;

  <<"%V $ASr \n"

  ASf= AS->getfloors() ;

  <<"%V $ASf \n"

  chkN(ASf,2);

    house BS;

   BSr= BS->getrooms() ;
  <<"%V $BSr \n"

chkN(BSr,4);


    house CS;
    house DS;    

  DSr= DS->getrooms() ;
  <<"%V $DSr \n"
 chkN(DSr,4); 

  ASr= AS->getrooms() ;
  <<"%V $ASr \n"

 chkN(ASr,4);


   BSr= BS->setrooms(8) ;
  <<"%V $BSr \n"

 chkN(BSr,8); 

   CSr= CS->setrooms(9) ;
  <<"%V $CSr \n"

 chkN(CSr,9); 

CSr= CS->getrooms() ;
  
<<"%V $CSr \n"

 chkN(CSr,9); 

   DSr= DS->setrooms(10) ;
  <<"%V $DSr \n"

 chkN(DSr,10); 

  DSr= DS->getrooms() ;
  <<"%V $DSr \n"

 chkN(DSr,10); 
  

//////////////////////////////////////////////////////////////
   ASr= AS->getrooms() ;
  <<"%V $ASr \n"

   BSr= BS->getrooms() ;
  <<"%V $BSr \n"

  res = BSr + ASr;
<<"%V $res\n"

   x=DS->setrooms(BS->getrooms() + CS->setrooms(AS->getrooms())) ;

<<"%V $x  should be $res ?\n"


  chkN(x,res); 


   DSr= DS->getrooms() ;
  <<"%V $DSr \n"

   chkN(DSr,res); 


   y=DS->setrooms(BS->getrooms() + CS->setrooms(checkRooms(AS->getrooms()))) ;

<<"%V $y  should be $res +1 ?\n"
   chkN(y,res+1); 


   ASr= AS->getrooms() ;
  <<"%V $ASr \n"

   res2= BS->getrooms() ;
  <<"%V $BSr $res2 \n"

   chkN(BSr,res2); 

   CSr= CS->getrooms() ;
  <<"%V $CSr \n"
  chkN(CSr,ASr+1);




  chkOut(); 

