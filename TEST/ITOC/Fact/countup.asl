setap(100)
pan N

  i = atoi(_clarg[1])

  Pan F = 1;
  int k = 1;
  pan E = 1;
  pan R = 1.0;
  while (1) {

     F = F*k;

     if (k > i) {
        break;
     }
     R = 1.0/F;
     E = E + R ;
<<" $k %p$R %p$E  %p$F\n"
     k++;


  }