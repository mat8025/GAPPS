
pan a = 1

pan b = 0

//pan t = 3

//<<"$t \n"

for (i=0;i<1000;i++)
 {
<<"$i $b  \n";  
  t= a ; 
//<<"%V$t \n"
  a = a + b;

//<<"%V$a \n"

 b = t;

//<<"%V$i $b \n"
}