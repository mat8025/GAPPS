



setap(100)
pan N

<<"%V <|$_clarg[1]|>\n"

  i = atoi(_clarg[1]);

   i->info(1)
!a  
  if (i <= 0) {
    i = 10;
  }

  i->info(1)
!a
  Pan F = 1;
  int k = 1;
  pan E = 1;
  pan R = 1.0;

while (1) {

     F = F*k;


     R = 1.0/F;
     E = E + R ;
<<" $k %p$R %p$E  %p$F\n"
     k++;
     if (k > i) {
        break;
     }

  }

