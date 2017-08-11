//////// pt.asl ////////////////////

setdebug(0)

Graphic = CheckGwm()

<<" %v $Graphic \n"
spawn_it = 1
 if (Graphic) {
   spawn_it = 0;
 }

<<" %v $spawn_it \n"

     if (spawn_it) {
       X=spawngwm()
       spawn_it  = 0;
     }

    vp = cWi(@title,"Periodic_Table_Of_Elements",@resize,0.01,0.2,0.95,0.9,0)

    sWi(vp,@pixmapon,@drawon,@save,@bhue,WHITE_)
    setgwob(vp,@grid,11,20)
    sWi(vp,@clip,0.2,0.2,0.8,0.8)

//////// Wob //////////////////

 bx = 0.1
 bX = 0.3
 yht = 0.2
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 proc eleSpec(i) 
 {
 elespec = Pt(i)
 elef = split(elespec,",")
 ewo[i]=cWo(vp,"BV",@name,"$elef[1]  $elef[2]",@color,ecolor[i],@resize,col,rb,col+1,rt,3)

  setgwob(ewo[i],@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@VALUE,"$elef[0]\n $elef[3]",@STYLE,"SVB")
 if (show) {
  setgwob(ewo[i],@redraw)
 }
 else {
 setgwob(ewo[i],@clear)
 }
 sWo(ewo[i],@help,"$elespec")
 col++;
 }


 proc peleSpec(si,fi) 
 {
 for (i = si ; i <=fi; i++) {
 elespec = Pt(i)
 elef = split(elespec,",")
 ewo[i]=cWo(vp,"BV",@name,"$elef[1]  $elef[2]",@color,ecolor[i],@resize,col,rb,col+1,rt,3)
 setgwob(ewo[i],@BORDER,@DRAWON,@CLIPBORDER,@FONTHUE,BLACK_,@VALUE,"$elef[0]\n $elef[3]",@STYLE,"SVB")
 if (show) {
    setgwob(ewo[i],@redraw)
 }
 else {
    setgwob(ewo[i],@clear)
 }
 sWo(ewo[i],@help,"$elespec")
 col++;
 }
 }





 int ewo[120]
 int ecolor[120]

 ecolor = YELLOW_;

 ecolor[5,14,32,33,51,52,84,85] = GREEN_;
 ecolor[1,2] = LILAC_;
 ecolor[6:10] = LILAC_;
 ecolor[15:18] = LILAC_;
 ecolor[34:36] = LILAC_;

 ecolor[53:54] = LILAC_;
 ecolor[36,53,54,86] = LILAC_;


 int col =1;

 rb = 9.0;
 rt = rb+1;



 
 show = atoi(_clarg[1])

 
 // Hydrogen
 eleSpec(1) 


 // Helium
 col = 18
 eleSpec(2) 


 // lithium
 // period 2
 rb = 8;
 rt = rb+1;
 col =1;

      peleSpec(3,4) 





// ecolor = LILAC
 col = 13;


    peleSpec(5,10) 
 


///////////////////////
// PERIOD 3
 rb = 7;
 rt = rb+1;
 col = 1
 // Sodium



 for (i = 11; i <= 12; i++) {
      eleSpec(i) 
 }


 
 col = 13;

 peleSpec(13,18) 




// PERIOD 4
 rb--;  rt = rb+1;  col = 1;

 
   peleSpec(19,36) 
 



// PERIOD 5
 rb--;
 rt = rb+1;
 col =1;

 for (i = 37; i <= 54; i++) {
      eleSpec(i);
 }


// PERIOD 6
 rb--;
 rt = rb+1;
 col =1;
 for (i = 55; i <= 56; i++) {
       eleSpec(i);
 }

 col =4;
 for (i = 72; i <= 86; i++) {
       eleSpec(i);
 }



// PERIOD 7
 rb--;
 rt = rb+1;
 col =1;
 for (i = 87; i <= 88; i++) {
     eleSpec(i);
 }


 col =4;
 for (i = 104; i <= 112; i++) {
   eleSpec(i);
 }


 rb -=1.1;
 rt = rb+1;
 col =3;
 for (i = 57; i <= 71; i++) {
     eleSpec(i);
 }

 rb--;
 rt = rb+1;
 col =3;
 for (i = 89; i <= 103; i++) {
    eleSpec(i);
 }


////////////////////   EVENT PROCESSING ////////////////////////////

CLASS Event
{

 public:

   Svar emsg ;
   Svar kws ;
   Str keyw ;
   Str woname ;

   char keyc ;

   int minfo[];
   float rinfo[];
   float wms[];


   int woid
   int button
   int wo_ival

 #  method list


   CMF getMsg()
   {
     emsg = ""
     keyc = 0
     emsg= MessageWait(minfo,rinfo)

//<<"reading msg \n"

       // emsg= MessageRead(minfo,rinfo)

    <<"<|$emsg|> \n"

     keyw = "NO_MSG"

     if ( !(emsg[0] @= "NO_MSG")) { 


//<<"%V$minfo \n"
//<<"%V$rinfo \n"
//<<"%V$emsg \n"

      kws = Split(emsg)

//<<"%V$kws \n"

      keyw = kws[0]
      woname = kws[1]

//<<"%V$keyw\n"

      keyc = pickc(kws[2],0)

//      wms=GetMouseState()

//<<"%V$wms\n"

      woid = minfo[3]

      button = minfo[8]

      wo_ival = minfo[13]
//      button = wms[2]
    }
     // sleep(0.1)
   }   
}

Event E



xp = 0.1
yp = 0.5

   while (1) {


    E->getMsg()


     

  if (scmp(E->woname,"QUIT",4)) {
       break
  }

  }

 exit_gs()

;