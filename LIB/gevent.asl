//
//
// wait and catch mouse/key window events
//
//
// version 1.2

proc eventDecode()
{

// get all below button,rx,ry via parameters to waitformsg
    ev_woval = Ev->getEventWoValue();
    
    <<"$ev_kloop %V$ev_msg $ev_woval\n"

    words = Split(ev_msg)
    ev_keyw = words[2];
    ev_woid = Ev->getEventWoid();
    ev_button = Ev->getEventButton();
    ev_keyc = Ev->getEventKey();
    ev_woname = Ev->getEventWoName();
    ev_type = Ev->getEventType();    
    ev_woproc = Ev->getEventWoProc();        
    ev_id = Ev->getEventID();
    Ev->geteventrxy(&ev_rx,&ev_ry);
    Ev->geteventrowcol(&ev_row,&ev_col);

<<"%V$ev_keyc $ev_button $ev_id $ev_woid $ev_woname $ev_woval\n"
<<"%V $ev_keyw $ev_woproc $ev_row $ev_col $ev_rx $ev_ry\n"

}


proc eventWait()
{
    ev_kloop++;
    ev_msg = Ev->waitForMsg();
    <<"$ev_kloop %V$ev_msg \n"
    eventDecode();

}
//==============================

proc eventRead()
{
    ev_kloop++;
    ev_msg = Ev->readMsg();
    <<"$ev_kloop %V$ev_msg \n";
    eventDecode();
}
//==============================



Ev =1; // event handle

int ev_kloop = 0
int last_evid = -1;
int do_loop = 1;

float ev_rx = 0;
float ev_ry = 0;

int ev_row = -1;
int ev_col =-1;
int ev_button;
int ev_id;
int ev_keyc;
int ev_woid;

svar ev_msgwd;

str ev_type;
str ev_keyw;
str ev_msg = "xyz";

//str ev_woname = "";
//str ev_woval = "";

str ev_woname = "xxx";

str ev_woval = "yyy";

ev_woproc = "";

<<" loaded event processor $ev_woval $ev_msg\n"

//====================================
