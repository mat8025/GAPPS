//   test Limit


F= vgen(FLOAT_,10,-7,1)

<<"$F \n"


F->limit(-5,5)


<<"$F \n"



a = 7

<<"$a\n"

a->limit(0,2)

<<"$a\n"

stop!