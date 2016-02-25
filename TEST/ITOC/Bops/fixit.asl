
//CheckIn()

double at =  0.000012345
double et =  0.000012346
double ft =  0.000012346

dt = ft - et

<<"%V $at $et $dt \n"

    if (dt == 0.0) {
<<"%v $dt is 0.0 \n"
    }
    else {
<<"%v $dt !=  0.0 \n"
    }

st = ft + et

<<"%V $st \n"

a = 59

b = 12

mt = a * b

<<"%V  $mt \n"


qt = ft / et

<<"%V $qt \n"





stop!



<<"%V %12.9f $at $et $dt \n"


<<"%V %12.9f $dt \n"

<<" $(typeof(dt)) \n"

  at *= 1000
  et *= 1000
  ft *= 1000

dt = at - et

<<"%V %12.9f $at $et $dt \n"

    if (dt == 0.0) {
<<"%v $dt is 0.0 \n"
    }
    else {

<<"%v $dt != 0.0 \n"

    }


dt = ft - et

<<"%V %12.9f $at $et $dt \n"

    if (dt == 0.0) {
<<"%v $dt is 0.0 \n"
    }
    else {
<<"%v $dt !=  0.0 \n"
    }




// CheckFNum(at,et,6)


// CheckFNum(ft,et,6)


;