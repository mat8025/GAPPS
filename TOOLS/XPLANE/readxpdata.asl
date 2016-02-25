SetPCW("writeexe","writepic")

setdebug(1)
// read xplane data file

df=GetArgStr()

//<<" $df \n"

 A = ofr(df)
//<<" $A \n"

  T=readline(A)
  T=readline(A)

//  S->dewhite()
//<<"$T \n"

<<[2]"<$T>\n"
T->dewhite()

C= split(T,"|")



sz=Caz(C)

<<[2]"C sz $sz \n"


<<[2]"$sz <$C[0]> <$C[1]> <$C[2]>  <$C[sz-2]> <$C[sz-1]>\n"


AHRS_Hdg = -1
AHRS_Pitch = -1
AHRS_Roll = -1


  S=readline(A)

//sz=Caz(S)
//  S->dewhite()
//<<"$S \n"

D= split(S,"|")

sz = Caz(D)

<<[2]"$sz $D[0] $D[1] $D[2] \n"

//  B=ofw("xcols")
  // <<" $C[0] $D[0] \n"

<<[2]" \n\n""

  for (i=0; i < (sz-1) ; i++) {
      j = i +1
      <<[2]" $j $C[i] $D[i] \n"
  }

if (C[0] @= "elaps,_time") {
  <<[2]" found et \n"

}

  for (i=0; i < (sz-1) ; i++) {

if (C[i] @= "_wind,speed") {
  <<[2]" found $i $C[i] \n"
 WS=i
}



if (C[i] @= "_elec,force") {
  <<[2]" found @= $i $C[i] \n"
  EG = i
}


if (C[i] @= "pitch,__deg") {
  <<[2]" found @= $i $C[i] \n"
  PITCH = i
}

if (C[i] @= "_roll,__deg") {
  <<[2]" found @= $i $C[i] \n"
  ROLL = i
}

if (C[i] @= "mavar,__deg") {
  <<[2]" found @= $i $C[i] \n"
  MAVR = i
}

if (C[i] @= "__alt,ftmsl") {
  <<[2]" found @= $i $C[i] \n"
  ALTMSL = i
}

if (C[i] @= "_slip,__deg") {
  <<[2]" found @= $i $C[i] \n"
  SLIP = i
}


if (C[i] @= "hding,_true") {
  <<[2]" found @= $i $C[i] \n"
  HDTRUE = i
}

if (C[i] @= "hding,__mag") {
  <<[2]" found @= $i $C[i] \n"
  HDMAG = i
}


if (C[i] @= "_AHRS,_Roll") {
  <<[2]" found @= $i $C[i] \n"
  AHRS_Roll = i
}

if (C[i] @= "_AHRS,Pitch") {
  <<[2]" found @= $i $C[i] \n"
  AHRS_Pitch = i
}


if (C[i] @= "_AHRS,Hding") {
  <<[2]" found @= $i $C[i] \n"
  AHRS_Hdg = i
}




}



int wl = 0
//B= ofw("junk")

//int M[] = {0,5,WS,ROLL,PITCH,HDTRUE,ALTMSL,SLIP,AHRS_Roll,AHRS_Pitch,AHRS_Hdg}

// this does not put them out in order!! -- but in ascending values

int M[] = {0,ROLL,PITCH,HDMAG,ALTMSL,AHRS_Roll,AHRS_Pitch,AHRS_Hdg}

//int M[] = {ROLL,PITCH,HDMAG,AHRS_Roll,AHRS_Pitch,AHRS_Hdg}

//int W[] = {0,AHRS_Roll,AHRS_Pitch,AHRS_Hdg}

<<[2]" $M \n"
//<<[2]" $W \n"
//iread()


<<[2]"$C[M] \n"
// fix fh seen as array? 

//<<[B ]"$C[M] \n"



 while (1) {


  S=readline(A)

  S->dewhite()
//<<"$S \n"

  D= split(S,"|")
  sz=Caz(D)
  

  if (sz < 38) {
     break
  }

  if (f_error()==6) {
//   <<"$err \n"
    break
  }




//  <<[B]"$wl $D[0] $D[5] $D[WS] $D[PITCH] $D[ROLL] $D[HDMAG]\n"

// make this do the right position order
<<"$D[M] \n"


if ((wl % 100) == 0) {
//iread("$wl->")
}
//<<"$D[W] \n"

//<<"$D[AHRS_Hdg] \n"

//<<[B] "$D[M] \n"

   wl++


  

//  if (wl > 4000)      break

 }




STOP!
