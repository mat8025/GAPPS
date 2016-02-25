CheckIn()

int J[] 

<<"$(Cab(J)) \n"

<<"$J \n"

  J[0:19:2]->Set(10,1)

<<"$J \n"

CheckNum(J[0],10)


<<"$J \n"


  J[0:7] = 6

CheckNum(J[0],6)
CheckNum(J[7],6)

<<"$J \n"


  J[-1:1:-2] = 35

CheckNum(J[19],35)
CheckNum(J[1],35)

<<"$J \n"
CheckOut()

stop!






