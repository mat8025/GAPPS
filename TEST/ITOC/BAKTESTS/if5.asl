CheckIn()


//uint j = 429000000
//uint j = 120000000
//uint j = 120000000

d = pow(2,8) -5
<<"%V$d \n"

// FIX THIS -- can't do init via function??

//uint k = pow(2,3)

uint k =  2^^3

<<"%V$k \n"


uint j = d

<<"%v$j \n"


uint ts_secs = j-4


CheckNum(ts_secs,(j-4))

uint last_ts_secs = j

   <<"%V $ts_secs  $last_ts_secs \n"

CheckNum(last_ts_secs,j)

int n = 0

<<"%v $n \n"

CheckNum(0,n)


 for (i= 0; i < 5; i++) {


   if (ts_secs == last_ts_secs) {

   <<"%V $ts_secs == $last_ts_secs \n"

   n++

   }

   ts_secs++

 <<"%V $i $ts_secs \n"

 }


CheckNum(1,n)

CheckOut()


stop()
