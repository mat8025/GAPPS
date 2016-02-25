


 if (argc() < 3) {
  <<" usage:  asl client.asl <Ip address e.g. loopback  (127.0.0.1) or 192.168.0.xx> <port e.g. 9869> \n"
  exit()
 }


 Ipa = ""
 Ipa = _clarg[1]

<<"%V$port $Ipa \n"

int  port = atoi(_clarg[2])


   Sh = socket(Ipa, port, "UDP")

<<" created socket index $Sh $port\n"

  //GsockConnect(Sh)
//<<"connected !\n"

  // now just read and write
  k = 0;
  char rcv[1024];
  while (1) 
   {
    msg = i_read("type a message :-")
<<" $msg\n"

    ok=GsockSendTo(Sh,msg);

<<"sent $ok $msg\n"

//    rc = GsockRecv(Sh,rcv,500,1)
    rcv = 0;

//    rc = GsockRecvFrom(Sh,rcv,500)
    rc = RecvFrom(Sh,rcv,500)

<<"%V$rc\n"

    if (rc > 0) {
<<" Got :: $rc chars %s$rcv\n"
    }

    //GsockSendTo(Sh,"Got Ack $k\n")
     SendTo(Sh,"Got Ack $k\n")
    k++
   }