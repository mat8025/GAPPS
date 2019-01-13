//%*********************************************** 
//*  @script tbqrd.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Fri Jan 11 08:46:34 2019 
//*  @cdate Fri Jan 11 08:46:34 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
///

int tbqrd_tv = 0;

<<[_DB]"FIRST %V $tbqrd_tv \n"

proc  titleButtonsQRD(v)
{

//////////////////////////////// TITLE BUTTON QUIT RESIZE REDRAW ////////////////////////////////////////////////
 tq=cWo(v,@TBS,@name,"tbq",@value,"QUIT",@func,"window_term",@resize,0.97,0,0.99,1,@symbol,X_);
 
 tr=cWo(v,@TBS,@name,"tbr",@value,"RESIZE",@func,"window_resize",@resize,0.94,0,0.96,1,@symbol,PLUS_);
 
 td=cWo(v,@TBS,@name,"tbd",@value,"REDRAW",@func,"window_redraw",@resize,0.91,0,0.93,1,@symbol,DIAMOND_);

 tbqrd_tv = cWo(v,"TBV",@name,"tbv",@value,"VERS",@style,SVO_,@resize,0.20,0,0.30,1);
<<"SET %V $tbqrd_tv \n"
//int qrd[] = {tr,tq,td};

int qrd[3]

qrd[0]= tq;
qrd[1]= tr;
qrd[2]= td;

<<[_DB]"%V $tr $tq $td\n"
<<[_DB]"%V $qrd $(caz(qrd)) $(typeof(qrd))\n"
 sWo(qrd,@drawon,@pixmapon,@fonthue,RED_,@color,WHITE_,@symsize,45, @clip,0,0,1,1,@redraw);
 sWo(tbqrd_tv,@redraw);
 
}

proc titleComment( msg)
{
 <<"%V $msg \n"
 sWo(tbqrd_tv,@value,"$msg",@clear,@redraw);

}

proc titleVers()
{
 titleComment("$_ele_vers $_ele");
}

<<[_DB]"EXIT %V $tbqrd_tv \n"
<<[_DB]" %V $_include \n"

