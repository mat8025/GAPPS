
int sr
int er

proc find_be(int X[],n)
{
int j
int pts[4]
  for (j=1 ; j < n ; j++) {

    if (X[j-1] == 0 && X[j] > 0) {
       sr = j
    }

    if (X[j] == 0 && X[j-1] > 0) {
       er = j
    }
  }

  pts[0] = sr
  pts[1] = er
  pts[2] = sr + (er-sr)/2
  pts[3] = (er-sr)
  return pts

}


int C[120]


int S[120]



// fill cloud vector
int mid_point = 30
int cloud_vextent = 50

// back-project onto screen
  ramp_val = 10
  ramp = 10
  ramp_edge = 10
  start = mid_point - cloud_vextent/2
  end = mid_point + cloud_vextent/2
  start_ramp = start + 10
  end_ramp =  end - 10

 for (i = start; i < end; i++) {

      C[i] = 50 -ramp

      if (i < start_ramp)
      ramp--

      if (ramp < 0)
        ramp = 0

      if (i > end_ramp) {
         ramp++ 
      }

      if (ramp > ramp_val)
        ramp = ramp_val

 }

int j
int k
float ang
float cloud_range = 80
float screen_range = 20

  for (i = 0; i < 120; i++) {

     if (C[i] > 0) {
        j = abs(i-mid_point)
        ang = r2d(atan(j/cloud_range))

        k = (screen_range * tan(d2r(ang)) + 0.5)
//<<"$i $j $ang $k\n"
        if (i > mid_point) {
        S[mid_point+k] = C[i]
        }
        else {
        S[mid_point-k] = C[i]
        }
     }
  }



<<"$C\n"
    wpts = find_be(C,120)
<<"$wpts\n"

    ce= wpts[3]

<<"$S\n"

    wpts = find_be(S,120)
<<" $wpts\n"

    se= wpts[3]
float cpr = ce/(1.0*se)

<<"compression $cpr \n"