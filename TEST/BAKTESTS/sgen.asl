///
///   sgen
///


setDebug(1,@keep)


checkIN()

int v[2] = {2,-1}
<<"$v \n"

I = sgen(INT_,10,v)

<<"$I\n"


checkNum(I[0],2)
checkNum(I[1],1)


int vi[2] = {0,1}

int vs[2] = {1,2}


J = vvgen(INT_,10,vi,vs)

<<"$J\n"

checkNum(J[2],1)
checkNum(J[3],3)


checkOut()

exit()