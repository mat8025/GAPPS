//%*********************************************** 
//*  @script rp2.asl 
//* 
//*  @comment test class member access 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Sun Mar  3 12:41:16 2019 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
  
  checkIn(_dblevel); 
  
  Nhouses = 0;
  
  class house {
    
    int rooms; 
    int floors; 
    int area; 
    int number;
    
    cmf setrooms(int val); 
    {
      rooms = val;
     <<" $_proc  $_cobj set rooms  $rooms  for house $number  \n"; 
      return rooms; 
     }
    
    cmf setfloors(int val); 
    {
      if (floors > 0) {
        floors = val; 
        area = floors * 200; 
        }
      return area; 
      }
    
    cmf getrooms(); 
    {
      <<"$_proc %V  $_cobj $rooms for house  $number \n"
         return rooms;
    }
    
    cmf print(); 
    {
      <<" $_cobj has %V $floors and  $rooms $area\n"; 
      }
    
    
    cmf house(); 
    {
      floors = 2; 
      rooms = 4; 
      area = floors * 200;
      number= Nhouses;
      <<"cons $Nhouses for $_cobj setting  $floors  $rooms $area $number\n"; 
      Nhouses++;
      }
    
    }
  
  <<" after our class definition \n"; 
    house AS;
    house BS;
    house CS;
    house DS;    


   asr=  AS->getrooms();

  checkNum(asr,4)

  bsr=  BS->getrooms();
  csr = CS->getrooms();

  res =AS->setrooms(BS->getrooms() + CS->getrooms())

 <<"%V $res $asr $bsr $csr \n"

  checkNum(res,(bsr+csr))




    house C[10];

    house D[6];


//<<" myhouse is $(typeof(&house)) \n" // TBF crash
  
  <<" myhouse is $(typeof(C)) \n"; 
  <<" myhouse is $(typeof(house)) \n"; 
  <<" myhouse is $(infoof(house)) \n"; 
  <<" myhouse is $(statusof(house)) \n"; 
  /{
    A=examine(C[0]);
    <<"$A\n"; 
    
    iread(); 
    A=examine(C[1]);
    <<"$A\n"; 
    
    iread(); 
    /}
  <<"sz $(Caz(C)) \n"; 
  



  C[1]->print(); 
  
  c2r = C[2]->getrooms(); 
  
  <<"house 2 has $c2r rooms \n"; 
  checkNum(c2r,4)





  C[3]->setrooms(15); 
  
  y = C[3]->getrooms(); 
  
  <<"house 3 has $y rooms \n"; 
  
  a = 4; 
  
  C[a]->setrooms(17); 
    
  y = C[a]->getrooms(); 
  
  <<"house $a has $y rooms \n"; 
  
  x=C[a+1]->setrooms(19); 
    
  y = C[a+1]->getrooms(); 

 checkNum(y,19); 

  <<"house ${a}+1 has $y rooms \n"; 


  a= 3; 
  
  y = C[a]->getrooms(); 
  
  <<"house $a has $y rooms \n"; 

  checkNum(y,15); 

  y = C[a-1]->getrooms(); 
  
  <<"house $a -1 has $y rooms \n"; 
  
  
  x=C[a+1]->setrooms(C[a]->getrooms()); 
  
  <<"house ${a}+1 has $x rooms \n"; 

 checkNum(x,15); 

  x=C[a+1]->setrooms(C[a-1]->getrooms()); 
  
  <<"house ${a}+1 has $x rooms \n"; 
  
  x=C[a]->setrooms(C[a-2]->getrooms()); 
  
  <<"house ${a} has $x rooms \n"; 
  
  x=C[a-2]->setrooms(22); 

  y=C[a]->setrooms(C[a-2]->getrooms()) ;

  checkNum(y,22); 


  am1r =C[a-1]->getrooms();
  ar =C[a]->getrooms();
  <<"%V $am1r $ar\n"
  
  y=C[a+1]->setrooms(C[a-1]->getrooms() + C[a]->getrooms()) ;

 checkNum(y,(am1r+ar));
 
  y=C[a]->setrooms(C[a-2]->getrooms())

<<"house  $a has $y rooms \n"; 
 checkNum(y,22);

  a1r= C[1]->getrooms() ;
  <<"%V $a1r \n"



   a2r= C[2]->setrooms(11) ;
  <<"%V $a2r \n"

   a2r= C[2]->getrooms() ;
  <<"%V $a2r \n"

  a4r=C[4]->getrooms() ;

<<"%V $a4r\n"

  a4r=C[4]->setrooms( C[2]->getrooms()  ) ; //XIC wrong
  
//a4r=C[4]->setrooms( a2r ) ; 
<<"%V $a4r\n"

  a4r=C[4]->getrooms() ;

<<"%V $a2r $a4r\n"
 checkNum(a4r,a2r);

checkOut()
  d2r = D[2]->getrooms()  ) ; 

  a5r=C[5]->setrooms( D[2]->getrooms() + C[2]->getrooms() ) ; 

 checkNum(a5r,d2r+a2r);


  c1r = C[1]->getrooms()
  c2r = C[2]->getrooms()
  cr = C[2]->getrooms() + C[1]->getrooms() ;



  res=C[5]->setrooms( C[2]->getrooms() + C[1]->getrooms() ) ;

// fails since it sets C[1] instead pf C[4]   - xic works

//res=C[4]->setrooms( c1r + c2r ) ;

  c5r = C[5]->getrooms()

<<"%V $res $c2r $c1r $c5r $cr \n"
 checkNum(res,33);
 checkNum(c5r,33); 


  a1r= C[1]->getrooms() ;
  a2r= C[2]->getrooms() ;
  a3r= C[3]->getrooms() ;
  a6r= C[6]->getrooms() ;
  
  <<"%V $a1r $a2r $a3r $a6r\n"

  res=C[6]->setrooms( C[3]->setrooms(C[2]->getrooms()) + C[1]->getrooms()) ;

  a1r= C[1]->getrooms() ;
  a2r= C[2]->getrooms() ;
  a3r= C[3]->getrooms() ;
  a6r= C[6]->getrooms() ;
  <<"%V $a1r $a2r $a3r $a6r $res\n"

  checkNum(res,33);
  checkNum(a3r,11); 
  checkNum(a6r,33); 



  res= C[7]->setrooms(C[2]->getrooms() + C[3]->setrooms(C[1]->getrooms())) ;

  a1r= C[1]->getrooms() ;
  a2r= C[2]->getrooms() ;
  a3r= C[3]->getrooms() ;
  a7r= C[7]->getrooms() ;
  
<<"%V $a1r $a2r $a3r $a7r $res\n"
  checkNum(res,33);
  checkNum(a3r,22); 
  checkNum(a6r,33); 




   Ar= AS->setrooms(a1r))) ;
  <<"%V $Ar \n"

   Br= BS->setrooms(a2r))) ;
  <<"%V $Br \n"

  csr =   CS->setrooms(AS->getrooms())  ;

  res= DS->setrooms(BS->getrooms() + CS->setrooms(AS->getrooms()))  ;

  dsr = DS->getrooms()


<<"%V $Ar $Br $csr $dsr $res\n"
  checkNum(res,33);
  checkNum(res,dsr); 



  checkOut()


 a1 = a+1;
 am1 = a-1;
 am2= a-2;

<<"%V $a $a1 $am1 $am2 \n"

  


  x= C[a]->setrooms(C[a-2]->getrooms()) ;

  x=C[a+1]->setrooms(C[a-1]->getrooms() + C[a]->setrooms(C[a-2]->getrooms())) ;
 checkNum(x,26);
 

  x=C[a1]->setrooms(C[am1]->getrooms() + C[a]->setrooms(C[am2]->getrooms())) ;
  <<"%V $x\n"
  checkNum(x,26); 

<<"%V $a $a1 $am1 $am2 \n"



  C[3]->setfloors(3); 
  C[5]->setfloors(9); 
  
  
  for (a= 0 ; a < 6 ; a++) {
    <<" $a "; 
    C[a]->print(); 
    
    }
  
  checkOut(); 
  exit(); 
  
  
  C[1]->setrooms(8); 
  C[1]->setfloors(3); 
  
  
  <<" obj 1 : \n"; 
  C[1]->print(); 
  <<" obj 2 : \n"; 
  C[2]->print(); 
  
  
  z= C[1]->getrooms(); 
  
  <<" obj 1 has  $z rooms \n"; 
  
  
  z= C[2]->getrooms(); 
  
  <<" obj 2 has  $z rooms \n"; 
  
  
