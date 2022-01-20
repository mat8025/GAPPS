///
///
///



V= vgen(DOUBLE_,10,10,1);

<<"$V\n"


rms = rms(V);

<<"%V$rms\n"

V[4] = 82;

rms = V.rms();

<<"%V$rms\n"

rms = V[2:7:1].rms();

<<"%V$rms\n"

rms = V[9:2:-1].rms();

<<"%V$rms\n"

sv =V.stats()

<<"%V$sv\n"
