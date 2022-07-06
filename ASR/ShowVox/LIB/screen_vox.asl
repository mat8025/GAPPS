/* 
 *  @script screen_vox.asl                                              
 * 
 *  @comment procs for vox screen setup                                 
 *  @release Beryllium                                                  
 *  @vers 1.2 He Helium [asl 6.4.41 C-Be-Nb]                            
 *  @date 07/05/2022 16:36:05                                           
 *  @cdate Mon Feb 24 09:56:39 2020                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  

///
/// upe_ws
///


/// Window/Wo and button setup

//=======================================================


//////////////////////// WINDOW SETUP ////////////////////////////////////////////
#include "tbqrd.asl"

float wx = 0.05;
float wX = 0.98;

  int upewins[10];
  int nupewins = 0;
# pitch window

 int pw = cWi("RMS_ZX_Pitch");
 sWi(pw,_WRESIZE,wbox(wx,0.84,wX,0.99));
 


 int fewo = cWo(pw, WO_GRAPH_);
 sWo(_WOID,fewo,_WRESIZE,wbox(0.05,0.2,0.95,0.9));
 
  sWo(_WOID,fewo,_WNAME,"FE",_WCLIP,wbox(0.01,0.15,0.99,0.99), _WPIXMAP,ON_);
  sWo(_WOID,fewo,_WDRAW,ON_,_WSAVE,ON_,_WBORDER,BLACK_, _WCLIPBORDER,GREEN_,_WPENHUE,BLUE_);
  sWo(_WOID,fewo,_WSCALES,rbox(0,-0,10,100));
  sWo(_WOID,fewo,_WHELP," pitch, zx, rms ");
sWi(pw,_WTITLE,"Pitchsignal");

 upewins[nupewins++] = pw;


  titleButtonsQRD(pw);

# spectrogram window

  int spw = cWi("Sgraph")
  sWi(_WOID,spw,_WRESIZE,wbox(wx,0.63,wX,0.83));
  
  int sgwo =cWo(spw,WO_GRAPH_);

  sWo(_WOID,sgwo,_WRESIZE,wbox(0.05,0.2,0.95,0.9));
  
  sWo(_WOID,sgwo,_WPENHUE,GREEN_,_WNAME,"SG",_WPIXMAP,ON_,_WDRAW,ON_,_WSAVE,ON_);
  sWo(_WOID,sgwo,_WCLIP,wbox(0.01,0.01,0.99,0.99), _WBORDER,ON, _WCLIPBORDER,RED_);
  sWo(_WOID,sgwo,_WSCALES,rbox(0,0,100,120));
  sWo(_WOID,sgwo,_WHELP," spectrograph ");

sWi(spw,_WTITLE,"Spectograph");

  upewins[nupewins++] = spw;

# time-amp window

  int tw = cWi("Tran");
  
  sWi(_WOID,tw,_WRESIZE,wx,0.25,wX,0.62)_WBHUE,"skyblue");

  int two =cWo(tw,WO_GRAPH_);
  sWo(_WOID,two,_WRESIZE,wbox(0.05,0.2,0.95,0.9));
  
  sWo(_WOID,two,_WNAME,"TA",_WCLIP,wbox(0.01,0.15,0.99,0.99), _WPIXMAP,ON_);
  sWo(_WOID,two,_WDRAW,ON_,_WSAVE,ON_,_WBORDER, BLACK_,_WCLIPBORDER,GREEN_,_WPENHUE,BLUE_)
  sWo(_WOID,two,_WSCALES,rbox(0,-20000,10,20000));

sWi(tw,_WTITLE,"Vox");

 upewins[nupewins++] = tw;

//ans=query("?", "ta screen");

# label window

  int lw = cWi("Label");
  sWi(lw,_WRESIZE,wbox(wx,0.01,wX,0.20));
  
  int lwo =cWo(lw,WO_GRAPH_);
  
  sWo(_WOID,lwo,_WRESIZE,wbox(0.05,0.2,0.95,0.9));
  
  sWo(_WOID,lwo,_WNAME,"LABEL",_WCLIP,wbox(0.01,0.15,0.99,0.99), _WPIXMAP,ON_);
  sWo(_WOID,lwo,_WDRAW,ON_,_WSAVE,ON_,_WBORDER,BLACK_, _WCLIPBORDER,GREEN_,_WPENHUE,BLUE_);
  sWo(_WOID,lwo,_WSCALES,rbox(0,0,20,1));

  upewins[nupewins++] = lw;
sWi(lw,_WTITLE,"Transcription");


////////////////////////// WINDOW OBJECTS ////////////////////////////////////////////

  //su_buttons(tw);


 nwo = 0;


float y0 = .025;
float y1 = .125;
float wox0 = .04;
float wox1 = .6

// buttons under time window graph
int playwo =cWo(tw,WO_BN_);

sWo(playwo,_WNAME,"PLAY",_WVALUE,ON_,_WCOLOR,GREEN_,_WHELP, "play selection");

int selwo =cWo(tw,WO_BN_);
   sWo(_WOID,selwo,_WNAME,"SEL",_WVALUE,ON_,_WCOLOR,GREEN_,_WHELP, "make selection");
   

int forwwo =cWo(tw,WO_BN_);

 sWo(_WOID,forwwo,_WNAME,"FORW",_WVALUE,ON_,_WCOLOR,GREEN_,_WHELP, "scroll forward");

int revwo =cWo(tw,WO_BN_);
 sWo(_WOID,revwo,_WNAME,"REV",_WVALUE,ON_,_WCOLOR,GREEN_,_WHELP, "scroll back");

int ptokwo =cWo(tw,WO_BN_);
 sWo(_WOID,ptokwo,_WNAME,"P_TOK",_WVALUE,ON_,_WCOLOR,BLUE_,_WHELP, "play token");

int pwordwo =cWo(tw,WO_BN_);

 sWo(_WOID,pwordwo,_WNAME,"P_WORD",_WVALUE,ON_,_WCOLOR,BLUE_,_WHELP, "play word");

int addwo =cWo(tw,WO_BN_);
  sWo(_WOID,addwo,_WNAME,"ADD",_WVALUE,ON_,_WCOLOR,BLUE_,_WHELP, "add token");

int renamewo =cWo(tw,WO_BN_);
  sWo(_WOID,renamewo,_WNAME,"RENAM",_WVALUE,ON_,_WCOLOR,WHITE_,_WHELP, "rename");

int delwo =cWo(tw,WO_BN_);
  sWo(_WOID,delwo,_WNAME,"DEL",_WVALUE,ON_,_WCOLOR,RED_,_WHELP, "delete token");

int newwo =cWo(tw,WO_BN_);

  sWo(_WOID,newwo,_WNAME,"NEWF",_WVALUE,ON_,_WCOLOR,RED_,_WHELP, "work on new file");

int exitwo =cWo(tw,WO_BN_);

 sWo(_WOID,exitwo,_WNAME,"EXIT",_WVALUE,ON_,_WCOLOR,RED_,_WHELP, "exit");


 int buttonwos[] = { playwo, selwo, forwwo, revwo, ptokwo , pwordwo, addwo, renamewo, delwo, newwo, exitwo ,-1  } ;


  wohtile(buttonwos, wox0, y0,wox1 , y1);

  setGwindow(upewins,_WREDRAW);

  sWi(tw,_WTITLE,"Timesignal");




  woi = 0;
  while (1) {
   if (woi>0)
    sWo(_WOID,buttonwos[woi],_WBORDER,BLACK_,_WREDRAW,_ON);
   else
    break;
    woi++;
  }
  
 // titleVers();
  titleComment("ShowVox $hdr_vers")

ans=query("?", "screen setup",__LINE__);


////////////////////////////////// GLINES for FEATURE TRACKS ///////////////////////////////////////
Vec<float>ZxTrk(1000);
Vec<float> PtTrk(1000);
Vec<float> RmsTrk(500);

// RMS
int rmsgl = cGl(fewo);

 sGl(_GLID,rmsgl,_GLTY,RmsTrk,_GLHUE,RED_,_GLNAME,"RMS");

 sGl(_GLID,rmsgl,_GLSCALES,rbox(0,0,200,30), _GLSYMBOL,DIAMOND_,_GLSAVESCALES,0,_GLUSESCALES,0);


// ZX
 int zxgl = cGl(fewo);
 sGl(_GLID,zxgl, _GLTY,ZxTrk,_GLHUE,GREEN_,_GLNAME,"ZX");
 sGl(_GLID,zxgl,_GLSCALES,rbox(0,0,200,1.0), _GLSYMBOL,DIAMOND_,_GLSAVESCALES,0,_GLUSESCALES,0);
// PT
 int ptgl = cGl(fewo);

 sGl(_GLID,ptgl,_GLTY,PtTrk,_GLNAME,"PT",_GLSCALES,rbox(0,0,200,500), _GLSYMBOL,DIAMOND_,_GLSAVESCALES,0,_GLUSESCALES,0);


ans=query("?", "gline setup",__LINE__);

//////////////////////////////////////////////////////////////////////////////////////////////////