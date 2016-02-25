#! /usr/local/GASP/bin/asl



//Wd=split("once upon a time ")

Wd=split(": ,,Granby airport ")

<<" $Wd \n"

<<" ${Wd[*]} \n"

<<" ${Wd[0]} ${Wd[1]} ${Wd[2]}\n"


str = scat(Wd[0],Wd[1],Wd[2],Wd[3])

<<" %v <$str> \n"

STOP!

     v= Wd[2]
     t = Wd[3]
<<" %V $v $t \n"

     s302 = scat(v,t)
<<" $s302 \n"

#{

  Test If variations

#}


int ok = 0
int bad = 0
int ntest = 0




STOP!
