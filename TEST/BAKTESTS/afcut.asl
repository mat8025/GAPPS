//
// filter
//
nc = atoi(_clarg[1])
while (1) {

 S=readline();
 
 if (feof()) {
  break;
 }
 C=split(S)
 nm=scut(C[0],nc)
 <<"$nm\n"
}