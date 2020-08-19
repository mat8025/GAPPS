setdebug(1)

checkIn()

int Data[10]


 Data[1] = 47

 Data[2] = 79


 int k = 0

  while (1) {



     k++

     Data[1] = k
     Data[2] = Data[1]

<<"$Data \n"

checkNum(Data[2],k)

     if (k > 5)
     break

  }


checkOut()


stop!