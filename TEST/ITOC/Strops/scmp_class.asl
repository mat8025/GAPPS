


Class Event 
{

 public:
   Str emsg;


  CMF GetMsg(ws)
   {



     emsg = ws

<<" scmp testing of $ws $emsg \n"

     if (emsg @= "NO_MSG") {

<<"%V $emsg is @= NO_MSG  $ws\n"


     }

     if (!(emsg @= "NO_MSG")) {

<<"%V $emsg is ! @= NO_MSG  $ws\n"


     }


   }

}



Event E ;

  E->GetMsg("NO_MSGX")

  E->GetMsg("NO_MSG")


  E->GetMsg("NO_MSGX")






stop!
