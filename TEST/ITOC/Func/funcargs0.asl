CheckIn()

CheckIn()


I = Igen(10,0,1)

<<" $I \n"
    
   CheckNum(I[4],4)

  // testargs(I, I[:-3:])
 testargs(I)

<<" $I \n"

t = typeof(I)

<<"%v $t \n"

<<" $(typeof(I)) \n"

   CheckNum(I[4],5)

   CheckOut()


STOP!


  for (k = 0 ; k < 4; k++) {
<<" %v $k \n"
<<" $I \n"
   testargs(I)



<<" $I \n"
  
  }



STOP!

 foota({4,2,3})




 for (i = 0 ; i < 5; i++ ) {

 foota({1,2,3,i})

}



STOP!



I=Igen(12,0,1)

  foota("mark",8,I,I[2], I[2:7:2], I[1:8:2])

ttyin()

k = 3

 for (i = 1 ; i < 5; i++ ) {
  foota(k, "mark", 8, i, I[i:7:2], I[i:8:2])
  ttyin()
 }


STOP!