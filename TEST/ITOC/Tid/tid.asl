//%*********************************************** 
//*  @script tid.asl 
//* 
//*  @comment test typeof via %i %I  
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.98 C-He-Cf]                                
//*  @date Tue Dec 22 22:16:38 2020 
//*  @cdate 1/1/2003 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


//  print type id of variables

int i = 6

int k = 3

float f = 3.4

int v[3] = {1,2,3}

Str s = "mark"

<<"%I $i $f $k $s $v\n"

i++
<<"%I $k $i\n"

Str t = "terry"


<<"%I $t $s \n"

t->info(1)