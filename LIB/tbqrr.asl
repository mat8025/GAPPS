

proc  setupTitleButtonsQRR( ww)
{

//////////////////////////////// TITLE BUTTON QUIT ////////////////////////////////////////////////
 tbqwo=cWo(vp,@TB,@name,"tb_q",@color,WHITE_,@value,"QUIT",@func,"window_term",@resize,0.97,0,0.99,1);
 sWo(tbqwo,@drawon,@pixmapon,@fonthue,RED_, @symbol,X_, @symsize,45,   @clip,0,0,1,1,@redraw);

 tbrszwo=cWo(vp,@TB,@name,"tb_2",@color,WHITE_,@VALUE,"RESIZE",@func,"window_resize",@resize,0.94,0,0.96,1)
 sWo(tbrszwo,@DRAWON,@PIXMAPON,@FONTHUE,RED_, @symbol,PLUS_,  @symsize, 45, \
 @clip,0,0,1,1,@redraw)


 tbrdrwo=cWo(vp,@TB,@name,"tb_3",@color,WHITE_,@VALUE,"REDRAW",@func,"window_redraw",@resize,0.92,0,0.938,1)
 sWo(tbrdrwo,@DRAWON,@PIXMAPON,@FONTHUE,RED_, @symbol,DIAMOND_,  @symsize, 45, \
 @clip,0,0,1,1,@redraw)
}
