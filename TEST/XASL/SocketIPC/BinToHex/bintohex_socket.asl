//%*********************************************** 
//*  @script bintohex_socket.asl 
//* 
//*  @comment test sockets 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                  
//*  @date Thu Feb 21 14:27:47 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


include "debug.asl"
include "gevent.asl"
include "hv.asl"
include "tbqrd";
debugON()

// want do this statement if DB is define

//Graphic = checkGWM()


 //rmsg = readgwmsock();
// <<"got $rmsg \n"



   // needs screen spec -- make 0 default
   vp = cWi(@title,"BinToHex",@resize,0.1,0.1,0.95,0.95,-1)

   sWi(vp,@pixmapon,@drawon,@save,@bhue,"blue")

   sWi(vp,@clip,0.1,0.2,0.9,0.9)
   
   titleButtonsQRD(vp);
   titleVers();
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


 decwo=cWo(vp,"BV",@name,"DEC",@VALUE,decval,@help," decimal value")
 octwo=cWo(vp,"BV",@name,"OCT",@VALUE,decval,@help," octal value")

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

   byte3[i++]=cWo(vp,"BS",@name,"15",@color,"yellow")
   byte3[i++]=cWo(vp,"BS",@name,"14",@color,"yellow")
   byte3[i++]=cWo(vp,"BS",@name,"13",@color,"yellow")
   byte3[i++]=cWo(vp,"BS",@name,"12",@color,"yellow")

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

   byte2[i++]=cWo(vp,"BS",@name,"11",@color,"yellow")
   byte2[i++]=cWo(vp,"BS",@name,"10",@color,"yellow")
   byte2[i++]=cWo(vp,"BS",@name,"9",@color,"yellow")
   byte2[i++]=cWo(vp,"BS",@name,"8",@color,"yellow")

<<"byte2 $byte2 \n"

//<<"$byte2 \n"
 bx = bX + xpad*2
 bX = bx + xwid
   sWo(byte2,@value,"0",@style,"SVB",@callback,"binset")
   sWo(byte2,@CSV,"0,1")
   wo_htile(byte2,bx,by,bX,bY,xpad)


int byte1[4]
   i =0

   byte1[i++]=cWo(vp,"BS",@name,"7",@color,"yellow")
   byte1[i++]=cWo(vp,"BS",@name,"6",@color,"yellow")
   byte1[i++]=cWo(vp,"BS",@name,"5",@color,"yellow")
   byte1[i++]=cWo(vp,"BS",@name,"4",@color,"yellow")

<<"byte1 $byte1 \n"


//<<"$byte1 \n"
 bx = bX + xpad*2
 bX = bx + xwid
   sWo(byte1,@value,"0",@style,"SVB",@callback,"binset")
   sWo(byte1,@CSV,"0,1")
   wo_htile(byte1,bx,by,bX,bY,xpad)

int byte0[4]

   i =0

   byte0[i++]=cWo(vp,"BS",@name,"3",@color,"yellow")
   byte0[i++]=cWo(vp,"BS",@name," 2",@color,"yellow")
   byte0[i++]=cWo(vp,"BS",@name," 1",@color,"yellow")
   byte0[i++]=cWo(vp,"BS",@name," 0",@color,"yellow")

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

   hexlow[i++]=cWo(vp,"BS",@name,"byte_3",@color,"yellow")
   hexlow[i++]=cWo(vp,"BS",@name,"byte_2",@color,"yellow")
   hexlow[i++]=cWo(vp,"BS",@name,"byte_1",@color,"yellow")
   hexlow[i++]=cWo(vp,"BS",@name,"byte_0",@color,"yellow")

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
int bv[4]
     
     woval = getWoValue(hexlow[wb]);
<<"%V $woval\n"
     bs= dec2bin(hex2dec(woval))
     
     //bs= dec2bin(hex2dec(getWoValue(hexlow[wb])));

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
<<" Done \n"
}
//---------------------------------------
proc showDecVal()
{

low0=getWoValue(hexlow[0])
<<"%V $low0\n"
low1=getWoValue(hexlow[1])
<<"%V $low1\n"
low2=getWoValue(hexlow[2])
<<"%V $low2\n"
low3=getWoValue(hexlow[3])
<<"%V $low3\n"

hstr = "$low0 $low1 $low2 $low3"

 //hstr = "$(getWoValue(hexlow[0])) $(getWoValue(hexlow[1])) $(getWoValue(hexlow[2])) $(getWoValue(hexlow[3]))"
//<<"$hstr \n"
    decval = hex2dec(hstr)
    sWo(decwo,@value,decval,@update)
    octval = dec2oct(decval)
    sWo(octwo,@value,octval,@update)
}
//---------------------------------------
proc binval_hex(wbit)
{
  if (wbit <= 3) {
     b0=getWoValue(byte0);
    // sWo(hexlow[3],@value,dec2hex(bin2dec("$(getWoValue(byte0))")),@update)
     sWo(hexlow[3],@value,dec2hex(bin2dec("$b0")),@update)
  }
  elif (wbit <= 7) {
    b1 = getWoValue(byte1);
  //  sWo(hexlow[2],@value,dec2hex(bin2dec("$(getWoValue(byte1))")),@update)
    sWo(hexlow[2],@value,dec2hex(bin2dec("$b1")),@update)
  }
  elif (wbit <= 11) {
    b2 = getWoValue(byte2);
    sWo(hexlow[1],@value,dec2hex(bin2dec("$b2")),@update)
  }
  else {
    b3 = getWoValue(byte3);
    sWo(hexlow[0],@value,dec2hex(bin2dec("$b3")),@update)
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
  int k;
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
  h=dec2hex(d)
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

      if ( _ewoname @= "byte_0" ) {
          hexval_bin(3, Woid)
      }

      if ( _ewoname @= "byte_1" ) {
          hexval_bin(2, Woid)
      }

      if ( _ewoname @= "byte_2" ) {
          hexval_bin(1, Woid)
      }

      if ( _ewoname @= "byte_3" ) {
          hexval_bin(0, Woid)
      }
}
//========================//
proc binset()
{
//<<"$_proc $_ewoname \n"
    if ( isadigit(_ewoname) ) {
      binval_hex( Atoi(_ewoname))
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

proc updateScreen()
{
       showDecVal()
}

//////////////////////////BKG LOOP/////////////////////////////////////////

setFromHex("feed")
setFromHex("cafe")

 sWo(sdecwo,@value,1964,@update)
 setDec()
 sWo(decwo,@value,@update)

dn = 1234

sWo(sdecwo,@value,dn,@update)
 setDec()
 sWo(decwo,@redraw)
showDecVal()

while (1) {

 dn=iread("num: ")
 <<"%V$dn \n"
 if (dn == -1) {
  break;
 }

sWo(sdecwo,@value,dn,@update)
 setDec()
 sWo(decwo,@redraw)
 showDecVal()

}

 <<"%V$dn \n"





uint n_msg = 0
   while (1) {

     
      eventWait();
      
      n_msg++
<<"%V$n_msg\n"
     
       if (!(_ewoproc @= "")) {
         <<"calling |${_ewoproc}| $(typeof(_ewoproc))\n"
         $_ewoproc()        
       }

         updateScreen()

    }

 exit_gs()

;

////////////////////   TBD -- FIX //////////////////////
