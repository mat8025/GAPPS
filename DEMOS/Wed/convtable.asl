
 k =0
 while (1) {

  line = readline(0)

  if (eof(0)) 
    break

  len = slen(line)

 // <<"$(k++) $len $line \n"

  W= split(line)
  fd = sele(line,0,30)
  rol = sele(line,30,-1)
//  num = W[1]
//  <<"\n $fd $W[1]\n"
  <<"$fd $rol \n"

 }