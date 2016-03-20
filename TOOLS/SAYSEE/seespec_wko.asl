
///  seespec
///////////////////////  Wo and Key callbacks ///////////////////

proc do_wo_options(w_wo)
{
<<"In $_proc  \n"

        if (w_wo == qwo) {
                  do_loop = 0;
        }
	
        else if (w_wo == playsr_wo) {
                   playSection (tx)
        }
        else if (w_wo == playbc_wo) {
                playBCtas()
        }
        else if (w_wo == selectsr_wo) {
                showSelectRegion()
        }
/{	
        else if (w_wo == res_wo) {
//                 <<"%V$msgw[1] $wshift\n"
                 if (msgw[1] @= "low") {
                    <<" res low\n"
                    wshift = hwlen
                 }
                 else if (msgw[1] @= "med") {
                    wshift = qwlen
                 }
                 else if (msgw[1] @= "high") {
                    wshift = owlen
                 }
                 tx_shift = samp2time(wshift/2)

                  getNpixs()
                  selSection (tx)

        }
/}

    else if (w_wo == voxwo) {

              tx = btn_rx // x val ---- time in voxwo

              if (button == 1) {
                sGl(co2_gl,@cursor,tx,y0,tx,y1)  
              }
              else if (button == 3) {
                sGl(co3_gl,@cursor,tx,y0,tx,y1)  
              }

              sGl(cosg_gl,@cursor,tx,0,tx,100)  

              //showSlice (tx)
	      
        }
        else if (w_wo == sgwo) {

              tx = btn_rx // x val ---- time in voxwo

              sGl(cosg_gl,@cursor,tx,0,tx,100)  

             // showSlice (tx)
        }
        else if (w_wo == taswo) {

              tx = btn_rx // time 

              if (button == 1) {
                sGl(co2_gl,@cursor,tx,y0,tx,y1)  
              }
              else if (button == 3) {
                sGl(co3_gl,@cursor,tx,y0,tx,y1)  
              }

              selSection (tx)
	      
              txa = tx - 2.0
	      if (txa < 0) {
                txa = 0
              } 
              txb = txa + 4.0
              //sWo(tawo,@scales, txa ,-26000, txb, 26000)  // via SHM

              showSlice (tx)

              displayComment("%6.2f$tx $txa $txb \n")

        }
        else if (w_wo == record_wo) {

            do_record()

            //SB = getSignalFromBuffer(sbn,0,ds)
	    YS = getSignalFromBuffer(sbn,0,ds)

            //YS = SB
                
            sWo(voxwo, @redraw, @clearclip, BLUE_)
            drawSignal(voxwo, sbn, 0, npts)

        }
        else if (w_wo == read_wo) {

         // pop up a window to look for vox files?
	 
          fname = naviwindow("Vox File Locator", " Search for vox files " , "sp_phrase.vox", vox_type);

             <<"got $fname\n"
          //  fname = "ec1.0-9.vox"
	  // check it exists then


            ds=voxFileRead(fname)
            sWo(butawo,@border,@drawon,@clipborder,@fonthue,BLACK_,@redraw)

            <<"read $ds from file $fname \n"
            displayComment("reading $fname \n")

            setUpNewVoxParams()

            <<"%V $mm[0]  $vox_tX  $Freq\n"

            sWo(voxwo,@scales,0,mm[0],vox_tX,mm[1])



            // position cursors
            sGl(co2_gl,@cursor,0,y0,0,y1)
            sGl(co3_gl,@cursor,10,y0,10,y1)  

            sWo(voxwo, @redraw,@clearclip,WHITE_)
            drawSignal(voxwo, sbn, 0, npts)

            axnum(voxwo,-3)

	 //   sWo(taswo, @redraw,@clearclip,WHITE_)
         //   drawSignal(taswo, sbn, 0, npts)	    

            showSelectRegion()

            sWo(butawo,@border,@drawon,@clipborder,@fonthue,BLACK_,@redraw)
          
	    displayComment("reading $fname \n")
            <<"done with read and process of vox file \n"
        }	
        else if (w_wo == write_wo) {
            // write current select region to out.vox
            writeVox()
        }


}
//===========================================================

proc do_key_options(key)
{
<<"In $_proc  \n"
       switch (key) 
       {

         case 'R':
            tx += 0.1
              selSection (tx)
              txa = tx - 2.0
	      if (txa < 0) {
                txa = 0
              } 
              txb = txa + 4.0
              sWo(taswo,@scales, txa ,-30000, txb, 31000)  // via SHM
         break;
         case 'T':
            tx -= 0.1
              selSection (tx)
              txa = tx - 2.0
	      if (txa < 0) {
                txa = 0
              } 	      
              txb = txa + 4.0
              sWo(taswo,@scales, txa ,-30000, txb, 31000)  // via SHM
         break;
         case 'Q':
            tx -= tx_shift  // this should be adjustable by key
            showSlice (tx)
            sGl(co2_gl,@cursor,tx,y0,tx,y1)  
            sGl(cosg_gl,@cursor,tx,0,tx,100)  
         break;
         case 'S':
            tx += tx_shift
            showSlice (tx)
            sGl(co2_gl,@cursor,tx,y0,tx,y1)  
            sGl(cosg_gl,@cursor,tx,0,tx,100)  
         break;
       }

}
//===========================================================
