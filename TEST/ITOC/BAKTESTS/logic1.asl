


proc StrCli( cfd)
{

kw =0
tw =0
 // 
<<" Listening "
       first = 1

//T=FineTime()
//T2=FineTime()
int nbr = 0
eom = 1
eidpn = 5
eidmh = 6
  while (1) {

int mblen = 10

 if (eidmh == msg_port_n || (showall == 1)) {

    while (eom < mblen) {
<<"$eom outer \n"

//FIX -- needs bracks and condition  if ( eidpn == port_n || showall) {
  if ( (showall == 1) || (eidpn == port_n) ) {
    if (showall >= 0) {
<<"frame_hd %v $showall \n"
    }
<<"$eom $port_n  inner_if\n"
    //    <<"%20\nr %hx $NM \n"
<<"----------------------------------------- \n"
  }
   eom += 2


   }

  }
   kw++
   if (kw > 6)
     break
  }

}




msg_port_n = _clarg[1]
port_n = _clarg[2]
showall = _clarg[3]


StrCli(3)


STOP!