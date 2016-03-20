
///////////////////////////////// IO /////////////////////////////////

vox_type = ".vox"

proc voxFileRead(vfname)
{

////////////// READ FILE INTO BUFFER   ///////////////////////////
<<"$_proc \n"

//    ok=deleteSignalBuffer(sbn)
//    sbn = createSignalBuffer()

<<"created %V$sbn \n"

  vds = readsignal(sbn,vfname)

<<"%V $sbn $vds \n"

  // find range of signal
  // just copy buffer back out so we can process it
  // we will add builtin processing later

isz= Caz(YS)
<<"sigsize %V$isz\n"

   YS = getSignalFromBuffer(sbn,0,vds-2)

   osz= Caz(YS)

<<"signal size %V$osz\n"

//<<"%(16,, ,\n)$YS[0:32] \n"

<<" $YS[3] $YS[vds-2]\n"

//<<"Done $_proc \n"

  return vds
}//-------------------------------------

proc setUpNewVoxParams()
{
            npts = (ds/512) * 512

            sz = Caz(YS)

<<"%V $ds $npts $sz $YS[3]\n"

            mm= minmax(YS)
            y0 = mm[0]
            y1 = mm[1]

            vox_tX = ds / Freq;

<<"%V$mm  $vox_tX\n"

                

}//-------------------------------------



proc writeVox()
{
int start_n;
int stop_n;

     GV = glineGetValues(co2_gl)
     GV1 = glineGetValues(co3_gl)

     ps_tx1 = GV[0]
     ps_tx2 = GV1[0]

     start_n = ps_tx1 * Freq
     stop_n = ps_tx2 * Freq  

  nsw =   writeSignal(sbn,"out.vox",start_n, stop_n);

  <<"wrote $nsw samples to out.vox\n"

}
//---------------------------------------------

