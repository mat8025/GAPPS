///
///  Setv  test
///

/{/*
setv
setv(vec, op,cmp_value, set_value)
sets elements of a vector to set_value if compare operator (">,>=,<,<=,==") 
on an element with the cmp_value is true.
setv(vec,">",1,1)
will limit vector values to 1
 Another operation may done sequentially e.g
setv(vec,">",10,10,"<",-10,-10)  
would limit vector between range -10,10.
/}*/


envDebug();
proc limit_vec()
{
   set(I,">",1,10)
}


checkin()

I = vgen(INT_,20,0,1)

<<"$I \n"

 for (k =0 ; k < 10; k++) 
 {
  I += 5;
  <<"[${k}] $I \n"
  set(I,">",50,10)
  <<"$I \n"
}

checkNum(I[0],50)
/////


for (i = 0; i < 5; i++) {

  I[0:7] = 25 + i

  <<"$I \n"

  limit_vec()

  <<"$I \n"

}

checkNum(I[0],10)

checkOut()