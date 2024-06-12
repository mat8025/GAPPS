//%*********************************************** 
//*  @script for.asl 
//* 
//*  @comment Test For syntax 
//*  @release CARBON 
//*  @vers 1.5 B Boron [asl 6.2.98 C-He-Cf]                                  
//*  @date Mon Dec 21 22:14:37 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

//chkIn()

chkIn()


prog = GetScript()

N = GetArgI()

<<"%V $N \n"

ans=ask("$N ?",0)
if (N == 0) {
 N = 24
}
//tt = GetArgI()

tt = 18

<<"%V $tt $N \n"

#{

 This will calculate a times table

#}


<<" $N $tt times table  test for statement \n"

//int k = 0



int cnt = 0

<<"%i $tt \n"
<<"%i $N \n"

//int b

k = 2

  a= k * tt
<<"%i $a  \n"



//int a
  for ( k = 1; k <= N ; k++) {

  a= k * tt

 <<" $k * $tt = $a \n"
  cnt = k
 }

<<" DONE %V $k  $N  \n"

<<" $cnt == $N ?? \n"

   chkN(cnt,N)

 b = cnt * tt

<<"%v $a ? ==  %v $b \n"


   chkN(a, b)


   chkN(a, (cnt * tt))

/*
A=ofr("for.asl")

jc = 0;
for (j=0; j<3; j++) {
   T = readline(A);

   where = ftell(A)
<<"$j $where line is $T \n"
    jc++;
   }


chkN(jc,3)
*/
   chkOut(1)



///////////////////////////////
