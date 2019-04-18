

sdb(-1)
ks = 50000000;
kstep = 50000;
while (ks < 99999999) {

!!"asl -u longarm.asl $ks $kstep "

ks += kstep;

}

