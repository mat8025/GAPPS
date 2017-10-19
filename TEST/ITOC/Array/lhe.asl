///
///
///

setdebug(1,"pline","~step")

checkIn()

int Data[10];


 i = 3
 j = 4

Data[i] = 80
<<"$Data \n"
checkNum(Data[3],80)
//checkNum(Data[i],80)


int k = 0


///////////////////////////////////////////////////////



Data[1] = 47

<<"$Data \n"

<<"$Data[1] \n"

checkNum(Data[1],47)

k = 2
Data[k] = 79

<<"$Data[2] $Data[k]\n"

checkNum(Data[2],79)
checkNum(Data[k],79)









int Vec[10]
int LP[10]

Data[j] = 26;

<<"$Data \n"

checkNum(Data[4],26)
     Data[1] = k
     Data[2] = Data[1]
<<"$Data \n"
<<"%V$i $j\n"
     Data[j] = Data[i]
<<"$Data \n"
<<"%V$Data[2]  $k $i\n"

checkNum(Data[2],k)





 m = 7

Data[i] = 80
Data[j] = 26

<<"$Data \n\n"

b = 67

  while (1) {

     k++;

<<"%V$k\n"

     Data[1] = k;
     Data[2] = Data[1];

<<"%V $Data[1] $Data[2] $k $i\n"
//ans =iread()

     checkNum(Data[2],k)


<<"$Data \n"
<<"%V$i $j\n"
     Data[j] = Data[i]
<<"$Data \n"


     if (k > 5)
     break

  }


checkOut()


stop!