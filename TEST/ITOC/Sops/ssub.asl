
//setdebug(1)

Checkin()

S="The very next day - he started to improve"

CheckStr(S,"The very next day - he started to improve")

<<"$S\n"

T=ssub(S,"improve","improvase")

CheckStr(T,"The very next day - he started to improvase")


<<"$T\n"

R= ssub(ssub(S,"improve","improvase"),"vase","vuse")

CheckStr(R,"The very next day - he started to improvuse")

<<"$R\n"



U= ssub(ssub(S,"improve","improvase"),"vase",ssub("vase","a","i"))

CheckStr(U,"The very next day - he started to improvise")

<<"$U\n"

CheckOut()


// want rssub to do regex!