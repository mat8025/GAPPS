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

<<"Stable:\n $Stable\n"

stablesz=Caz(Stable)


<<"Good:\n $Good\n"

//<<"$Good[0] $Good[1]\n"
gsz=Caz(Good)


<<"Maybe:\n $Maybe\n"

maybesz = Caz(Maybe);


<<"Bad:\n$Bad\n"


badsz=Caz(Bad)


<<"%V$stablesz\n"
<<"%V$gsz\n"
<<"%V$maybesz\n"
<<"%V$badsz\n"


ppc = (stablesz+gsz*1.0)/(stablesz+gsz+maybesz+badsz)  *100.0

<<"$(date(2)) $gsz %6.2f ${ppc}\% \n"

//<<"Bad: $Bad[0] $Bad[1]\n"


<<"TBF:\n $TBF\n"

exit()
