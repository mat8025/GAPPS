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


<|Use_=
  demo test class member access 
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

allowErrors(-1) ; // keep going

//filterFileDebug(REJECT_,"scope_e","proc_e.cpp","ic_pushsivele.cpp","ic_pop.cpp");
//filterFuncDebug(REJECT_,"var_ptr");

  chkIn(_dblevel); 
  
  Nhouses = 0;
  
  Class house {
    
    int rooms; 
    int floors; 
    int area; 
    int number;
    
    Cmf setRooms(int val)
    {
      rooms = val;
     <<" $_proc  $_cobj set rooms  $val $rooms  for house $number  \n"; 
      return rooms; 
     }
    
    Cmf setfloors(int val) 
    {
      if (floors > 0) {
        floors = val; 
        area = floors * 200; 
        }
      return area; 
      }
    
    Cmf getRooms()
    {
      <<"$_proc %V  $_cobj $rooms for house  $number \n"
         return rooms;
    }
    
    Cmf print() 
    {
      <<" $_cobj has %V $floors and  $rooms $area\n"; 
      }
    
    
    Cmf house() 
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


   asr=  AS->getRooms();

  chkN(asr,4)

  bsr=  BS->getRooms();
  csr = CS->getRooms();

  res =AS->setRooms(BS->getRooms() + CS->getRooms())

 <<"%V $res $asr $bsr $csr \n"

  chkN(res,(bsr+csr))


    house C[10];


   C[1]->print();

   C[2]->print();

//exit()





   house D[6];


//<<" myhouse is $(typeof(&house)) \n" // TBF crash
  
  <<" myhouse is $(typeof(C)) \n"; 
  <<" myhouse is $(typeof(house)) \n"; 
  <<" myhouse is $(infoof(house)) \n"; 
  <<" myhouse is $(statusof(house)) \n"; 
  /*
    A=examine(C[0]);
    <<"$A\n"; 
    
    iread(); 
    A=examine(C[1]);
    <<"$A\n"; 
    
    iread(); 
   */
  <<"sz $(Caz(C)) \n"; 
  



  
  
  c2r = C[2]->getRooms(); 
  
  <<"house 2 has $c2r rooms \n"; 
  chkN(c2r,4)





  C[3]->setRooms(15); 
  
  y = C[3]->getRooms(); 
  
  <<"house 3 has $y rooms \n"; 
  
  a = 4; 
  
  C[a]->setRooms(17); 
    
  y = C[a]->getRooms(); 
  
  <<"house $a has $y rooms \n"; 
  
  x=C[a+1]->setRooms(19); 
    
  y = C[a+1]->getRooms(); 

 chkN(y,19); 

  <<"house ${a}+1 has $y rooms \n"; 


  a= 3; 
  
  y = C[a]->getRooms(); 
  
  <<"house $a has $y rooms \n"; 

  chkN(y,15); 

  y = C[a-1]->getRooms(); 
  
  <<"house $a -1 has $y rooms \n"; 
  
  
  x=C[a+1]->setRooms(C[a]->getRooms()); 
  
  <<"house ${a}+1 has $x rooms \n"; 

 chkN(x,15); 

  x=C[a+1]->setRooms(C[a-1]->getRooms()); 
  
  <<"house ${a}+1 has $x rooms \n"; 
  
  x=C[a]->setRooms(C[a-2]->getRooms()); 
  
  <<"house ${a} has $x rooms \n"; 
  
  x=C[a-2]->setRooms(22); 

  y=C[a]->setRooms(C[a-2]->getRooms()) ;

  chkN(y,22); 

  b = a-1;
  br =C[b]->getRooms();

<<"%V $b  $br\n"
   b= a;

  br =C[b]->getRooms();

<<"%V $b  $br\n"

  C[a-1]->setRooms(7);

 C[a]->setRooms(13);


  am1r =C[a-1]->getRooms();

  ar =C[a]->getRooms();

<<"%V $a  $am1r $ar\n"

  z2 = ar + am1r;

  z= C[a-1]->getRooms() + C[a]->getRooms() ;

<<"%V $a $z $z2\n"

!z





z3 = C[2]->getRooms() + C[3]->getRooms() ;
  b= a-1
  z4 = C[b]->getRooms() + C[a]->getRooms() ;
<<"%V $a $z $z3 $z4\n"

z2 = ar + am1r;

  chkN(z,z2)


ap1 = a +1;
am1 = a - 1;
  
  z3 = C[2]->getRooms() + C[3]->getRooms() ;
  
  y= C[a+1]->setRooms(C[a-1]->getRooms() + C[a]->getRooms()) ;

  y2= C[ap1]->setRooms(C[am1]->getRooms() + C[a]->getRooms()) ;

  
  y3=C[a+1]->setRooms(C[2]->getRooms() + C[3]->getRooms()) ;



<<"%V $y $y2 $y3 $z $z2 $z3 $am1r $ar\n"

  chkN(y2,(am1r+ar));

  chkN(y,(am1r+ar));

<<"house  $(a+1) has $y rooms \n"; 
!z


 chkN(y,20);


  y=C[a]->setRooms(C[a-2]->getRooms())




  a1r= C[1]->getRooms() ;
  <<"%V $a1r \n"



   a2r= C[2]->setRooms(11) ;
  <<"%V $a2r \n"

   a2r= C[2]->getRooms() ;
  <<"%V $a2r \n"

  a4r=C[4]->getRooms() ;

<<"%V $a4r\n"

  a4r=C[4]->setRooms( C[2]->getRooms()  ) ; //XIC wrong
  
//a4r=C[4]->setRooms( a2r ) ; 
<<"%V $a4r\n"

  a4r=C[4]->getRooms() ;

<<"%V $a2r $a4r\n"
 chkN(a4r,a2r);


  d2r = D[2]->getRooms()  ) ; 

  a5r=C[5]->setRooms( D[2]->getRooms() + C[2]->getRooms() ) ; 

 chkN(a5r,d2r+a2r);


  c1r = C[1]->getRooms()
  c2r = C[2]->getRooms()
  cr = C[2]->getRooms() + C[1]->getRooms() ;



  res=C[5]->setRooms( C[2]->getRooms() + C[1]->getRooms() ) ;

// fails since it sets C[1] instead pf C[4]   - xic works

//res=C[4]->setRooms( c1r + c2r ) ;

  c5r = C[5]->getRooms()

<<"%V $res $c2r $c1r $c5r $cr \n"
 chkN(res,33);
 chkN(c5r,33); 


  a1r= C[1]->getRooms() ;
  a2r= C[2]->getRooms() ;
  a3r= C[3]->getRooms() ;
  a6r= C[6]->getRooms() ;
  
  <<"%V $a1r $a2r $a3r $a6r\n"

  res=C[6]->setRooms( C[3]->setRooms(C[2]->getRooms()) + C[1]->getRooms()) ;

  a1r= C[1]->getRooms() ;
  a2r= C[2]->getRooms() ;
  a3r= C[3]->getRooms() ;
  a6r= C[6]->getRooms() ;
  <<"%V $a1r $a2r $a3r $a6r $res\n"

  chkN(res,33);
  chkN(a3r,11); 
  chkN(a6r,33); 



  res= C[7]->setRooms(C[2]->getRooms() + C[3]->setRooms(C[1]->getRooms())) ;

  a1r= C[1]->getRooms() ;
  a2r= C[2]->getRooms() ;
  a3r= C[3]->getRooms() ;
  a7r= C[7]->getRooms() ;
  
<<"%V $a1r $a2r $a3r $a7r $res\n"
  chkN(res,33);
  chkN(a3r,22); 
  chkN(a6r,33); 




   Ar= AS->setRooms(a1r))) ;
  <<"%V $Ar \n"

   Br= BS->setRooms(a2r))) ;
  <<"%V $Br \n"

  csr =   CS->setRooms(AS->getRooms())  ;

  res= DS->setRooms(BS->getRooms() + CS->setRooms(AS->getRooms()))  ;

  dsr = DS->getRooms()


<<"%V $Ar $Br $csr $dsr $res\n"
  chkN(res,33);
  chkN(res,dsr); 



 a1 = a+1;
 am1 = a-1;
 am2= a-2;

<<"%V $a $a1 $am1 $am2 \n"

  


  x1= C[a]->setRooms(C[a-2]->getRooms()) ;
  <<"%V $x1\n"
  x2=C[a-1]->getRooms()
  <<"%V $x2\n"
  x3 =C[a+1]->setRooms(x1+x2)
  <<"%V $x3\n"
  x=C[a+1]->setRooms(C[a-1]->getRooms() + C[a]->setRooms(C[a-2]->getRooms())) ;
    <<"%V $x\n"
 chkN(x,x3);


<<"%V $a   $am2\n"



x1=C[a]->setRooms(C[am2]->getRooms())) ;


<<"%V $x1\n"


x2 =C[am1]->getRooms() ;

x3 =C[a1]->setRooms(x1+x2)

x=C[a1]->setRooms(C[am1]->getRooms() + C[a]->setRooms(C[am2]->getRooms())) ;

<<"%V $x $x1 $x2 $x3 \n"

  <<"%V $x\n"
  chkN(x,x3); 

<<"%V $a $a1 $am1 $am2 \n"



  C[3]->setfloors(3); 
  C[5]->setfloors(9); 
  
  
  for (a= 0 ; a < 6 ; a++) {
    <<" $a "; 
    C[a]->print(); 
    
    }
  
  chkOut();



  exit(); 
  
  
  C[1]->setRooms(8); 
  C[1]->setfloors(3); 
  
  
  <<" obj 1 : \n"; 
  C[1]->print(); 
  <<" obj 2 : \n"; 
  C[2]->print(); 
  
  
  z= C[1]->getRooms(); 
  
  <<" obj 1 has  $z rooms \n"; 
  
  
  z= C[2]->getRooms(); 
  
  <<" obj 2 has  $z rooms \n"; 
  
  
