//%*********************************************** 
//*  @script vector.asl 
//* 
//*  @comment test vector ops 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.57 C-He-La]                              
//*  @date Tue Jun  9 20:28:45 2020 
 
//*  @cdate Thu Apr 16 23:13:22 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%




chkIn(_dblevel)

V= vgen(FLOAT_,10,0,1)

<<"%V6.1f $V\n"


T = V + 1.0

<<"(V+1) %6.1f$T \n"

chkN (T[1],2)

T = 2+ V 

<<"(V+2) %6.2f$T \n"

chkN (T[1],3)

T = (2+ V)/4.0 

<<"(2+V/4.0) %6.2f$T \n"

chkN (T[1],0.75)


// FIX XIC fail
H = (4.0 * (V+1))
<<"%V%6.1f $H\n"

T = (2+ V)/(4.0 * (V+1)) 

chkN (T[1],0.375)

<<"%6.4f$T \n"

<<"$(Caz(T)) $(Cab(T))\n"


checkStage("vop")

proc ask()
{
   ok=checkStage();
   <<"%6.2f$ok\n"
  if (ok[0] < 100.0) {
  ans=iread();
  }

}





proc foo()
{

<<"in $_proc Y: $Y\n"
<<"in $_proc T: $T\n"

  Y *= T
<<"out $_proc $Y\n"

}
//========================




 Y = vgen(FLOAT_,10,1,1);


<<"Y $Y\n"
Y->info(1)
  Y *= 2;
Y->info(1)
<<"$Y\n"



chkN (Y[2],6)



  T = vgen(FLOAT_,10,0,1);

<<"$T\n"

//chkN (T[2],2)
//

  Y *= T

<<"Y: $Y\n"

chkN (Y[2],12)


 Y = vgen(FLOAT_,10,0,1);


<<"Y $Y\n"

  Y *= 2;

<<"$Y\n"

chkN (Y[2],4)


  Y =  Y * T
  


<<"Y: $Y\n"


chkN (Y[2],8)



<<"$Y\n"

 foo()

chkN (Y[2],16)

<<"$Y\n"

 foo()

chkN (Y[2],32)
<<"$Y\n"

 Y *= T


chkN (Y[2],64)

<<"$Y\n"



foo()

chkN (Y[2],128)


 Y = vgen(FLOAT_,10,0,1);

<<"Y: $Y\n"
<<"T $T\n"

  Y += T;

<<"Y: $Y\n"

chkN (Y[2],4)

chkN (Y[9],18)

  Y -= T;

<<"Y: $Y\n"

chkN (Y[2],2)

chkN (Y[9],9)

checkStage("opeq")



//%*********************************************** 
//*  @script vecrange.asl 
//* 
//*  @comment test vector range ops 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Tue Mar 12 07:50:33 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%



  V= vgen(INT_,10,0,1);

 <<"$V\n"


  chkN (V[2],2)
  chkN (V[9],9)

  T = V[1:3]
  <<"$T\n"

  j=1;
  
  for (i=0;i<3;i++) {
    chkN (T[i],j++)
  }
 
  T = V[1:3] + V[2:4]
  <<"$T\n"
   j = 3
   for (i=0;i<3;i++) {
    chkN (T[i],j); j +=2;
  }


  T = V[1:3] + V[2:4] + V[3:5]
  <<"$T\n"

   j = 6;
   for (i=0;i<3;i++) {
    chkN (T[i],j); j +=3;
  }


  T = V[1:3] + V[2:4] + V[3:5] + V[4:6]
  <<"$T\n"
  
   j = 10;
   for (i=0;i<3;i++) {
    chkN (T[i],j); j +=4;
  }

   S= V[7:9] + V[2:4]
<<"$S\n"   
   V[0:2] =  V[7:9] + V[2:4]

<<"$V\n"

  chkN (V[0],S[0])
  chkN (V[1],S[1])
  chkN (V[2],S[2])  

   R=vvcomp(S,V,3)
   <<"$R\n"

  checkStage("vecrange")

//%*********************************************** 
//*  @script veccat.asl 
//* 
//*  @comment test concat of vectors using @+ operator 
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                 
//*  @date Fri Feb  8 20:22:01 2019 
//*  @cdate 1/1/2001 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

int vec1[]  = { 1,2,3};

<<"%V $vec1 \n"

vec1->info(1)

int vec2[] = {7,8,9}

<<"%V $vec2\n"

vec2->info(1)

//int vec3 []  = vec1 @+  vec2;   // TBF -- WS should be OK
int vec3[]  = vec1 @+  vec2;

<<"$vec3[1] $vec3[2] $vec3[4] \n"
<<"%V $vec3 \n"
//exit()

vec4 = vec1 @+  vec2;

<<"%V $vec4 \n"


chkN (vec4[5],9)

chkN (vec4[1],2)

vec4 = vec4 @+  vec2;

<<"%V $vec4 \n"

chkN (vec4[8],9)
chkN (vec4[1],2)

vec5 = vec1 @+  vec2 @+ vec3 ;

<<"%V $vec5 \n"

chkN (vec5[1],2)

checkStage("veccat")

//%*********************************************** 
//*  @script veclhrange.asl 
//* 
//*  @comment test vector range ops 
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Mon Apr  8 08:27:28 2019 
//*  @cdate Tue Mar 12 07:50:33 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


IV= vgen(INT_,10,0,1)


<<"$IV \n"


IV *=2 ;


<<"$IV \n"

chkN (IV[1],2)
chkN (IV[2],4)
chkN (IV[3],6)
chkN (IV[4],8)

IV2= vgen(INT_,15,0,1)


<<"$IV2 \n"


IV2[1:3] *=2 ;

chkN (IV2[1],2)
chkN (IV2[2],4)
chkN (IV2[3],6)
chkN (IV2[4],4)

checkStage("self op * on lhrange  ")


<<"$IV2 \n"


IV2[1:8:2] +=7 ;

checkStage("self op + on lhrange  ")

<<"$IV2 \n"
chkN (IV2[0],0)
chkN (IV2[1],9)
chkN (IV2[2],4)
chkN (IV2[3],13)


IV3 = IV2[1:-3]

chkN (IV3[0],9)
chkN (IV3[1],4)
chkN (IV3[2],13)

checkStage("RH range inserted correctly to new vec")
<<"$IV3 \n"

//  what of range overruns current array sizes
IV3[7:9] =IV2[1:3]

<<"$IV3 \n"
IV3->info(1)
chkN (IV3[7],9)
chkN (IV3[8],4)
chkN (IV3[9],13)

<<"$IV3\n"
IV3->Info(1);
checkStage("RH range inserted correctly to LH range")


//int IV4[>5] = IV3
// BUG XIC
// BUG  does not clear existing range
IV3->info(1)

int IV4[>5] = IV3[::]   // BUG xic

<<"$IV4\n"

IV4->info(1)



<<"$IV3\n"

<<"$IV3[0:-1:2]\n"
<<"$IV3[1:-1:2]\n"


IV5 =    IV3[0:-1:2] + IV3[1:-1:2]

<<"$IV5 \n"
i=0;
chkN (IV5[i++],13)
chkN (IV5[i++],17)
chkN (IV5[i++],18)
chkN (IV5[i++],23)
chkN (IV5[i++],17)
//chkN (IV5[i++],23)
chkN (IV5[i++],23)

//cn IV5[i++] 23

//13 17 18 23 17 23


checkStage("lhrange")


/{/*

  TBD
  warning for overrun of fixed array ?
  allow runtime mod to dynamic? - or exit store or op on vector 
 
   int IV4[>5] = IV3
 
  BUG XIC
  BUG  does not clear existing range

/}*/




chkOut ()
  