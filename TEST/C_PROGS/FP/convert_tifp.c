
float convert_ti_float(uint *tif)
{
  float ieee_f = 0.0;
  float *fp;
  uint32 val = *tif;
  uint32 ieee_val;
  uint32 ieee_man;
   char ieee_exp;
   char ieee_sign = 0;
   val = 0xFB400000;
  int ti_exp = (val >> 24);
  if (ti_exp & 0x80) {
    ti_exp = ~ti_exp + 1;
    ti_exp *= -1;
  }
  char ti_sign =  (val & 0x00800000) >> 23;
  uint32 ti_man =     (val & 0x007fffff) ;

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
        ieee_val =  (ieee_sign << 31 | ieee_exp << 23 | ieee_man) ;
        ieee_f = * (float *) &ieee_val;
    }
    else if (ti_exp >= -126 && ti_exp <= 127
         && ti_sign == 1
          && ti_man != 0) {
        ieee_exp = ti_exp + 0x7F;
        ieee_sign = 0;
        ieee_man =  ~ti_man + 1; // ones comp + 1
        ieee_val =  (ieee_sign << 31 | ieee_exp << 23 | ieee_man) ;
        ieee_f = * (float *) &ieee_val;
    }

    else if (ti_exp >= -126 && ti_exp <= 127
         && ti_sign == 1
          && ti_man == 0) {
        ieee_exp = ti_exp + 0x80;
        ieee_sign = 1;
        ieee_man =  0;
        ieee_val =  (ieee_sign << 31 | ieee_exp << 23 | ieee_man) ;
        ieee_f = * (float *) &ieee_val;
    }
    else if (ti_exp == 127
             && ti_sign == 1
             && ti_man == 0) {
        ieee_exp =  0xFF;
        ieee_sign = 1;
        ieee_man =  0;
        ieee_val =  (ieee_sign << 31 | ieee_exp << 23 | ieee_man) ;
        ieee_f = * (float *) &ieee_val;
    }

    return ieee_f;

}
