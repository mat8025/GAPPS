

setDebug(1,@keep,@pline);

Ntaskpts = 10;

for (i = 0; i < Ntaskpts ; i++) {
      <<"$i    \n"

      if (i >= 2) {
      <<" i >=2 $i \n"
      }

      if (i >= 7) {
      <<" $i >= 7 break $i \n"
        break;
      }

}

<<"%V $i $Ntaskpts \n"