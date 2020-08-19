

 float f

  A= ofw("data.bin")
  for (i = 0; i < 10; i++) {
    f = i * 2
    nir = fwrite(&f,4,1,A)

<<"[${i}] $nir $f\n"

  }

cf(A)