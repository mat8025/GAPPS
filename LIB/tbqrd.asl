//%*********************************************** 
//*  @script tbqrd.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.3 Li Lithium                                                  
//*  @date Tue Feb 25 10:26:59 2020 
//*  @cdate Fri Jan 11 08:46:34 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
///

// TBF has to be a 'starter' line before any decs in include file?
// keep for TBQRD 2
#ifndef TBQRD
#define TBQRD 2

//<<"including tbqrd.asl TBQRD $(TBQRD)\n"

// assume just main window use

// glargs has to main scope 
#if CPP
#include "gline.h"
#include "glargs.h"
#include "woargs.h"
#endif


//extern Str Hdr_vers;
// need to be global
int TBqrd_tv = 0;
int TBqrd_msg = 0;


// tmp use these for woarrays
int woi;
int woj;

//<<[_DB]"FIRST %V $tbqrd_tv \n"

float rsz[5] = {0.97,0,0.99,1};

void  titleButtonsQRD(int v)
{
 //printf("USING COMPILE version !\n");
//////////////////////////////// TITLE BUTTON QUIT RESIZE REDRAW ////////////////////////////////////////////////
 int tq=cWo(v,TBS_);



 sWo(_woid,tq,_wname,"tbq",_wvalue,"QUIT",_wfunc,"window_term",_wresize,wbox(rsz),_wsymbol,X_);
 
int  tr=cWo(v,TBS_);
rsz[0] = 0.94;
rsz[2] = 0.96;
 sWo(_woid,tr,_wname,"tbr",_wvalue,"RESIZE",_wfunc,"window_resize",_wresize,wbox(rsz),_wsymbol,CROSS_);
 
 int td=cWo(v,TBS_);
 rsz[0] = 0.91;
 rsz[2] = 0.93;
 
sWo(_woid,td, _wname,"tbd",_wvalue,"REDRAW",_wfunc,"window_redraw",_wresize,wbox(rsz),_wsymbol,DIAMOND_);

//  TBqrd_tv = cWo(v,TBV_);
//rsz[0] = 0.2;
//rsz[2] = 0.3;
//sWo(_WOID,TBqrd_tv,_WNAME,"tbv",_WVALUE,"VERS",_WSTYLE,SVO_,_WRESIZE,rsz);

//<<[_DB]"SET %V $tbqrd_tv \n"
//int qrd[] = {tr,tq,td};
  //TBqrd_msg = cWo(v,TBV_);


rsz[0] = 0.42;
rsz[2] = 0.90;

//sWo(_WOID,TBqrd_msg,_WNAME,"tbm",_WVALUE,"MSG",_WSTYLE,SVO_,_WRESIZE,wbox(0.12,0,0.8,1.0,0),_WREDRAW,ON_);

int qrd[3];

qrd[0]= tq;
qrd[1]= tr;
qrd[2]= td;

//<<"%V $tr $tq $td\n"
//<<[_DB]"%V $qrd $(caz(qrd)) $(typeof(qrd))\n"
float clip[5] = {0,0,1,1};
int i;
// need cpp version to process array without for loop 03/14/22

 sWo(_WOID,tq,_WDRAW,ON_,_WPIXMAP,ON_,_WFONTHUE,RED_,_WCOLOR,WHITE_,_WSYMSIZE,45, _WCLIP,wbox(clip),_WREDRAW,ON_);

sWo(_WOID,tr,_WDRAW,ON_,_WPIXMAP,ON_,_WFONTHUE,RED_,_WCOLOR,WHITE_,_WSYMSIZE,45, _WCLIP,wbox(clip),_WREDRAW,ON_);

sWo(_WOID,td,_WDRAW,ON_,_WPIXMAP,ON_,_WFONTHUE,RED_,_WCOLOR,WHITE_,_WSYMSIZE,45, _WCLIP,wbox(clip),_WREDRAW,ON_);


//  printf("%d _tbqrd_tv\n", TBqrd_tv);
// sWo(tbqrd_tv,_redraw);
// sWo(tbqrd_msg,_redraw);
 
}
//============================//
//void titleComment(Str& msg)
void titleComment(Str msg)
{
 // msg.pinfo()
//<<"titlecomment %V $msg \n"
 //sWo(_WOID,TBqrd_tv,_WVALUE,msg.cptr(),_WCLEAR,ON_,_WCLEARCLIP,ON_,_WREDRAW,ON_);
 sWo(_WOID,TBqrd_tv,_WVALUE,msg,_WCLEAR,ON_,_WCLEARCLIP,ON_,_WREDRAW,ON_);

}
//============================//
//void titleVers(Str &vers)
void titleVers(Str vers)
{
// Str tit = "$_ele_vers $_ele";
//Str tit = scriptVers();
// Str tit = "xyz";
 //<<"script vers $tit\n"

   titleComment(vers);

}



//============================//
void titleMessage(int wid, Str msg)
{

// for which window ??
// <<"titleMessage   $msg\n"


  sWi(_WOID,wid,_WMSG,"$msg");

  sWo(_WOID,grwo,_WMSG,"$msg");
  

}

void titleMsg(int wid,Str msg)
{
  //<<"titleMsg $_tbqrd_msg  $msg\n"
// sWo(_WOID,tbqrd_msg,_WVALUE,msg.cptr(),_WCLEAR,ON_,_WREDRAW,ON_);
 // woSetValue(TBqrd_msg, msg);
  
  //sWo(_WOID,tbqrd_msg,_WVALUE,msg,_WCLEAR,ON_,_WREDRAW,ON_);
  sWi(_WOID,wid,_WMSG,"$msg");

}




#endif


//<<[_DB]"EXIT %V $tbqrd_tv \n"
//<<[_DB]" %V $_include \n"

