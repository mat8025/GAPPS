setdebug(1)
//float sp1[16]
float sp2[16]


float stc[253]


proc read_sp(float wsp[])
{
 int nr = 5

//    nr = v_read(A,wsp,256)

  //nwsp = wsp

<<"IN \n "
<<"%(10,, ,\n)6.1f$wsp \n"

   wsp += 1.0

<<"+1 %(10,, ,\n)6.1f$wsp \n"
<<"+1 %(10,, ,\n)6.1f$sp1 \n"

// FIXME!
   // wsp = 77.0  // FIXME does not export
    wsp = Log10(wsp) // FIXME does not export
    //wsp = nwsp


<<"OUT \n"
<<"%(10,, ,\n)6.3f$wsp \n"

<<"%V$nr \n"

    return nr
}



sp1 = vgen(FLOAT_,16,1,0.5)
sp2 = vgen(FLOAT_,16,22,0.5)

<<"%(10,, ,\n)6.4f$sp1 \n"

    onr =read_sp(&sp1)

<<"AFTER \n"

<<"%(10,, ,\n)6.4f$sp1 \n"

<<"%V$onr\n"

stop!

sp1 = vgen(FLOAT_,16,16,0.5)

    onr =read_sp(&sp1)

<<"AFTER \n"

<<"%(10,, ,\n)6.4f$sp1 \n"

<<"%V$onr\n"



sp2 = vgen(FLOAT_,16,64,0.5)

    onr =read_sp(&sp2)

<<"AFTER \n"
<<"%(10,, ,\n)6.4f$sp2 \n"

<<"%V$onr\n"

stop!






//////////////////////////
stop!
/{
    log_sp(&sp1)

<<"%(10,, ,\n)6.1f$sp1 \n"

stop!


proc log_sp(float wsp[])
{
    wsp +=  1.0
    wsp = Log10(wsp)
<<"%(10,, ,\n)6.3f$wsp \n"
}

/}