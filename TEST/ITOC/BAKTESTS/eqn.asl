
f = 880.0
t = 1.2
dt = 1.0/ (5.0*f)

for (i = 0; i < 1000; i++)
{
r= 2*_PI*f*t
pf = r/_PI
y = sin(2*_PI*f*t)
<<"$i $r $pf $y\n"
t += dt

}