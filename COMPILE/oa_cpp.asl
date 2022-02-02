
///
///
///

filterFuncDebug(REJECT_,"~varIndex","~var_sindex","var_main","primitive","Delimiter");

 chkIn(_dblevel);
 



int Tleg_id = 0;

//<<"%V $_include $Tleg_id\n"

class Tleg 
 {

 public:

  
  int tpA;
  int tpB;
  
  float dist;
  float pc;
  float fga;
  float msl;

  str Tow;
  str Place;


 void Tleg() 
 {
 //<<"Starting cons \n"
  dist = 0.0
  pc = 0.0;
  fga =0;
  msl = 0.0;
 // <<"Done cons $dist $pc\n"
 }
 
};

Tleg  Aleg;


Aleg->msl = 5300.0;

float msl = Aleg->msl;


chkR(msl,5300.0);


//ans=query(":->");

Aleg.dist = 1.9;


float dist = Aleg.dist;

chkR(dist,1.9);


float tkm = 7;

float tkmB = 15;

float tkmC = 34;
float val = 0;
<<"$dist \n"


chkR(tkmC,34);

val = tkmC;

chkR(tkmC,val);

int nl = 2;


Tleg  Wleg[20];
  

Wleg[nl]->dist = tkm;

<<"$nl $Wleg[nl]->dist \n"
nl++;

//Wleg[nl++]->dist = tkmB; // bug double incr

Wleg[nl]->dist = tkmB;
val = Wleg[nl]->dist;
chkR(val,15.0)
<<"$nl $Wleg[nl]->dist $val\n"



nl++;

Wleg[nl].dist = tkmC;
val = Wleg[nl].dist;

<<"$nl $Wleg[nl]->dist $val\n"
<<"$nl $Wleg[4]->dist $val\n"
nl++;
Wleg[nl++].dist = tkmC + tkmB;
val = Wleg[6].dist;
<<"$nl $Wleg[6].dist $val\n"
chkR(val,49.0)
chkT(1);
chkOut();
