/* 
 *  @script rp2.asl                                                     
 * 
 *  @comment test class member access                                   
 *  @release Boron                                                      
 *  @vers 1.4 Be Beryllium [asl 5.83 : B Bi]                            
 *  @date 02/09/2024 06:16:17                                           
 *  @cdate 1/1/2003                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 




<|Use_=
  demo test class member access 
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

allowErrors(-1) ; // keep going


  chkIn(_dblevel); 
  
int db_ask = 0; // set to zero for no ask
int db_step = 0; // set to zero for no step
int db_allow = 0; // set to zero for internal debug print

  allowDB("ic,oo,spe_proc", 0)

  Nhouses = 0;

  Class house {
    
    int rooms; 
    int floors; 
    int area; 
    int number;
    
    int setRooms(int val)
    {
      rooms = val;
    <<" $_proc  $_cobj set rooms  $val $rooms  for house $number  \n"; 
      return rooms; 
     }
    
    int setfloors(int val) 
    {
      if (floors > 0) {
        floors = val; 
        area = floors * 200; 
        }
      return area; 
      }
    
    int getRooms()
    {
      <<"$_proc getRooms %V  $_cobj $rooms for house  $number \n"
         int nrooms = rooms;
	 // TBF  return rooms  - does not get the correct house -- offset into house array wrong
         return rooms;
    }
    
    void print() 
    {
      <<" $_cobj has %V $floors and  $rooms $area\n"; 
    }
    
    
    void house() 
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



    house C[10];

   C[1].print();

   C[2].print();



 //ans=ask("%V $__LINE__  ynq [y]\n",db_ask);

 DBaction((DBSTEP_),db_step)

 
 allowDB("array,spe_proc,parse,ic,oo",db_allow)

  c2r = C[2].getRooms(); 



  <<"house 2 has $c2r rooms \n"; 
  chkN(c2r,4)

  C[3].setRooms(15); 
  
  y = C[3].getRooms(); 
  
  <<"house 3 has $y rooms \n";

  chkN(y,15)




  chkStage("get set rooms")





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


  
  a = 4; 
  
  C[a].setRooms(17); 

 <<"house $a set  to 17 rooms \n"; 

  y = C[a].getRooms(); 

 ans=ask("%V $y  $a $__LINE__  ynq [y]\n",db_ask);

  <<"house $a has $y rooms \n"; 

   x=C[4].setRooms(29); 

  y = C[4].getRooms(); 

 chkN(y,x);

  y = C[a].getRooms(); 



ans=ask("%V $y  $__LINE__  ynq [y]\n",db_ask);

  x=C[a+1].setRooms(19); 
    
  y = C[a+1].getRooms(); 

 chkN(y,19); 

  <<"house ${a}+1 has $y rooms \n"; 


  a= 3; 
  
  y = C[a].getRooms(); 
  
  <<"house $a has $y rooms \n"; 

  chkN(y,15); 

  y = C[a-1].getRooms(); 
  
  <<"house $a -1 has $y rooms \n"; 
  
  chkStage("[a-1] ")

  ar2 = = C[a+1].getRooms();

  ar = C[a].getRooms();

<<" do the problem state\n"
allowDB("ic,oo,spe", 0)
  x=C[a+1].setRooms(C[a].getRooms()); 
  
  <<"house $a has $ar rooms   sets   ${a}+1 had $ar2 now has $x rooms \n"; 

 chkN(x,15);
 




  x=C[a+1].setRooms(C[a-1].getRooms()); 
  
  <<"house ${a}+1 has $x rooms \n"; 
  
  x=C[a].setRooms(C[a-2].getRooms()); 
  
  <<"house ${a} has $x rooms \n"; 
  
  x=C[a-2].setRooms(22); 

  y=C[a].setRooms(C[a-2].getRooms()) ;

  chkN(y,22); 

  b = a-1;
  br =C[b].getRooms();

<<"%V $b  $br\n"
   b= a;

  br =C[b].getRooms();

<<"%V $b  $br\n"

  C[a-1].setRooms(7);

 C[a].setRooms(13);



 allowDB("array,spe_proc,parse,ic,oo",db_allow)

  am1r =C[a-1].getRooms();

  ar =C[a].getRooms();

<<"%V $a  $am1r $ar\n"

  z2 = ar + am1r;

  z= C[a-1].getRooms() + C[a].getRooms() ;

<<"%V $a $z $z2\n"


  chkN(z,z2)

 ans=ask("%V $z $z2  $__LINE__  ynq [y]\n",db_ask);

//chkOut(1)

  c2r =  C[2].getRooms()
  c3r =  C[3].getRooms()   

  z3 = C[2].getRooms() + C[3].getRooms() ;


 chkN(z3,c2r+c3r)

  chkStage(" C[2].getRooms() + C[3].getRooms()")

 //ans=ask("%V  $c2r $c3r $z3 $__LINE__  ynq [y]\n",db_ask)
    

  b= a-1
  
  z4 = C[b].getRooms() + C[a].getRooms() ;




  ap1 = a +1;


  am1 = a - 1;

<<"%V $ap1 $am1 \n"

  z3 = C[2].getRooms() + C[3].getRooms() ;
  
  am1r = C[am1].getRooms() ;
 // y= C[ap1].setRooms(C[am1].getRooms() + C[a].getRooms()) ;

  ar = C[a].getRooms() ;



  y= C[ap1].setRooms(C[a].getRooms() + C[am1].getRooms()) ;


  w =  C[ap1].getRooms() ;

  chkN(y,w)

  ans=ask("%V  $y $w $am1r + $ar  ynq [y]\n",db_ask);
  

  //chkOut(1)
  


  am1c = C[a-1].getRooms() ;

  c3r= C[3].getRooms() ;

  ar = C[a].getRooms()) ;

 //ans=ask("%V  $am1r + $am1c $c3r $ar ynq [y]\n",,db_ask)
 
  chkN(am1r,am1c)





  chkN(y,(am1r+ar));


  ans=ask("%V  $y $am1r + $ar  ynq [y]\n",db_ask)

  y2 = C[a+1].setRooms(C[2].getRooms() + C[3].getRooms()) ;

  y3 = C[a+1].setRooms(C[a-1].getRooms() + C[a].getRooms()) ;  

<<"%V $y $y2 $y3  $z $z2 $z3 $am1r $ar $a\n"

   ans=ask("%V $y $y2 $y3 $am1r + $ar  ynq [y]\n",db_ask);

  chkN(y,y2)

  chkN(y2,y3)


  chkN(y,(am1r+ar));

<<"house  $(a+1) has $y rooms \n"; 


  chkN(y,20);
  


  chkStage(" two cmf args")

//  chkOut(1)
  

/////////////////

  y=C[a].setRooms(C[a-2].getRooms())

  car = C[a].getRooms()

  chkN(car,y)

<<" $car $y \n"



  a1r= C[1].getRooms() ;

<<"%V $a1r \n"

ans=ask("%V  $a1r   yn!q [y]\n",db_ask)


   w2r= C[2].setRooms(11) ;

   a2r= C[2].getRooms() ;


ans=ask("%V  $w2r $a2r   yn!q [y]\n",db_ask)


  a4r=C[4].getRooms() ;

<<"%V $a4r\n"

  a4sr=C[4].setRooms( C[2].getRooms()  ) ; //XIC wrong
  
//a4r=C[4].setRooms( a2r ) ; 

<<"%V $a4sr\n"

  a4r=C[4].getRooms() ;
  c2r = C[2].getRooms()
  chkN(a4r,a4sr)


  ans=ask("%V  $a2r $a4sr $a4r $c2r $__LINE__  ynq [y]\n",db_ask);

  chkN(a4r,a2r);
  

 allowDB("array,spe_proc,ic",db_allow)




  d2r = D[2].getRooms()  ; 

  w2r = C[2].getRooms()

  c5rb= C[5].getRooms()

  a5r=C[5].setRooms( D[2].getRooms() + C[2].getRooms() ) ; 

 chkN(a5r,d2r+a2r);


  c1r = C[1].getRooms()
  c2r = C[2].getRooms()
  c5r= C[5].getRooms()
  d2rb = D[2].getRooms()  ;
  
ans=ask("%V  $d2r $d2rb $w2r $a5r $c2r $c5rb $c5r  ynq [y]\n",db_ask)

  chkN(w2r,c2r)
  
ans=ask("%V   $c2r $w2r  ynq [y]\n",db_ask)

//chkOut(1)
  

  car = C[2].getRooms() + C[1].getRooms() ;

  w2 = c1r + c2r

  res=C[5].setRooms( C[2].getRooms() + C[1].getRooms() ) ;

// fails since it sets C[1] instead pf C[4]   - xic works
   c5r = C[5].getRooms()
  
ans=ask("%V  $res $c5r $w2 $car ynq [y]\n",db_ask);
//res=C[4].setRooms( c1r + c2r ) ;



<<"%V $res $c2r $c1r $c5r  $w2 $car \n"
 chkN(res,w2);
 chkN(c5r,w2);


  ans=ask("%V  $res $c5r $w2  ynq [y]\n",db_ask);




C[1].setRooms(11) ;
C[2].setRooms(22) ;
C[3].setRooms(33) ;
C[4].setRooms(44) ;
C[5].setRooms(55) ;
C[6].setRooms(66) ;

  a1r= C[1].getRooms() ;
  a2r= C[2].getRooms() ;
  a3r= C[3].getRooms() ;
  a4r= C[4].getRooms() ;
  a5r= C[5].getRooms() ;    
  a6r= C[6].getRooms() ;
  
  <<"%V $a1r $a2r $a3r $a4r $a5r $a6r\n"

  ans=ask("%V  $a1r $a2r $a3r $a4r $a5r $a6r \n",db_ask);
  chkN(a1r,11)
  chkN(a2r,22)
  chkN(a3r,33)
  


  res=C[6].setRooms( C[3].setRooms(C[2].getRooms()) + C[1].getRooms()) ;

  ans=ask("%V  $a1r $a2r $a3r $a4r $a5r $a6r \n",db_ask);
  
  a1r= C[1].getRooms() ;
  a2r= C[2].getRooms() ;
  a3r= C[3].getRooms() ;
  a4r= C[4].getRooms() ;
  a5r= C[5].getRooms() ;  
  a6r= C[6].getRooms() ;

  ans=ask("%V  $a1r $a2r $a3r $a4r $a5r $a6r \n",db_ask);

  <<"%V $a1r $a2r = $a3r $a6r = $a2r +$a3r  = $a6r ==  $res\n"

  chkN(res,33);
  
  chkN(a3r,22);
  
  chkN(a6r,33);
  
  ans=ask("%V  $res $a6r  \n",db_ask);


  
  res= C[7].setRooms(C[2].getRooms() + C[3].setRooms(C[1].getRooms())) ;

  a1r= C[1].getRooms() ;
  a2r= C[2].getRooms() ;
  a3r= C[3].getRooms() ;
  a7r= C[7].getRooms() ;
  
<<"%V $a1r $a2r $a3r $a7r $res\n"
  chkN(res,33);
  chkN(a3r,11); 
  chkN(a6r,33); 




    house AS;
    house BS;
    house CS;
    house DS;    


   asr=  AS.getRooms();

  chkN(asr,4)

  bsr=  BS.getRooms();
  res = CS.setRooms(5)
  csr = CS.getRooms();

  res =AS.setRooms(bsr + csr)

  chkN(res,(bsr+csr))


  res =AS.setRooms( BS.getRooms() + CS.getRooms() )

 <<"%V $res $asr $bsr $csr \n"

  chkN(res,(bsr+csr))
  
//ans=ask("%V $db_ask $__LINE__  ynq [y]\n",1);

 chkStage ("get plus")


   Ar= AS.setRooms(a1r))) ;
  <<"%V $Ar \n"

   Br= BS.setRooms(a2r))) ;
  <<"%V $Br \n"

  csr =   CS.setRooms(AS.getRooms())  ;

  res= DS.setRooms(BS.getRooms() + CS.setRooms(AS.getRooms()))  ;

  dsr = DS.getRooms()


<<"%V $Ar $Br $csr $dsr $res\n"
  chkN(res,33);
  chkN(res,dsr); 



 a1 = a+1;
 am1 = a-1;
 am2= a-2;

<<"%V $a $a1 $am1 $am2 \n"

  


  x1= C[a].setRooms(C[a-2].getRooms()) ;
  <<"%V $x1\n"
  x2=C[a-1].getRooms()
  <<"%V $x2\n"
  x3 =C[a+1].setRooms(x1+x2)
  <<"%V $x3\n"
  x=C[a+1].setRooms(C[a-1].getRooms() + C[a].setRooms(C[a-2].getRooms())) ;
    <<"%V $x\n"
 chkN(x,x3);


<<"%V $a   $am2\n"



x1=C[a].setRooms(C[am2].getRooms())) ;


<<"%V $x1\n"


x2 =C[am1].getRooms() ;

x3 =C[a1].setRooms(x1+x2)

x=C[a1].setRooms(C[am1].getRooms() + C[a].setRooms(C[am2].getRooms())) ;

<<"%V $x $x1 $x2 $x3 \n"

  <<"%V $x\n"
  chkN(x,x3); 

<<"%V $a $a1 $am1 $am2 \n"



  C[3].setfloors(3); 
  C[5].setfloors(9); 
  
  
  for (a= 0 ; a < 6 ; a++) {
    <<" $a "; 
    C[a].print(); 
    
    }
  
  
  
  C[1].setRooms(8); 
  C[1].setfloors(3); 
  
  
  <<" obj 1 : \n"; 
  C[1].print(); 
  <<" obj 2 : \n"; 
  C[2].print(); 
  
  
  z= C[1].getRooms(); 
  
  <<" obj 1 has  $z rooms \n"; 
  
  
  z= C[2].getRooms(); 
  
  <<" obj 2 has  $z rooms \n"; 

  chkStage("OK?");

  chkOut(1)


////







