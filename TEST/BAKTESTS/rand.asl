//%*********************************************** 
//*  @script rand.asl 
//* 
//*  @comment test Random SF 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sun Apr 12 18:53:17 2020 
//*  @cdate Sun Apr 12 18:53:17 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
///  test rand functions
///

/{/*

Rand
A= Rand(n,max)
returns a vector of n random numbers in range (1 to max)
or a single number if called with no arguments
if max is not specified the numbers will be in the range 0 and RAND_MAX
as defined on Unix math rand() function.
Use randseed() to seed the random function- 
randseed with no arguments uses unix time function to seed random.

R=Urand(n,seed)

returns a vector of n numbers in the range 0 to 1.0  -- 
if seed is zero the time function is used as a seed
 

/}*/


R=Urand(10,0);

N = 6

randseed(7)

V= Rand(6,42)

<<"$V\n"

U= Rand(6,42,0)

<<"$U\n"

randseed()

U= Rand(6,42,0)

<<"$U\n"

U->sort()

<<"$U\n"

W= Rand(100,100)

<<"%(10,, ,\n)$W\n"

W->sort()

<<"%(10,, ,\n)$W\n"


H= Hist(W,1,0,100)


<<"Hist \n"
<<"%(10,, ,\n)$H\n"


L = H

L->sort()

<<"%(10,, ,\n)$L \n"

///
///  test Urand function
///

/{/*

R=Urand(n,seed)

returns a vector of n numbers in the range 0 to 1.0  -- 
if seed is zero the time function is used as a seed
/}*/

CheckIn();

R=Urand(10,7);

<<"$R\n"


R=Urand(10,0);


<<"$R\n"
// no float sort

F=QuickSort(R)

<<"$F\n"


B=BubbleSort(R)

<<"$B\n"


T=Sort(R*1000);


<<"$T\n"

<<" VecSubSet //////\n"


<<"$V\n"

float VF[20];
 VF[5:10] = Urand(6,0)

<<"$V\n"

 VF[15:18] = Urand(10,0)

<<"$V\n"

checkNum(VF[0],0,EQU_);
//ans=iread()

<<"%6.2f$VF[15] %d $(GTE_)\n"

checkNum(VF[15],0.0,GTE_);

checkStage("urand")

F = grand(100,1)
<<"%(10,, ,\n)+6.5f$F \n"



F = grand(100,0)
<<"%(10,, ,\n)+6.5f$F \n"


F = grand(100,0) * 20000
<<"%(10,, ,\n)+8.1f$F \n"

short S[]

S = F


<<"%(10,, ,\n)$S \n"


CheckOut()

exit()



