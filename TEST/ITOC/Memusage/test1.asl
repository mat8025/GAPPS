
setdebug(1,"keep","trace");

filterDebug(0,"args")


int a =2;

float y = atan(1.0) * 4;

checkMemory(1);
<<"%V $a $y\n"

float sum = 0;
Lmu = memused();
<<"$Lmu\n"
int MA[];

Mu = memused();
<<"$Mu\n"

N = atoi(_clarg[1])

for (i =  0; i < N;  i++) {
<<"<$i> in loop \n"
     //    sum += (y * i);
         sum += i;

      Mu = memused();
     <<"<$i> $sum $Mu\n"

   //   MA[i] = Mu[2];

   }

<<"out of loop $i\n"

<<"%V $sum\n"
Mu = memused();
<<"$Mu\n"
//<<"$MA\n"

