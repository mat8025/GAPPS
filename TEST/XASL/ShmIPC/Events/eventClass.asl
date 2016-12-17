
setdebug(1)

Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }

int PT[]


PT[7] = 78
PT[23] = 47

<<"%{10\n} $PT \n"


CLASS Event
{

 public:

   Svar msg;

   int minfo[]
   float wms[]
   float ems[];

   int wid
   int button

 #  method list
   int e;

   CMF Wait()
   {
      msg = e->waitForMsg()
      button = e->getEventButton()
      wid = e->getEventWoId()
   }    

}



Event E


  E->wid = 79

<<"%v $E->wid \n"



  E->minfo[0] = 1.0
  E->minfo[2] = 7.0

<<"%V $E->minfo \n"

  while (1) {

    E->Wait()
    <<"%V $E->button $E->wid \n"

  }


stop!
