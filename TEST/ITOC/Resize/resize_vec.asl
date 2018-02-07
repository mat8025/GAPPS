///
///
///


checkIn();

int V[20];


 V[10] = 47;

checkNum(V[0],0)
checkNum(V[10],47)
checkNum(V[19],0)
<<"$V\n"



  resize(V,30);


 V[20] = 80;
checkNum(V[20],80)
checkNum(V[29],0)
<<"$V\n"


//  should give error --- not dynamic

V[30] = 79;

checkNum(V[30],79)



<<"$V\n"
TR=testargs(V)


 resize(V,40);

V[35] = 80;

checkNum(V[35],80)

<<"%(1,,,\n)$TR\n"

 resize(V,6,6);

 V[0][3] = 79;
checkNum(V[0][3],79)


<<"$V\n";

TR=testargs(V)

<<"%(1,,,\n)$TR\n"




 Delete(V);



float V = 4*atan(1.0)
<<"%V $(Caz(V)) $V\n"


TR2=testargs(V)

<<"%(1,,,\n)$TR2\n"


checkOut();

