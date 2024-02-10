/* 
 *  @script rpS.asl                                                     
 * 
 *  @comment test class member set/access                               
 *  @release Boron                                                      
 *  @vers 1.4 Be Beryllium [asl 5.80 : B Hg]                            
 *  @date 01/31/2024 15:52:16                                           
 *  @cdate 1/1/2003                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

  

#include "debug"

if (_dblevel >0) {
   debugON()
}



chkIn(_dblevel); 

int db_ask = 0; // set to zero for no ask
int db_step = 1; // set to zero for no step




  Nhouses = 0;


<<"init %V $Nhouses\n"




Class house {
    
    int rooms; 
    int floors; 
    int area; 
    int number;
    
    int setrooms(int val) {
      <<" $_proc  $_cobj $val \n"; 
      rooms = val;
    
      <<" $_proc  $_cobj set rooms  $rooms  for house $number  \n"; 
      return rooms; 
     }
    
    int setfloors(int val){
      if (floors > 0) {
        floors = val; 
        area = floors * 200; 
        }
      return area; 
      }

    int getrooms() {
         <<"getrooms $_cobj $rooms for house  $number \n"
         return rooms;
    }

    int getarea() {
         area = floors * 200;
         <<"getarea $_cobj $area for house  $number \n"
         return area;
    }

    int getfloors() {
         <<"getfloors $_cobj $floors for house  $number \n"
         return floors;
    }
    
    void print() {
      <<" $_cobj has %V $floors and  $rooms $area\n"; 
      }
    
    
    void house()  {
      floors = 2; 
      rooms = 4; 
      area = -1;
      number= Nhouses;
      Nhouses++;

      //<<"cons $Nhouses for $_cobj setting  $floors  $rooms $area $number\n";
      <<"cons $Nhouses for $_cobj \n"; 
      }
    
    }
  //===============================//

// crash unless type of rmchk specified -- want to work anyway -- default gen type
int  checkRooms( int rmchk)
  {
     crooms = rmchk +1;

     return crooms;
 }

 //===============================//

   house AA;

   AAr= AA.getrooms() ;
  <<"%V $AAr \n"
   chkN(AAr,4);


   AAr=AA.setrooms(7) ;
 <<"%V $AAr \n"
   chkN(AAr,7);

   AAr= AA.getrooms() ;
  <<"%V $AAr \n"
   chkN(AAr,7);

    house AS;


   ASr= AS.getrooms() ;

  <<"%V $ASr \n"

  ASf= AS.getfloors() ;

  <<"%V $ASf \n"

  chkN(ASf,2);

    house BS;

   BSr= BS.getrooms() ;
  <<"%V $BSr \n"

chkN(BSr,4);


    house CS;
    house DS;    

  DSr= DS.getrooms() ;
  <<"%V $DSr \n"
 chkN(DSr,4); 

  ASr= AS.getrooms() ;
  <<"%V $ASr \n"

 chkN(ASr,4);


   BSr= BS.setrooms(8) ;
  <<"%V $BSr \n"

 chkN(BSr,8); 

   CSr= CS.setrooms(9) ;
  <<"%V $CSr \n"

 chkN(CSr,9); 

CSr= CS.getrooms() ;
  
<<"%V $CSr \n"

 chkN(CSr,9); 

   DSr= DS.setrooms(10) ;
  <<"%V $DSr \n"

 chkN(DSr,10); 

  DSr= DS.getrooms() ;
  <<"%V $DSr \n"

 chkN(DSr,10); 
  

//////////////////////////////////////////////////////////////
   ASr= AS.getrooms() ;
  <<"%V $ASr \n"

   BSr= BS.getrooms() ;
  <<"%V $BSr \n"

  res = BSr + ASr;


<<"%V $res\n"


   CSr1= CS.setrooms(4 +2) ;

   chkN( CSr1,6)

     CSr2=  CS.setrooms( AS.getrooms() +2 ) ;

   chkN( CSr2,6)

   CSr3= CS.setrooms(  3+ AS.getrooms()  +2);

   chkN( CSr3,9)
   
   DSr= DS.getrooms() ;

<<"%V $ASr $BSr  $CSr $DSr  \n"

   ans=ask("debug",db_ask);

if (ans == "y") {
   allowDB("spe,opera,ic")
}

  x1= DS.setrooms(BS.getrooms() + AS.getrooms()) ;

<<"%V $ASr $BSr    $x1 \n"

   x2 = -1
   
   x2 = DS.setrooms(BS.getrooms() + CS.setrooms(AS.getrooms()) ) ;

<<"%V $ASr $BSr    $x1 $x2 \n"

<<"%V $x2  should be $res ?\n"

ans=ask("%V $x2  should be $res ?",db_ask);

   ASr= AS.getrooms() ;

   BSr= BS.getrooms() ;

   CSr= CS.getrooms() ;

   DSr= DS.getrooms() ;

<<"%V $ASr $BSr  $CSr $DSr $x2 $res\n"

  chkN(x2,res); 

  chkStage("%V  $x2 $res cmf + scalar OK?")


   
  <<"%V $DSr $res\n"

   chkN(DSr,res); 




y1=AS.getrooms();
y2= CS.setrooms(AS.getrooms());
y3 = BS.getrooms();
y4 = DS.setrooms(y3+y2);




y5 =DS.setrooms(BS.getrooms() + CS.setrooms(checkRooms(AS.getrooms()))) ;

y=DS.setrooms(BS.getrooms() + CS.setrooms(AS.getrooms())) ;

<<"%V $y $y1 $y2 $y3 $y4 $y5\n"


   chkN(y,y4); 


   ASr= AS.getrooms() ;
  <<"%V $ASr \n"

   res2= BS.getrooms() ;

<<"%V $BSr $res2 \n"

   chkN(BSr,res2);
   

   CSr= CS.getrooms() ;

<<"%V $CSr \n"
   Asr=AS.setrooms(CS.getrooms()) ;

  chkN(CSr,ASr);




  chkOut(1);
  

