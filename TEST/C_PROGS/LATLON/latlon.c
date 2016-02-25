#include <stdio.h>
#include <math.h>

float PI = 4*atan(1.0);


float d2r( float deg)
{

  return (deg /180.0 * PI);

}

float r2d( float r)
{

  return (r/ PI * 180);

}


int main (int argc, char **argv)
{


  float pi= 4*atan(1.0);

  float rad_per_deg = ( pi/ 180.0);

  float NM_TO_RAD =    (pi/(60.0 * 180.0));  


  printf("pi %f \n",pi);

  float y = asin(0);

  printf("y %f \n",y);


  
  y = asin(pi/4.0);

  printf("y %f \n",y);

// FIX < pi/2.0 value
//y = asin(pi/2.0)
//<<"$y \n"




   float lat = 40.0;
   float lon = 90.0;
  
   float lat_r = d2r(lat);

   printf(" lat_r %f\n",lat_r);



   float sin_ac_lat  = sin(lat_r);

    printf ("sin_ac_lat %f\n", sin_ac_lat);

  float cos_ac_lat  = cos(lat_r);


  float cos_rng = (40 * NM_TO_RAD);
  float sin_rng = (40 * NM_TO_RAD);


  float trg_lat = asin(sin_ac_lat * cos_rng + cos_ac_lat * sin_rng * cos(rad_per_deg * 0));


  printf ("trg_lat %f\n", trg_lat);

  float    trg_lat_d = r2d(trg_lat);

  printf ("trg_lat_d %f\n", trg_lat_d);

 
    }
