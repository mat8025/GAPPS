
//            temp_lat = asin(sin_ac_lat * cos_rng + cos_ac_lat * sin_rng * cos(RADIANS_PER_DEGREE * CellArray[cell_count].centroid_brg));


double pi

   pi= 4.0*atan(1.0)

<<"%V10.8f$pi \n"

double rad_per_deg
rad_per_deg = (pi/ 180.0)

double nm_to_rad
nm_to_rad =    (pi/(60.0 * 180.0))  





// FIX < pi/2.0 valie
//y = asin(pi/2.0)
//<<"$y \n"

#define FAI_EARTH_RAD_KM 6371.0

#define EQT_EARTH_RAD_KM 6378.137

double i_rad
double e_rad

  i_rad = 1.0/FAI_EARTH_RAD_KM 

  e_rad = 1.0/EQT_EARTH_RAD_KM 

<<"%V10.8f$i_rad %10.8f$e_rad\n"


//XX=YY
//<<"%V$YY $XX\n"
/{
 double dist
 double lat
 double lon
 double hdg
/}


 float dist
 float lat
 float lon
 float hdg


 lat = 5.0
 lon = 90.0
 dist = 1000.0
 hdg = 180.0

 dist_nm = dist * 1000.0/ 1852.0


<<"%V$dist $dist_nm \n"

// double lat_r = d2r(lat)
   float lat_r = d2r(lat)

<<"%V10.8f$lat_r\n"

  double sin_ac_lat  = sin(lat_r)


/{
  double cos_ac_lat  = cos(lat_r)
  double cos_rng
  double sin_rng
  double trg_lat
/}


  float cos_ac_lat  = cos(lat_r)
  float cos_rng
  float sin_rng
  float trg_lat


<<"%V10.8f$sin_ac_lat $cos_ac_lat \n"

//  cos_rng = (dist * NM_TO_RAD)
//  sin_rng = (dist * NM_TO_RAD)
//  cos_rng = cos(dist * i_rad)
//  sin_rng = sin(dist * i_rad)


  cos_rng = cos(dist * e_rad)
  sin_rng = sin(dist * e_rad)

<<"%V10.8f$cos_rng $sin_rng \n"


  trg_lat = asin(sin_ac_lat * cos_rng + cos_ac_lat * sin_rng * cos(rad_per_deg * hdg));


<<"%V$trg_lat \n"

     trg_lat_d = r2d(trg_lat)

<<"%V$trg_lat_d \n"


 Wh = latlongfromradialopad( hdg, lat, lon, dist)

<<"$Wh \n"

dist = 1001

 Wh = latlongfromradialopad( hdg, lat, lon, dist)

<<"$Wh \n"


  cos_rng = cos(dist * e_rad)
  sin_rng = sin(dist * e_rad)

<<"%V10.8f$cos_rng $sin_rng \n"


  trg_lat = asin(sin_ac_lat * cos_rng + cos_ac_lat * sin_rng * cos(rad_per_deg * hdg));


<<"%V$trg_lat \n"

     trg_lat_d = r2d(trg_lat)

<<"%V$trg_lat_d \n"





  cos_rng = cos(dist_nm * nm_to_rad)
  sin_rng = sin(dist_nm * nm_to_rad)


  trg_lat = asin(sin_ac_lat * cos_rng + cos_ac_lat * sin_rng * cos(rad_per_deg * hdg));


<<"%V$trg_lat \n"

     trg_lat_d = r2d(trg_lat)

<<"%V$trg_lat_d \n"
