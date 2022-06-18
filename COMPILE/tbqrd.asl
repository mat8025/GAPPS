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
#include "gline.h"
#include "glargs.h"
#include "woargs.h"

int tbqrd_tv = 0;
int tbqrd_msg = 0;

//<<[_DB]"FIRST %V $tbqrd_tv \n"


void  titleButtonsQRD(int v)
{

//////////////////////////////// TITLE BUTTON QUIT RESIZE REDRAW ////////////////////////////////////////////////
 int tq=cWo(v,TBS_);

float rsz[5] = {0.97,0,0.99,1};

 sWo(tq,_WNAME,"tbq",_WVALUE,"QUIT",_WFUNC,"window_term",_WRESIZE,rsz,_WSYMBOL,X_,_WFLUSH);
 
int  tr=cWo(v,TBS_);
rsz[0] = 0.94;
rsz[2] = 0.96;
 sWo(tr,_WNAME,"tbr",_WVALUE,"RESIZE",_WFUNC,"window_resize",_WRESIZE,rsz,_WSYMBOL,CROSS_,_WFLUSH);
 
 int td=cWo(v,TBS_);
 rsz[0] = 0.91;
 rsz[2] = 0.93;
 
sWo(td, _WNAME,"tbd",_WVALUE,"REDRAW",_WFUNC,"window_redraw",_WRESIZE,rsz,_WSYMBOL,DIAMOND_,_WFLUSH);

int  tbqrd_tv = cWo(v,TBV_);
rsz[0] = 0.2;
rsz[2] = 0.5;
sWo(tbqrd_tv,_WNAME,"tbv",_WVALUE,"VERS",_WSTYLE,WO_SVO,_WRESIZE,rsz,_WFLUSH);

//<<[_DB]"SET %V $tbqrd_tv \n"
//int qrd[] = {tr,tq,td};
int  tbqrd_msg = cWo(v,TBV_);
rsz[0] = 0.52;
rsz[2] = 0.80;
sWo(tbqrd_msg,_WNAME,"tbm",_WVALUE,"MSG",_WSTYLE,WO_SVO,_WRESIZE,rsz,_WREDRAW,_WFLUSH);

int qrd[3];

qrd[0]= tq;
qrd[1]= tr;
qrd[2]= td;

//<<[_DB]"%V $tr $tq $td\n"
//<<[_DB]"%V $qrd $(caz(qrd)) $(typeof(qrd))\n"
float clip[5] = {0,0,1,1};
int i;
// need cpp version to process array without for loop 03/14/22

 sWova(_WOID,tq,_WDRAW,ON_,_WPIXMAP,ON_,_WFONTHUE,RED_,_WCOLOR,WHITE_,_WSYMSIZE,45, _WCLIP,clip,_WREDRAW,ON_);

sWo(qrd,_WDRAWON,_WPIXMAPON,_WFONTHUE,RED_,_WCOLOR,WHITE_,_WSYMSIZE,45, _WCLIP,clip,_WREDRAW,_WFLUSH);

// sWo(tbqrd_tv,_redraw);
// sWo(tbqrd_msg,_redraw);
 
}
//============================//
void titleComment(Str msg)
{
// <<"%V $msg \n"
 sWo(tbqrd_tv,_WVALUE,"$msg",_WCLEAR,_WREDRAW,_WLAST);

}
//============================//
void titleVers()
{
// Str tit = "$_ele_vers $_ele";
 //Str tit = scriptVers();
 Str tit = "xyz";
 
 //<<"script vers $tit\n"
 titleComment(tit);
}


//============================//
void titleMessage(Str msg)
{
 
 sWo(tbqrd_msg,_WVALUE,"$msg",_WCLEAR,_WREDRAW,_WLAST);
}

void titleMsg(Str msg)
{
 
 sWo(tbqrd_msg,_WVALUE,"$msg",_WCLEAR,_WREDRAW,_WLAST);
}

#endif


//<<[_DB]"EXIT %V $tbqrd_tv \n"
//<<[_DB]" %V $_include \n"

