
<|Use_=
Demo  of sscan;
///////////////////////
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}

filterFileDebug(REJECT_,"scopesindex_e.cpp","scope_e.cpp","scope_findvar");
filterFileDebug(REJECT_,"ds_sivbounds","ds_sivmem","exp_lhs_e");


chkIn()



char s[] = "hey baby you got the love I need" ;

<<"%s $s \n"




w = "life full of dreams"

<<"%s $s\n"


str g
str s1



na=sscan(s,'%s %s',&g,&s1)

<<"$na <$g> <$s1> \n"

uchar C[20];

 C[0] = 57;
 C[1] = 56;
  C[2] = 55;
    C[3] = 54;
        C[4] = 53;
	        C[5] = 0;

int ws;
int ws2;
short sw;
short sw2;
na=sscan(C,'%c %c %c %c',&ws,&ws2,&sw,&sw2);

<<"$na <$ws> <$ws2> <$sw> <$sw2>\n"


na=sscan(&C[0],'%d',&ws);

<<"$na <$ws> \n"

na=sscan(&C[1],'%d',&ws);

<<"$na <$ws> \n"



int k =0

//<<"%I $s $k $w\n"

 //chkStr(w,"life full of dreams")

float f = 3.142.0
int j = 8


na=sscan("3.1 4 hey ","\%f \%d \%s",&f,&k,&g)
<<"$na %V$f $k $g\n"
<<"%I $f $k $g\n"



na = sscan("6.123 1 hey baby",'%f %d %s %s',&f,&k,&g,&s1)
<<"%V$na $f $k $g $s1\n"



//na = sscan("3 1 hey baby","\%f \%d \%s \%s",&f,&k,&g,&s1)
//<<" $na $f $k $g $s1\n"

na = sscan("4.5 2 hey baby",'%f %d %s %s',&f,&k,&g,&s1)
<<" $na $f $k $g $s1\n"



chkN(na,4)

chkR(f,4.5,6)

chkN(k,2)

<<"%I$s1   $g \n"

chkStr(s1,"baby")

chkStr(g,"hey")

<<"%I $s1   $g \n"

chkStr(s1,"baby")

<<"%I $s1   $g \n"


//chkOut()



s= "3 1 4:hey baby you got the love I need"

sscan("3 1",'%f %d',&f,&k)
<<"%I $f $k \n"

str lv
str lw
str lx
//sscan(s,"\%f \%d",f,k)


<<"%I $f $k \n"
sscan(s,"\%f \%d \%s",&f,&k,&g)

<<"%I $f $k $g\n"

sscan(s,'%f %d %d :%s %s',&f,&k,&j,&g)
//sscan(s,"\%f \%d \%d :\%s \%s",&f,&k,&j,&g,&s1)

<<"%I $f $k $j $g\n"


<<"%I $s \n"

na = sscan(s,'%f %d %d %s %s %s %* %s',&f,&j,&k,s1,lv,lw,lx)

<<" SQ \n"

<<"$s\n"
<<"$na $f $j $k $s1 $lv $lw $lx\n"

<<" $lw\n"

g="star"
s1= " bright"

news = scat(g,s1)
<<"%V$news $g $s1\n"

chkStr(news,"star bright")


chkOut()
