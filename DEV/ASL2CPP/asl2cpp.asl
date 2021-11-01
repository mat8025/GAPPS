

#include "debug";



if (_dblevel >0) {
   debugON()
}



chkIn(_dblevel)

ignoreErrors()
//// take asl script and convert to cpp src


// have to check statements have ;

//  array []   to ()    i.e. V[8] ==> V(8)


// range specs to R func args
//  V[1:9:2]    ==>   V(R(1,9,2))

//  asl for MD arrays

//  MA[1:-1:2] [1:3:1]   === > MA(R(1,-1,2), R(1,3,1))


// margin codes !a to  expanded code


//  <<" value is $s \n"   ===> printf() equiv or cout equiv


///  sfunc  rework  wans = scat(w1,w2,"hi")    --


///  many other things ???


str sin = "V[8]"

sout = ssub(sin,"[","(",0)

<<" $sin ==> $sout\n"

sout = ssub(sin,"]",")",0)

<<" ==> $sout\n"

sin = "V[9]abc";

sout = ssubrgx(sin,"]",")",0)

<<" $sin ==> $sout\n"

//  MA[1:-1:2][1:3:1]   === > MA(R(1,-1,2), R(1,3,1))

 sin = "MA [ 12: 18 :2] [1:3:1 ] =  MB [ 11: 17 :2] [2:5:1 ]";
<<" with white $sin \n"
 sin = dewhite(sin);
 tsin = sin
<<" sans white <|$sin|> \n"

///////////////   use ssub ////

// ][ to Rng(

sout = ssub(sin,"][","), Rng(",0)
<<"ssub $sin ==> $sout\n"
//sin = sout;
sout = ssub(sout,":",",",0)
<<"ssub $sin ==> $sout\n"
sout = ssub(sout,"[","(Rng( ",0)
<<"ssub $sin ==> $sout\n"
sout = ssub(sout,"]"," )) ",0)
<<"ssub $sin ==> $sout\n"
sout = dewhite(sout);
<<" sans white <|$sout|> \n"


///////////////////////////////////////////////////////////
sin = tsin;
sin = "MA [ 12: 18 :2] [1:3:1 ]"
sout = ssubrgx(sin,"]\\[",",",0)


<<"rgx $sin ==> $sout\n"

sout = ssub(sin,"][",",",0)
<<" $sin ==> $sout\n"


sin = "ABCABDABE"

sout = ssub(sin,"AB","XY",-1)
<<" $sin ==> $sout\n"

sout = ssubrgx(sin,"AB","XY",-1)
<<"rgx $sin ==> $sout\n"

sin = "MA [ 12:18:2] [11:17:2 ]"
<<" $sin \n"
// sed 's/\[\([0-9]*\):\([0-9]*\):\([0-9]*\)]/(Rng(\1,\2,\3),/'

sout = ssubrgx(sin,'([0-9]*):','Rng(\1, ',1)

//sout = ssubrgx(sin,"([0-9]*):([0-9]*):",'Rng(\1,\2,')
<<"rgx $sin ==> $sout\n"
sout2 = ssubrgx(sout,'([0-9]*):','\1,')
<<"rgx $sout ==> $sout2\n"

sout3 = ssubrgx(sout2,'([0-9]*):','\1,\2,',2)
<<"rgx 2 $sout2 ==> $sout3\n"

//sout4 = ssubrgx(sout3,'([0-9]*):','\1,',1)
//<<"rgx 3 $sout3 ==> $sout4\n"


chkT(1)
chkOut()




exit()



sout = ssub(sin,"][",",",0)

<<" $sin ==> $sout\n"




