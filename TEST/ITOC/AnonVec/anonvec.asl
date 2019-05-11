///
///
///



checkIn()





int vi[2] = {0,0}
<<"$vi \n"

int vs[2] = {1,-1}

checkNum(vs[0],1)
checkNum(vs[1],-1)

int vec[] = {1,2,3,4,5,6,7,8,9}

<<"$vec\n"

Table = vvgen(INT_,20,vi,vs)

<<"%(2,, ,\n)$Table \n"

testArgs(1,vi,vs)

// show list arg arrives as array of values
S=testArgs(1,{1,2,3,4,5,6,7,8,9})

<<"$S\n"


T=testArgs(1,{"hey","hago","haces","hace"})



<<"%(1,,,\n)$T\n"



checkOut()
