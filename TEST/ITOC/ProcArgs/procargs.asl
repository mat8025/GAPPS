
/// ?? que?

long  tproc (pan arg)
{
   long in = arg;

<<"%V $in $arg \n"


    return in;
}

double dproc(double arg)
{
   double in = arg;

<<"%V $in $arg \n"

   return in;
}

  long out;
  double dout;

  pan pval = 1234.567;
  
  out = tproc(pval)

 <<"%V $pval $out\n";


  long lval = 123456789;
  out = tproc(lval)

 <<"passed long %V $lval $out\n";

  int ival = 123456789;
  out = tproc(ival)

 <<"passed int %V $ival $out\n";



  double dval = 1234.567;
  
  out = tproc(dval)

 <<"%V double $dval $out\n";

  short sval = 12345;
  out = tproc(sval)

 <<"passed short %V $sval $out\n";

  char cval = 12;
  out = tproc(cval)

 <<"passed char %V $cval $out\n";


  cval = 'A';
  out = tproc(cval)

 <<"passed char %V $cval $out\n";


  dout = dproc(dval)

 <<"%V double $dval $dout\n";


  dout = dproc(lval)

 <<"%V double $lval $dout\n";

  dout = tproc(sval)

 <<"passed short %V $sval $dout\n";

  dout = tproc(ival)

 <<"passed int %V $ival $dout\n";


  exit()


int  goalwos[10] = {-2,0, 1, 2, 3, -1,5,6,7,8,9};

goalwos.pinfo();


 first = goalwos[0];
 last = goalwos[3];
 ha = goalwos[4];

first.pinfo();
last.pinfo();
ha.pinfo();

<<"%V $goalwos  $first $last $ha\n"; 



  int i = 0;

  while (1) {
  <<"%V $i $goalwos[i] \n";

    goalwos.pinfo();



   if (goalwos[i] < 0) {
   <<" break neg goalwo  $goalwos[i]\n"
       break;
       }
    else {
<<" break neg goalwo test fail $goalwos[i]\n"
    }

   if (goalwos[i] == -2) {
   <<" break  goalwo == -2\n"
       break;
       }



    last = goalwos[i];
<<"%V $i $last \n"  
last.pinfo();
!a
  if (last < 0) {
<<" break on last < 0\n"
    break;
  }

  if (last == -1) {
<<" break on last == -1\n"
    break;
  }

  if (last == 7) {
<<" break on last == 7\n"
     break;
  }
       
    //sWo(_WOID,goalwos[i],_WREDRAW,ON_);
    i++;
    if (i > 8) {
         break;
    }
  }

