// sg_options


proc do_wo_options(w_wo)
{

<<"OPTIONS $_proc  $w_wo \n"

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
        else if (w_wo == res_wo) {

                 if (E->woval @= "low") {
                    <<" res low\n"
                    wshift = hwlen
                 }
                 else if (E->woval @= "med") {
                    wshift = qwlen
                 }
                 else if (E->woval @= "high") {
                    wshift = owlen
                 }
                 else if (E->woval @= "fine") {
                    wshift = owlen/2
                 }

                 tx_shift = samp2time(wshift/2)

                <<"%V$E->woval $wshift $tx_shift\n"

                  getNpixs()

                  selSection (tx)

        }
        else if (w_wo == taswo) {

              tx = E->rx // x val ---- time in voxwo

<<"clicked in tas $taswo @time val $tx \n"

              if (E->button == 1) {
                setGline(co2_gl,@cursor,tx,y0,tx,y1)  
              }
              else if (E->button == 3) {
                setGline(co3_gl,@cursor,tx,y0,tx,y1)  
              }

              setGline(cosg_gl,@cursor,tx,0,tx,100)  

              showSlice (tx)


        }
        else if (w_wo == sgwo) {

              tx = E->rx // x val ---- time in voxwo

<<"clicked in sg $sgwo @time val $tx \n"

              setGline(cosg_gl,@cursor,tx,0,tx,100)  


              showSlice (tx)


        }
        else if (w_wo == voxwo) {

              tx = E->rx // time in voxwo
<<"clicked in %V$voxwo @time val $tx \n"

              selSection (tx)
              txa = tx - 2.0
              txb = tx + 2.0
              setGwob(taswo,@scales, txa ,-MaxTa, txb, MaxTa)  // via SHM
              showSlice (tx)
              displayComment("%6.2f$tx $txa $txb \n")

        }
}


proc do_key_options(key)
{

       switch (key) 
       {

         case 'R':
            tx += 0.1
              selSection (tx)
              txa = tx - 2.0
              txb = tx + 2.0
              setGwob(taswo,@scales, txa ,-MaxTa, txb, MaxTa)  // via SHM
         break;
         case 'T':
            tx -= 0.1
              selSection (tx)
              txa = tx - 2.0
              txb = tx + 2.0
              setGwob(taswo,@scales, txa ,-MaxTa, txb, MaxTa)  // via SHM
         break;
         case 'Q':
            tx -= tx_shift  // this should be adjustable by key
            showSlice (tx)
            setGline(co2_gl,@cursor,tx,y0,tx,y1)  
            setGline(cosg_gl,@cursor,tx,0,tx,100)  
         break;
         case 'S':
            tx += tx_shift
            showSlice (tx)
            setGline(co2_gl,@cursor,tx,y0,tx,y1)  
            setGline(cosg_gl,@cursor,tx,0,tx,100)  
         break;


       }

}


////////////////////////////////////////////////////
