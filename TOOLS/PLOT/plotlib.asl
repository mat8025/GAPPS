#/* -*- c -*- */
# "$Id: plotlib.asl,v 1.1 2004/10/11 04:43:57 mark Exp mark $"

<<" loading plotlib \n"


proc ShowFileN(ww, fn)
{

  // <<" $_cproc $fn \n" 

    W_SetPen(ww,"black")

    Text(ww," $fn ", 0.7, -0.10,1)
 
      //<<" $fn \n"

      //    cwd = GetDir()

      //    Text(ww," $cwd ", 0.2, -0.07,1)
}


proc ShowLabel(ww, fn, col, lx,ly)
{

  // <<" $_cproc $fn \n" 

    W_SetPen(ww,col)

    Text(ww," $fn ", lx, ly,1)

 }

proc DrawAxis(ww ,six, siy ,xsc, ysc)
{


      ReScaleGraph(ww,xsc,ysc)

      rs = w_getRS(ww)
      <<" $_cproc $ww $rs \n"
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

      //<<" $rs \n"

            dy = (rY - ry )

            dx = (rX -rx)
          
  	   if (six == -1)
	    ix = get_incr (dx)
	   else
             ix = six

  	   if (siy == -1)
            iy = get_incr ( dy)
	    else
            iy = siy


	<<" incr %V $ix $iy \n"

            int irx = rx/ix

            rx = irx * ixx

	      <<"%V $rx $ry $rX $rY \n"

            int iry = ry/iy
            ry = iry * iy

            W_SetPen(ww,"black")

            ticks(ww,1,rx,rX,ix,0.02)

            ticks(ww,2,ry,rY,iy,0.02)
         
	      //FIX   axnum(ww,1,rx+2*ix,rX-(2*ix),2*ix,-2.0,"3.0f")
 axnum(ww,1,rx+2*ix,rX-(2*ix),2*ix,-2.0,"3.0f")
            ix2 = 2 * ix
            <<" %I $ix2 \n"
	      //            axnum(ww,1,rx+2*ix,rX-(2*ix),2*ix,-2.0,"3.0f")

	      //            axnum(ww,1,rx+ix2,rX-ix2,ix2,-2.0,"3.0f")

            axnum(ww,2,ry+iy,rY,4*iy,3.0,"g")

        w_clipborder(ww)

  ReScaleGraph(ww,1.0/xsc,1.0/ysc)
}


proc ReScaleGraph(ww, xsc, ysc) 
{
      rs = w_getRS(ww)

<<" $_cproc $ww $rs \n"
      
      rx = rs[1] 
      ry = rs[2]
      rX = rs[3] 
      rY = rs[4]

      rx *= xsc
      rX *= xsc

  <<" $rx $rX \n"

      ry *= ysc
      rY *= ysc

	//<<" $rx $rX \n"

      SetGwindow(ww,"scales",rx,ry,rX,rY,"savescales",0)

}


proc  RedrawGraph(tw)
 {
      SetGwindow(tw,"clearpixmap","clearclip")
      RedrawGlines(tw)
      SetGwindow(tw,"showpixmap","store")
 }


////////////////////////////////////////////////////////////////////////////////////

