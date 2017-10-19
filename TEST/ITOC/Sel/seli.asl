/// Sel

/{/*
Seli(A,condition,val,{1},{justfirst})
compares array values  using "<,>,==,,!=,>=,<=" operations with value
    delivers an integer array which contains indices - where the
    operation was TRUE - else first element is -1 for no valid comparison
optionally delivers integer array where elements are 0 or 1 depending on TRUE/FALSE of element value comparison
If you need just the first element/index where the condition was true set the final optional arg (justfirst) to one,
the default is to work through the vector.
(see Cmp)
/}*/

setDebug(1,"pline","~step")

checkIn()



I=vgen(INT_,10,0,1);


<<"$I\n"

S=Seli(I,GT_,5)

<<"$S\n"
checkNum(S[0],6)
checkNum(S[3],9)

<<"$I\n"

S=Seli(I,">",5,1)

<<"$S\n"


S=Seli(I,">",5,0,1)

<<"$S\n"

S=Seli(I,">",50)

<<"$S\n"


F=vgen(INT_,10,0,1);

<<"$F\n"


S=Seli(F,GT_,5)

<<"$S\n"
checkNum(S[0],6)
checkNum(S[3],9)



checkOut()






/{/*
/////////// TBD //////////

  option to get justfirst should return array size 1

/}*/

