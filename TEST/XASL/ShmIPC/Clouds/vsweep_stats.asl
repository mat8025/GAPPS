//

setdebug(1)



fn = _clarg[1]
wc = atoi(_clarg[2])
A= ofr(fn)

// 

CW = readline(A)  // read version

<<"dat file %s$CW\n"

    CW = readline(A)  // read parameters names

<<"parameter names %s$CW\n"


RS= readRecord(A,@del,',',@TIMECONVERT,1,@pickrow,0,93)
b = Cab(RS)
<<"$b \n"


cid = RS[::][0] 

b = Cab(cid)
<<"$b \n"

<<"$cid \n"


rng = RS[::][4] 

b = Cab(rng)
<<"$b \n"

<<"RNG $rng \n"

S= stats(rng)

<<"$S\n"


a_score = RS[::][10] 

b = Cab(a_score)
<<"$b \n"

<<"A_SCORE \n$a_score \n"

S= stats(a_score)

<<"$S\n"