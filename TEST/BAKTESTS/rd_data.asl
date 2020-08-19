


 float f

 

  A= ofr("data.bin")
  for (i = 0; i < 10; i++) {

    nir = fread(&f,4,1,A)

<<"[${i}] $nir $f\n"

  }

  cf (A)

float vf[10]

  A= ofr("data.bin")

  nir = fread(&vf,4,10,A)

 <<"\n%3.1f$vf\n"


 <<"\n%(5,<|,;,|>)3.1f$vf\n"

printf("hey \%f \%f\n",vf[1],vf[2]);

msg = "don't you hear that call"

printf('hey %f %f  hey mama %s\n',vf[1],vf[2],msg);

int d = 80

<<"hey %3.1f$f %d$d hey mama $msg\n"