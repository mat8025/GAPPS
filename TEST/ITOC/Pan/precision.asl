///
/// check double precision
///


app = 100
setap(app);
double x = 1.2345678900100;
double y = 123456789.0;
double z = x + y;
<<"$(typeof(x)) %V $x $y $z\n"


pan p;
pan q;
pan r;
 p = x;
 q = y;
 r = p + q;
<<"$(typeof(p)) %V $p  $q\n"

double fr = 10;
  for (i = 0 ; i < 200; i++) {
    x *= 0.5;
    y *= 2;
    z = x + y;
   // p = x;
    p *= 0.5;
    q *= 2;
    r = p + q;
    if ((i%20) == 0) {
<<"$i %V %400.390f$z\n"
  //  <<"$i %V $p\n"
   <<"\n$i %V $r\n"
     app += 20;
     setap(app);
    }
  }