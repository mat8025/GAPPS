// Server UDP datagram


// create a DATAGRAM UDP packet



  pid = GetPid()

  int  port_id = atoi(_clarg[1])

//  Sh = GsockCreate("any",port_id,"UDP") // Sh is our socket 'handle'
    Sh = socket("any",port_id,"UDP") // Sh is our socket 'handle'


  if (Sh == -1) {
<<"error could not create UDP socket \n"
   exit()
  }

  //ok=GsockBind(Sh) //  now the bind
    ok=Bind(Sh) //  now the bind

<<"bind $ok socket \n"
  char rcv[1024]
  // now just read and write

  k = 0;
  while (1) 
   {

//    rc = GsockRecv(Sh,rcv,500,1)
    rcv = 0;

    //rc = GsockRecvFrom(Sh,rcv,500)  

    rc = RecvFrom(Sh,rcv,500)  
                                    // our 'socket' stores the received from sockaddr struct
                                    // so that next send goes to that addr
<<"recv ret $rc\n"


    if (rc > 0) {

<<"got :- $rc chars %s $rcv \n"

//    GsockSendTo(Sh,"message $k %s < ${rcv} > received \n")

    SendTo(Sh,"message $k %s < ${rcv} > received \n")

    k++
    }

    sleep(2)
   }