
/{

Cmp
Cmp(A,B,condition,{1})
compares 2 arrays  using "<,>,==,,!=,>=,<=" operations
    delivers an integer array which contains indices - where the
    operation was TRUE - else first element is -1 for no valid comparison
optionally delivers integer array where elements are 0 or 1 depending on TRUE/FALSE of element comparison
e.g.
I=Cmp(A,B,"<=")
I=Cmp(A[::2],B[0::2],">")
I=Cmp(A,B,"!=",1)
scmp
scmp(w1,w2,{n},{case},{difference})
string compare of w1,w2 variables returns 1 if same 0 if different.
will compare up to n characters default all. 
If case set to zero a case independent match is made.
If difference set to 1 - return is as C routine strcmp.
If n is zero all the string is compared, else the first n characters.
if n less than zero the tails are compared for n elements.

/}


checkIn()

//xic(0)

int I[5] = { 1,2,3,4,5 }

//int I[] = { 1,2,3,4,5}

<<"%V$I \n"

int J[5] = { 1,2,-3,8,9}

<<"%V$J \n"


       K = Cmp(I,J,"<")

<<"$K\n"

checkNum(K[0],3)
checkNum(K[1],4)

       K = Cmp(I,J,"<",1)

checkNum(K[0],0)
checkNum(K[3],1)

<<"$K\n"

       K = Cmp(I,J,"==",1)

<<"$K\n"
checkNum(K[0],1)

checkOut()