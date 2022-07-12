/* 
 *  @script showvox.asl                                                 
 * 
 *  @comment speech edit and label                                      
 *  @release Beryllium                                                  
 *  @vers 1.5 B Boron [asl 6.4.41 C-Be-Nb]                              
 *  @date 07/05/2022 16:19:28                                           
 *  @cdate 1/1/2000                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  

//
//  revision of phn/upe labeller
//

#define ASL 1
#define ASL_DB 0
#define GT_DB   0
#define CPP 0


#if ASL
// the include  when cpp compiling will re-define ASL 0 and CPP 1
//#include "compile.h"
#define PXS  <<
#define VCOUT //
#endif


#include "debug.asl";
  debugON();
  
//  setdebug(1,@keep,@~pline,@~trace);
//  FilterFileDebug(REJECT_,"~storetype_e");
//  FilterFuncDebug(REJECT_,"~ArraySpecs",);


//set_debug(-1)
#include "hv.asl"


// version should be read from script header

<<"$_clarg[0]   $hdr_vers\n";
#include "graphic"


//OpenDll("plot","audio","image","tran");
OpenDll("audio");
OpenDll("image");
OpenDll("tran");

mach = get_arch();
myname = get_uname(1);


Str s_display=get_env_var("DISPLAY");
Str display=spat(s_display,":0");

  si_pause(1);
  int mywid =getAslWid();
//stitle = scat("UPET_V",the_version);




  sWi(_WOID,mywid,_WNAME,"UPET");

int do_audio = 0;

int Sf = 16000;
float Sfreq = Sf; // default sampling frequency

// defaults

int Fkgrey = 0;
int ngl = 16;
int Gindex = 8;
int min_v = 20;
int max_v= 80;
int ntpx = 1;
int st_fr = 0;
float Endtime = 1.0;
float Z0 = 0.0;
float Z1 = 1.0;
float start_t = 0.0;
float stop_t = Endtime;

#include "screen_vox"

#include "procs_vox"


//include "vox_menu";

#include "compute_vox"

#include "io_vox"

<<" after includes %V$two $lwo\n"

#include "settings_vox"

#include "gevent"

//read_devices()
// TBD

 if (do_audio) {
  openAudio(); // open rec,play snd devices
  }

// get signal space

// TDB  ss= get_signal_space(320000) ; // signal space needed?
 ss = 320000;

 Sbn = createSignalBuffer() ; // create an audio buffer

<<"%V$Sbn \n"


sp1 = 0;
sp2 = ss;
Olds1 = 0;
Olds2 = 0;




// get a set of labels

int timit_w = getLabelSet(100);

<<"label_set for words %V $timit_w \n"

int timit_p = getLabelSet(500);
<<"label_set for phones %V$timit_p \n"

int timit_gp = get_label_set(500);

<<"label_set %V$timit_gp \n"
ans=query("?", "getLabelSet",__LINE__);

tok_type = timit_gp;

Transcribe = 1;
Transcribe_type = "UPE";
//////////////////////////////////


timit_file = "fmj-1.16k.left"
sig_file =  scat (timit_file,".vox")




float YS[]

 int go_on = 1;
 
 go_on= new_file();

 
<<"%V$timit_file  $sig_file \n"

// test for pcm wav

 if ( !go_on) {
   <<" missing init file \n"
 }
 else {

//  read_the_signal()
  
//<<"%V $file_start $sig_file\n"

// success= read_the_signal(file_start,0,1)
//<<"%V read_the_signal $success \n"
  }


// open up label files

lab_file = "";

guplab_file = ""

upe_file =  ""

oupe_file = ""

wrd_file = ""

owrd_file = "";

/////////////////////////
 


type = -1
choice = 1
time_stamp =0

// if abort/interrupt jump here

sw = tw

// TBD set_sip_jump(); // for interrupt-- reload funcs?

len = 0



//ngl = set_cmap();  // set number of grey levels to be used in sgraph


   sWi(tw,@redraw);
   
//iread()


   get_data_files();

<<"%V$two $Nbufpts\n"
   fs = getChannelPara(spp_file,"FS",1);
   nvals = getChannelPara(spp_file,"NOB",1);
   stp = getChannelPara(spp_file,"STP",1);
   sGl(ptgl,@XI,fs,@XO,0)


  sWo(buttonwos,@border,BLACK_,@redraw);

   showVox(two, 0, Durnvox);
   
   computeSpecandPlot(0, Durnvox);

   showRmsZx();

   do_pt();

   sWo(buttonwos,@border,BLACK_,@redraw);


// navigate to speech database directory



 read_the_labels();

prog = "sg"

fil_bw = 100
f_shift = 2.5
pre = 90 ;// preemphasis of signal -- check needed
op = "NO"


<<"@Main Loop \n" ; 

int do_loop = 1;
int w_wo = 0;
int button = 0;
int keyc = 0;
float btn_rx = 0;
float btn_ry = 0;
int kloop = 0;




    gwm_w_show_curs(pw,1,"trek",0.5,0.5);
    gwm_w_show_curs(tw,1,"spider",0.5,0.5);
    gwm_w_show_curs(lw,1,"gumby",0.5,0.5);
    gwm_w_show_curs(spw,1,"sailboat",0.5,0.5);

float t1 = 0;
float t2 = t1 + 3.0;


    ok=gwm_w_show_curs(tw,1,"spider",0.5,0.5);
//<<"entering gui loop \n"

   while (do_loop) {

        kloop++;
    
	sWo(buttonwos,@redraw);
	
//        w_show_curs(tw,1,"spider",0.5,0.1); // leave it where it is or at buttons
        gwm_w_show_curs(tw,1,"spider"); // leave it where it is or at buttons
        // load curs for tw
 //<<"do you see a spider?\n"
        //showcurs(1,-1,-1,"spider",7,7)

	
        eventWait();
	
//<<"%V$msg\n"
  //        evid = E->getEventID()

	//wnu=message_wait(&MS[0],&type,&len,&time_stamp)
	//l=str_scan(&MS[0],&choice)

        //E->geteventrxy(btn_rx,btn_ry);
       // etype = E->getEventType();
        
	
       // sw = wnu
        if ( (_ename @= "PRESS")  ) {

	    <<"%V$_ewoid $_ewoname\n"
            //do_wo_options(Woid)
	    if ( _ewoname @= "SEL" ) {
            showVox(two, t1, t2);
	    t1 += 1;
	    t2 = t1 + 2;
	    computeSpecandPlot(t1, t2);
	    }
	    else if ( _ewoname @= "FORW" ) {
                go_forward();
            }
	    else if ( _ewoname @= "REV" ) {
                go_back();
            }
	    else if ( _ewoname @= "P_TOK" ) {
                play_token(timit_p);
            }
	    else if ( Woid == pwordwo ) {
                play_token(timit_w);
            }	    
	    else if ( _ewoname @= "PLAY" ) {
                play_window(timit_gp);
            }
	    else if ( _ewoname @= "NEWF" ) {
             <<" load up new file - save changes?\n";
	         new_file();
            }	    
	    else if ( _ewoname @= "EXIT" ) {
             <<"exit now !\n";
                   break;
            }	    
	    else {
	    <<"%V $_ewoname ? \n";
	    //the_menu (_ewoname);
	    }
        }
       
  }



exit(-1)

//exitgs();


////////////////////////////////////////////////////////
