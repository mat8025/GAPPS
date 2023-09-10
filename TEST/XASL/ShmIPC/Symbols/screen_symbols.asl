
int rwo =0
int gwo = -1
int msgwo = -1
 int vp = -1
void setScreen()
   {
    int i;

   vp = cWi("SYMBOLS")

   sWi(_WOID,vp,_WPIXMAP,ON_,_WDRAW,ON_,_WSAVE,ON_,_WBHUE,WHITE_,_WRESIZE,wbox(0.35,0.1,0.9,0.80))


   
    msgwo=cWo(vp,WO_TEXT_)


    sWo(_WOID, msgwo ,_WNAME,"COOR",_WVALUE,"0.0 0.0",_WCOLOR,TEAL_,_WRESIZE,wbox(0.15,0.81,0.9,0.99))

    sWo(_WOID,msgwo,_WBORDER,BLACK_,_WDRAW,ON_,_WFONTHUE,RED_, _WREDRAW,ON_,_WSAVE,ON_)


    rwo=cWo(vp,WO_SYM_)

    sWo(_WOID,rwo,_WRESIZE,wbox(0.1,0.1,0.3,0.3),_WNAME,"RED",_WVALUE,1.0,_WCLIP,wbox(0.01,0.01,0.99,0.99))

    sWo(_WOID,rwo,_WSYMBOL,DIAMOND_)

    sWo(_WOID,rwo,_WDRAW,OFF_,_WPIXMAP,ON_,_WSAVE,ON_,_WSAVEPIXMAP,ON_)


    gwo=cWo(vp,WO_SYM_)

     sWo(_WOID,gwo,_WRESIZE,wbox(0.5,0.1,0.9,0.6),_WNAME,"green",_WVALUE,1.0)

    sWo(_WOID,gwo,_WSYMBOL,CROSS_)

    sWo(_WOID,gwo,_WDRAW,OFF_,_WPIXMAP,ON_,_WSAVE,ON_,_WSAVEPIXMAP,ON_)

   titleButtonsQRD(vp);
   titleVers(myvers);

  }

//   sym_size = 7;
//   symbol_name = "diamond"
