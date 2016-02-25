// what is beam width feet at nmile



nm2feet = 6076.0


beam_wd = 3.5

// at 40 nm 1/2 beam_width is  40 * nm2ft * tan(1.75)

d_deg = 3.0/8.0
int taps
  for (k = 10; k <= 120 ; k += 10) {

    h = k * nm2feet * tan(d2r(1.75))
    sp = k * nm2feet * tan(d2r(d_deg))
    taps = h/500
<<"$k nmiles   $h feet  delta $sp feet $taps\n"

  }