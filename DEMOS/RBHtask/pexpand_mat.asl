///
///
///


   Mat R(DOUBLE_,10,7);


   R[1][2] = 787.0
      R[2][2] = 999.0
      R[3][2] = 451.0      
   
   R.pinfo()


<<" $R \n"

 double Lon[12]
 Lon.pinfo()
 
 Lon = R[::][2]
 Lon.pinfo()
 Lon.redimn()
  Lon.pinfo()
  
   Lon[5] =555;  // TBF when 2d [10][1]  not put in correct ele
   Lon[6] = 666;   

  Lon[11] =371;
  
 <<">> $Lon \n"

 <<"%(1,>>, ,<<\n) $Lon \n"
C=ofw("rbh_lon")
<<[C]"%(1,>>,:,<<\n)$Lon \n"

 Lon.pinfo()
 
 ;

///
///
///