/* 
 *  @script mat-det.asl 
 * 
 *  @comment test mdet function 
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.22 C-Li-Ti]                               
 *  @date Tue Feb 16 13:54:54 2021 
 *  @cdate Tue Feb 16 13:54:54 2021 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


a= 4.0;
b= 6.0;
c= 3.0;
d=8.0
e=1.0
f = 3.0
g = 4.0
h= 5.0;
i = 6.0;
j= 0;
k= 0;
l= 0;
m= 0;
n= 0;
o= 0;
p= 0;


chkIn()

 z = a*d - b*c;

float A[] = {a,b,c,d}


  A.Redimn(2,2)

<<"A= \n $A\n"
<<"/////////\n";

<<"%(2,\t, ,\n)$A\n"

//  mprt(A) //  TBF bug

A.pinfo()

  det= mdet(A);  // TBF

det.pinfo()

<<"$e det is $det\n"

chkR(det,z);


a= 6.0;
b= 1.0;
c= 1.0;
d=4.0
e=-2.0
f = 5.0
g = 2.0
h= 8.0;
i = 7.0;


z= 0.0;



float B[] = {a,b,c,d,e,f,g,h,i};

  B.Redimn(3,3)

<<"B= \n $B\n"
<<"/////////\n";

<<"%(3,\t, ,\n)$B\n"

<<"$z  $a $b $c $d $e $f $g $h $i  \n"


Str Txt = "a(ei − fh) − b(di − fg) + c(dh − eg)"

ks= Txt.slen() ; // TBF should work

<<"$ks $Txt\n"

ks=slen(Txt)

uchar mc= Txt[2];
<<"$k   $mc %c $mc\n"

  for (j= 0; j < 10; j++) {

   mc= Txt[j];
<<"$j   $mc %c $mc\n"

  }

Txt = "a(ei - fh) - b(di - fg) + c(dh - eg)"

k= Txt.slen() ; // TBF should work

<<"$k $Txt\n"


 for (j= 0; j < 10; j++) {

   mc= Txt[j];
<<"$j   $mc %c $mc\n"

  }


//z= a * (e * i − f * h) ; // no ascii

//<<"laplace pattern method = $z\n"



//z= a(ei − fh) − b(di − fg) + c(dh − eg);

//<<"laplace pattern method = $z\n"

//exit()




 z = a * (e * i - f * h);

<<"$z  $a $b $c $d $e $f $g $h $i  \n"



  z = a*(e*i - f*h) - b*(d*i - f*g) + c*(d*h - e*g);



<<"laplace pattern method = $z\n"



  det= mdet(B)

<<"ludcmp Crout = $det\n"

<<"%V$z $det \n"

chkR(det,z);

  f = -8;
 B[1][2] = f;

  det= mdet(B)

  z = a*(e*i - f*h) - b*(d*i - f*g) + c*(d*h - e*g);
<<"%V$z $det \n"


float v[9];

//  3x3 //
B[1][2] = 5;

         v = B;
	 v.redimn(9)
v.pinfo();


float sum = 0.0;
//=======================//
void m3x3()
{
 float m3;
        m3 = v[0] * (v[4] * v[8] - v[5]*v[7]); // d*-1
        sum = m3;
        <<"%V$sum $m3\n"
	m3 =v[1] * (v[3] * v[8] - v[5]*v[6]);
	sum -= m3;
	<<"%V$sum $m3\n"
	m3 =v[2] * (v[3] * v[7] - v[4]*v[6]);
	sum += m3; 
	<<"%V$sum $m3\n"
}
//======================//
        m3x3();
      
<<"%V $sum\n"	




float C[] = {16, 3, 2, 13, 5, 10, 11, 8, 9, 6, 7, 12, 4 ,15, 14, 1};

<<" $(Cab(C)) $(typeof(C)) \n"
<<"%V$C \n"

  C.Redimn(4,4)


  det= mdet(C)


<<"$det \n"

float D[]  = vgen(FLOAT_,16,1,1);

<<"$D \n";


  D.Redimn(4,4)

  D[2][2] = 67;

    D[3][3] = -77;
    D[1][1] = 80;
  ldet= mdet(D)


<<"$ldet \n"

///////////////////////////////    4x4  ///////////////////////////////////////

//  partition into  4 3x3 and do the sums
//  via skipping the row and col for each ele in the first row


//  ele [0][0] row0 col 0

 det = 0.0;
  last_det = 0.0
  dsign = 1;
  for (skip_col = 0; skip_col <=3; skip_col++) {
  je = 0;
   for (r= 1; r <= 3 ; r++) {

   for (s= 0; s <=3; s++) {
    if (s != skip_col) {
     v[je] = D[r][s];
     <<"$je  $r,$s  $v[je]\n"
     je++;
     }
    }
  }

   sum = 0;
        m3x3();
   det +=   (dsign *sum)  * D[0][skip_col];
   dsign *= -1;
<<"%V $skip_col $sum $det $last_det\n"
   last_det = det;
   }

   <<"%V $det $ldet\n"




/////////////////////// 5x5 ? /////////////////////////////


void setm4x4(int scol)
{
  I.redimn(16)
    je =0;
    index = 5;  // first in second row
    for (r=0; r <4 ; r++) {

    for (s=0; s <= 4 ; s++) {
       if (s != scol) {
          I[je] = index;
	  je++;
        }
        index++;
    }
    }
<<"%(4,\t, ,\n)$I \n";

  I.redimn(4,4)
}


void m4x4()
{
 int scol;
 det = 0.0;
  last_det = 0.0
  dsign = 1;
  jk =0;
  for (scol = 0; scol <=3; scol++) {
  je = 0;
   for (r= 1; r <= 3 ; r++) {

   for (s= 0; s <=3; s++) {
    if (s != scol) {
     jk = I[r][s];
     v[je] = E[jk];
     <<"$je $jk $r,$s  $v[je]\n"
     je++;
     }
    }
  }

   sum = 0;
        m3x3();
   jk = I[0][scol];
   
   det +=   (dsign *sum)  * E[jk];
   dsign *= -1;
<<"%V $scol $sum $det $last_det\n"
   last_det = det;
   }

   <<"%V $det \n"
}



float E[25] = { \
  1, 2, 3, 4, 5,\
  21, 22, -23, 24, 25,\
  31, 32, 33, 34, 35,\
  41, -42, 43, 44, 45,\
  51, 52, 53, -54, 55,\
};

<<"$E\n"

 E.redimn(5,5);

 E.pinfo();


/// partition into  5 of  4x4 - each 4x4  is index array to original

//  MD.getEle(i) -- treat MD as vector obtain ith element 0- MD.size()








int I[] = vgen(INT_,16,0,1);


<<"$I \n"
<<"////\n"


// first of 5

  sum = 0;

   a= E[0];

   E.redimn(25);



    float det5 = 0;
    dsign5 = 1;
    for (skip_col = 0; skip_col < 5; skip_col++) {

    setm4x4(skip_col)
    I.pinfo()

    m4x4();
    det5 += (dsign5 * det * E[skip_col]);
    dsign5 *= -1;
    <<"%v $skip_col $det5 $det\n"
    }
   


 E.redimn(5,5)
 
 ldet= mdet(E)

<<"%V $det5 $ldet\n"




chkOut()


exit()