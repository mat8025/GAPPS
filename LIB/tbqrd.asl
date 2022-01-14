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
 tq=cWo(v,@TBS,@name,"tbq",@value,"QUIT",@func,"window_term",@resize,0.97,0,0.99,1,@symbol,X_);
 
 tr=cWo(v,@TBS,@name,"tbr",@value,"RESIZE",@func,"window_resize",@resize,0.94,0,0.96,1,@symbol,PLUS_);
 
 td=cWo(v,@TBS,@name,"tbd",@value,"REDRAW",@func,"window_redraw",@resize,0.91,0,0.93,1,@symbol,DIAMOND_);

 tbqrd_tv = cWo(v,@TBV,@name,"tbv",@value,"VERS",@style,SVO_,@resize,0.2,0,0.50,1);
<<[_DB]"SET %V $tbqrd_tv \n"
//int qrd[] = {tr,tq,td};
 tbqrd_msg = cWo(v,@TBV,@name,"tbm",@value,"MSG",@style,SVO_,@resize,0.52,0,0.90,1);
int qrd[3]

qrd[0]= tq;
qrd[1]= tr;
qrd[2]= td;

<<[_DB]"%V $tr $tq $td\n"
<<[_DB]"%V $qrd $(caz(qrd)) $(typeof(qrd))\n"
 sWo(qrd,@drawon,@pixmapon,@fonthue,RED_,@color,WHITE_,@symsize,45, @clip,0,0,1,1);
// sWo(tbqrd_tv,@redraw);
// sWo(tbqrd_msg,@redraw);
 
}
//============================//
void titleComment(str msg)
{
 <<"%V $msg \n"
 sWo(tbqrd_tv,@value,"$msg",@clear,@redraw);

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
proc titleMessage(str msg)
{
 //<<"%V $msg \n"
 sWo(tbqrd_msg,@value,"$msg",@clear,@redraw);
}

proc titleMsg(str msg)
{
 //<<"%V $msg \n"
 sWo(tbqrd_msg,@value,"$msg",@clear,@redraw);
}




//<<[_DB]"EXIT %V $tbqrd_tv \n"
//<<[_DB]" %V $_include \n"

