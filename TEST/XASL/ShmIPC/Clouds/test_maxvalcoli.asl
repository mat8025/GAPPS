// test maxvalcoli - get a vector of max col val indices



F = vgen(FLOAT,20,0,1)

redimn(F,4,5)

<<"%(5,, ,\n)3.1f$F\n"

cv = maxvalcoli(F)

<<"$cv\n"

F[0][1] = 11

F[2][0] = 15


cv = maxvalcoli(F)

<<"$cv\n"

<<"%(5,, ,\n)3.1f$F\n"


cv = maxvalcoli(F,1,3)

<<"$cv\n"

<<"%(5,, ,\n)3.1f$F\n"


cv = minvalcoli(F)

<<"min $cv\n"