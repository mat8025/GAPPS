
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

    //vp = cWi(@title,"Periodic_Table_Of_Elements",@resize,0.01,0.2,0.95,0.9,0)
    vp = cWi("Periodic_Table_Of_Elements")
    sWi(_woid,vp,_wresize,wbox(0.01,0.2,0.95,0.9,0))

    sWi(_woid,vp,_wpixmap,ON_,_wdraw,ON_,_wsave,ON_,_wbhue,WHITE_)

    sWi(_woid,vp,_wgrid,11,20)
    
    sWi(_woid,vp,_wclip,wbox(0.2,0.2,0.8,0.8))

//////// Wob //////////////////

 bx = 0.1
 bX = 0.3
 yht = 0.2
 ypad = 0.05

 bY = 0.95
 by = bY - yht

 void eleSpec(i) 
 {
  elespec = Pt(i)
  elef = split(elespec,",")
  ewo[i]=cWo(vp,WO_BV_)
 
  sWo(_woid,ewo[i],_wname,"$elef[1]  $elef[2]",_wcolor,ecolor[i],_wresize,wbox(col,rb,col+1,rt,3))

  sWo(_woid,ewo[i],_wborder,BLUE_,_wdraw,ON_,_wclipborder,GREEN_,_wfonthue,BLACK_,_wvalue,"$elef[0]\n $elef[3]",_wstyle,SVB_)
  
 if (show) {
  sWo(_woid,ewo[i],_wredraw,ON_)
 }
 else {
 sWo(_woid,ewo[i],_wclear,ON_)
 }
 sWo(_woid,ewo[i],_whelp,"$elespec")
 col++;
 }


 void peleSpec(si,fi) 
 {
 for (i = si ; i <=fi; i++) {
 elespec = Pt(i)
 elef = split(elespec,",")
 ewo[i]=cWo(vp,"BV",_wname,"$elef[1]  $elef[2]",_wcolor,ecolor[i],_wresize,col,rb,col+1,rt,3)
 setgwob(ewo[i],_wBORDER,_wDRAWON,_wCLIPBORDER,_wFONTHUE,BLACK_,_wVALUE,"$elef[0]\n $elef[3]",_wSTYLE,"SVB")
 if (show) {
    setgwob(ewo[i],_wredraw,ON_)
 }
 else {
    setgwob(ewo[i],_wclear,ON_)
 }
 sWo(ewo[i],_whelp,"$elespec")
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

#include "wevent.asl"



xp = 0.1
yp = 0.5

   while (1) {


      eventWait()


     

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
