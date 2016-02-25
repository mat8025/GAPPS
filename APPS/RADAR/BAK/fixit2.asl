

float Alt[5000]
float Tim[]
float DB[]
float LPDB[]
float FP[5000]

 k = 0

// so read in Tim and Alt

A = 0  // read on stdio


   lp_delta_baro = 0.0
   delta_baro = 0.0
   B1  = 0.0
   Beta = 0.0
   last_baro = 0.0
   last_tim = 0.0
   flight_phase = 0.0
   int fast_change = 0
   int kfc = 0


  for (i =0 ; i < 10 ; i++) {

       Alt[i] = i * 2
       Tim[i] = i      
       delta_baro = i +3
       DB[i] = delta_baro

      flight_phase = delta_baro * 0.1

      FP[i] = flight_phase

      DB[i] = delta_baro
      LPDB[i] = lp_delta_baro

      FP[i] = flight_phase

      DB[i] = delta_baro


      LPDB[i] = lp_delta_baro


<<"$i $Tim[i] $Alt[i] $DB[i] $FP[i]\n"

 }

<<"\n"

  for (i =0 ; i < 10 ; i++) {

  <<"$i $Tim[i] $Alt[i] $DB[i] $LPDB[i]  $FP[i]\n"

 }





/{

  R = ReadRecord(A,@type,FLOAT,@NCOLS,ncols)

  sz = Caz(R) ;  dmn = Cab(R) ; nrows = dmn[0]; ncols = dmn[1]

<<"%V$sz   $nrows $ ncols \n"

  Tim = R[::][0]
  Alt = R[::][1]

/}


// produce flight-phase 


TCR = 500
MCR = 100



<<"here \n"

  for (i =0 ; i < 10 ; i++) {

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

    // limit delta_baro
    // is TCR 500 a sufficient climb?


        if (delta_baro > TCR)
            delta_baro = TCR

        if (delta_baro < -TCR)
            delta_baro = -TCR

/{
        if ((delta_baro < MCR) && (delta_baro > 0))
             delta_baro = 0

        if ((delta_baro < 0) && (delta_baro > -MCR))
             delta_baro = 0
/}


// 240 is about right

       Beta = dsecs/ (240)


// low pass -- change in  filter output proportional to difference beteen current and last input
 
      lp_delta_baro = lp_delta_baro + Beta * (delta_baro - lp_delta_baro)

      flight_phase = lp_delta_baro  * 0.002  // for 500'

    //   flight_phase = lp_delta_baro  * 0.001  // for 1000'


     if (flight_phase > 1.0)
            flight_phase = 1.0

     if (flight_phase < -1.0)
            flight_phase = -1.0


      <<"$tim $alt $delta_baro $lp_delta_baro $flight_phase \n"

      FP[i] = flight_phase

      <<"%V$FP[i] $flight_phase \n"
      j = i
      DB[j] = delta_baro


      <<"%V$DB[j] $delta_baro \n"

      LPDB[i] = lp_delta_baro
 
      <<"%V$LPDB[i] $lp_delta_baro \n"


    if (i < 1000) {
      <<[2]"%V$i $alt $tim $delta_baro $lp_delta_baro $B1 $Beta $flight_phase \n"
       <<[2]"$Tim[i] $Alt[i] $DB[i] $LPDB[i] $FP[i] \n"

     }





   }


<<[2]"%V$kfc \n"


//<<"%V$k $tim $alt \n"

<<"#col_headings Tim Alt DB LPDB FP \n"

/{
   for (i =0 ; i < nrows ; i++) {

       <<"$Tim[i] $Alt[i] $DB[i] $LPDB[i] $FP[i] \n"

   }
/}

stop!

