setdebug(1)

//checkIn()

float Data[10]
float Vec[10]
float LP[10]


 Data[1] = 47

 Data[2] = 79




 int k = 0

 i = 3
 j = 4
 m = 7

Data[i] = 80

Data[j] = 26

<<"$Data \n\n"

b = 67
flight_phase = 0.0
  while (1) {


     k++
     flight_phase += 0.1
     Vec[1] = flight_phase
     Data[1] = flight_phase
     Data[2] = Data[1]
     Vec[2] = Vec[1]

     Data[i] = k
     Vec[i] = k
     LP[i] = flight_phase
     Data[m] = b
     Vec[m] = b++


     Data[j] = Data[i]
     Vec[j] = Data[i]

<<"$Data \n"
<<"$Vec \n"
<<"$LP \n"

//checkNum(Data[2],k)

     if (k > 5)
     break

  }


//checkOut()


stop!