


 float f

  A= ofr("data.bin")
  for (i = 0; i < 10; i++) {

    fread(&f,4,1,A)

<<"[${i}] $f\n"

  }