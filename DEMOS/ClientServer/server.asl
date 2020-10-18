//%*********************************************** 
//*  @script server.asl 
//* 
//*  @comment test commands to setup server 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium [asl 6.2.76 C-He-Os]                               
//*  @date Thu Oct 15 09:48:31 2020 
//*  @cdate 1/1/2008 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();



///
/// test socket code
///

proc StrEcho( )
{
 int k = 0
 
 while (1) {

      CR=GsockRead(A,"connect",1024)

      sz = Csz(CR)

<<" msg sz $sz \n"

    //  if (sz[0] == -1) {
      if (sz == 0) {
          exit()
      }
       err= Cerror(CR)

      if (err == -1)
         exit()


  if (sz > 0) {

 <<"$k read $sz chars >>> %s $CR \n"

       RC = srev(CR)

       nw=GsockWrite(A,"connect",RC)

// <<"%V $nw \n"

     k++
   }
  }
}
//------------------------------------


// server

// create socket

   pid = getAslPid()

  int  port_id = atoi(_clarg[1])

// on server side the address can be any
// it is of type SOCK_STREAM AF_INET by default

  A = GsockCreate("any",port_id)

<<" mypid $pid  Create Socket $port_id index $A \n"

    GsockBind(A) //  now the bind

// backlog default is 1024

  GsockListen(A) // now listen on that socket - port

   cpid = 0

 // block till get connection

   Cfd = GsockAccept(A)

<<"got accepted $Cfd \n"

//  GsockClose(A,"connect")

   StrEcho( )

/////////////////////////   DEV ////////////////////////////////////
/{/*


    nc -u 127.0.0.1 9892  
    does not connect  ?





/}*/