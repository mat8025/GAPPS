

X = vgen(FLOAT,100,0)

X[20] = 1.0


Y = vgen(FLOAT,100,0)



   X[0] = Y[0]
   

   for (i = 1; i < 100; i++) {

      Y[i] = Y[i-1] * alpha (X[i] - Y[i-1])

   }