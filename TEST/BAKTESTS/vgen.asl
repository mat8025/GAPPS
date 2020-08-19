
setdebug(1)

CheckIn()

C = vgen(CHAR_,40,0,1)

    wt = C->getType()
    sz = Caz(wt)
<<"$wt $(typeof(wt)) $sz \n"

<<" $wt $(CHAR) $(typeof(C)) $C \n"

    CheckNum(wt,1)
<<"$wt $(typeof(wt)) \n"
checkOut()
stop()

// FIXME
// int I[] = C


 int I[] 

<<"type  $(typeof(I)) sz $(Caz(I)) [$I ] \n"

    I = C

    wt = I->getType()

<<" $wt $(INT) $(typeof(I)) $(Caz(I)) $I \n"

    CheckNum(wt,3)
    CheckNum(wt,INT)

 CheckOut()


;