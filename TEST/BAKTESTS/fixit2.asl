setdebug(1,@pline,@keep,@trace,@~soe)
filterFuncDebug(ALLOWALL_,"proc","opera_ic");
filterFileDebug(ALLOWALL_,"ic_op","ic_pu");

CheckIn(1)

 a = 1.0;
 b = 2.0;
 c = 0.2;


 float mbc;
 float my;
 float  v = 2.1;
<<"%V $v\n"
// float x;
   ok=CheckFNum(v,2.1);
float x;
 for (i = 0 ; i < 5 ; i++) {
   
    x = (b-c);
    x->info(1);

<<"[${i}] %V $b $c $x   \n"
   b += 0.1;

}

exit();



 for (i = 0 ; i < 5 ; i++) {

   
    x = (b-c);
    x->info(1);
   y = x/2.0;
    y->info(1);
   mbc = (b - c)/2.0;

<<"[${i}] %V $b $c $mbc $x $y  \n"
   b += 0.1;

}
