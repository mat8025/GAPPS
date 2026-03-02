//
//  drawMonths
//

  void  drawMonths(int wwo)
  {
  //
  // as either Months Jan,Feb, ... Dec  
  // or quarter and cross-quarter days
  // Candlemass Feb 2
  // Lady Day   March 25
  // Beltane (may day) May 1
  // MidSummer   June 24
  // Lughnasaid  Aug 1
  // Michlemas   Sept 29
  // Samhain     Oct 31
  // Christmas   Dec 25
  //
  // Equinoxes Dec 21, March 21, June 21, Sep 21 -
  // winter ,vernal, midsummer, fall
  //<<"$_proc  $wwo\n"
  // oknow = Ask ("que pasa? $_proc $wwo",1)
  int match[2]
  int sd

  int k

  int yd

  int wd

  int wm = 0

  float lty = 0
//  Str wday = "Mon"
  
  float qfwd = 0.0

  RS=wgetrscales(wwo)
// just plot at mid - the date

  mid_date = (RS[3] - RS[1])/2 + RS[1]

  float q1_date = (RS[3] - RS[1])/4 + RS[1]

  float q3_date = 3*(RS[3] - RS[1])/4 + RS[1]

  long jd= mid_date +Bday

//  the_date = julmdy("$jd")
   the_date = Julmdy(jd)

   // use mondays as the date tick


   //AxText(wwo, 1, the_date, mid_date, -0.25, BLUE_)

  jd= RS[1] + Jan1

  the_date = Julmdy(jd)
  
  Str mday = spat(the_date, "/",-1,-1, match)
  
 // AxText(wwo, 1, mday, q1_date, -0.25, BLUE_)

  float wdate = RS[1]

  sWo(_WOID,wwo,_WFONT,"small")
 //  AxText(wwo, 1, the_date, wdate, 0.25, BLUE_)

  int draw_months =1

  int mon = (jd +1) % 7

  mon = 2 -mon
  jd -= mon
  wdate -= mon
  
  while (draw_months <= 12) {

  jd += 7

  wdate += 7

  if (wdate >= RS[3]) {

     break

  }

  the_date = Julmdy(jd)

 //wday = Julday(jd)
  
 // Str mday = spat(the_date, (char *)"/",-1,-1, match)
  mday = spat(the_date, "/",-1,-1, match)

 // axisLabel(wwo, 1, mday, wdate, 0.7, BLUE_)
  AxText(wwo, 1, mday, wdate, -0.25, MAGENTA_)
  
//   <<"%V $jd $wdate $RS[3] $the_date $mday $wday\n"

  draw_months++

  }

  }
//---------------------------------------------------------------
