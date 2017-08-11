setdebug(1,"trace")

hue =1
grwo = 6

XV= vgen(FLOAT_,10,0,1)

YV1 = vgen(FLOAT_,10,0,1)
i = 0;
svar vn;

vn[0] = "YV0"
i = 1;
vn[1] = "YV$i"

i = 1;
AL = testargs(grwo,@TXY,XV, $vn[i])
<<"%V$AL\n"
