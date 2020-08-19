
CheckIn()

// test array indexing

 N = 20

 YV = Igen(N,21,1)

<<"$YV \n"

 IV = YV[0:5]

<<"$IV \n"

 CheckNum(IV[0],YV[0])

 CheckNum(IV[5],YV[5])


 IV = YV[1:7:2]
 NV = YV[2:10:2]

sz = Caz(IV)

<<"%v $sz \n"

<<"%v $YV \n"

<<"%v $IV \n"

<<"%v $NV \n"



 CheckNum(IV[0],YV[1])

 CheckNum(IV[1],YV[3])

 CheckNum(IV[3],YV[7])





 a = 1
 b = 7
 c = 2

 IV = YV[a:b:c]

<<"%v $IV \n"



 CheckNum(IV[0],YV[1])

 CheckNum(IV[1],YV[3])

 CheckNum(IV[3],YV[7])

 IV = YV[a+1:b+1:c]

<<"$IV \n"

 CheckNum(IV[0],YV[2])

 CheckNum(IV[1],YV[4])

 CheckNum(IV[3],YV[8])

 IV = YV[a+1:12:c+1]

<<" IV = YV[a+1:12:c+1] \n"

<<"$IV \n"


 CheckNum(IV[0],YV[2])

 CheckNum(IV[1],YV[5])

 CheckNum(IV[3],YV[11])



<<" TBD FIX IC \n"

<<" IV = YV[a+1::c+1] \n"




 IV = YV[a+1:-1:c+1]

  <<"$IV \n"


 CheckNum(IV[0],YV[2])
 CheckNum(IV[1],YV[5])
 CheckNum(IV[4],YV[14])


 CheckOut()


STOP!
