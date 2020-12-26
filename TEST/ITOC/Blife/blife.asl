

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

 if (do_laser) {
 scr_laser(cw)
 open_laser("pic1.ps")
 }


 setgw("hue","green")
 drawxy(cw,X,B1)
 setgw("hue","blue")
 drawxy(cw,X,B2)
 setgw("hue","red")
 drawxy(cw,X,RV)

// gline

// b1
// plot
 setgw(cw,"hue","black")
 SetGwindow(cw,"clipborder")

 axnum(cw,2,1.0,1.8,0.1,1,"3.1f")

 axnum(cw,1,0,920,60,2,"3.0f")


 text(cw,"Time (mins)",0.5,-0.08,1,0,1,"black")

 text(cw,"Volts ",-0.09,0.5,1,90,1,"black")

 text(cw,"Rayovac ",0.5,0.4,1,0,1,"red")

 text(cw,"EverReady ",70,1.6,0,0,0,"green")

 text(cw,"Duracell ",0.8,0.6,1,0,1,"blue")

 gsync()







  sleep(5)

 gsync()
 if (do_laser) {
 close_laser()

!!"ps2pdf pic1.ps pic1.pdf"
 }







