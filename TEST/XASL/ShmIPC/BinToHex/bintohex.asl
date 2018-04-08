////////////////////////////////////////
//////// bintohex.asl
///   16,32,64  TDB
////////////////////////////////////////

setdebug(1,@keep,@~trace,@filter,0)
// want do this statement if DB is define

Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }
//icompile(0)
   // needs screen spec -- make 0 default
   vp = cWi(@title,"BinToHex",@resize,0.1,0.1,0.95,0.95,-1)

   sWi(vp,@pixmapon,@drawon,@save,@bhue,"blue")

   sWi(vp,@clip,0.1,0.2,0.9,0.9)

//////// Wob //////////////////
 xwid = 0.15
 bx = 0.8
 bX = 0.9
 yht = 0.08
 ypad = 0.05
 xpad = 0.02
 bY = 0.2
 by = bY - yht


 qwo=cWo(vp,"BN",@name,"RESET?",@value,"RESET",@color,"orange",@resize_fr,bx,by,bX,bY)
 sWo(qwo,@help," click to quit",@border,@drawon,@clipborder,@fonthue,"black", @callback,"reset")

<<"%V$qwo \n"

include "tbqrd.asl"

titleButtonsQRD(vp);

 bx = 0.2
 bX = bx + xwid

 int decval = 9474;  

 sdecwo=cWo(vp,@BV,@name,"SetDec",@VALUE,"$decval",@callback,"setDec",@help," decimal value")

 shexwo=cWo(vp,@BV,@name,"SetHex",@VALUE,"$decval",@callback,"setHex",@help," hex value")

 //sWo({sdecwo,shexwo},@style,"SVB",@FONTHUE,"black",@color,"white",@FUNC,"inputValue")

 sWo(sdecwo,@style,"SVB",@FONTHUE,"black",@color,"white",@FUNC,"inputValue")

sWo(shexwo,@style,"SVB",@FONTHUE,"black",@color,"white",@FUNC,"inputValue")


<<"%V$shexwo \n"


 decwo=cWo(vp,@BV,@name,"DEC",@VALUE,decval,@help," decimal value")
 octwo=cWo(vp,@BV,@name,"OCT",@VALUE,decval,@help," octal value")

 //      sWo({decwo,octwo},@style,"SVB", @FONTHUE,"black",@color,YELLOW_)
      sWo(decwo,@style,"SVB", @FONTHUE,"black",@color,YELLOW_)
      sWo(octwo,@style,"SVB", @FONTHUE,"black",@color,YELLOW_)

 //wo_htile({sdecwo,shexwo,decwo,octwo}, 0.1,by,0.6,bY,0.05)

int numwos[] = {sdecwo,shexwo,decwo,octwo}

 wo_htile(numwos, 0.1,by,0.6,bY,0.05)


 ypad = 0.02

//  create byte bins

int byte3[4]

// need to fix postincrement
   i =0

   byte3[i++]=cWo(vp,@BS,@name,"15",@color,YELLOW_)
   byte3[i++]=cWo(vp,@BS,@name,"14",@color,YELLOW_)
   byte3[i++]=cWo(vp,@BS,@name,"13",@color,YELLOW_)
   byte3[i++]=cWo(vp,@BS,@name,"12",@color,YELLOW_)

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

   byte2[i++]=cWo(vp,@BS,@name,"11",@color,YELLOW_)
   byte2[i++]=cWo(vp,@BS,@name,"10",@color,YELLOW_)
   byte2[i++]=cWo(vp,@BS,@name,"9",@color,YELLOW_)
   byte2[i++]=cWo(vp,@BS,@name,"8",@color,YELLOW_)

<<"byte2 $byte2 \n"

//<<"$byte2 \n"
 bx = bX + xpad*2
 bX = bx + xwid
   sWo(byte2,@value,"0",@style,"SVB",@callback,"binset")
   sWo(byte2,@CSV,"0,1")
   wo_htile(byte2,bx,by,bX,bY,xpad)


int byte1[4]
   i =0

   byte1[i++]=cWo(vp,@BS,@name,"7",@color,YELLOW_)
   byte1[i++]=cWo(vp,@BS,@name,"6",@color,YELLOW_)
   byte1[i++]=cWo(vp,@BS,@name,"5",@color,YELLOW_)
   byte1[i++]=cWo(vp,@BS,@name,"4",@color,YELLOW_)

<<"byte1 $byte1 \n"


//<<"$byte1 \n"
 bx = bX + xpad*2
 bX = bx + xwid
   sWo(byte1,@value,"0",@style,"SVB",@callback,"binset")
   sWo(byte1,@CSV,"0,1")
   wo_htile(byte1,bx,by,bX,bY,xpad)

int byte0[4]

   i =0

   byte0[i++]=cWo(vp,@BS,@name,"3",@color,YELLOW_)
   byte0[i++]=cWo(vp,@BS,@name," 2",@color,YELLOW_)
   byte0[i++]=cWo(vp,@BS,@name," 1",@color,YELLOW_)
   byte0[i++]=cWo(vp,@BS,@name," 0",@color,YELLOW_)

<<"byte0 $byte0 \n"
 bx = bX + xpad*2
 bX = bx + xwid

   sWo(byte0,@value,"0",@style,"SVB",@callback,"binset")
   sWo(byte0,@CSV,"0,1")
   wo_htile(byte0,bx,by,bX,bY,xpad)

int allbytes[] 

    allbytes = byte0 @+ byte1 @+ byte2 @+ byte3

<<"%V$allbytes \n"

    sWo(allbytes,@callback,"binset");


int hexlow[4]

   i =0

   hexlow[i++]=cWo(vp,@BS,@name,"byte_3",@color,YELLOW_)
   hexlow[i++]=cWo(vp,@BS,@name,"byte_2",@color,YELLOW_)
   hexlow[i++]=cWo(vp,@BS,@name,"byte_1",@color,YELLOW_)
   hexlow[i++]=cWo(vp,@BS,@name,"byte_0",@color,YELLOW_)


 bY = by - ypad
 by = bY - yht * 0.5

 bx = 0.1
 bX = bx + 4*xwid

<<"%V$hexlow \n"

   sWo(hexlow,@value,"A",@style,"SVB",@callback,"hexval_setbin")
   sWo(hexlow,@CSV,"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F")
   wo_htile(hexlow,bx,by,bX,bY,xpad)

   sWi(vp,@redraw)
   sWi(vp,"woredrawall")

////////////////////////////// PROCS //////////////////////////////////////////////////

proc binval_reset()
{
  sWo(allbytes,@value,"0",@redraw)
}
//--------------------------

proc hexval_bin(wb, wid)
{

 <<"%V$wb $hexlow[wb] $wid\n"

int i;
int bv[4];

     bs= dec2bin(hex2dec(getWoValue(hexlow[wb])));

     for (i= 0; i < 4; i++) {
         bv[i] = atoi(sele(bs,28+i,1));
     }

     if (wb == 0)  {
       sWo(byte3,@value,bv);
     }
     elif (wb == 1) {
       sWo(byte2,@value,bv);
     }
     elif (wb == 2) {
       sWo(byte1,@value,bv);
     }
     elif (wb == 3) {
       sWo(byte0,@value,bv);
     }

     sWo(allbytes,@update)
<<" $_proc Done \n"
}

//---------------------------------------

proc showDecVal()
{
 hstr = "$(getWoValue(hexlow[0])) $(getWoValue(hexlow[1])) $(getWoValue(hexlow[2])) $(getWoValue(hexlow[3]))"
<<"$hstr \n"
    decval = hex2dec(hstr)
    sWo(decwo,@value,decval,@update)
    octval = dec2oct(decval)
    sWo(octwo,@value,octval,@update)
    <<" $_proc Done \n"
}
//---------------------------------------

proc gbval (ba[])
{
svar bv;
//<<"$_proc  $ba\n"

   bv = getWoValue(ba);
//<<"%V $bv \n"

   bbval = "$(dewhite(\"$bv\"))"
//<<"%V $bbval \n"

 val= dec2hex(bin2dec(bbval));
   
//     <<"%V $(typeof(bv)) $bbval $val \n"
return val;
}
//==========================//


proc binval_hex(wbit)
{
//<<"IN $_proc binval_hex( $wbit ) \n"
  svar bval;
  
  if (wbit <= 3) {
   // bitval = getWoValue(byte0[0]);
    val =gbval (byte0);
  //   <<" get lowest byte 0 value $bitval  $(typeof(bitval)) $val\n"
     <<" get lowest byte  $byte0 $val\n"   
   sWo(hexlow[3],@value,val,@update);
     
   //  sWo(hexlow[3],@value,dec2hex(bin2dec("$(getWoValue(byte0))")),@update)
  }
  elif (wbit <= 7) {
   val =gbval (byte1);
   sWo(hexlow[2],@value,val,@update);

  }
  elif (wbit <= 11) {
   val =gbval (byte2);
   sWo(hexlow[1],@value,val,@update);
  }
  else {
   val =gbval (byte3);
   sWo(hexlow[0],@value,val,@update);
  }
  //<<" $_proc Done \n"
}
//-------------------------------------------------------
proc setBinFromHexBytes()
{
  for (i=0;i<4;i++) {
     hexval_bin(i, 0);
  }
  <<" $_proc Done \n"
}
//-------------------------------------------------------

proc setFromHex(h)
{
int k = 0;

  nb = slen(h)

<<"%V$h $nb $(typeof(h))\n"

  sWo(hexlow,@value,"0",@update)

  if (nb > 4) {
  nb = 4
  }
 
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
  <<" $_proc Done \n"
}

////////////////////////WOB CALLBACKS///////////////////////////////////////
proc setDec()
{
<<"IN $_proc \n"
  val = getWoValue(sdecwo);
  d = atoi(val);
//  d= Atoi(getWoValue(sdecwo))

<<"setdec $d \n"

h=dec2hex(d)
<<"$h\n"

setFromHex(h);

<<"OUT $_proc \n"

}
//--------------------------------------------
proc setHex()
{
<<"IN $_proc setHex\n"
  h= getWoValue(shexwo)
<<"%V$h\n"

  setFromHex(h);
<<"OUT $_proc setHex \n"
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

<<"$_proc $_ewoname  $(isadigit(_ewoname)) \n"

    if ( isadigit(_ewoname) ) {
      binval_hex( Atoi(_ewoname))
    }
}
//------------------------------------------------------
proc reset()
{
  binval_reset()
  for (i=0;i<16;i++) {
   binval_hex(i);
  }
}
//------------------------------------------------------
///////////////////////////////////////////////////////////////////


proc updateScreen()
{
       showDecVal()
}

//////////////////////////BKG LOOP/////////////////////////////////////////

 sWi(vp,@redraw);

//setFromHex("feed")

//setFromHex("cafe")

 setDec();

uint n_msg = 0

// Event vars
Svar msg
include "gevent"


while (1) {

     
      msg = eventWait()

      n_msg++;

<<"%V$n_msg   $_ewoname $_ewoproc\n"


// FIX -- 

 if (!(_ewoproc @= "")) {
         <<"callback |${_ewoproc}| $(typeof(_ewoproc))\n"

          $_ewoproc();
// FIX endless repeat of call back 	 
        <<"done callback |${_ewoproc}\n"
         
       }
 

/{
        if (_ewoproc @= "setHex") {
             setHex()
        }

        else if (_ewoproc @= "setDec") {
             setDec()
        }

        else if (_ewoproc @= "binset") {
	<<" to binset\n"
             binset()
        }

/}

         updateScreen()

<<"loop $n_msg\n"

    showDecVal()

    showHexVal()

    }

 exit_gs()

;

////////////////////   TBD -- FIX //////////////////////
