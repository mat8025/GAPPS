


#define DBON 




// <<" comment \n"

<<" ordinary print out ?\n"

DBON<<"see this ?\n"

// bug DBON <<"see this ?\n"  gives parse error

;<<"and see this ?\n"

int a = 2
int b = 3;
int c = 0;


DBON c= a+b


<<"%V$a $b $c\n"




// bug ?redefine does not happen
#define DBON  ~!

DBON<<"after redefine do we see this ?\n"

<<"%V $DBON \n"
