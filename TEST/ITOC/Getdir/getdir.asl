//%*********************************************** 
//*  @script getdir.asl 
//* 
//*  @comment test getdir SF  
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.3.2 C-Li-He]                                 
//*  @date Mon Dec 28 22:23:54 2020 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

checkIn()
wdir=!!"pwd"

<<"$wdir\n"
dir=getDir()

sz = Caz(dir)

<<"%V$sz\n"

<<"%V<$dir|>\n"
<<"<<$dir>>\n"

chkStr(wdir,dir);

name="mt"


<<"%V${dir[0]}/foo\n"

<<"%V$name/foo\n"

str sdir

sdir=getDir()

sz = Caz(sdir)

<<"%V$sz\n"

<<"%V<$sdir|>\n"

chkOut()