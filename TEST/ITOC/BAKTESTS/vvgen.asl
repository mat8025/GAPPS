///
///
///



checkIn()
int vi[2] = {0,0}
<<"$vi \n"

int vs[2] = {1,-1}



Table = vvgen(INT_,20,vi,vs)


<<"%(2,, ,\n)$Table \n"
j= 0;
for (i= 0; i< 4; i++) {

checkNum(Table[j],i)
checkNum(Table[j+1],-i)
j +=2
}


STable = vvgen(SHORT_,20,{0,0},{1,-1}) ; // TBF anon vec as argument

<<"%(2,, ,\n)$STable \n"



checkOut()


exit()