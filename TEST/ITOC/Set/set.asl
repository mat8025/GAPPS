

proc limit_vec()
{

   set(I,">",1,10)

}



I = vgen(FLOAT_,20,0,1)

<<"$I \n"


 for (k =0 ; k < 10; k++) 
 {
  I += 5

  <<"$k \n"
  set(I,">",1,10)
  <<"$I \n"
 }


for (i = 0; i < 5; i++) {

  I[0:7] = 25.0 + i

  <<"$I \n"

  limit_vec()


  <<"$I \n"

}