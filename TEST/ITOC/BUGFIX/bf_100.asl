///
/// bf_100
///

/// if do not declare is as dynamic array -- will not dynamically increase correctly

//Svar W; // does not dynamically increase correctly - can't skip elements
Svar W[]; //works

sz =Caz(W);
<<"%V$sz  $(caz(W))\n"

W[0] = "hey" ;

<<"$W\n"

sz =Caz(W);
<<"%V$sz  $(caz(W))\n"

W[3] = "jay" ;

<<"$W\n"

sz =Caz(W);
<<"%V$sz  $(caz(W))\n"

// W array does not expand to size 4 !?

W[7] = "improve daily";

<<"sz is $(caz(W))  $W\n"


<<"%V $W[0]  $W[3] $W[4] $W[7]\n"
 