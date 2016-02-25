#! /usr/local/GASP/gasp/bin/asl 
#/* -*- c -*- */


SetDebug(1)
stype = "XX"

char CW[64] = { "linux reading" }

<<" %s $CW \n"

int last_sent = 0
int last_rec = 0
int ds
int dr
int sec = 5
int last_sec = 55
int dsec

kickoff =0

int gwo = -1
int max_gl
int min_gl

float XVEC[]
float MAXVEC[]
float MINVEC[]

float rx
float rX

char CR[2048]

proc StrCli( cfd)
{
kw =0
 // 
<<" Listening \n"

  while (1) {

<<" Listening $kw \n"

   kw++
   sleep(0.5)
   if (kw > 3)
   break
  }

  while (1) {

    //<<" Listening from socket $kw \n"

    nbr =GsockRecv(A,CR,500,1)

   kw++

   if (nbr > 0)  {
<<"$kw $nbr %s $CR \n"
   }

   sleep(0.2)

  }

//<<"\r %s $CR "
    fflush(1)
//   <<" $ds $dr per sec \n"

}


// we want to create socket on our local machine
// on the port that the other side is sending

 port = 9871
 Ipa = "any"

 if (AnotherArg()) {
  Ipa = GetArgStr()
 }

 if (Ipa @= "") {
  Ipa = "any"
 }

// port = GetArgI(9871)

<<"%V  $Ipa $port \n"


   A = GsockCreate(Ipa, port, "UDP")

<<" created UDP type socket index $A $port\n"

//      GsockConnect(A)
      errnum = CheckError()

<<"%v $errnum \n"

<<" now reading from it \n"

      StrCli()


      STOP!

