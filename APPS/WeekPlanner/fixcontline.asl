
setdebug(1)

<<" hi there !\n"


<<" hi \
there \
matey I did not think\
 this works !\n"


<<"hi \
there \
matey I did not think\
 this works !\n"

<<"Hour,0,0:30,1,1:30,2,2:30,3,3:30,4,4:30,\
5,5:30,6,6:30,7,7:30,8:0,8:30,\
9,9:30,10,10:30,11,11:30,12,12:30,\
13,13:30,14,14:30,15,15:30,16,16:30,\
17,17:30,18,18:30,19,19:30,20,20:30,\
21,21:30,22,22:30,23,23:30, Score\
\n"



 aw = cWi(@title,"DailyTracker",@resize,0.1,0.02,0.98,0.99)

    sWi(aw,@pixmapon,@drawoff,@save,@bhue,LILAC_)

    sWi(aw,@clip,0.1,0.1,0.9,0.95)


 awo=cWo(aw,"SHEET",@name,"sheet_name",@color,GREEN_,@resize,0.1,0.01,0.98,0.99)
 // does value remain or reset by menu?
 
 rows = 50;
 cols = 8;
 sWo(awo,@setrowscols,rows,cols);
  sWo(awo,@sheetrow,0,1,"Mo,Tu,We,Th,Fr,Sa,Su");

sWo(awo,@sheetcol,0,0,"Hour,0,0:30,1,1:30,2,2:30,3,3:30,4,4:30,\
5,5:30,6,6:30,7,7:30,8:0,8:30,\
9,9:30,10,10:30,11,11:30,12,12:30,\
13,13:30,14,14:30,15,15:30,16,16:30,\
17,17:30,18,18:30,19,19:30,20,20:30,\
21,21:30,22,22:30,23,23:30, Score")

 sWi(aw,@redraw);

 sWo(awo,@redraw);

 wkeep(aw)

sipause(2)

exit()