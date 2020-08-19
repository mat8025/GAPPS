///
/// d2r
///

chkIn();

d = 180.0;
r= d2r(d)

<<"$r $_PI\n"
p= r2d(r)

<<"$p $d\n"


chkR(r,_PI)

chkR(p,d)

for (d = 0.0; d<= 360; d+= 45.0)
{
  r= d2r(d)
  p= r2d(r)
<<"$d $r $p\n"
}
chkOut()