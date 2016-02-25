
setdebug(1)


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


   CMF Wait()
   {
      msg= MessageWait(minfo,ems)

<<" $msg $minfo\n"

      wms=GetMouseState()
      wid = wms[0]
      button = wms[2]
   }    


}



Event E


  E->wid = 79

<<"%v $E->wid \n"

stop!

  E->minfo[0] = 1.0
  E->minfo[2] = 7.0

<<"%V $E->minfo \n"



stop!
