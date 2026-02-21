/* 
 *  @script wevent.asl                                                        
 * 
 *  @comment        
 *  @release Carbon                                                           
 *  @vers 1.7 N Nitrogen [asl 6.67 : C Ho]                                    
 *  @date 02/14/2026 07:42:00                                                 
 *  @cdate Tue Jan 1 10:36:56 2019                                           
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2026 -->                                     
 * 
 */ 


//----------------<v_&_v>-------------------------//                  

///
/// wait and catch mouse/key window events
//
//

// all the Globals  are of the form  exxxx_   


#if __CPP__
#include "gevent.h"
#endif

  Gevent Gev;  // event type - can inspect for all event attributes

  Gev.pinfo();

  Vec<int> WPOS__( 16);
  Vec<int> MPOS__( 16);

///  use prefix  GEV_    _GEV seen as tag arg by ASL


  int last_eid_ = -1;

/////////////////////////////////////
  int  ewsz_ = 0;
  int  eloop_ = 0;

  float erx_ = -1.234;
  float ery_ = -1.2345;

  int ex_ = -15;
  int ey_ = 0;

  int etype_ = 0;
  int erow_ = -1;
  int ecol_ = -1;
  int ebutton_ = 0;
  int eid_ = 0;
  int ekeyc_ =0;
  int ewoid_ 
  int ewoaw_ =0;
  int ewid_ =0;

  Svar emsgwd_;
  Svar ewords_;

  Str ename_;

  Str ekeyw_ = "nada";
  Str ekeyw2_ = "nada2";
  Str ekeyw3_ = "nada3";

  Str emsg_ = "";

  Str evalue_ = "abc";

  Str ewoname_ = "noname";

  Str ewoval_ = "yyy";

  Str ewoproc_ = "abc";

//////////////////////////////////////

//////////////////////////////////////
  int GCL_init = 1
  int GCR_init = 1
  
/////////////////////////////////////////////////////////////
//
//
//  _name not allowed  _wclear  is used as a tar arg  - recognized by asl
//  but not a user defined allowed variable
//  abc_def is allowed
//




void eventDecode()
  {
   // can get all of these in one by using ref parameters

/*
// needs work in scopesindex to get a GEV member
// and icode getGetmember

<<"trying  to get Gev.ebutton\n"

  abut = Gev.ebutton;

<<"%V $abut $Gev.ebutton \n"
*/

#if ASLGEV_

  ename_ = Gev.getEventparameters   (eid_,etype_,ewoid_,ewoaw_,ebutton_,ekeyc_,ewoproc_,ex_,ey_,ewoval_);
   
   <<"ASLGEV %V $ename_ $etype_ $ebutton_ $ekeyc_ \n"
#else

      etype_ = Gev.getEventType();

      ename_ = Gev.getEventName();
   
      ebutton_ = Gev.getEventButton();  // or Gev.ebutton

cprintf("getting   ebutton_ %d ename_ %S\n",ebutton_,ename_) ;

      ekeyc_ = Gev.getEventKey();

#endif     
//<<"$_proc %V $ex $ey  $ewoid\n"

      ewoval_ = Gev.getEventWoValue();
   
//  <<"%V $ewoval \n"       
      MPOS__[0] = -1;
    
      ewid_ = -1;

      if  (checkTerm())  {
          ekeyw_ =  "EXIT_ON_WIN_INTRP";
      }
      else  {
//  <<"$_proc %V $emsg_ \n"
          if  (emsg_ != "")  {
     // split the msg into separate words
              ewords_.split(emsg_);

              ewsz_ = ewords_.getSize();

              if  (ewsz_ >= 1)  {
                  ekeyw_ = ewords_[0];  // TBC

//<<"%V $evalue_ $emsg_  $ekeyw_ \n"
                  evalue_ =   spat(emsg_,ekeyw_,1);

                  evalue_.eatWhiteEnds();


                  if  (ewsz_ >= 2)  {
                      ekeyw2_ = ewords_[1];
                      if  (ewsz_ >= 3)
		       ekeyw3_ = ewords_[2];
                  }



                  if  (ewoid_ < 32767)  {
                      ewid_ = ewoid_;
                  }
                  else  {
                      ewid_ = (ewoid_ & 0xFFFF0000) >> 16 ;
		      }
              }
    
              ewoname_ = Gev.getEventWoName();
	      
              ewoproc_ = Gev.getEventWoProc();
  
//  Motion event -- will have 1 or more 'event' readings
//  read these into array or rxy and erow-col

              Gev.getEventRowCol(erow_,ecol_);

//  Mouse  pos, screen pos?
// needed?
              MPOS__[2] = ebutton_;

          }
      }
  }
//==============================

  void eventWait(float secs)
  {
       vardef(secs,-1.0);
       
 // <<"$_proc %V $secs \n"
      int ret = 1;

      eloop_++;
      ekeyc_ = 0;
      ewoid_ = -1;
      erow_ = -1;
      ecol_ = -1;
      ewoname_ = "";
      ename_ = "xx";
      ewoval_ = "";
      emsg_ = "";
      ekeyw_ = "";
      secs.pinfo()
   //  <<"$_proc ENTER from Gev.eventWait  $secs\n"

      emsg_ = Gev.eventWait(secs);



      erx_ = -0.004;
      ery_ = -0.005;

      //erx_.pinfo()
      
      Gev.getEventRxRy(erx_,ery_);  //  SF func should process as a reference arg

      
     //erx_.pinfo()
 
      ewoid_ =Gev.getEventWoid();

     // cprintf("%s    ewoid %d  erx %f  ery %f\n",__FUNCTION__,ewoid,erx,ery)      ;
      <<" %V $ewoid \n"
      eventDecode();
/*     
     if (ekeyw_ == "EXIT_ON_WIN_INTRP") {
     
       ret = 0;
        <<"exit on WIN_INTRP ? $ret\n"
     }
*/     
    // return ret;  // TBF 10/24/21

 }

//==============================

  void eventRead()
  {
//     <<"$_proc\n"
      emsg_ = Gev.eventRead();
      eloop_++;
      eventDecode();
  }
//==============================
  int getEventButton()
  {

      int bt;

      bt= Gev.getEventButton();

      return bt;
  }

//<<" %V $_include $emsg\n"

//====================================


  
