//%*********************************************** 
//*  @script vox_ws.asl 
//* 
//*  @comment procs for vox screen setup  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                    
//*  @date Mon Feb 24 09:56:39 2020 
//*  @cdate Mon Feb 24 09:56:39 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
///
/// upe_ws
///


/// Window/Wo and button setup

//=======================================================


//////////////////////// WINDOW SETUP ////////////////////////////////////////////

wx = 0.05
wX = 0.98

  int upewins[];
  int nupewins = 0;
# pitch window

 pw = cWi(@title,"RMS_ZX_Pitch",@resize,wx,0.84,wX,0.99)

 fewo =cWo(pw,"GRAPH",@resize,0.05,0.2,0.95,0.9)
  sWo(fewo,@name,"FE",@clip,0.01,0.15,0.99,0.99, @pixmapon);
  sWo(fewo,@drawon,@save,@border, @clipborder,GREEN_,@penhue,BLUE_)
  sWo(fewo,@scales,0,-0,10,100);
  sWo(fewo,@help," pitch, zx, rms ");
 upewins[nupewins++] = pw;


titleButtonsQRD(pw)

# spectrogram window

  spw = cWi(@title,"Sgraph",@resize,wx,0.63,wX,0.83);
  sgwo =cWo(spw,"GRAPH",@resize,0.05,0.2,0.95,0.9);
  sWo(sgwo,@penhue,"green",@name,"SG",@pixmapon,@drawon,@save);
  sWo(sgwo,@clip,0.01,0.01,0.99,0.99, @border, @clipborder,"red");
  sWo(sgwo,@scales,0,0,100,120);
  sWo(sgwo,@help," spectrograph ");



upewins[nupewins++] = spw;

# time-amp window
  tw = cWi(@title,"Tran",@resize,wx,0.25,wX,0.62)
  sWi(tw,@bhue,"skyblue")

  two =cWo(tw,"GRAPH",@resize,0.05,0.2,0.95,0.9)
  sWo(two,@name,"TA",@clip,0.01,0.15,0.99,0.99, @pixmapon);
  sWo(two,@drawon,@save,@border, @clipborder,GREEN_,@penhue,BLUE_)
  sWo(two,@scales,0,-20000,10,20000)

 upewins[nupewins++] = tw;


# label window
  lw = cWi(@title,"Label",@resize,wx,0.01,wX,0.20)
  lwo =cWo(lw,"GRAPH",@resize,0.05,0.2,0.95,0.9)
  sWo(lwo,@name,"LABEL",@clip,0.01,0.15,0.99,0.99, @pixmapon);
  sWo(lwo,@drawon,@save,@border, @clipborder,GREEN_,@penhue,BLUE_)
  sWo(lwo,@scales,0,0,20,1);

  upewins[nupewins++] = lw;



////////////////////////// WINDOW OBJECTS ////////////////////////////////////////////

  //su_buttons(tw);


 nwo = 0;


y0 = .025
y1 = .125
wox0 = .04
wox1 = .6

// buttons under time window graph
playwo =cWo(tw,"BN",@name,"PLAY",@value,ON_,@color,GREEN_,@help, "play selection")

selwo =cWo(tw,"BN",@name,"SEL",@value,ON_,@color,GREEN_,@help, "make selection")

forwwo =cWo(tw,"BN",@name,"FORW",@value,ON_,@color,GREEN_,@help, "scroll forward")

revwo =cWo(tw,"BN",@name,"REV",@value,ON_,@color,GREEN_,@help, "scroll back")

ptokwo =cWo(tw,"BN",@name,"P_TOK",@value,ON_,@color,BLUE_,@help, "play token")

pwordwo =cWo(tw,"BN",@name,"P_WORD",@value,ON_,@color,BLUE_,@help, "play word")

addwo =cWo(tw,"BN",@name,"ADD",@value,ON_,@color,BLUE_,@help, "add token")

renamewo =cWo(tw,"BN",@name,"RENAM",@value,ON_,@color,WHITE_,@help, "rename")

delwo =cWo(tw,"BN",@name,"DEL",@value,ON_,@color,RED_,@help, "delete token")

newwo =cWo(tw,"BN",@name,"NEWF",@value,ON_,@color,RED_,@help, "work on new file")

exitwo =cWo(tw,"BN",@name,"EXIT",@value,ON_,@color,RED_,@help, "exit")


 int buttonwos[] = { playwo, selwo, forwwo, revwo, ptokwo , pwordwo, addwo, renamewo, delwo, newwo, exitwo   } 


  wohtile(buttonwos, wox0, y0,wox1 , y1);

  setGwindow(upewins,@redraw);

  sWi(tw,@title,"Timesignal");

  sWo(buttonwos,@border,BLACK_,@redraw);

 // titleVers();
  titleComment("ShowVox $vers")

////////////////////////////////// GLINES for FEATURE TRACKS ///////////////////////////////////////
float ZxTrk[];
float RmsTrk[];
float PtTrk[];

// RMS
 rmsgl = cGl(fewo,@TY,RmsTrk,@XO,0,@XI,1,@color,RED_,@name,"RMS")

 sGl(rmsgl,@scales,0,0,200,30,@ltype,1, @symbol,"diamond",@savescales,0,@usescales,0)
// ZX
 zxgl = cGl(fewo,@TY,ZxTrk,@XO,0,@XI,1,@color,GREEN_,"name","ZX")

 sGl(zxgl,@scales,0,0,200,1.0,@ltype,1, @symbol,"diamond",@savescales,1,@usescales,1)

// PT
 ptgl = cGl(fewo,@TY,PtTrk,@XO,0,@XI,1,@color,BLUE_,"name","PT",@usescales,0)

//////////////////////////////////////////////////////////////////////////////////////////////////