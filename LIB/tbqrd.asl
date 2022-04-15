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
// keep following

#define TBQRD 2

<<"including tbqrd.asl TBQRD $(TBQRD)\n"

// assume just main window use

int tbqrd_tv = 0;
int tbqrd_msg = 0;

//<<[_DB]"FIRST %V $tbqrd_tv \n"


void  titleButtonsQRD(int v)
{

//////////////////////////////// TITLE BUTTON QUIT RESIZE REDRAW ////////////////////////////////////////////////
 tq=cWo(v,WO_TB_,_name,"tbq",_value,"QUIT",_func,"window_term",_resize,0.97,0,0.99,1,_symbol,X_,_flush);
 
 tr=cWo(v,WO_TB_,_name,"tbr",_value,"RESIZE",_func,"window_resize",_resize,0.94,0,0.96,1,_symbol,CROSS_,_flush);
 
 td=cWo(v,WO_TB_,_name,"tbd",_value,"REDRAW",_func,"window_redraw",_resize,0.91,0,0.93,1,_symbol,DIAMOND_,_flush);

 tbqrd_tv = cWo(v,_TBV,_name,"tbv",_value,"VERS",_style,SVO_,_resize,0.2,0,0.50,1,_flush);
<<[_DB]"SET %V $tbqrd_tv \n"
//int qrd[] = {tr,tq,td};
 tbqrd_msg = cWo(v,_TBV,_name,"tbm",_value,"MSG",_style,SVO_,_resize,0.52,0,0.90,1,_flush);
int qrd[3]

qrd[0]= tq;
qrd[1]= tr;
qrd[2]= td;

<<[_DB]"%V $tr $tq $td\n"
<<[_DB]"%V $qrd $(caz(qrd)) $(typeof(qrd))\n"
 sWo(qrd,_drawon,_pixmapon,_fonthue,RED_,_color,WHITE_,_symsize,45, _clip,0,0,1,1,_flush);
// sWo(tbqrd_tv,_redraw);
// sWo(tbqrd_msg,_redraw);
 
}
//============================//
void titleComment(str msg)
{
 <<"%V $msg \n"
 sWo(tbqrd_tv,_value,"$msg",_clear,_redraw);

}
//============================//
void titleVers()
{
// str tit = "$_ele_vers $_ele";
 str tit = scriptVers();
 <<"script vers $tit\n"
 titleComment(tit);
}


//============================//
void titleMessage(str msg)
{
 //<<"%V $msg \n"
 sWo(tbqrd_msg,_value,"$msg",_clear,_redraw);
}

void titleMsg(str msg)
{
 //<<"%V $msg \n"
 sWo(tbqrd_msg,_value,"$msg",_clear,_redraw);
}




//<<[_DB]"EXIT %V $tbqrd_tv \n"
//<<[_DB]" %V $_include \n"

