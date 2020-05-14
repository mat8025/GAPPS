//%*********************************************** 
//*  @script declare.asl 
//* 
//*  @comment test basic declare statments 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Sat May  9 08:59:31 2020 
//*  @cdate Sat May  9 08:59:31 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();///
///
///

checkIn(_dblevel)

// make 1 to stop if error


proc Foo(int a, int b)
{
<<" $_proc $a $b\n"
  int x;
  int y = 1;

  checkNum (y ,1)
  x = a;
  y = b;

  c= x+ y;

<<"%V $c $a $b $x $y \n"

  return c;
}
//======================================//

int q;

int m = 3;
int n = 4;


 pri = Foo(m,n)


<<"%V $pri $m $n\n"

 x= Sin(0.5)

<<"%V $x\n"

checkNum(pri,7)


 pri = Foo(47,79)


<<"%V  $m $n\n"



checkNum(pri,126)



int ok = 0
int ntest = 0;

jj = 6

<<"%V$jj \n"

   CheckNum(jj,6)


int k =34

<<" %v $k \n"

   CheckNum(k,34)

float ytest = 1.234

<<"%V$ytest \n"

   CheckFNum(ytest,1.234,6)

// dynamic array declare with intial size

//float Leg[10+]


float Leg[12]



Leg[8] = 8


<<"%I $Leg \n"

 sz = Caz(Leg)

<<"%V$sz \n"

 cb  = Cab(Leg)

<<"%V$cb \n"


<<"%v $(Caz(Leg)) $(Cab(Leg)) \n"






double yr0 = -1.5
double yr1 = 1.5
double xr0 = -1.5
double xr1 = 1.5
//double xr9 = (2 * -1.6)
double xr9 = (-1.6 * 2)

<<"%V $xr0 $yr0 $xr1 $yr1 $xr9 \n"

   CheckNum(yr0,-1.5)
   CheckNum(xr0,-1.5)
   CheckNum(xr1,1.5)

<<"%V$xr9 $(typeof(xr9))\n"

   CheckFNum(xr9,-3.2000);

int M[10]

  M = 8

<<" $M[0] \n"

<<" $M \n"

<<"%V $(Caz(M)) $(Cab(M))\n"

    if (Caz(M) == 10) {
     ok++
    }
    else {
     <<"fail $(Caz(M)) != 10 \n"
     bad++
    }
 ntest++




   msz = Caz(M)

   CheckNum(msz,10)




int JJ[10][3]

<<" %V $(Caz(JJ)) $(Cab(JJ))\n"
  JJ[1][2] = 3

   CheckNum(JJ[1][2],3)

<<" $JJ[1][2] \n"




<<" %V $ntest  $k  \n"

<<" %V $k $ok $ntest $ytest \n"


<<" %V $(typeof(ntest))  $(typeof(ok)) $(typeof(k)) $(typeof(yr1)) \n"





int J[30]

  sz =Caz(J)
<<" %v $sz $(Cab(J)) \n"
 J[7] =7
 J[1] = 1

<<"%v $J[*] \n"
 
   CheckNum(J[7],7)
   CheckNum(J[1],1)



// FIX int MS[12] = 7

int MS[12]

MS = 37

<<"%V $(Caz(MS))  \n"
<<" $MS \n"

   CheckNum(MS[4],37)




<<" 2d  \m"
int P[10][3]

P = 76



<<"%(10,, ,\n) $P \n"

<<" $P \n"
<<" %v $P[2][1] \n"
  sz =Caz(P)
<<"$sz $(Cab(P)) \n"

      if (P[7][0] == 76) {
           ok++
      <<"2D pass $ok \n"
      }
      else {
      <<"2D fail $P[7][0] != 76 \n"
      }

      ntest++

   CheckNum(P[7][0],76)




 double dp = 10.0e25

 double dc =  2.9979e8

<<"%e$dp $dc  \n"

   CheckNum(dp,10.0e25)

   CheckNum(dc,2.9979e8)


  dz= dp / dc

  dq = dz * dc

<<" $(typeof(dp))  $(typeof(dz))\n"

<<"%e$dp $dc $dz $dq\n"

   CheckNum(dp,dq)

//<<" using which checkout ??\n"



prec=setap(20)

<<" %v $prec \n"

 pan p = 9.0345679979e8

 pan c =  2.9979e8

  z= p / c



  q = z * c 

<<" $(typeof(p))  $(typeof(z)) $(typeof(q))\n"

<<"   $p $c $z \n"
<<"  %e $p $c $z \n"
<<" %V %p $p $q $c $z \n"

<<"%v  %e $q \n"

//  check within acceptable range

   pan pr
   pan qr

<<"%V $p $q\n"
   pr = fround(p,0)
   qr = fround(q*1.0,2)

<<" %v $pr \n"
<<" %v $qr \n"


   CheckFNum(pr-1,qr,5)


proc Foo(int a)
{
int k = 2
<<" entered $_proc $a $k\n"
 checkNum(k,2)
 checkNum(a,A)
}


A =5
Foo(A)
A++
Foo(A)




//%*********************************************** 
//*  @script chardeclare.asl 
//* 
//*  @comment test declare of char vector 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                                
//*  @date Fri Apr 12 16:13:07 2019 
//*  @cdate 1/1/2000 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



Z="hey"

<<"%V $Z\n"

checkStr(Z,"hey");

S="hey";

<<"%V $S\n"

checkStr(S,"hey");

V="hey"  // gets hey"

<<"%V $V\n"

checkStr(V,"hey");



//sdb(1,@pline)
char c2 = 65;
char p2 = 'q';

<<"%I $c $p2 \n"
<<"%I %c$c2 %c$p2 \n"

<<"%V $c2\n"
<<"%V $p2\n"


str s = "abc"

<<"%I $s %s$s \n"

str tease = "a b c "

//FIXIT missing varname


tease->info(1)
<<"<|$tease|> \n"

uchar cv[] = { 65,47,79,0xBA };


 sz= Caz(cv)
 
<<"%V$sz $cv \n"

 cve = cv[0]

<<"%V$cve\n"
<<"%V$cv[0]\n"

 checkNum(cve,65)



 cv[0] = 'M';
 
 cve = cv[0]

<<"%V$cve\n"
<<"%V$cv[0]\n"

 checkNum(cv[0],77)



 str ls = 'abc'

 checkNum(cv[3],0xBA)



<<"%I %hx $cv \n"
<<"%I %s $cv \n"

wc = scnt("G")

<<"%V $wc $(typeof(wc))\n"

int iv[] = { 0,1,2,3,4,5,6,7,8,9, }

iv->info(1)
<<" $iv \n"

//sdb(1,@step)
char dv[] = { 'G', 84, 85, 78, 'O', '0', 69, 75,76,77 }


<<"$(vinfo(dv))\n"
<<"$dv \n"
<<"%c $dv \n"

 checkNum(dv[4], 'O' )
 checkNum(dv[5], '0' )
 checkNum(dv[6], 69 )
 checkNum(dv[9], 77 )
 checkNum(dv[0], 'G' ) 



char a = 'G';

<<" $(vinfo(a)) \n"

<<"%V $dv[0] $a \n"

 checkNum(dv[0],a)

 checkNum(dv[0], wc )

 checkNum(dv[0], 'G' )


 checkStage()

<<"%V $dv  \n"

<<"%V $dv[1]  \n"

 checkNum(dv[1],84)



  char b = dv[4];

<<"%V $b %d $b\n"
<<"%V $dv[4]\n";

<<"dv %d $dv\n"
<<"dv %c $dv\n"

 printargs(dv[4],'O')
 checkNum(dv[4], 'O' )
  checkNum(dv[4], 79 )

 checkOut()

<<" whaat is happening here $dv[5] \n"

 tc = scnt("0");
 <<"%V $tc\n";
 checkNum(dv[5], scnt("0") )
<<" Imm not really cleaaaaaaar \n" 


 checkNum(dv[5], '0' )



char lv[] = { 'ABCDEF MARK$S PERRY NEEDS TO FOCUS ' }

sz = Caz(lv)
<<"%v $sz \n"
<<"%V $lv \n"

<<" $lv[0] \n"
<<" $lv[1] \n"
//iread("->");

char ev[] = { "ABCDEF MARK$S BERRY NEEDS TO FOCUS " }


<<"%V$ev \n"
sz = Caz(ev)
<<"%v $sz \n"

<<"%V %c $ev \n"
<<"%V $ev \n"

//iread("->");

 checkNum(ev[0],'A')
 checkNum(ev[7],'M')

<<"%I %s $lv \n"

 checkNum(lv[0],'A')
 checkNum(lv[7],'M')
 checkNum(lv[11],'$')


 <<" chardec DONE\n"

for (k=0;k<sz;k++) {

<<"$k $ev[k] %c $ev[k] \n"
}


 checkStage("char")
 


 checkOut()




