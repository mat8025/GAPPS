///
///
///

checkIn()

setDebug(1,"trace")

filterDebug(2,"xxx");

filterFileDebug(2,"args_e.cpp","declare_type_e.cpp");
char c = '?';

float f = atan(1.0) *4;

F=vgen(INT_,5,20,1)
D = vgen(FLOAT_,20,10,1)

D->redimn(2,5,2)

//svar help="Ayudame ahora"
svar help

help[0] = "Ayudame ahora";
help[1] = "que esta pasando?";

//Pan P = exp(1.0); // TBF

Pan R;
R = exp(1.0);

P = &R;

 A = testargs(2,help,47,f,"hey",1.2,1,',',"*",c,F,D,R,P,@hue,"red",&F[2])


//asn=iread(":");
//<<"%(1,,,\n)$A\n"

 int b = ',';

<<"%V %c $b $(',') $c\n"

for (i = 0; i <10; i++) {
<<"<$i> value $A[i] \n"
}

ans = A[11];

checkStr(ans,"47")

<<"$help\n"



checkOut();