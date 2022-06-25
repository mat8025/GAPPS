

#if CPP
// gevent.h  should have these ? - alternative to gevent.asl
int Ev_button = 0;
Str Ev_keyw = "nada";


extern int tdwo,vvwo;
extern int mapwo;
//extern int tpwo[];
//extern int legwo[];
extern int TASK_wo;
extern int sawo;
extern int vptxt;
extern int Witp;
extern  int igc_tgl;
extern  int igc_vgl;
extern int Maxtaskpts;
//extern float erx,ery;
extern Gevent gev;

extern Turnpt  Wtp[]; //
extern Tleg  Wleg[];
extern  void gg_gridLabel(int wid);

void drawTask(int w,int col);

int ClosestTP (float longx, float laty);
int ClosestLand(float longx,float laty);
int  PickTP(Str atarg,  int wtp);
void taskDist();

#endif

int mapwo,vptxt,sawo,vvwo,TASK_wo, TASK_menu_wo, ZOOM_wo;

 int igc_tgl, igc_vgl;

//Str ans;
  int Witp = 0;



int tdwo = -1;

int ntp;

Str np,nval;



//int ekey;
float ght;

float ST_msl;





int MaxSelTps = 12;

Str WoName = "xyz";
Str wc = "Salida";
int wtpwo;
Str wway="P";
int ok =0;



  int Init = 1;
  int zoom_begin = 0;
  int zoom_end =  200;
  float MSE[32];

int CR_init = 0;
int CL_init = 0;


int st_lc_gl= -1;
int st_rc_gl = -1;
int Vp;
int MaxLegs = 12;
Str TaskType = "MT";


  int legwo[14];
  
  int tpwo[14];


 int symsz = 2;
 int wfr = 0;


/////////////  Arrays : Globals //////////////

        float symx = 0.0;
	float symy = 0.0;
        float syme = 0.0;
        float symem = 0.0;	

Str ttp;
  
float LoD = 35.0;

int r_index;


int Nlegs = 3;


int Taskpts[30];



int LastTP = 12; 


Record SRX;


int is_an_airport = 0;

int wtp;
/////////////////// TASK DEF ////////////





int Task_update =1;

//Units = "KM";

int tp_wo[20];
int gtp_wo[20];
int ltp_wo[20];

int finish_wo = -1;
int start_wo = -1;



char MS[240];
//char Word[128];
char Long[128];
int num_tpts = 700;

float R[10];

int Have_igc = 0;

Vec<float> ST_RS(50);


//  Read in a Task via command line

float min_lat;
float max_lat;
float longW =0.0;
float mkm;


//////////////// PARSE COMMAND LINE ARGS ///////////////////////

long posn = 0;
Svar Tskval;
Str targ;
Str cval ="?";
Str igc_fname ="xyz";
Str igc_fname1 ="abc";
//Str igc_file = "dd.igc";
