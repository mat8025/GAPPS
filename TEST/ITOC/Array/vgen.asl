
setdebug(1)

chkIn()

C = vgen(CHAR_,40,0,1)

    wt = C->getType()
    sz = Caz(wt)
<<"$wt $(typeof(wt)) $sz \n"

<<" $wt $(CHAR) $(typeof(C)) $C \n"

    chkN(wt,1)
<<"$wt $(typeof(wt)) \n"
chkOut()
stop()

// FIXME
// int I[] = C


 int I[] 

<<"type  $(typeof(I)) sz $(Caz(I)) [$I ] \n"

    I = C

    wt = I->getType()

<<" $wt $(INT) $(typeof(I)) $(Caz(I)) $I \n"

    chkN(wt,3)
    chkN(wt,INT)

 chkOut()


;