
setdebug(1)

int a = 1.0

float f = 3.1

<<"%V $a $(typeof(a)) \n"


  a += f

  
<<"%V $a $(typeof(a)) \n"




VI = dgen(10,0,1)

<<"$VI \n"
 a= VI[1]


<<"%V $a $(typeof(a)) \n"

 a += VI[2]

<<"%V $a $(typeof(a)) \n"

  for (i = 1; i < 5; i++) {

    a += VI[i]

<<"%V $a $(typeof(a)) \n"

  }