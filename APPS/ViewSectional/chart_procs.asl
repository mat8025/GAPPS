///
///
///    proc_chart.asl
///
///

int IGC_Read(Str igc_file)
{

<<"$_proc %V $igc_file \n"

  // double ssing[14]  - should translate to vec double
  
   Vec<double> sslng(14);
   
   Vec<double> sslat(14);
   
   Vec<double> ssele(14);


   T=fineTime();

   a=ofr(igc_file);

  <<"%V $a\n";

   if (a == -1) {
     <<" can't open IGC file $igc_file\n";
     return 0;
   }

    ntps =ReadIGC(a,IGCTIM,IGCLAT,IGCLONG,IGCELE);

    IGCELE *= 3.280839 ;

  //  IGCLONG = -1 * IGCLONG;
<<"read $ntps from $igc_file \n"

   dt=fineTimeSince(T);
   
<<" took $(dt/1000000.0) secs \n"

  for (i=0; i < 1000; i += 10) {
     //<<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n";
     printf("%d %f %f %f %f\n",i,IGCTIM[i] ,IGCELE[i] ,IGCLAT[i]  ,IGCLONG[i] );
     }
     


   sslng=  IGCLONG.stats();
     for (i=0; i < 12; i++) {
        printf("i %d %f \n",i,sslng[i]);
      }

   sslat= IGCLAT.stats(); // also works

     for (i=0; i < 12; i++) {
 printf("i %d %f \n",i,sslat[i]);
      }


    cf(a);
   return ntps;
}
//[EP]========================


void East()
{

    sec_col = dcols -scols;
    elng =  103.56;   // depends on lat - TBF
    wlng = elng + dlng;

  <<"at Eastern edge  %V $sec_col   $wlng $elng  $slat $nlat\n"
}
//[EP]========================
void goEast()
{
//sdb(2);
 int  new_col   = sec_col + scols/4;

 int  new_sec_col; 

 int dscols = scols/4;
 
 new_sec_col =  sec_col + scols/4;
 //new_col = sec_col + dscols;
 
    if (new_col != new_sec_col) {

<<"PARSE ERROR %V $new_col $new_sec_col\n"
    }
 
 if ((new_sec_col + scols) < dcols) {
   sec_col = new_sec_col;
   wlng -= dlng/4;
   elng -= dlng/4;

  }
  else {
  <<"at edge \n"
    sec_col = dcols -scols;
    elng =  103.56;   // depends on lat - TBF
    wlng = elng + dlng;
  }

<<"Heading East %V $new_sec_col  $sec_col $wlng  $elng $dlng  $scols $dcols $dscols $new_col\n"
}
//[EP]========================
void West()
{
      sec_col = sec_col_min; // west edge
       wlng = 110.0;  // lat dependent TBF
       elng = wlng + dlng;
<<"At Western edge  $sec_col  $wlng  $elng  \n"
}
//[EP]========================
void goWest()
{

 int dscols = scols/2;

   sec_col -=  scols/2;

   if (sec_col < sec_col_ min) {
       sec_col = sec_col_min; // west edge
       wlng = 110.0;  // lat dependent TBF
       elng = wlng + dlng;
       <<"at edge\n"
  }
  else {
   wlng += dlng/2 ;
   elng += dlng/2;
   }
<<"Heading West  $sec_col  $wlng  $elng  $dscols\n"
}
//[EP]========================

void Top()
{
       sec_row = drows - srows;
       nlat = 40.03;
       slat = nlat - dlat;
<<"At top North  $sec_row $slat  $nlat  $srows $drows \n"
}
//[EP]========================

void goNorth()
{

 int  new_sec_row =  sec_row + srows/4;
  if ((new_sec_row + srows) < drows) {
       sec_row = new_sec_row;
          nlat += dlat/4;
          slat += dlat/4;	  
  }
  else {
       sec_row = drows - srows;
       nlat = 40.03;
       slat = nlat - dlat;
  <<" at top \n";
}
<<"Heading North  $sec_row $slat  $nlat  $srows $drows \n"
}
//[EP]========================

void Bottom()
{

           sec_row =sec_row_min;
	   <<"at bottom\n"
          slat = slat_min;	  
          nlat = slat + dlat/4;
}
//[EP]========================

void goSouth()
{
<<"Heading South\n"

       sec_row -= srows/4;
       if (sec_row < sec_row_min) {
           sec_row =sec_row_min;
	   <<"at bottom\n"
       }
      else {
          nlat -= dlat/4;
          slat -= dlat/4;	  
      }
<<"$slat  $nlat\n"
}
//[EP]========================
void zoomOut()
{
	 
           skip_row++;
	if (skip_row >=10) {
	   skip_row =10;
	   }
        skip_col++;
	if (skip_col >=10) {
	   skip_col =10;
	   }

   scols = (ncols * (skip_col+1))
   srows = (nrows * (skip_row+1))   
   dlat = srows / 2840.0;
   dlng = scols /2100.0; 

   titleComment("ZoomOut ");
<<"Zoom OUT $skip_row $skip_col \n"

     titleMessage("Zoom OUT $skip_row $skip_col ");
// adjust  the lat,lng 
}
//[EP]========================
void zoomIn()
{
                skip_row--;
	if (skip_row < 0) {
	   skip_row =0
	   }
        skip_col--
	if (skip_col <0) {
	   skip_col =0
	   }

   scols = (ncols * (skip_col+1))
   srows = (nrows * (skip_row+1))   
   dlat = srows / 2840.0;
   dlng = scols /2100.0; 
     <<"Zoom IN in $skip_row $skip_col \n"
     titleMessage("Zoom IN $skip_row $skip_col ");



}
//[EP]========================
void centerPos()
{

	    
   <<"Center on click position \n"
   <<"%V $targ_col $targ_row  $sec_col $sec_row  $ncols $nrows\n"
  
            mid_col = sec_col + scols/2;
	    mid_row = sec_row + srows/2;
	    adj_col = mid_col - targ_col;
	    adj_row = mid_row - targ_row;
	    sec_col -= adj_col;
	    sec_row -= adj_row;
	    <<"%V $mid_col $mid_row $adj_col $adj_row $sec_col $sec_row\n"
	    if (sec_col < 0 ) sec_col = 0;
	    if (sec_row < 0) sec_row = 0;

  	 <<"%V $targ_col $targ_row $sec_col $sec_row $skip_col $skip_row $srows $scols\n"

}
//[EP]========================

//void chartCmap(Mat& LCM, int ncolors , int cindex)
// TBF  does get Mat& arg
void chartCmap(int ncolors , int cindex)
{

uint hexw = 0;
float dr = 1.0/256.0;

int i=3;

float redv;
float greenv;
float bluev;

uint redc
uint greenc
uint bluec


 for (i=0; i< ncolors; i++) {

  // hexw= LCM[i][1];
   hexw= CM[i][1];

   redc = ((hexw & 0x00ff0000) >> 16)
   greenc = ((hexw & 0x0000ff00)   >> 8)
   bluec = (hexw & 0x000000ff)

   redv = redc * dr;
   greenv = greenc *dr;
   bluev = bluec *dr;
  if ((redv > 0.0) || (greenv > 0.0) || (bluev > 0.0)) {

// <<"$i $CM[i][1] $cindex $hexw $redc $greenc $bluec $redv $greenv $bluev\n"
 <<" $i  %V $cindex $hexw $redc $greenc $bluec $redv $greenv $bluev\n"

  }

//<<"$i $cindex $hexw \n"
//   setRGB(cindex,hexw,0);

 // setRGB(cindex,redv,greenv,bluev);
    setRGB(cindex,bluev,greenv,redv);

 //setRGB(cindex,greenv,bluev,redv);
     cindex++;
  //redv += dr; greenv -= dr; bluev += dr/2.0;

  }
<<"DONE chartCmap $cindex \n"
!a
}
//[EP]========================

//<<"DONE include proc_chart\n"
