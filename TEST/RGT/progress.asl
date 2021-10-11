///
///


//08/22/21   65%
//08/23/21   68%
//08/25/2021 81.82%
//08/26/2021   84.09%
//08/27/2021   86.36%
//08/29/2021   90.91%

////////////////// Good /////////////////////
#include "progress.txt"
<<"Good:\n $Good\n"

//<<"$Good[0] $Good[1]\n"
gsz=Caz(Good)


<<"Maybe:\n $Maybe\n"

maybesz = Caz(Maybe);


<<"Bad:\n$Bad\n"


bsz=Caz(Bad)



<<"goodsz $gsz\n"
<<"%V$maybesz\n"
<<"badsz $bsz\n"


ppc = (gsz*1.0)/(gsz+maybesz+bsz)  *100

<<"$(date(2)) $gsz %6.2f ${ppc}\% \n"

//<<"Bad: $Bad[0] $Bad[1]\n"

exit()
