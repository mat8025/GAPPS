/* 
 *  @script cut.asl 
 * 
 *  @comment test SF cut (array) 
 *  @release CARBON 
 *  @vers 1.4 Be Beryllium [asl 6.3.55 C-Li-Cs] 
 *  @date 10/12/2021 13:35:43 
 *  @cdate 1/1/2005 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                           

// test cut array

<|Use_=
Demo  of cut function
An  VMF operation to remove selected elements of an vector. 
I->cut(V) the cut function that uses the vector V to indicate which elements of I to 'cut'.
I[3:7]->cut() --- the subscripted range of I is cut from the vector.
The cut operation can be applied to most types,  Float, Double, Int ...
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"
}


chkIn(_dblevel)



int I[] ;

I= Igen(20,0,1)

<<"$I \n"

C = Igen(4,12,1)

<<"$C \n"

I<-cut(C)

<<" $I \n"

chkN(I[12],16)


//float F[]

F= Fgen(20,0,1)
sz = Caz(F)
<<"$sz $F \n"
//<<"%,j%{5<,\,>\n}%6.1f$F\n"

<<"%6.1f$F\n"

C = Igen(4,12,1)

<<"%V $C \n"

F<-cut(C)




<<"%6.1f$F \n"
chkR(F[12],16,6)


<<" $I \n"

//I[3:8]->cut()
I[3:8]<-cut()

<<" $I \n"

chkN(I[3],9)

<<"$I[0:-1:2]\n"

Y = I

<<"Y $Y = $I \n"

Y = I[0:8:1]

<<" $Y \n"




F[3:8]<-cut()

<<" %6.1f$F[::] \n"
chkR(F[3],9,6)

F[3]<-cut()

<<" %6.1f $F[::] \n"

chkOut()

