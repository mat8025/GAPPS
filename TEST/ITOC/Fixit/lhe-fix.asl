


chkIn(_dblevel)



Data = vgen(INT_,10,0,1)

<<"$Data \n"


      a = 33;
     Data[1] = a;
     Data[2] = Data[1];

<<"$a  \n"
<<"$Data \n"

chkN(Data[1],a)
chkN(Data[2],a)

K= vgen(INT_,10,0,1)
 K->info(1)

  <<"%V$K\n";
  <<"K0 $K[0]\n"
  <<"K1 $K[1]\n"
  <<"K5 $K[5]\n"
  k = K[4];
  <<"%V $k $K[4]\n"

 printargs(K[3],K[5],K[1],K[0],k)


  chkN(K[5],5);
    chkN(K[2],2); 







chkOut()