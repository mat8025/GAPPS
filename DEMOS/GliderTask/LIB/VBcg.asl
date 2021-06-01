
MW =500.0;
TW = 73.2;


//MW =515.0;
//TW = 80.0;



y = 164.28; //ledge to tskd inches
x = 3.94 ; // ledge to main wheel hub



empty_cg = ((y *TW) + (x *MW) )/ (TW+MW)

<<"%V$empty_cg\n"

MPW = 715.0;



pilot_cg =  ((y *TW) + (x *MPW) )/ (TW+MPW)

<<"%V$pilot_cg\n"


<<"max fwd 21.0  max rear 25.2 \n"


for (pw = 200.0 ; pw >= 100 ; pw -= 5) {
MPW = MW + pw +15.0;
pilot_cg =  ((y *TW) + (x *MPW) )/ (TW+MPW)

<<"%V$pw $pilot_cg\n"

}