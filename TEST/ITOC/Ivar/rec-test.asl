///
///
///

chkIn()

Record R[5];
   
   R[0] = Split("the best things in life are free");
   
   R[1] = Split("but you can give them to the birds and bees");
   
   R[2] = Split("just give me money that's what I want");


<<"$R[2]\n"
<<"$R[2][3]\n"

chkStr(R[2][3],"money")

   R->info(1)

chkOut()