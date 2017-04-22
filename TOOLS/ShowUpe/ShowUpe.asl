//
//
//
// UPE TRANSCRIPTION  Dec 2016 revise
//
//set_debug(1,"trace")
//
//

set_debug(-1)

version = "1.5"

<<"$_clarg[0] $version\n";

 Graphic = CheckGwm()
   
  if (!Graphic) {
     X=spawngwm() // has to use xgs
  }
  
//OpenDll("plot","audio","image","tran");
OpenDll("audio","image","tran");

mach = get_arch()
myname = get_uname(1)

  //if (mach @= "sun") {
  //sun = 1
  //}
  //else {
  //sun = 0
  //}

s_display=get_env_var("DISPLAY")
display=spat(s_display,":0")

  si_pause(3)
  mywid =getAslWid();
//stitle = scat("UPET_V",the_version);

  sWi(mywid,"UPET")

int Sf = 16000;
float Sfreq = Sf; // default sampling frequency

// defaults

Fkgrey = 0
ngl = 16
Gindex = 8
min_v = 20
max_v= 80
intpx = 1
st_fr = 0


include "upe_ws";

include "upe_procs";

//include "upe_menu";



include "upe_compute";



include "upe_io";

<<" after includes %V$two $lwo\n"


include "upe_settings";

 
//read_devices()
// TBD

  openAudio(); // open rec,play snd devices
  

# get signal space

// TDB  ss= get_signal_space(320000) ; // signal space needed?
 ss = 320000;

 Sbn = createSignalBuffer() ; // create an audio buffer

<<"%V$Sbn \n"


sp1 = 0;
sp2 = ss;
Olds1 = 0;
Olds2 = 0;

Endtime = 1.0;

Z0 = 0.0;
Z1 = 1.0;


# get a set of labels

timit_w = getLabelSet(100)

<<"label_set for words %V $timit_w \n"

timit_p = get_label_set(500)
<<"label_set for phones %V$timit_p \n"

timit_gp = get_label_set(500)

<<"label_set %V$timit_gp \n"


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

# if abort/interrupt jump here

sw = tw

// TBD set_sip_jump(); // for interrupt-- reload funcs?

len = 0



//ngl = set_cmap();  // set number of grey levels to be used in sgraph


   sWi(tw,@redraw);
   
//iread()


   get_data_files()

<<"%V$two $Nbufpts\n"
   fs = getChannelPara(spp_file,"FS",1)
   nvals = getChannelPara(spp_file,"NOB",1)
   stp = getChannelPara(spp_file,"STP",1)
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
int last_evid = -1;
woname = "";

E =1; // event handle

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
    
        button = 0;
	sWo(buttonwos,@redraw);
	
//        w_show_curs(tw,1,"spider",0.5,0.1); // leave it where it is or at buttons
        gwm_w_show_curs(tw,1,"spider"); // leave it where it is or at buttons
        // load curs for tw
 //<<"do you see a spider?\n"
        //showcurs(1,-1,-1,"spider",7,7)

	
        msg = E->waitForMsg()
//<<"%V$msg\n"
        keyc = E->getEventKey()
        button = E->getEventButton()
        evid = E->getEventID()

	//wnu=message_wait(&MS[0],&type,&len,&time_stamp)
	//l=str_scan(&MS[0],&choice)
        E->geteventrxy(btn_rx,btn_ry);
        etype = E->getEventType();
        
	
       // sw = wnu
        if ( (etype @= "PRESS")  ) {
            Woid = E->getEventWoId();
	    woname = E->getEventWoName();
	    <<"%V$Woid $woname\n"
            //do_wo_options(Woid)
	    if ( woname @= "SEL" ) {
            showVox(two, t1, t2);
	    t1 += 1;
	    t2 = t1 + 2;
	    computeSpecandPlot(t1, t2);
	    }
	    else if ( woname @= "FORW" ) {
                go_forward();
            }
	    else if ( woname @= "REV" ) {
                go_back();
            }
	    else if ( woname @= "P_TOK" ) {
                play_token(timit_p);
            }
	    else if ( Woid == pwordwo ) {
                play_token(timit_w);
            }	    
	    else if ( woname @= "PLAY" ) {
                play_window(timit_gp);
            }
	    else if ( woname @= "NEWF" ) {
             <<" load up new file - save changes?\n";
	         new_file();
            }	    
	    else if ( woname @= "EXIT" ) {
             <<"exit now !\n";
                   break;
            }	    
	    else {
	    <<"%V $woname ? \n";
	    //the_menu (woname);
	    }
        }
       
          last_evid = evid;
      
  }


<<" out of loop \n"
exit()

//exitgs();


////////////////////////////////////////////////////////
