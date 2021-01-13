
int M[2][3]

M = 5

<<"%(,,\,,\n)$M"


A=ofw("MOP")

  for (i = 0; i < 3; i++) {
  M = i
<<"%(,>>,\,,<<\n)$M"

  }


  for (i = 0; i < 3; i++) {
  M = i
<<"%(,>>,|,<<\n)$M"

  }
<<"$A\n"


float MF[2][3]

MF = 5

  for (i = 0; i < 3; i++) {
  MF = i
//  wfile(A,"%(,>>,|,<<\n)$MF")  // arg not XIC correctly?
  csv = "%(,,\,,\n)4.2f$MF"
  wfile(A,csv)

  }


Bf=ofw("BOP")

  for (i = 0; i < 3; i++) {
  MF = i
  csv = "%(,,\,,\n)4.2f$MF"
  <<[Bf]"$csv"
  }

 <<[Bf]"----------------------\n"

  for (i = 0; i < 3; i++) {
  MF = i
  <<[Bf]"%(,,\,,\n)4.2f$MF"

  }


