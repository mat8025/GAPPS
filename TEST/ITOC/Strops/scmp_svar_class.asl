
Str  s = "pow"

<<"%V $s $(typeof(s)) \n"

String  gstring = "wow"

<<"%V $gstring $(typeof(gstring)) \n"


Class Event 
{

 public:
   Svar emsg;


  CMF GetMsg(ws)
   {



     emsg = ws

<<" scmp testing of $ws $emsg[0] \n"

     if (emsg[0] @= "NO_MSG") {

<<"%V $emsg[0] is @= NO_MSG  $ws\n"


     }

     if (!(emsg[0] @= "NO_MSG")) {

        <<"%V $emsg[0] is ! @= NO_MSG  $ws\n"


     }


   }

}



Event E ;

  E->GetMsg("NO_MSGX")

  E->GetMsg("NO_MSG")

  E->GetMsg("NO_MSGX")

Event K;

stop!
