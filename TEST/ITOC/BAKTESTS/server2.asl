//#! /usr/local/GASP/bin/asl

// want to listen/ write on multiple sockets to multiple clients
// as one process

proc StrEcho( sock_handle )
{

 // 
  int k = 0
 
 while (1) {

       CR=GsockRead(sock_handle,"connect",1024)

       sz = Caz(CR)
      if (sz == -1)
       STOP!

       err= Cerror(CR)

   if (err == -1)
         STOP!


//<<" msg sz $sz \n"

  if (sz > 0) {

 <<" $k read $sz chars >>> %s $CR \n"

      RC = srev(CR)

       nw=GsockWrite(sock_handle,"connect",RC)

// <<" %v $nw \n"

     k++
   }
  }

}



proc server_t( sock_handle)
{
 // block till get connection
 int tid
 tid = GthreadGetId()

 <<" %V $tid waiting for $sock_handle \n"

    int  Cfd 

    Cfd = GsockAccept(sock_handle)

    <<" got connected $Cfd \n"

            GsockClose(sock_handle,"listen")
            // do serving
            StrEcho()
   

          GsockClose(sock_handle,"connect")

}


proc server_t2( sock_handle)
{
 // block till get connection
 int tid
 tid = GthreadGetId()

 <<" %V $tid waiting for $sock_handle $B \n"

    int  Cfd 

    Cfd = GsockAccept(B)

    <<" got connected $Cfd \n"

            GsockClose(B,"listen")
            // do serving

       while (1) {

       CR=GsockRead(B,"connect",1024)

       sz = Caz(CR)
        if (sz == -1) {
          STOP!
        }

       err= Cerror(CR)

       if (err == -1) {
         STOP!
       }

         if (sz > 0) {

       <<" $k read $sz chars >>> %s $CR \n"

          RC = srev(CR)

          nw=GsockWrite(B,"connect",RC)

          k++
        }

       }

       GsockClose(B,"connect")
}


port1 = 9869
port2 = 9867

// test socket code

// server

// create socket

  pid = GetPid()

<<" mypid $pid \n"

// on server side the address can be any
// it is of type SOCK_STREAM AF_INET byt default

  A = GsockCreate("any",port1)

<<" Create Socket index $A \n"

     GsockBind(A);

// now listen on that socket - port

// backlog default is 1024

  GsockListen(A)

  B = GsockCreate("any",port2)

 GsockBind(B);

  GsockListen(B)

<<" Create Socket index $B \n"

  cpid = 0


// thread to process A
    servid1 = gthreadcreate("server_t", A)
<<" just created A thread server $servid1 on port $port1\n"
// thread to process B
    servid2 = gthreadcreate("server_t2", B)
<<" just created B thread server $servid2 on port $port2\n"



    ks = 0
    while (1) {

      nt = gthreadHowMany()
   <<" main thread sleeping $(ks++)  WAITING for $(nt-1) other threads to finish \n"
      sleep(2);

    }



STOP!