////////////////////   EVENT PROCESSING ////////////////////////////


<<"FOUND event.asl  adding event code \n"


CLASS Event
{

 public:

   Svar emsg ;
   Svar kws ;
   Str keyw ;
   Str etype ;
   Str woname ;
   Str woval ;
   Str wovalue;
   char keyc ;

   int minfo[];
   float rinfo[];

   int woid
   int button ;
   int wo_ival ;

   float rx
   float ry

   int nm

#  method list

   CMF waitForMsg()
   {
     emsg = ""

     keyc = 0

     emsg= MessageWait(minfo,rinfo)

//<<"reading msg \n"

       // emsg= MessageRead(minfo,rinfo)

//    <<"<|$emsg|> \n"

     keyw = "NO_MSG"

     if ( !(emsg[0] @= "NO_MSG")) { 
      
      kws = Split(emsg)
      keyw = kws[0]
      etype = kws[1]
      woname = kws[1]
      woval = kws[2]
      wovalue = woval;

//<<"%V$keyw\n"

     keyc = pickc(kws[2],0)

     woid = minfo[3]
     button = minfo[8]
     wo_ival = minfo[13]

    rx = rinfo[1]
    ry = rinfo[2]


//<<"%V$keyw $woname $woval $button $wo_ival $woid\n"
//<<"%Vd$minfo"
//<<"%V6.2f$rinfo\n"

     nm++
    }
   }

   CMF readMsg()
   {

     emsg = ""
     keyc = 0

//<<"reading msg \n"

      emsg= MessageRead(minfo,rinfo)

 //   <<"<|$emsg|> \n"

     keyw = "NO_MSG"

     if ( !(emsg[0] @= "NO_MSG")) { 

      kws = Split(emsg)

      keyw = kws[0]
      etype = kws[1]

      woname = kws[1]
      woval = kws[2]
      wovalue = woval;
<<"woname $woname wovalue $wovalue \n"
//<<"%V$keyw\n"

      keyc = pickc(kws[2],0)

     woid = minfo[3]
     button = minfo[8]
     wo_ival = minfo[13]

    rx = rinfo[1]
    ry = rinfo[2]
     nm++
    }


   }      

   CMF printMsg()
    {
     <<"$emsg \n"
    }

   CMF Event()
    {
     nm = 0
     <<" constructing event %V$nm \n"
    }

}


///////////////////////////////////

