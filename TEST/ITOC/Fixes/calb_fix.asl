

float CALBURN[>10]


for (i=0;i<100;i++) {

   CALBURN[i] = i;
}

CALBURN->info(1)

for (k=0;k<20;k++) {

  if (CALBURN[k] > 10.0) {
    b = CALBURN[k];
   <<"$k $b\n"
  }


 }