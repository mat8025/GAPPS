//
//    bike task
//

setDEbug(1,@keep)

   data_file = GetArgStr()

  if (data_file @= "") {
    data_file = "bike.tsv"  // open turnpoint file 
   }


<<"using $data_file\n"

  A=ofr(data_file)
  

  if (A == -1) {
    <<" can't find turnpts file \n"
     exit();
  }

///  Read data as Record
//R=readRecord(A,@type,FLOAT_)

R=readRecord(A)


sz = Caz(R);

<<"$R[0]\n"
<<"$R[1]\n"
<<"$R[2]\n"

<<"$sz\n"

<<"$R[2][1]\n"
<<"$R[2][2]\n"
<<"$R[2][3]\n"
<<"///\n"
<<"$R[0:9] \n"

M= R[1:20]

<<"$(Caz(M)) $(Cab(M))\n"

//<<"$R[0:9][1] \n"



 lat = R[4][1]
 <<"$lat\n"
exit()


float Lat[20];

 Lat = R[0:19:][1];

<<"Lat $Lat[0:9]\n"

exit()
////////////////////////////////////


Units = "M"


/////////////  Arrays : Globals //////////////

LatS= 37.5;

LatN = 40.2;

LongW= 105.5;

LongE= 102.8;

MidLat = (LatN - LatS)/2.0 + LatS;
MidLong = (LongW - LongE)/2.0 + LongE;



LoD = 30;

char MS[240]
char Word[128]
char Long[128]
num_tpts = 700




//////////////// PARSE COMMAND LINE ARGS ///////////////////////



///////////////////// SETUP GRAPHICS ///////////////////////////

Graphic = CheckGwm();

  if (!Graphic) {
    Xgm = spawnGwm("BikeTask")
  }

// create window and scale

  vp = cWi("title","vp","resize",0.1,0.01,0.9,0.95,0)

  sWi(vp,"scales",-200,-200,200,200,0, @drawoff,@pixmapon,@save,@bhue,WHITE_); // but we dont draw to a window!

  sWi(vp,"clip",0.01,0.1,0.95,0.99);

  vptxt= cWo(vp,@TEXT,@resize_fr,0.55,0.01,0.95,0.1,@name,"TXT",@color,WHITE_,@save,@drawon,@pixmapoff);

  tdwo= cWo(vp,@BV,@resize_fr,0.01,0.01,0.14,0.1,@name,"TaskDistance",@color,WHITE_,@style,"SVB");

  sawo= cWo(vp,@BV,@resize_fr,0.15,0.01,0.54,0.1,"name","SafetyAlt",@color,WHITE_,@style,"SVB");

  vvwo= cWo(vp,@GRAPH,@resize_fr,0.2,0.11,0.95,0.25,@name,"MAP",@color,WHITE_);

  sWo(vvwo, @scales, 0, 0, 86400, 6000, @save, @redraw, @drawon, @pixmapon);

  mapwo= cWo(vp,@GRAPH,@resize_fr,0.2,0.26,0.95,0.95,@name,"MAP",@color,WHITE_);

<<"%V $mapwo \n"

  sWo(mapwo, @scales, LongW, LatS, LongE, LatN, @save, @redraw, @drawon, @pixmapon);



   c= "EXIT"

   sWi(vp,@redraw); // need a redraw proc for app


# main
setdebug(0);

int wwo = 0;
int witp = 0;
int drawit = 0;
msgv = "";

float d_ll = 0.05;



float mrx;
float mry;
str wcltpt="XY";

include  "gevent";

  while (1) {

    drawit = 1

    waitForMsg()

    

        if (drawit) {
	
        sWo(mapwo, @scales, LongW, LatS, LongE, LatN )
        sWo(mapwo,@clearpixmap,@clipborder);

        DrawMap(mapwo);
	if (Ntpts > 0) {
        sWo(vvwo, @scales, 0, 0, Ntpts, 6000 )
        DrawGline(igc_tgl);
	sWo(vvwo,@clearpixmap,@clipborder);
	DrawGline(igc_vgl);
        sWo(mapwo,@showpixmap);
        sWo(vvwo,@showpixmap);
	}
        }

}
///

//////////////////////////// TBD ///////////////////////////////////////////
/{/*


 BUGS:  
        not showing all WOS -- title button



/}*/








