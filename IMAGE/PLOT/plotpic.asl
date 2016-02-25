// plot a 512X512 image

 opendll("image");

 if (! CheckGwm() ) {
     X=spawngwm()
  }


// want this to contain a 512X512 image -- so that plus borders and title
  
  wid =  CreateGwindow("title","PIC_WINDOW",@resize,0.01,0.01,0.99,0.99,0)

// again must be greater the 512x512 plus the borders
 
 picwo=createGWOB(wid,"GRAPH",@name,"Pic",@color,"yellow",@resize,0.01,0.01,0.99,0.99)

// set the clip to be 512x512 --- clipborder has to be on pixel outside of this!

// setGwob(picwo,@clip,100,4,512,256,2)

 setgwob(picwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red", @redraw)

 setgwob(picwo,@SCALES,0,0,1,1)


 setGwob(picwo,@pixmapon,@drawon,@redraw)

 setGwob(picwo,@clip,4,4,512,512,2)



 plotline(picwo,0,0,1,1)

 setGwob(picwo,@plotline,0,1,1,0,"blue")

// space for image
fp =  ofr("../SIGNALS/woman.pic")

npx = 512*512
uchar PX[npx+]

// read in image file

 nc=v_read(fp,PX,(512*512),"uchar")

<<"%(10,, ,\n)$PX[0:99]\n"

<<"%V $nc \n"

// set the gray-scale ?? is it 256 levels since uchar

# color map index - 16 start of default 64 grey scale
// we need an offset for plotpixmap so we can use that to select region of our
// CMAP

ngl = 256
cmi = 64

set_gsmap(ngl,cmi)



uchar CX[]

 CX = 255 - PX

<<"%(10,, ,\n)$CX[0:99]\n"

// display


  Redimn(CX,512,512)

<<"%V$(cab(PX)) \n"

//  PlotPixRect(picwo,CX,cmi)

<<"$CX[0][0:20]\n"


  RCX = reflectCol(CX)

<<"$RCX[0][0:20]\n"

<<"$RCX[0][-21:-1]\n"

  PlotPixRect(picwo,RCX,cmi)

  RCX = reflectRow(CX)

  PlotPixRect(picwo,RCX,cmi)


  NCH = Imop(CX,"sobel")


  PlotPixRect(picwo,NCH,cmi)

  sleep(2)


  NCH = Imop(CX,"laplace")

  PlotPixRect(picwo,NCH,cmi)

  int T[10]

           	T[0] = 0;
		T[1] = -1;
		T[2] = -1;
		T[3] = 0;
		T[4] = 6;		
		T[5] = -2
		T[6] = 0
		T[7] = -1;
		T[8] = -1;
  NCH = Imop(CX,T)

  PlotPixRect(picwo,NCH,cmi)

/{
  PlotPixRect(picwo,CX,cmi,0,511,1)

  PlotPixRect(picwo,CX,cmi,0,511,2,-1)

  PlotPixRect(picwo,CX,cmi,511,0,0,2)
/}


  setGwob(picwo,@showpixmap)
//FIX  PX = 255 - PX

   


//  PlotPixRect(picwo,PX)
//setGwob(picwo,@showpixmap)



// flip



// rotate




