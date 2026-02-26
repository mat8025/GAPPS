
/* 
 *  @script chem_pt.asl                                                 
 * 
 *  @comment show Periodic Table                                        
 *  @release 6.67 : C Ho                                                
 *  @vers 1.2 He Helium [asl 6.67 : C Ho]                               
 *  @date 02/24/2026 14:30:58                                           
 *  @cdate 02/24/2026 14:30:58                                          
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2026 -->                               
 * 
 */ 


  <<" $_clarg[0] $_clarg[1] $_clarg[2] \n" 
 int show
 show = atoi(_clarg[1])

// ans=ask("%V $show ",1)

 show.pinfo()


 Svar argv = _argv;  // allows asl and cpp to refer to clargs
 argc = argc();




#include "debug" 

  if (_dblevel >0) { 
   debugON() 
   <<"$Use_ \n" 
} 

   allowErrors(-1); // set number of errors allowed -1 keep going 

#endif       

// CPP main statement goes after all procs
#if __CPP__
#include <iostream>
#include <ostream>
using namespace std;
#include "vargs.h"
#include "cpp_head.h"
#define PXS  cout<<

#define CPP_DB 0

  int main( int argc, char *argv[] ) {  
    init_cpp(argv[0]) ; 

#endif       


  chkIn(1) ;

  chkT(1);

 

//////// pt.asl ////////////////////



 


sdb(1,"~step")

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

#include "wevent.asl"
#include "tbqrd.asl"

    vp = cWi("Periodic_Table_Of_Elements")

    sWi(_woid,vp,_wresize,wbox(0.01,0.1,0.95,0.95),_wredraw,ON_)

    sWi(_woid,vp,_wpixmap,OFF_,_wdraw,ON_,_wsave,ON_,_wbhue,WHITE_)
    
    sWi(_woid,vp,_wclipborder,PINK_,_wcliphue,RED_,_wclearclip,BLUE_,_wredraw,ON_)

    sWi(_woid,vp,_wsetgrid,12,20)
    

  titleButtonsQRD(vp);
  ans=ask("see it?",1)
  if (ans == "n") {
    exitgs();
    exit(-1);
  }
//////// Wob //////////////////



 void eleSpec(int i) 
 {
  elespec = Pt(i)

  ans=ask(" $elespec \n",0)
  
  <<" %V $elespec $Pt(i) \n"
  
  elef = split(elespec,",")

  ewo[i]=cWo(vp,WO_BN_)
  <<"$i  $ewo[i] $elef[1]  $elef[2] \n"
  <<"resize $col,$rb,$(col+1),$rt \n"
  sWo(_woid,ewo[i],_wname,"$elef[1] $elef[2] ",_wcolor,ecolor[i],_wresize,wbox(col,rb,col+1,rt,WGRID_),_wredraw,ON_)

  sWo(_woid,ewo[i],_wborder,BLUE_,_wdraw,ON_,_wclipborder,GREEN_,_wfonthue,BLACK_,_wvalue,"$elef[1]\n $elef[3]",_wstyle,SIV_)
  
 if (show) {
  sWo(_woid,ewo[i],_wredraw,ON_)
 }
 else {
  sWo(_woid,ewo[i],_wclear,ON_)
 }
 sWo(_woid,ewo[i],_whelp,"$elespec")
 col++;
 }


 void peleSpec(int si,int fi) 
 {
 for (i = si ; i <=fi; i++) {
 elespec = Pt(i)
 <<"$i  $Pt(i) \n"
 elef = split(elespec,",")
 ewo[i]=cWo(vp,WO_BN_)
 sWo(_woid,ewo[i],_wname,"$elef[1] $elef[2] ",_wcolor,ecolor[i],_wresize,wbox(col,rb,col+1,rt,WGRID_))
 sWo(_woid,ewo[i],_wborder,RED_,_wdraw,ON_,_wclipborder,GREEN_,_wfonthue,BLACK_,_wvalue,"$elef[0]\n $elef[3]",_wstyle,SIN_)
 if (show) {
    sWo(_woid,ewo[i],_wredraw,ON_)
 }
 else {
    sWo(_woid,ewo[i],_wclear,ON_)
 }
 sWo(_woid,ewo[i],_whelp,"$elespec")
 col++;
 }
 }





 int ewo[120]
 int ewo_show[120]
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

 rb = 9;
 rt = rb+1;



 

 

 //int show = 1
 
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


//ans=ask("see it?",1)


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




xp = 0.1
yp = 0.5

   //sWi(_woid,vp,_wredraw,ON_)

   // toggle wo on/off ?

   if (!show) {
     // for (i = 1; i <= 112; i++) {

         sWo(_woid,ewo,_wclear,LILAC_,_wborder,MAGENTA_,_wclipborder,PINK_,_wstyle,"SIN",_wredraw,ON_)
	
  //    }
   }

ans=ask("see it?",0)

   while (1) {

      eventWait(4.0)   

   if (!show) {
      //for (i = 1; i <= 112; i++) {
        sWo(_woid,ewo, _wborder,GREEN__,_wclipborder,RED_)
      //}
   }



   <<"$ewoname_ $ewoid_\n"
   
   sWo(_woid,ewoid_,_wfonthue,BLUE_,_wstyle,SVO_,_wredraw,ON_)
     

  if (scmp(ewoname_,"QUIT",4)) {
       break
  }

  }

 exit_gs()



///

  chkOut(1);



#if __CPP__           
  exit(-1); 
  }  // end of C++ main 
#endif     

 

//==============\_(^-^)_/==================//
