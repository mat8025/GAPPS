setdebug(0)

float Alt[]
float Tim[]
float DB[]
float LPDB[]
float FP[]

 k = 0

// at 5 sec int
 
  alt = 0.0
  tim = 0.0
  roc = 0.0

  rocs = roc/60.0

  for (i = 0; i < 20; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


//<<"%V$k $tim $alt $Tim[k-1] $Alt[k-1]\n"


  roc = 50
  rocs = roc/60.0
  for (i = 0; i < 5; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 







  roc = 100
  rocs = roc/60.0
  for (i = 0; i < 10; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


  roc = 500
  rocs = roc/60.0
  for (i = 0; i < 10; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 



  roc = 1000
  rocs = roc/60.0
  for (i = 0; i < 20; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


  roc = 2000
  rocs = roc/60.0
  while (alt < 23000) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


  roc = 1000
  rocs = roc/60.0
  while (alt < 24000) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 

  roc = 500
  rocs = roc/60.0
  while (alt < 24500) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 

  roc = 200
  rocs = roc/60.0
  while (alt < 24800) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


  roc = 100
  rocs = roc/60.0
  for (i = 0; i < 10; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


  roc = 50
  rocs = roc/60.0
  while (alt < 25000) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 

  roc = 0
  rocs = roc/60.0
  for (i = 0; i < 600; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 

  roc = -100
  rocs = roc/60.0
  for (i = 0; i < 10; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 

  roc = -200
  rocs = roc/60.0
  for (i = 0; i < 10; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 

  roc = -500
  rocs = roc/60.0
  for (i = 0; i < 20; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


  roc = -1000
  rocs = roc/60.0
  for (i = 0; i < 30; i++) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


  roc = -2000
  rocs = roc/60.0
  while (alt > 3000) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


  roc = -1000
  rocs = roc/60.0
  while (alt > 1000) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 

  roc = -500
  rocs = roc/60.0
  while (alt > 500) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


  roc = -200
  rocs = roc/60.0
  while (alt > 50) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 


  roc = -50
  rocs = roc/60.0
  while (alt > 0) {
     Tim[k] = tim
     tim++;
     alt += rocs
     Alt[k] = alt; 
     k++;
  } 



// produce flight-phase 
   lp_delta_baro = 0.0
   delta_baro = 0.0
   B1  = 0.0
   Beta = 0.0
   last_baro = 0.0
   last_tim = 0.0
   flight_phase = 0.0
   int fast_change = 0
   int kfc = 0
  for (i =0 ; i < k ; i++) {

      alt = Alt[i]
      tim = Tim[i]      

      delta_baro = alt - last_baro
      last_baro =  alt

      dsecs = tim - last_tim
      last_tim = tim

      if (dsecs == 0.0)
          delta_baro = 0
      else
          delta_baro = delta_baro * 60.0/dsecs

//        B1 = dsecs/ 60.0

      B1 = dsecs/ 240.0
      B1 *= 0.0625

      if ((lp_delta_baro * delta_baro) < 0.0)  {
           fast_change += 1
           kfc++
      }
      else
           fast_change -= 1



      if (fast_change > 4)
       Beta = B1 * 4
      else
       Beta = B1 


    if (fast_change > 4)
        fast_change = 4 

    if (fast_change < 0)
        fast_change = 0 


      lp_delta_baro = lp_delta_baro + Beta * (delta_baro - lp_delta_baro)

      flight_phase = lp_delta_baro  * 0.002  // for 500'
    //   flight_phase = lp_delta_baro  * 0.001  // for 1000'

     if (flight_phase > 1.0)
            flight_phase = 1.0

     if (flight_phase < -1.0)
            flight_phase = -1.0
 

    if (i < 100) {
      <<[2]"%V$i $alt $tim $delta_baro $lp_delta_baro $B1 $Beta $flight_phase \n"
     }

      DB[i] = delta_baro
      LPDB[i] = lp_delta_baro
      FP[i] = flight_phase


   }


<<[2]"%V$kfc \n"


//<<"%V$k $tim $alt \n"

<<"#col_headings Tim Alt DB LPDB FP \n"


   for (i =0 ; i < k ; i++) {

       <<"$Tim[i] $Alt[i] $DB[i] $LPDB[i] $FP[i] \n"

   }


stop!

