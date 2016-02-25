Pi = 4.0 * Atan(1.0)

opendll("math")

// a table 
   <<"Deg \tRad \tSine\tCosine\tTangent \n"
   for (i = 0; i <= 180; i++) {
   a = i/180.0 * Pi   
   <<"%3d $i  %-8.6f $a $(Sin(a)) $(Cos(a)) $(Tan(a)) \n"

   }