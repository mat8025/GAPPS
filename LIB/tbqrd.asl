///
///
///

proc  titleButtonsQRD(v)
{

//////////////////////////////// TITLE BUTTON QUIT RESIZE REDRAW ////////////////////////////////////////////////
 tq=cWo(v,@TB,@name,"tbq",@value,"QUIT",@func,"window_term",@resize,0.97,0,0.99,1,@symbol,X_);
 
 tr=cWo(v,@TB,@name,"tbr",@value,"RESIZE",@func,"window_resize",@resize,0.94,0,0.96,1,@symbol,PLUS_);
 
 td=cWo(v,@TB,@name,"tbd",@value,"REDRAW",@func,"window_redraw",@resize,0.91,0,0.93,1,@symbol,DIAMOND_);


//int qrd[] = {tr,tq,td};

int qrd[3]

qrd[0]= tq;
qrd[1]= tr;
qrd[2]= td;

<<[_DB]"%V $tr $tq $td\n"
<<[_DB]"%V $qrd $(caz(qrd)) $(typeof(qrd))\n"
 sWo(qrd,@drawon,@pixmapon,@fonthue,RED_,@color,WHITE_,@symsize,45, @clip,0,0,1,1,@redraw);

}

<<[_DB]" %V $_include \n"