///
///
///

  data_file = GetArgStr()

  if (data_file @= "") {
    data_file = "bike.tsv"  // open turnpoint file 
   }


<<"using $data_file\n"

  A=ofr(data_file)

  B=ofw("rbh_junk")

 // C=ofw("rbh_tim")  ; // TBF crash

  if (A == -1) {
    <<" can't find data file \n"
     exit();
  }

  <<" $A\n"

  double  D[100][10]

 D.pinfo()

// Record R;  // type not yet set - can be Svar,DOUBLE,INT ...



  // triple, tuple ... int*
  
  D.readRecord(A,_RTYPE,DOUBLE_,_RDEL,-1,_RPICKCOND,">",0,0,_RPICKCOND,">",6,0)

  sz = Caz(D);

  D.pinfo()

<<"%V $sz\n"

  bd = Cab(D)

<<"%V  $bd \n"
!a
<<" $(Cab(D)) \n" ; //  TBF

<<"%V $D[0][1]\n"



  <<"%V $D[0][2]\n"
  <<"%V $D[0][3]\n"

  <<"%V $D[0:5:1][2] \n" ; // TBF

  <<[B]"$D\n"

  D.pinfo()

   val = D[1][1]

<<"%V $val\n"

!a


 long Tim[200]
 Tim.pinfo()


 Tim = D[::][0]  ;

 Tim->redimn()

<<"Tim $Tim[0]\n"
<<"Tim $Tim[1]\n"  ; // TBF  every other??
<<"Tim $Tim[2]\n"

 Tim.pinfo()

  C=ofw("rbh_tim")

<<[C]" $Tim \n"
   cf(C)
   
!a

 double Lat[200]

 Lat = D[::][1]

<<"Lat $Lat[0]\n"
<<"Lat $Lat[1]\n"  ; // TBF  09/24/23 every other?? 

  C=ofw("rbh_lat")

<<[C]" $Lat \n"
   cf(C)

  cf(A)


!a

   A=ofr(data_file)

   Mat R(DOUBLE_,200,10);

   R.pinfo()


  
  R.readRecord(A,_RTYPE,DOUBLE_,_RDEL,-1,_RPICKCOND,">",0,0,_RPICKCOND,">",6,0)

  sz = Caz(R);

  R.pinfo()

<<"%V $sz\n"

  bd = Cab(R)

<<"%V  $bd \n"

  val = R[0][1]

<<"%V $val\n"


 double Lon[200]

 Lon = R[::][2]

<<"Lon $Lon[0]\n"
<<"Lon $Lon[1]\n"  ; // TBF  09/24/23 every other?? 

  C=ofw("rbh_lon")

<<[C]" $Lon \n"
   cf(C)


///////