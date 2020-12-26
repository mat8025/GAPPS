//%*********************************************** 
//*  @script sscan.asl 
//* 
//*  @comment Test sscan  
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Thu Dec 24 12:13:17 2020 
//*  @cdate 1/1/2007 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%


# test ASL function sscan




chkIn(_dblevel)


str s = "hey baby you got the love I need" 
w = "life full of dreams"

int k =0

//<<"%I $s $k $w\n"

 //chkStr(w,"life full of dreams")

float f = 3.142.0
int j = 8


Str g


svar s1

na=sscan("3.1 47 hey ",'%f %d %s',&f,&k,g)

//na=sscan("3.1 47 hey ","\%f \%d \%s",&f,&k,g)

<<"$na %V$f $k $g\n"
<<"%V $f $k $g\n"



na = sscan("6.123 1 hey baby",'%f %d %s %s',&f,&k,&g,&s1)
<<"%V$na $f $k $g $s1\n"



na = sscan("3 1 hey baby","\%f \%d \%s \%s",&f,&k,&g,&s1)
<<" $na $f $k $g $s1\n"

na = sscan("4.5 2 hey baby",'%f %d %s %s',&f,&k,&g,&s1)
<<"%V $na $f $k $g $s1\n"



chkN(na,4)

chkR(f,4.5,6)

chkN(k,2)

<<"%V  $s1   $g \n"

chkStr(s1,"baby")

chkStr(g,"hey")

<<"%V $s1   $g \n"

chkStr(s1,"baby")

<<"%V $s1   $g \n"



s= "3 1 4:hey baby you got the love I need"

sscan("3 1",'%f %d',&f,&k)
<<"%V $f $k \n"

str lv
str lw
str lx
//sscan(s,"\%f \%d",f,k)


<<"%V $f $k \n"
sscan(s,"\%f \%d \%s",&f,&k,&g)

<<"%V $f $k $g\n"

sscan(s,'%f %d %d :%s %s',&f,&k,&j,&g)
//sscan(s,"\%f \%d \%d :\%s \%s",&f,&k,&j,&g,&s1)

<<"%V $f $k $j $g\n"


<<"%V $s \n"

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


