
setdebug(1)
float real[]
float imag[]

FFTSZ = 256

   real[255] = 0;
   imag[255] = 0 ;

   real = 1.2;

<<"$real[0:9] \n"
   
   imag = 0.2;

<<"$imag[0:31] \n"

   fft(real,imag,FFTSZ,1)


<<"$real[0:9] \n"

<<"$imag[0:9] \n"

