//%*********************************************** 
//*  @script varname.asl 
//* 
//*  @comment test indirect var assign 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.98 C-He-Cf]                                
//*  @date Tue Dec 22 17:24:59 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

//
// generates var names 
// 



chkIn(_dblevel)

int a_3 = 66

vn = "a_3"

k = $vn

$vn = 77

<<"%V$vn $k $a_3 \n"

chkN(k,66)

chkN(a_3,77)



//a_0 = 700
  a_1 = 4



//a_4 = 20

<<"%V$a_1 \n"



vn = "a_3"
$vn = 80

<<"%V$a_3 \n"

i = 4
vn = "a_$i"
<<"%V$vn\n"
$vn = 79

<<"%V$a_4 \n"
vn = "a_8"
$vn = 88
<<"%V$a_8 \n"


i = 7
vn = "a_$i"
<<"%V$vn\n"
$vn = 47

<<"%V$a_7 \n"


//"%V$(a_$i) \n"

for (i = 0; i < 15; i++) {
  vn = "a_$i"
  $vn = i*2
  y = $vn
  <<"$i $vn $y $($vn)\n"
}

<<"%V$a_2 $a_3 $a_10 $a_11\n"
chkN(a_14,28)
chkOut()

