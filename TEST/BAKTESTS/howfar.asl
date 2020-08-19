setdebug(1)

//  nashville  N 36 7.2   W 86 40.2
//  los angeles N 33 56.4   W 118 24.0



  latA = 36 +  7.2/60.0
  lngA = - (86 +  40.2/60.0)


  latB = 33 + 56.4/60.0
  lngB = - (118 + 24/60.0)


  km = HowFar(latA,lngA,latB,lngB)


<<"%V$latA $lngA $latB $lngB  $km\n" 


  km = HowFar(latA,lngA,latB,lngB,2)


<<"%V$latA $lngA $latB $lngB  $km\n" 

  km = HowFar(latA,lngA,latB,lngB,3)


<<"%V$latA $lngA $latB $lngB  $km\n" 

  

  dlon = deg2rad((lngA - lngB))
  dlat = deg2rad((latA - latB))
  latA = deg2rad(latA)
  latB = deg2rad(latB)



  a = (cos(latB) * sin (dlon))

  b =  (cos(latA) * sin (latB)) - (sin(latA) * cos (latB) * cos(dlon))

  c = sqrt( a*a + b*b)

  d= sin(latA) * sin(latB) + cos(latA) * cos(latB) * cos (dlon)

  ang  = atan2(c,d)


  ang2 = atan2(sqrt( sqr(cos(latB) * sin (dlon))  + sqr((cos(latA) * sin (latB)) - (sin(latA) * cos (latB) * cos(dlon)))), \
                (sin(latA) * sin(latB) + cos(latA) * cos(latB) * cos (dlon)))




//  ang  = atan(c/d)

<<"%V$a $b $c $d $ang $ang2\n"

  D = 6371 * ang2

<<"%V$D \n"

