//
//  array svar within CMF does not produce correct XIC code
//


CLASS turnpt 
 {

 public:

  svar wval;  // holds all field info
  svar cltpt; //
  svar val;
  svar dbval;
  float Alt;
  float Ladeg;
  float Longdeg;
  float Dir;
  svar name

  float my_deg
  float my_min
  float my_la
  int minfo[30];
#  method list

  CMF Read ( ) 
  {
    nwr = 1
     la_deg = "" 
     long_deg = ""

    minfo[0] = 79

    wval[0] = "38,58.17,N"
    wval[1] = "105,58.17,W"
    wval[2] = "47,23.18,S"

   <<"IN \n"
   <<"%V$wval[0] \n"
   <<"%V$wval[1] \n"
   <<"%V$wval[0:2] \n"



    Ladeg = GetDeg(wval[0])
 
   <<"%V$Ladeg \n"

    Ladeg = GetDeg(wval[1])
 
   <<"%V$Ladeg \n"
   <<"OUT \n"
   <<"%V$wval[0] \n"
   <<"%V$wval[1] \n"
   <<"%V$wval[0:2] \n\n"

    return nwr
   }



  CMF GetDeg (svar the_ang)
    {
    float la
    int nf
    str dv = "x"
    int k = 0

      <<"turnpt GetDeg %V$the_ang $(typeof(the_ang)) $(typeof(dv)) \n" 

      <<"%V$dv $(typeof(dv)) \n" 

	//ttyin()

	//float la
	// this local declaration gets lost!!

      float the_deg
      float the_min

      Svar the_parts

	//<<"%v  $the_ang   \n"

      the_parts = Split(the_ang,",")

        nf = Caz(the_parts)

	<<"%V$the_parts $(typeof(the_parts)) $nf\n"

	<<"%V$the_parts[0]  \n"

    //<<"%v $the_parts \n"

        dv = the_parts[k]

        <<"%V$dv $(typeof(dv))\n"



        the_deg = atof(dv)

	<<"%V$the_deg $(typeof(the_deg)) \n"

        k = minfo[0]

	<<"%V$k $minfo[0] \n"

	ttyin()


        the_min = atof(the_parts[1])

       <<"%V$the_deg $the_min \n"

       sz= Caz(the_min)

      the_dir = the_parts[2]

<<"%V$the_dir $(typeof(the_dir))  \n"
    
      return (the_deg)

   }


  CMF turnpt()
    {
	//      <<" CONS $_cobj %i $Place\n"
      Ladeg = 40.0
      Longdeg = 105.0
      Dir = 0.0

    }



}

turnpt  T




//


Svar the_mparts

the_ang = "38,58.17,N"

<<"%V$the_ang   \n"
      kp = 0

      the_mparts = Split(the_ang,",")

      nf = Caz(the_mparts)

	<<"%V$the_mparts $(typeof(the_mparts)) $nf\n"

      <<"%V$the_mparts[0]  \n"

    //<<"%v $the_parts \n"

      dv = the_mparts[kp]

      <<"%V$dv $(typeof(dv))\n"

      kp++
      ev = the_mparts[kp]

      <<"%V$ev $(typeof(ev))\n"

      the_deg = atof(dv)



	//    the_deg = atof(the_parts[0])

	//<<"%v $the_deg $(typeof(the_deg))\n"

	//    the_min = atof(the_parts[1])

      the_min = atof(the_mparts[1])

      <<"%V$the_min $(typeof(the_min))\n"


//  single Object

   <<" Using turnpt object \n"

       T->Read()

       T->Read()

       T->Read()



// object array
/{
turnpt  Wtp[10]

      Wtp[0]->Read()

      Wtp[1]->Read()
/}

stop!

