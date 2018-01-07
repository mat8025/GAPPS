///
///
///

//setdebug(1)

float Tar1[5][5];

Tar1[0][0] = 1;
Tar1[1][1] = 1;
Tar1[2][2] = 1;
Tar1[1][3] = 1;
Tar1[0][4] = 1;

//<<" $Tar1\n"

float Tar2[5][5];

Tar2[4][0] = 1;
Tar2[3][1] = 1;
Tar2[2][2] = 1;
Tar2[3][3] = 1;
Tar2[4][4] = 1;

//<<" $Tar2\n"

float Tar3[5][5];

Tar3[4][0] = 1;
Tar3[3][1] = 1;
Tar3[2][2] = 1;
Tar3[1][3] = 1;
Tar3[0][4] = 1;

sz= Cab(Tar3)
<<"$sz\n"
//<<" $Tar3\n"

float Tar4[5][5];

Tar4[0][0] = 1;
Tar4[1][1] = 1;
Tar4[2][2] = 1;
Tar4[3][3] = 1;
Tar4[4][4] = 1;

//<<"$Tar4\n"

Tar1->Redimn();

Tar2->Redimn();

T= vsplice(Tar1,Tar2)

Tar3->Redimn();

T= vsplice(T,Tar3)

Tar4->Redimn();

T= vsplice(T,Tar4)


float Tar[5][5];

Tar[2][0] = 1;
Tar[2][1] = 1;
Tar[2][2] = 1;
Tar[2][3] = 1;
Tar[2][4] = 1;

Tar->Redimn();

T= vsplice(T,Tar)

Tar = 0;

Tar->Redimn(5,5);

Tar[4][0] = 1;
Tar[4][1] = 1;
Tar[4][2] = 1;
Tar[4][3] = 1;
Tar[4][4] = 1;


Tar->Redimn();

<<"//////////\n"
<<" %(5,, ,\n)6.1f $Tar\n"

T= vsplice(T,Tar)



Tar = 0;

Tar->Redimn(5,5);

Tar[0][0] = 1;
Tar[0][1] = 1;
Tar[0][2] = 1;
Tar[0][3] = 1;
Tar[0][4] = 1;


Tar->Redimn();

<<"//////////\n"
<<" %(5,, ,\n)6.1f $Tar\n"

T= vsplice(T,Tar)

Tar = 0;

Tar->Redimn(5,5);

Tar[2][0] = 1;
Tar[2][1] = 1;
Tar[2][2] = 1;
Tar[1][3] = 1;
Tar[0][4] = 1;

Tar->Redimn();

<<"//////////\n"
<<" %(5,, ,\n)6.1f $Tar\n"

T= vsplice(T,Tar)




Tar = 0;

Tar->Redimn(5,5);

Tar[0][0] = 1;
Tar[1][1] = 1;
Tar[2][2] = 1;
Tar[2][3] = 1;
Tar[2][4] = 1;

Tar->Redimn();

<<"//////////\n"
<<" %(5,, ,\n)6.1f $Tar\n"

T= vsplice(T,Tar)




<<"$(Caz(T))\n"
//<<"vsz $T\n"


//<<"T: %(5,, ,\n)6.1f $T\n"

/{/*
// BUG ??
R = Tar1 @+ Tar2 @+ Tar3 @+ Tar4;

<<"R: %(25,, ,\n)6.1f $R\n"

<<"$(Caz(R))\n"
/}*/

<<"done prepare patterns --- all concatted to vec T\n"

// TBF xic @+   ???




