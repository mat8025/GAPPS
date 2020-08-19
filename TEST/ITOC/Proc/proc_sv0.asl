
chkIn()

proc poo()
{

// int i = 4; // works

 int i;
 i = 4; // also works


 <<"%I $i \n"

 //variables()

 int p;

 i = 6;

 p = 9;

 <<"%I $i $p\n"

  i++
  p= i

 <<"%I $i $p\n"
   chkN(p,7)
}

int i = 3
int j = 4;

<<"%I $i \n"

   chkN(i,3)
   chkN(j,4)

 poo()

<<"%I $i \n"

   chkN(i,3)
j++
   chkN(j,5)
   chkOut()

;

