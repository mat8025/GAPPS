

setdebug(1,"trace");

na = argc()
<<"%V $na \n"


if (na >= 1) {
 for (i = 0; i < argc() ; i++) {
//<<"arg [${i}  // TBF
<<"arg ${i} $_clarg[i] \n"
 }
}


exit()