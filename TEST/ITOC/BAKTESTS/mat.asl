
// FIXME  - won't make D an in vector
//  D[] = {2,3,4,6,0,-1}
//<<" $D \n"


int A[] = {2,3,4,-6,3,1}

<<" $(Cab(A)) $(Caz(A)) \n"

<<"%V$A \n"


// FIXME  -- won't fill in rows
//int  B[2][3] = { {0,3,2 }, {-1,1,-2} }


int B[] = { 0,3,-2 ,-1,1,2 }

<<"$(Cab(B)) $(Caz(B)) \n"
<<"%V$B \n"

 A->redimn(3,2)
<<"%(2,\n|, , |)$A \n"


 B->redimn(3,2)


<<"%(2,\n|, , |)$B \n"


 C = A + B

<<"$C\n"

exit()


 E = B
 E->redimn(2,3)


<<"%(2,\n|, , |)%2d$A\n"

<<"%(3,\n|, , |)%2d$E\n"

 D = A * E

<<"%V%(3,\n|, , |)%2d$D\n"
 



<<"%V%(,\n|, , |)%2d$C\n"


  D = -A

<<"%V %(3,\n|, , |)%2d $D\n"

  D = -1 * A


<<"%V %(3,\n|, , |)%2d $A\n"

<<"%V %(3,\n|, , |)%2d $D\n"

stop!
