
#{

  not good



 for (k = 0 ; k < 5; k++) {

<<"FOR %V $k \n"

 }




#}
// whats up

 k= 0
 j = 0
 while ( k++ < 5) {

<<"%v $k \n"
<<"WHILE IN k $k j $(j++)\n"


 } 

<<"WHILE OUT %V $k \n"

 k= 0
 j = 0
 while ( ++k < 5) {

<<"%v $k \n"
<<"WHILE IN k $k j $(j++)\n"


 } 

<<"WHILE OUT %V $k \n"

stop!