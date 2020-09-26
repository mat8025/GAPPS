///
///
///


/// plot a 512X512 image

 opendll("image");

 if (! CheckGwm() ) {
     X=spawngwm()
  }


// want this to contain a 512X512 image -- so that plus borders and title
  
  wid =  cWi("title","PIC_WINDOW",@resize,0.01,0.01,0.99,0.99,0)

// again must be greater the 512x512 plus the borders
 
 picwo=cWo(wid,"GRAPH",@name,"Pic",@color,"yellow",@resize,0.01,0.01,0.99,0.99)

// set the clip to be 512x512 --- clipborder has to be on pixel outside of this!

// setGwob(picwo,@clip,100,4,512,256,2)

 sWo(picwo,@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,"red", @redraw)

 sWo(picwo,@SCALES,0,0,1,1)


 sWo(picwo,@pixmapon,@drawon,@redraw)

 sWo(picwo,@clip,4,4,512,512,2)



 plotline(picwo,0,0,1,1)

 plot(picwo,@line,0,1,1,0,BLUE_)

// space for image
fp =  ofr("../SIGNALS/woman.pic")

npx = 512*512
uchar PX[npx];

int PIX[npx]







// read in image file

 nc=v_read(fp,PX,(512*512),"uchar")

<<"%(10,, ,\n)$PX[0:99]\n"

<<"%V $nc \n"


    PIX = PX
<<"PX:$PX[0:32]\n"
<<"PIX:$PIX[0:32]\n"



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

    PIX = 255 - PX


   Redimn(PIX,512,512)

   PlotPixRect(picwo,PIX,cmi)

   sleep(1)


  Redimn(CX,512,512)

<<"%V$(cab(PX)) \n"

  PlotPixRect(picwo,CX,cmi)

<<"$CX[0][0:20]\n"

   sleep(1)





  RCX = reflectCol(CX)
//  RCX = CX

<<"$RCX[0][0:20]\n"

<<"$RCX[0][-21:-1]\n"

  PlotPixRect(picwo,RCX,cmi)

  RCX = reflectRow(CX)

  PlotPixRect(picwo,RCX,cmi)


  NCH = Imop(CX,"sobel")


  PlotPixRect(picwo,NCH,cmi)

 // sleep(2)


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


  sWo(picwo,@showpixmap)
//FIX  PX = 255 - PX

// set up a RGB map   

   c_index = cmi

   redv = 0.0 ; greenv = 0.0 ; bluev = 0.0 ; 
   dr = 1.0/256
   
   cv = 0.0
   //for (i=0;i <=255; i++) {
   while (c_index < 255) {
   setRGB(c_index++,cv,0,1.0-cv)
   cv += dr;
   setRGB(c_index++,0,cv,0)
   cv += dr;
   setRGB(c_index++,1.0-cv,0,cv)
   cv += dr;   
   }

   PlotPixRect(picwo,PIX,cmi)
   



   sleep(1);
   

   setRGB(c_index++,0,greenv,0)
   setRGB(c_index++,0,0,bluev)





   sleep(5)
//  PlotPixRect(picwo,PX)
//sWo(picwo,@showpixmap)



// flip



// rotate




