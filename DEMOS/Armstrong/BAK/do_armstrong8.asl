

sdb(-1)
ks = 10000000;
kstep = 50000;
while (ks < 49999999) {

!!"asl -u longarm.asl $ks $kstep "

ks += kstep;

}

