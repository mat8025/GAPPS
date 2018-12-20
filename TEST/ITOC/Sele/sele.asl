///
///   sele function
///

/{
used to select part of string variable
index in string (0...length-1), nc  number of chars (default from index to end of string).
newstr = sele(astr,3)
newstr contains from 4th character to end of original string.
newstr = sele(astr,3,3)
newstr contains from 4th character to 6th character of  original string.
/}


checkIn()

astr = "subsection"

<<"$astr  $(slen(astr))\n"

newstr = sele(astr,12);

<<"12, $(slen(newstr)) $newstr\n";


newstr = sele(astr,3);

<<"3, $(slen(newstr)) $newstr\n";




checkStr(newstr,"section")

newstr = sele(astr,3,3)

<<"3,3 $newstr\n";
checkStr(newstr,"sec")


newstr = sele(astr,-1,3)

<<"-1,3 $newstr\n";

checkStr(newstr,"n")


newstr = sele(astr,-3,3)

<<"-3,3 $newstr\n";

checkStr(newstr,"ion")



newstr = sele(astr,-3,-3)

<<"-3,-3 $newstr\n";
checkStr(newstr,"cti")


newstr = sele(astr,-4)

<<"-4, $newstr\n";

checkStr(newstr,"subsect")




newstr = sele(astr,-3,-14)

<<"-3,-14 $newstr\n";

checkStr(newstr,"")

newstr = sele(astr,-3,14)

<<"-3,14 $newstr\n";

checkStr(newstr,"ion")


newstr = sele("foo.dat",-5)

<<"$newstr\n"

checkStr(newstr,"foo")


newstr = sele("foo.dat",-4,4)
<<"$newstr\n"

checkStr(newstr,".dat")

astr= "penultimate"; b=sele(astr,-1,-4)
<<"$b\n";

checkStr(b,"mate");


checkOut();

