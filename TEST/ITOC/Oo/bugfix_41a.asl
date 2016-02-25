
int I[10]

I[0:5] = 3
I[6] = 6
i = 4

char C[1024]

C[0] = 1

    mad = memaddr(&C[0])
 <<"%V $mad \n"
 <<" $C[0:39]\n"


 mas = memaddr(&I[0])
<<"%V $mas \n"

 mas5 = memaddr(&I[5])
<<"%V $mas5 \n"


  memcpy(mad, mas, 40)

 <<" $C[0:39]\n"


#{
for (i = 0; i < 5; i++) {
 I[i] = i
}
#}

<<"%V $I \n"
// FIXME -- XIC -- if above print of I not done ???

  I[2:6:1]->Set(0,1)

 I[0] = 79


<<"%V $I \n"

stop!

  memcpy(mad, mas, 40)

 <<" $C[0:39]\n"


//  I[0:5:1]->Eval( ' i*2 ', ' i++', .... )

for (i = 1; i <= 3; i++) {
<<"$(i+2)\n"
 mas = memaddr(&I[0])
<<"%V $mas \n"

}

stop!
