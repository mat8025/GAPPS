# test ASL function bscan

CheckIn()

//setdebug(1)

uchar C[] = { 0xCA , 0xFE, 0xBA, 0xBE, 0xFA, 0xCE, 0xBE, 0xAD , 0xDE,0xAD, 0xC0, 0xDE }

<<" $(typeof(C)) \n"
<<" $C \n"
<<"%x $C \n"

// just copy
<<" just assign/copy to new vector \n"
D = C
<<"D $D\n"
// convert

   C->Convert(INT_)
   checkNum(202,C[0])

   CI= C

<<" $(typeof(C)) $(sizeof(C))\n"
<<" $C \n"
<<"%x $C \n"

    C->Convert(FLOAT_)

<<" $(typeof(C)) $(sizeof(C))\n"
<<" $C \n"
<<"%x $C \n"
<<"$C[0] $C[1] \n"



   checknum(202.0,C[0])
   checknum(254.0,C[1])




<<" $(typeof(D)) \n"
<<" $D \n"
<<"%x $D \n"
// FIX
//int E[] = D
int E[]  ; E = D


<<"E $(typeof(E)) \n"
<<" $E \n"
<<"%x $E \n"





// retype vector to int
<<"now retype D CHAR vec to an INT vec\n"

   retype(D,INT_)

<<" $(typeof(D)) \n"
<<"D[] \%d $D \n"
<<"D[] \%X %x $D \n"



d0 = 0xcafebabe



<<"%V %x $d0 \n"

<<"%V %d $d0 \n"

d0 = 0xca

<<"%V %x $d0 \n"
<<"%V  $d0 \n"

 x= D[0]
 swab(D)
<<"%x $D[0] \n"
<<"swabbed $D \n"
<<"%x $D \n"




   checkNum(d0,CI[0])


<<"retype CHAR $(CHAR) --> FLOAT $(FLOAT_) \n"

   E->retype(FLOAT_)

<<" $(typeof(E)) \n"
<<" $E \n"
<<"%x $E \n"

<<"%V $(INT_) $(FLOAT_) $(CHAR_) $(DOUBLE_)\n"





//<<"now retype D INT vec to a FLOAT \n"

//   retype(D,FLOAT_)

<<" $(Sizeof(D)) \n"
<<" $(typeof(D)) \n"

<<"D[] \%f $D \n"

<<"D[] \%X %x $D \n"


// F= cast(D,FLOAT_)
float F[]

 F = D
   

<<"float vec $F[0:-1]\n"

 G= cast(D,FLOAT_)

<<"float G[] $G[0:-1]\n"

 IV = cast(G,INT_)

<<"int IV[] $IV\n"

 LV = cast(G,LONG_)

<<"long LV[] $LV\n"


 p = &D

// should  PINT -- ptr to int
<<"%V %ld$p $(typeof(p)) \n"

// p[0] should first element 


// *p++   operations
// *p--   does this keep within the memory ranges


<<" $p[0] \n"
<<" $p[1] \n"
k = 2
<<" $p[k] \n"


checkOut()

