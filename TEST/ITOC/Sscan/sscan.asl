

# test ASL function sscan

checkIn(_dblevel)


str s = "hey baby you got the love I need" 
w = "life full of dreams"

int k =0

//<<"%I $s $k $w\n"

 //CheckStr(w,"life full of dreams")

float f = 3.142.0
int j = 8
str g

str s1

na=sscan("3.1 47 hey ","\%f \%d \%s",&f,&k,&g)

<<"$na %V$f $k $g\n"
<<"%V $f $k $g\n"



na = sscan("6.123 1 hey baby",'%f %d %s %s',&f,&k,&g,&s1)
<<"%V$na $f $k $g $s1\n"



na = sscan("3 1 hey baby","\%f \%d \%s \%s",&f,&k,&g,&s1)
<<" $na $f $k $g $s1\n"

na = sscan("4.5 2 hey baby",'%f %d %s %s',&f,&k,&g,&s1)
<<" $na $f $k $g $s1\n"



checkNum(na,4)

checkFNum(f,4.5,6)

checkNum(k,2)

<<"%V  $s1   $g \n"

checkStr(s1,"baby")

checkStr(g,"hey")

<<"%V $s1   $g \n"

checkStr(s1,"baby")

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

checkStr(news,"star bright")


checkOut()


