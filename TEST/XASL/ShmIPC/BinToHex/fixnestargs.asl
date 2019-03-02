///
///
///

setdebug(1,@keep,@~trace);

bval = "1000100010001000"

d= bin2dec(bval);

     <<"%V $bval $d\n"
val= dec2hex(bin2dec(bval));
      <<"%V $val \n"

val= dec2hex(bin2dec("$bval"));
      <<"%V $val \n"

val2 = scat("xxx_",dec2hex(bin2dec("$bval")));

<<"%V $val2\n"


d= hex2dec(dec2hex(bin2dec("$bval")));
      <<"%V $bval $d \n"


b1 = "100111011"

b2 = "10001000"

<<"%V $b1 $b2\n"

val2 = scat("xxx_",dec2hex(bin2dec("$(scat(b1,b2))")));

<<"%V $b1 $b2 $val2\n"

//exit()


proc numChange (nval)
{

nd= hex2dec(dec2hex(bin2dec("$nval")));
      <<"%V $nval $nd \n"

lval2 = scat("lxxx_",dec2hex(bin2dec("$nval")));

<<"%V $lval2\n"

}


proc n2 (aval)
{

    numChange(aval);

}


  numChange(bval);

bval = "1000100010001001"

 numChange(bval);

  n2(bval)

bval = "1000100010011001"

n2(bval)


Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }



      vp = cWi(@title,"BinToHex",@resize,0.1,0.1,0.95,0.95,-1)

   sWi(vp,@pixmapon,@drawon,@save,@bhue,"blue")

 int decval = 9474;  
 sdecwo=cWo(vp,@BV,@name,"SetDec",@VALUE,"$decval",@callback,"setDec",@help," decimal value")

 shexwo=cWo(vp,@BV,@name,"SetHex",@VALUE,"$decval",@callback,"setHex",@help," hex value")

 int numwos[] = {sdecwo,shexwo}

 wo_htile(numwos, 0.1,0.1,0.6,0.4,0.05)

int byte3[4]

// need to fix postincrement
   i =0

   byte3[i++]=cWo(vp,@BS,@name,"15",@color,YELLOW_,@value,"1")
   byte3[i++]=cWo(vp,@BS,@name,"14",@color,YELLOW_,@value,2)
   byte3[i++]=cWo(vp,@BS,@name,"13",@color,YELLOW_,@value,3)
   byte3[i++]=cWo(vp,@BS,@name,"12",@color,YELLOW_,@value,"47")

val5 = getWoValue(byte3);

<<"%V $(typeof(val5)) $val5\n"


val6 = getWoValue(byte3[2]);

<<"%V $(typeof(val6)) $val6\n"



 xwid = 0.20
 bx = 0.05
 bX = bx + xwid
 yht = 0.2


 bY = 0.95
 by = bY - yht

xpad = 0.02

int vec[4];
   vec[0] = 47;
   vec[1] = 79
   vec[2] = 80;
   vec[3] = 85;
   
   sWo(byte3,@value,vec,@style,"SVB",@callback,"binset")
   wo_htile(byte3,bx,by,bX,bY,xpad)



int hexlow[4];

hexlow[3] = sdecwo;


val3 = "$(getWoValue(sdecwo))"

<<"%V $val3\n"


val4 = "$(getWoValue(byte3))"

<<"%V $val4\n"

val6 = getWoValue(byte3[1]);

<<"%V $(typeof(val6)) $val6\n"


val5 = getWoValue(byte3);

<<"%V $(typeof(val5)) $val5[::]\n"




val2 = scat("xxx_",dec2hex(bin2dec("$(getWoValue(sdecwo))")));



//sWo(hexlow[3],@value,dec2hex(bin2dec("$(getWoValue(sdecwo))")),@update)


exit()      