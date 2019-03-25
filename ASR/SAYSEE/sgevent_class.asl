// sgevent.asl

////////////////////   EVENT PROCESSING ////////////////////////////

CLASS Event
{

 public:

   Svar emsg ;
   Svar kws ;
   Str keyw ;
   Str woname ;
   Str woval ;

   char keyc ;

   int minfo[] 
   float rinfo[]

   float rx
   float ry

   int woid
   int button
   int wo_ival
   int etype

 #  method list


   CMF getMsg()
   {

     emsg = ""
     keyc = 0
     woval = "_"
     woname = "_"
     rx = 0
     ry = 0

     emsg= MessageWait(minfo,rinfo)

//<<"reading msg \n"

       // emsg= MessageRead(minfo,rinfo)

    <<"<|$emsg|> \n"

     keyw = "NO_MSG"

     if ( !(emsg[0] @= "NO_MSG")) { 

      kws = Split(emsg)

<<"%V$kws \n"

      keyw = kws[0]

      woname = kws[1]

      if (keyw @= "WOEVENT") {
        woval = kws[2]
      }

      keyc = pickc(kws[2],0)

      //      wms=GetMouseState()

      //<<"%V$wms\n"


      woid = minfo[3]
      etype = minfo[7]
      button = minfo[8]

      wo_ival = minfo[13]

      rx = rinfo[1]
      ry = rinfo[2]

//<<"%V$keyw $woname $woval $keyc $rx $ry\n"
    displayEvent("%V$keyw $woname $wo_ival $woid $keyc $rx $ry")
    }
   }   
}

Event E

////////////////////////////////////////////////////////////////////////////////////////////////
