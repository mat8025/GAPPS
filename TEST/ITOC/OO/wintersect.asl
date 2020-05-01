//%*********************************************** 
//*  @script wintersect.asl
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






proc wintersect(Rect vpA,Rect vpB)
{

  overlap = 1;

       
          if (vpA->x > vpB->X) {
	    overlap = 0;
	  }
	  else if (vpB->x > vpA->X) {
	    overlap = 0;
	  }
	  else if (vpA->y > vpB->Y) {
	    overlap = 0;
	  }
	  else if (vpB->y > vpA->Y) {
	    overlap = 0;
	  }
vpA->print()

   <<"$_proc %V $overlap \n"
          return overlap;
}
//=============================//


// TBF  bug global X overshadows the local class X
// TBF  xic proc class arg fails

Class Rect
{

 public:
  int x;
  int y;
  int X;
  int Y;
  int rwid;

  CMF setWid(id)
  {
       rwid = id;
  }
  CMF set(xi,yi,Xi,Yi)
  {
    x=xi;
    y=yi;
    X=Xi;
    Y=Yi;    
  }

  CMF print()
  {

   <<"Rect:$rwid %V $x $y $X $Y \n"

  }

  // same name as class - is the construtor
  CMF Rect()
  {
   x= -1;
   X= -1;
   y= -1;
   Y= -1;
   rwid = -1;
  }

};

vp2=8
vp3=9
Rect vpR2;
vpR2->setWid(vp2)
vpR2->set(20,10,30,20)
vpR2->set(10,10,20,20)

vpR2->print()


Rect vpR3;
vpR3->setWid(vp3)
vpR3->set(12,12,18,18)

vpR3->print()

vp2c=1
vp3c=0;


proc chkWin()
{
coveredbyB = 1;

          if (vpR2->x > vpR3->X) {
  <<"NWI x>X $vpR2->x > $vpR3->X \n"
            coveredbyB = 0;
	  }
	  
	   if (vpR3->x > vpR2->X) {
  <<"NWI x>X $vpR3->x > $vpR2->X \n"	  
	    coveredbyB = 0;
	  }
	   if (vpR2->y > vpR3->Y) {
  <<"NWI y>Y $vpR2->y > $vpR3->Y \n"
            coveredbyB = 0;
	  }
	  if (vpR3->y > vpR2->Y) {
  <<"NWI y>Y $vpR3->y > $vpR2->Y \n"	  
	    coveredbyB = 0;
	  }


<<"%V $coveredbyB \n"

       ovl = wintersect(vpR3,vpR2)
  <<"win2 win3 intersect? ! vp2 intersects vp3 ? $ovl \n"	  



          complete =0;
           if ((vpR2->x <= vpR3->x) && (vpR2->X >= vpR3->X)) {
             if ((vpR2->y <= vpR3->y) && (vpR2->Y >= vpR3->Y)) {
               complete =1;
               if (vp3c) {
                 <<"Win$vp2 completely covers Win$vp3\n"
               }
	       else {
                   <<"Win$vp3 is completely inside of Win$vp2\n"
               }
             }
           }
           if (!complete) {
           if ((vpR2->x >= vpR3->x) && (vpR2->X <= vpR3->X)) {
             if ((vpR2->y >= vpR3->y) && (vpR2->Y <= vpR3->Y)) {
               complete =1;
                 if (vp2c) {
                  <<"Win$vp3 completely covers Win$vp2\n"
                 }
		 else {
                    <<"Win$vp2 is completely inside of Win$vp3\n"
                 }
		 
                 }
           }
          }





vpR2->print()
vpR3->print()
       return ovl;
}

//=================================//
    checkIn();
    is_ovl = chkWin();

    ok=checkTrue(is_ovl)
<<"%V $is_ovl $ok \n"

vpR2->x = 20
vpR2->X= vpR2->x +10

    is_ovl = chkWin()


 ok=checkFalse(is_ovl)
<<"%V $is_ovl $ok\n"

vpR2->x = 0
vpR2->X= vpR2->x +10

   is_ovl = chkWin()
<<"%V $is_ovl \n"
 checkFalse(is_ovl)

   CheckOut();