//  functions to read IQ dat file
//  and extract ac_info == power from IQ stream
opendll("uac")

// useage
// asl readradial.asl ~/FlightTest/20100810_213807.dat 
//


include "readradial_g"

A=ofw("vs.dat")

setdebug(0)

enum sweep_types {

   HORIZ_SWEEP,         // normal operation
   TRANSITION_HORIZ,    // after horiz scan
   AUX_VERT_UP,
   AUX_VERT_DOWN,       // legacy vert scan direction
   AUX_END_OF_VERT,     // 1st epoch after vert scan
   TRANSITION_AUX_VERT, // 2nd epoch... after vert scan
   AUX_HORIZ,
   AUX_END_OF_HORIZ,     // 1st epoch after aux horiz scan
   TRANSITION_AUX_HORIZ, // 2nd epoch... after aux horiz scan
   TRANSITION_UNKNOWN,   // in transition from unknown state
   AUX_UNKNOWN,          // unknown auxiliary type
}



float Pwr[256]
float Lpwr[512]
float SP2_pwr[256]

rad_date = ""

fname = _clarg[1]

<<"$fname \n"

 iq1 = openiqfile(fname)


 wt=readradial()

<<"$wt\n"

 wt=readradial()

<<"$wt\n"
  last_wt = wt
  i = 0;
     n_aux_h = 0
     n_aux_v = 0
  Swp = 0
  eos = 0
  OldEos = 255
  while (1) {

    wt=readradial()
    i++

    if ( (i % 500) == 0) {
   <<"$i $wt $(wt - last_wt) \n"
//    Swp++
    }
    last_wt = wt
    if (wt == -1)
     break
   // check type of radial(epoch)

     swp_type = checkRadialType()

     

     if (swp_type == HORIZ_SWEEP) {
        Pwr = getShortPulsePwr(0)
//<<"got HS pwr $Pwr[1] \n"
     Lpwr = getLongPulsePwr()
     plot_lp_pwr()
     }

     if (swp_type == AUX_HORIZ) {
//   <<"$i $wt $(wt - last_wt) \n"
     Pwr = getShortPulsePwr(1)
//<<"got AUX_HS pwr $Pwr[10] \n"
     n_aux_h++
     }


     if (swp_type == AUX_VERT_UP) {
 
        Pwr = getShortPulsePwr(0)
        SP2_pwr = getShortPulsePwr(1)
//<<"got VS pwr $pwr[10] $swp_type\n"
//i_read()
     v_write(A,Pwr)
     v_write(A,SP2_pwr)
     n_aux_v++

     plot_sp_pwr()
     Lpwr = getLongPulsePwr()
     plot_lp_pwr()


     }





     if (n_aux_v > 2000) {
       break
     }

     eos = getSweep()
     if (eos != OldEos) {
        Swp++
     rad_date = getRadDate() ; // look up time string

     OldEos = eos

     Update() 
    }

 

 }

<<" read $i radials %V$n_aux_h $n_aux_v\n"

err=getErrors()

<<"errors $err\n"

stop!