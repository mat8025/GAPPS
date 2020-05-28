setdebug(1)

CheckIn()

int ag = 47

<<"%v $ag \n"

CheckNum(ag,47)

short sv = 80

<<" %V$sv \n"
CheckNum(sv,80)


float fp ;

fp = 12.5674560

ok=CheckFNum(fp,12.567456,6)

<<"%V12.7f$fp %d$ok\n"


float ep = 12.5674560;

ok=CheckFNum(ep,12.567456,6)

<<"%V12.7f$ep %d$ok\n"


double dv = 7234.5678764;


ok=CheckFNum(dv,7234.5678764,7)

<<"%V$dv $ok \n"

str sx = "this is an input string"

<<"%V $sx \n"

  CheckStr(sx,"this is an input string")


char cv = 86

<<"%V %d $cv %x $cv %c $cv \n"

 CheckNum(cv,86)

char a = 'G';

<<"%V %d $a %x $a %c $a \n"

 CheckNum(a,'G')

 a = 'V';

<<"%V$a    $(typeof(a)) $(Csz(a)) \n"

 CheckNum(a,'V')


char ba[] = {'BEGIN'};


<<"%V$ba    $(typeof(ba)) $(Csz(ba)) \n"

// CheckNum(ba,'B')


CheckNum(ba[1],'E')

CheckOut()

stop!

char e

e = 'L'

<<" %d $e %x $e %c $e \n"


stop!
;