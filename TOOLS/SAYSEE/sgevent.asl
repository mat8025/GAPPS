// sgevent.asl

////////////////////   EVENT PROCESSING ////////////////////////////
Svar msg

E =1 // event handle

int evs[20];

button = 0
Woid = 0
Woname = ""
Woproc = "foo"
Woval = ""
Evtype = ""
int Woaw = 0
keyc = ""
keyw = ""
float rinfo[]


proc checkEvents()
{

   Woname = E->getEventWoName()    
   Evtype = E->getEventType()    
   Woid = E->getEventWoId()
   rinfo = E->getEventRinfo()
   
<<"%V$Woid \n"

   Woproc = E->getEventWoProc()
   Woaw =  E->getEventWoAw()

   Woval = getWoValue(Woid)
   
<<"%V$Woval \n"

   button = E->getEventButton()
   keyc = E->getEventKey()
   keyw = E->getEventKeyW()

//<<"%V$Woid $qwo \n"
  
   // sWo(two,@redraw)
  
//   sWo(two,@texthue,"black",@textr,"%V$Evtype $Woid $Woname  $button  $keyc $keyw $Woval",-0.95,0.3)

}




////////////////////////////////////////////////////////////////////////////////////////////////
