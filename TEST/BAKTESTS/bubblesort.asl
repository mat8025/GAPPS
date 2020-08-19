///
/// BubbleSort
///

/{/*
bubblesort(Vec)
performs bubble sort on a vector returns sorted vector.
Should work on all types.
If used as Vec->BubbleSort() the vector itself is sorted.
/}*/

checkIn()
I=vgen(INT_,10,10,-1);

<<"$I\n"
T=BubbleSort(I);
checkNum(T[0],1);
<<"$I\n"
<<"$T\n"
checkNum(I[0],1);

ok=I->BubbleSort()
<<"ret $ok\n"

<<"$I\n"
checkNum(I[0],1)

F=vgen(FLOAT_,10,10,-2);
checkNum(F[0],10)
<<"$F\n"

F->BubbleSort()

<<"$F\n"
checkNum(F[0],-8)
checkOut()




