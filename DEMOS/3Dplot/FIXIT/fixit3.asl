
  Svar emsg ;
   Svar kws ;
   Str keyw ;



CLASS Event
{

 public:

   Svar emsg ;
   Svar kws ;
   Str keyw ;

   int minfo[];

   float wms[];
   float ems[];


   int woid
   int button

 #  method list


   CMF GetMsg()
   {
  //   emsg = ""

  //   emsg= MessageWait(minfo,ems)

//<<"reading msg \n"

//      emsg= MessageRead(minfo,ems)

    <<"<|$emsg|> \n"

     if ( !(emsg[0] @= "NO_MSG")) { 


<<"%V$minfo \n"
<<"%V$ems \n"
<<"%V$emsg \n"


      kws = Split(emsg)

<<"%V$kws \n"

      keyw = kws[1]

<<"%V$keyw\n"

      keyw = kws[2]

<<"%V$keyw\n"


//      wms=GetMouseState()

//<<"%V $wms\n"

//      woid = minfo[3]

//     button = minfo[8]

//      button = wms[2]
    }

   }   
}



Event E





 E->emsg = "JAN FEB MAR APR" 

<<"%V$E->emsg \n"

 E->GetMsg()



 stop!