///
///  arraysubset
///

setDebug(1,@keep,@trace)
filterFuncDebug(ALLOWALL_);
filterFileDebug(ALLOWALL_,"declare_type","array_subset","storetype","ds_store","ds_vector");


checkIn()

B = vgen(INT_,10,0,1)
 
<<"$B\n"

B[3,5,6] = 96;

B[2,7,9] = 79;


checkNum(B[2],79)
checkNum(B[3],96)
checkNum(B[5],96)
checkNum(B[6],96)

<<"$B\n"


checkNum(B[1],1)

checkOut();