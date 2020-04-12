#! /usr/local/GASP/bin/asl
#/* -*- c -*- */

do_laser =0
//  
set_debug(0)
OpenDll("plot","math","stat")

fn= GetArgStr()
fn= GetArgStr()
A=ofr(fn)

<<" $fn $A \n"

svar wd


while (wd->read(A) != -1) <<"$wd\n"
sfile(A,0,0)

R=ReadRecord(A,"type","float","datecon",0,"\%m/\%d/\%Y_\%H:\%M:\%S")
dim = Cab(R)
<<" $dim \n"
<<"%r $R\n"


X= R[*][0]

X->redimn()
zx= X[0]
//X = X - zx
  X -= zx
  X /= 60

B1 = R[*][1] + R[*][2]
B1->redimn()

B1 /= 2

B2 = R[*][3] + R[*][4]
B2->redimn()
B2 /= 2

B3 = R[*][5]
B3->redimn()
B4 = R[*][6]
B4->redimn()


RV = B3 + B4
RV /= 2.0

<<" $X \n"
<<" $B1 \n"
mm = MinMax(X)
xmax = mm[1]
xmax = 600


<<"%v $xmax \n"
// window
 cw =  CreateGwindow("title","BL","scales",-60,1.0,xmax,1.8,"savescales",0)

// SetGwindow(cw,"resize",0.1,0.31,0.9,0.49,0)
 SetGwindow(cw,"clip",0.1,0.1,0.9,0.90)
 SetGwindow("clipborder","pixmapoff","drawon")
 setgw("clear","redraw","save")

  b1gl=CreateGline("wid",cw,"type","XY","xvec",X,"yvec",B1,"color", "green","usescales",0)
  DrawGline(b1gl)
  b2gl=CreateGline("wid",cw,"type","XY","xvec",X,"yvec",B2,"color", "blue","usescales",0)
  DrawGline(b2gl)

  b3gl=CreateGline("wid",cw,"type","XY","xvec",X,"yvec",RV,"color", "red","usescales",0,"name","Rayovac")
  DrawGline(b3gl)


  xlabel=CreateGwob(cw,"LABEL","resize",1,0.5,0.02,0.7,0.1)
  SetGwob(xlabel,"fonthue","black","name","xlabel","value","Time_(mins)","redraw")

  ylabel=CreateGwob(cw,"LABEL","resize",1,0,0.2,0.1,0.5)
  SetGwob(ylabel,"fonthue","black","name","ylabel","value","Volts","redraw")


  erlabel=CreateGwob(cw,"LABEL","resize",0,70,1.6,240,1.7)
  SetGwob(erlabel,"fonthue","green","value","EverReady","redraw")


  drlabel=CreateGwob(cw,"LABEL","resize",0,500,1.5,600,1.6)
  SetGwob(drlabel,"fonthue","blue","value","Duracell","redraw")


  rvlabel=CreateGwob(cw,"LABEL","resize",0,400,1.2,600,1.4)
  SetGwob(rvlabel,"fonthue","red","value","Rayovac","redraw")


  ullabel=CreateGwob(cw,"LABEL","resize",0,100,1.2,200,1.4)
  SetGwob(ullabel,"fonthue","black","value","<---Under Load---> ","redraw")

  reclabel=CreateGwob(cw,"LABEL","resize",0,300,1.5,600,1.6)
  SetGwob(reclabel,"fonthue","black","value","<--- Recovery---> ","redraw")





 if (do_laser) {
 scr_laser(cw)
 open_laser("pic1.ps")
 }


// gline

// b1
// plot
 setgw(cw,"hue","black")
 SetGwindow(cw,"clipborder")

 axnum(cw,2,1.0,1.8,0.1,1,"3.1f")
 axnum(cw,1,0,920,60,2,"3.0f")





 gsync()







 sleep(5)

 gsync()


   while (1) {

    w_activate(cw)
<<"activate and wait for msg \n"
    msg = MessageWait(Minfo)
    <<" $msg $Minfo \n"

  	if ((msg @= "REDRAW") || (msg @= "RESIZE") ) {
    		SetGwindow(cw,"woredrawall")
    		RedrawGlines(cw)
 gsync()
 setgw(cw,"hue","black")
 axnum(cw,2,1.0,1.8,0.1,1,"3.1f")
 axnum(cw,1,0,920,60,2,"3.0f")
  	}

  	if ((msg @= "PRINT")  ) {
 scr_laser(cw)
 open_laser("pic1.ps",20,1)

    		SetGwindow(cw,"woredrawall")
    		RedrawGlines(cw)
 setgw(cw,"hue","black")
 axnum(cw,2,1.0,1.8,0.1,1,"3.1f")
 axnum(cw,1,0,920,60,2,"3.0f")
 gsync()
 sleep(2)

 close_laser()
 laser_scr(cw)
!!"ps2pdf pic1.ps pic1.pdf"

  	}

  }




 if (do_laser) {
 close_laser()

!!"ps2pdf pic1.ps pic1.pdf"
 }

STOP!





