#include <stdio.h>
#include <stdlib.h>

typedef unsigned int  uint32 ;

float convert_ti_float(unsigned int ui)
{

  float ieee_f = 0.0;
  float *fp;
  uint32 val = ui;
  uint32 ieee_val;
  uint32 ieee_man;
  unsigned char ieee_exp;
  char ieee_sign = 0;
  char ke;
  int ti_sign ;
  uint32 ti_man;
  int ti_exp;

  printf("ui %x  %d \n",ui,ui);
  ti_exp = (ui >> 24);
  ke = ti_exp;

  ti_exp = ke;

  ti_sign = ((ui & 0x00800000) > 0) ? 1 : 0;
  ti_man = (ui & 0x007FFFFF);

  printf("ke %d ti_exp %d \n",ke,ti_exp);

  printf(" sign %d\n",ti_sign);

  printf(" frac %x %d\n",ti_man, ti_man);

  /*
  if (ti_exp & 0x80) {
    ti_exp = ~ti_exp + 1;
    ti_exp *= -1;
  }
  */






  


  fp = (float *) &val;

  //ieee_f = *fp;

    if ( ti_exp == -128) {
      ieee_f = 0.0;
    }
    else if (ti_exp == -127) {
      ieee_f = 0.0;
    }
    else if (ti_exp >= -126 && ti_exp <= 127 && ti_sign == 0) {
        ieee_exp = ti_exp + 0x7F;
        ieee_sign = 0;
        ieee_man =  ti_man;
	printf("3 exp %x sign %x man %x\n",ieee_exp,ieee_sign, ieee_man);
        ieee_val =  ((ieee_sign << 31) + (ieee_exp << 23) + ieee_man) ;
        ieee_f = * (float *) &ieee_val;

    }
    else if (ti_exp >= -126 && ti_exp <= 127
         && ti_sign == 1
          && ti_man != 0) {
        ieee_exp = ti_exp + 0x7F;
 
        ieee_sign = 0; // yes 0

        printf("ti_man %x  1comp %x\n",ti_man, ~ti_man);

        ieee_man =  (~ti_man & 0x007FFFFF) + 1; // ones comp + 1

        printf("4 exp %x sign %x man %x\n",ieee_exp,ieee_sign, ieee_man);
        ieee_val =  ((ieee_sign << 31) + (ieee_exp << 23) + ieee_man) ;
        ieee_f = * (float *) &ieee_val;
    }

    else if (ti_exp >= -126 && ti_exp <= 127
         && ti_sign == 1
          && ti_man == 0) {
        ieee_exp = ti_exp + 0x80;
        ieee_sign = 1;
        ieee_man =  0;
        printf("5 exp %x sign %x man %x\n",ieee_exp,ieee_sign, ieee_man);
        ieee_val =  ((ieee_sign << 31) + (ieee_exp << 23) + ieee_man) ;
        ieee_f = * (float *) &ieee_val;
    }
    else if (ti_exp == 127
             && ti_sign == 1
             && ti_man == 0) {
        ieee_exp =  0xFF;
        ieee_sign = 1;
        ieee_man =  0;
        printf("6 exp %x sign %x man %x\n",ieee_exp,ieee_sign, ieee_man);
        ieee_val =  ((ieee_sign << 31) + (ieee_exp << 23) + ieee_man) ;
        ieee_f = * (float *) &ieee_val;
    }

    printf("%x %d %f \n",ieee_val,ieee_val,ieee_f);    

    return ieee_f;

}





int main (int argc, char **argv)
{
  char k;
  unsigned char uc;
  int i;
  unsigned int ui = 0xFB400000;
  int ti_expn;
  int ti_sign;
  int ti_frac;
  char ke;
  float f;
  k = 251;
  uc = k;
  i = k;
  

  printf("k %c %d %x\n",k,k,k);
  printf("uc %c %d %x\n",uc,uc,uc);
  printf("i %d %x\n",i,i);
  printf("ui %u %x\n",ui,ui);


  // convert 
  ui = 0xFB400000;
  printf("ui %u %x\n",ui,ui);
  // expn
  ti_expn = (ui >> 24);
  ti_sign = ((ui & 0x00800000) > 0) ? 1 : 0;
  ti_frac = (ui & 0x007FFFFF);
  ke = ti_expn;
  printf(" expn %x %d ke %d\n",ti_expn,ti_expn, ke);
  printf(" sign %d\n",ti_sign);
  printf(" frac %x %d\n",ti_frac, ti_frac);



  ui = 0x01C00000;
  printf("ui %u %x\n",ui,ui);
  // expn
  ti_expn = (ui >> 24);
  ti_sign = ((ui & 0x00800000) > 0) ? 1 : 0;
  ti_frac = (ui & 0x007FFFFF);
  ke = ti_expn;
  printf(" expn %x %d ke %d\n",ti_expn,ti_expn, ke);
  printf(" sign %d\n",ti_sign);
  printf(" frac %x %d\n",ti_frac, ti_frac);


  ui = 0x02400000;
  f = convert_ti_float(ui);
  printf("ui %x -->  f %f\n\n",ui, f);


  ui = 0xFB400000;
  f = convert_ti_float(ui);
  printf("ui %x --> f %f %f\n",ui, f, (3.0/64.0));

  ui = 0x01C00000;
  f = convert_ti_float(ui);
  printf("ui %x --> f %f\n",ui, f);


  ui = 0x0140000;
  f = convert_ti_float(ui);
  printf("ui %x --> f %f\n",ui, f);

  ui = 0x0200000;
  f = convert_ti_float(ui);
  printf("ui %x --> f %f\n",ui, f);






}
