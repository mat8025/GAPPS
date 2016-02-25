////////////////////////////////////////
//////// bintohex.asl ////////////////////
////////////////////////////////////////

setdebug(1)
// want do this statement if DB is define

Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }

   // needs screen spec -- make 0 default
   vp = CreateGwindow(@title,"BinToHex",@resize,0.1,0.1,0.95,0.95,-1)

   SetGwindow(vp,@pixmapon,@drawon,@save,@bhue,"blue")

   SetGwindow(vp,@clip,0.1,0.2,0.9,0.9)

//////// Wob //////////////////
 xwid = 0.15
 bx = 0.8
 bX = 0.9
 yht = 0.08
 ypad = 0.05
 xpad = 0.02
 bY = 0.2
 by = bY - yht

 qwo=cWo(vp,"BN",@name,"RESET?",@VALUE,"RESET",@color,"orange"@resize_fr,bx,by,bX,bY)
 sWo(qwo,@help," click to quit",@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"black", @callback,"reset")

<<"%V$qwo \n"


 bx = 0.2
 bX = bx + xwid

 int decval = 0

 sdecwo=cWo(vp,"BV",@name,"SetDec",@VALUE,"$decval",@callback,"setDec",@help," decimal value")

 shexwo=cWo(vp,"BV",@name,"SetHex",@VALUE,"$decval",@callback,"setHex",@help," hex value")

 //sWo({sdecwo,shexwo},@style,"SVB",@FONTHUE,"black",@color,"white",@FUNC,"inputValue")

 sWo(sdecwo,@style,"SVB",@FONTHUE,"black",@color,"white",@FUNC,"inputValue")

sWo(shexwo,@style,"SVB",@FONTHUE,"black",@color,"white",@FUNC,"inputValue")


<<"%V$shexwo \n"


 decwo=createGWOB(vp,"BV",@name,"DEC",@VALUE,decval,@help," decimal value")
 octwo=createGWOB(vp,"BV",@name,"OCT",@VALUE,decval,@help," octal value")

 //      sWo({decwo,octwo},@style,"SVB", @FONTHUE,"black",@color,"yellow")
      sWo(decwo,@style,"SVB", @FONTHUE,"black",@color,"yellow")
      sWo(octwo,@style,"SVB", @FONTHUE,"black",@color,"yellow")

 //wo_htile({sdecwo,shexwo,decwo,octwo}, 0.1,by,0.6,bY,0.05)
 int numwos[] = {sdecwo,shexwo,decwo,octwo}
wo_htile(numwos, 0.1,by,0.6,bY,0.05)


 ypad = 0.02

//  create byte bins

int byte3[4]

// need to fix postincrement
   i =0

   byte3[i++]=createGWOB(vp,"BS",@name,"15",@color,"yellow")
   byte3[i++]=createGWOB(vp,"BS",@name,"14",@color,"yellow")
   byte3[i++]=createGWOB(vp,"BS",@name,"13",@color,"yellow")
   byte3[i++]=createGWOB(vp,"BS",@name,"12",@color,"yellow")

<<"byte3 $byte3 \n"


 xwid = 0.20
 bx = 0.05
 bX = bx + xwid
 yht = 0.2


 bY = 0.95
 by = bY - yht


   sWo(byte3,@value,"1",@style,"SVB",@callback,"binset")
   wo_htile(byte3,bx,by,bX,bY,xpad)

   sWo(byte3,@CSV,"0,1")

int byte2[4]

// need to fix postincrement
   i =0

   byte2[i++]=createGWOB(vp,"BS",@name,"11",@color,"yellow")
   byte2[i++]=createGWOB(vp,"BS",@name,"10",@color,"yellow")
   byte2[i++]=createGWOB(vp,"BS",@name,"9",@color,"yellow")
   byte2[i++]=createGWOB(vp,"BS",@name,"8",@color,"yellow")

<<"byte2 $byte2 \n"

//<<"$byte2 \n"
 bx = bX + xpad*2
 bX = bx + xwid
   setgwob(byte2,@value,"0",@style,"SVB",@callback,"binset")
   setGWOB(byte2,@CSV,"0,1")
   wo_htile(byte2,bx,by,bX,bY,xpad)


int byte1[4]
   i =0

   byte1[i++]=createGWOB(vp,"BS",@name,"7",@color,"yellow")
   byte1[i++]=createGWOB(vp,"BS",@name,"6",@color,"yellow")
   byte1[i++]=createGWOB(vp,"BS",@name,"5",@color,"yellow")
   byte1[i++]=createGWOB(vp,"BS",@name,"4",@color,"yellow")

<<"byte1 $byte1 \n"


//<<"$byte1 \n"
 bx = bX + xpad*2
 bX = bx + xwid
   setgwob(byte1,@value,"0",@style,"SVB",@callback,"binset")
   setGWOB(byte1,@CSV,"0,1")
   wo_htile(byte1,bx,by,bX,bY,xpad)

int byte0[4]

   i =0

   byte0[i++]=createGWOB(vp,"BS",@name,"3",@color,"yellow")
   byte0[i++]=createGWOB(vp,"BS",@name," 2",@color,"yellow")
   byte0[i++]=createGWOB(vp,"BS",@name," 1",@color,"yellow")
   byte0[i++]=createGWOB(vp,"BS",@name," 0",@color,"yellow")

<<"byte0 $byte0 \n"
 bx = bX + xpad*2
 bX = bx + xwid

   setgwob(byte0,@value,"0",@style,"SVB",@callback,"binset")
   setGWOB(byte0,@CSV,"0,1")
   wo_htile(byte0,bx,by,bX,bY,xpad)

int allbytes[] 

    allbytes = byte0 @+ byte1 @+ byte2 @+ byte3

<<"%V$allbytes \n"

    sWo(allbytes,@callback,"binset");


int hexlow[4]

   i =0

   hexlow[i++]=createGWOB(vp,"BS",@name,"byte_3",@color,"yellow")
   hexlow[i++]=createGWOB(vp,"BS",@name,"byte_2",@color,"yellow")
   hexlow[i++]=createGWOB(vp,"BS",@name,"byte_1",@color,"yellow")
   hexlow[i++]=createGWOB(vp,"BS",@name,"byte_0",@color,"yellow")

 bY = by - ypad
 by = bY - yht * 0.5

 bx = 0.1
 bX = bx + 4*xwid

<<"%V$hexlow \n"

   setgwob(hexlow,@value,"A",@style,"SVB",@callback,"hexval_setbin")
   setGWOB(hexlow,@CSV,"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F")
   wo_htile(hexlow,bx,by,bX,bY,xpad)

   setgwin(vp,@redraw)
   setgwin(vp,"woredrawall")

////////////////////////////// PROCS //////////////////////////////////////////////////

proc binval_reset()
{
  setgwob(allbytes,@value,"0",@redraw)
}
//--------------------------

proc hexval_bin(wb, wid)
{

 <<"%V$wb $hexlow[wb] $wid\n"

int i;
int bv[4]

     bs= decbin(hexdec(getWoValue(hexlow[wb])));

     for (i= 0; i < 4; i++) {
         bv[i] = atoi(sele(bs,28+i,1));
     }

     if (wb == 0)  {
       setgwob(byte3,@value,bv);
     }
     elif (wb == 1) {
       setgwob(byte2,@value,bv);
     }
     elif (wb == 2) {
       setgwob(byte1,@value,bv);
     }
     elif (wb == 3) {
       setgwob(byte0,@value,bv);
     }

     sWo(allbytes,@update)
<<" Done \n"
}
//---------------------------------------
proc showDecVal()
{
 hstr = "$(getWoValue(hexlow[0])) $(getWoValue(hexlow[1])) $(getWoValue(hexlow[2])) $(getWoValue(hexlow[3]))"
//<<"$hstr \n"
    decval = hexdec(hstr)
    sWo(decwo,@value,decval,@update)
    octval = decoct(decval)
    sWo(octwo,@value,octval,@update)
}
//---------------------------------------
proc binval_hex(wbit)
{
  if (wbit <= 3) {
     sWo(hexlow[3],@value,dechex(bindec("$(getWoValue(byte0))")),@update)
  }
  elif (wbit <= 7) {
    sWo(hexlow[2],@value,dechex(bindec("$(getWoValue(byte1))")),@update)
  }
  elif (wbit <= 11) {
    sWo(hexlow[1],@value,dechex(bindec("$(getWoValue(byte2))")),@update)
  }
  else {
    sWo(hexlow[0],@value,dechex(bindec("$(getWoValue(byte3))")),@update)
  }
}
//-------------------------------------------------------
proc setBinFromHexBytes()
{
  for (i=0;i<4;i++) {
     hexval_bin(i, 0);
  }
}
//-------------------------------------------------------

proc setFromHex(h)
{
  nb = slen(h)

<<"%V$h $nb $(typeof(h))\n"

  sWo(hexlow,@value,"0",@update)

  if (nb > 4) nb = 4

  for (i = 0; i < nb; i++) {

 //  hv = sele(h,-1*i,1)

     k = ((i+1) * -1) 

  hv = sele(h,k,1)
//  hv = sele(h,((i+1) * -1) ,1)

//<<"$h $i $k \n"
   if (slen(hv) > 0) { 
      sWo(hexlow[3-i],@value,hv,@update)
   }
  }
  setBinFromHexBytes()
}

////////////////////////WOB CALLBACKS///////////////////////////////////////
proc setDec()
{
<<"IN $_proc \n"
  d= Atoi(getWoValue(sdecwo))
<<"setdec $d \n"
  h=dechex(d)
<<"$h\n"
  setFromHex(h)
}
//--------------------------------------------
proc setHex()
{
//<<"$_proc \n"
  h= getWoValue(shexwo)
//<<"%V$h\n"
  setFromHex(h)
}
//--------------------------------------------
proc hexval_setbin()
{
<<"calling $_proc hexval_setbin\n"

      if ( Woname @= "byte_0" ) {
          hexval_bin(3, Woid)
      }

      if ( Woname @= "byte_1" ) {
          hexval_bin(2, Woid)
      }

      if ( Woname @= "byte_2" ) {
          hexval_bin(1, Woid)
      }

      if ( Woname @= "byte_3" ) {
          hexval_bin(0, Woid)
      }
}

//------------------------------------------------------
proc binset()
{
//<<"$_proc $Woname \n"
    if ( isadigit(Woname) ) {
      binval_hex( Atoi(Woname))
    }
}
//------------------------------------------------------
proc reset()
{
  binval_reset()
  for (i=0;i<16;i++) { binval_hex(i);}
}
//------------------------------------------------------
///////////////////////////////////////////////////////////////////
// Event vars
Svar msg

E =1 // event handle

int evs[16];

Woid = 0
Woname = ""
Woproc = "foo"
Woval = ""
Evtype = ""
int Woaw = 0

proc getWoMsg()
{
   Woproc = ""

   msg = E->waitForMsg()

<<"msg $msg \n"

//   sWo(two,@redraw)
//   sWo(two,@textr,"$msg",0.1,0.8)

//   E->geteventstate(evs)

   Woname = E->getEventWoName()    
   Evtype = E->getEventType()    
   Woid =   E->getEventWoId()
   Woproc = E->getEventWoProc()
   Woaw =  E->getEventWoAw()
   Woval = getWoValue(Woid)
   
<<"%V$Woproc \n"
<<"%V$Woname $Evtype $Woid $Woaw $Woval\n"
<<" callback ? $Woproc\n"
}

//----------------------------------------------------------
proc  processMsg()
{
// if  callback function has been set then call it -- based on woproc name

      if ( !(Woproc @= "")) {
          <<"calling $Woproc \n"
          $Woproc()        
      }
}
//----------------------------------------------------------
proc updateScreen()
{
       showDecVal()
}

//////////////////////////BKG LOOP/////////////////////////////////////////

setFromHex("feed")
setFromHex("cafe")


uint n_msg = 0
   while (1) {

     
      msg = E->waitForMsg()
      n_msg++
<<"%V$n_msg\n"
      Woproc = E->getEventWoProc()
      Woname = E->getEventWoName() 
   
       if (!(Woproc @= "")) {
         <<"calling |${Woproc}| $(typeof(Woproc))\n"
         $Woproc()        
       }

//       processMsg()
              
         updateScreen()

    }

 exit_gs()

;

////////////////////   TBD -- FIX //////////////////////
