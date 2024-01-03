 /* 
 *  @script class_mfcall.asl 
 * 
 *  @comment show mf call 
 *  @release CARBON 
 *  @vers 1.3 Li 6.3.87 C-Li-Fr 
 *  @date 02/23/2022 10:51:05          
 *  @cdate Tue Mar 31 20:10:28 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
//----------------<v_&_v>-------------------------//                              

///
///
///

///
///   try Class DLL for cpp compile
///   

///
///  need to sort out procrefargs
///



#include "debug"

   if (_dblevel >0) {

     debugON();

     }

#define ASL 1

   chkIn (_dblevel);

   allowErrors(-1)

   ok = 1;

class Instrum 
 {


  public:
  
  
  float mx;
  float my;
  float dia;
  float ht;
  float wd;
  int type;
  float px,py,pX,pY;
  
  int shape;
  Str Name;
  int wid;


 void Instrum()   //  use cons,destroy   -- have then set to NULL in CPP he
 {
  shape = 1;  // 1 circle, 2 rectangle
  dia = 3.0;

  wd =1.0;
  ht = 1.0;
  Name = "XI";
  wid = -1;

  mx=0.0;
  my=0.0;
  }

  void setName( Str nm)
   {
     <<" In $_proc  $nm\n";
     Name = nm;
   };

  Str getName ()   
   {
       return Name; 
   }

 // void Set(int id, Str nm, int shp, float d, float x, float y)
  void SetIns(int id, Str nm,int shp, float d, float x, float y)
  {
  <<" In Set ! %V $id $shp $d $x $y \n";
    //<<"Set    $shp     $ x $ y \n";
    wid = id;
    Name = nm;
    shape = shp;
    dia = d;
    mx = x;
    my = y;
<<"%V $wid $Name $shape $dia $mx $my \n";
  };

  void SetShape(int shp)
  {
  <<" In $_proc ! %V $shp\n";
     shape = shp;
  };

  void SetDia(float d)
  {
  <<" In $_proc ! %V $d\n";
     dia = d;
  };

/*
  double SetMid(double x, double y)
  {
  <<" In $_proc ! %V $x $y\n";
     mx = x;
     my = y;
     return (mx * my);
  };
*/

  float SetMid(float x, float y)
  {
  <<" In $_proc ! %V $x $y\n";
     mx = x;
     my = y;
     return (mx * my);
  };
  


  
  void Print() {

    <<"%V $wid $Name $shape $dia $mx $my \n";

   };
 
};   


float ShowMxy(Instrum wins[],int j, int k)
  {

  <<"$_proc  $j $k\n";
  pinfo(j);

  pinfo(wins);


  float x = -1;
  float y = -1;
  x.pinfo();
  
  x = wins[j].mx;

  y = wins[k].my;

<<"%V $x $y \n";
   <<" $VB_ins[j].mx   $VB_ins[k].my\n";
  return y;
}

float sx;
Str iname = "X?";
float idia = 4.0;
float imx = -15.1;
float imy = 27.1;

Svar Wval;


Wval.split("XYZ,1,2,$imx,$imy",44);

<<"$Wval \n";

<<"$Wval[0] \n";
<<"$Wval[2] \n";

Svar Wval2;

Wval2.split("ABC 1.3 2.4 $imx $imy");


<<"$Wval2[0] \n";
<<"$Wval2[2] \n";
<<"$Wval2[3] \n";

<<"$Wval2 \n"

  Instrum  VB_ins[16];

int vario1_wo = 42;

float mr;
float dr;

ans ="y"
//DBaction((DBSTEP_),ON_)
// allowDB("ic_,oo_,spe_,rdp_,pexpnd,tok,array")


    VB_ins[0].Name = "SN_Vario";
    //VB_ins[0].shape = 1;
    //VB_ins[0].mx = -15;
    //VB_ins[0].my = 27;
    
    iname = "Airspeed";
    
    VB_ins[0].SetIns(vario1_wo,iname,1,idia, imx, imy);
    vario1_wo++; imx += 1; imy += 2;
    
    VB_ins[1].SetIns(vario1_wo,"ins1",1,idia, imx, imy);
    vario1_wo++; imx += 1; imy += 2;
    
    VB_ins[2].SetIns(vario1_wo,"ins2",1,idia, imx, imy);
    vario1_wo++; imx += 1; imy += 2;
    
    VB_ins[3].SetIns(vario1_wo,"ins3",1,idia, imx, imy);
    vario1_wo++; imx += 1; imy += 2;
    
    VB_ins[4].SetIns(vario1_wo,"ins4",1,idia, imx, imy);     
    vario1_wo++; imx += 1; imy += 2;
    
    VB_ins[5].SetIns(vario1_wo,"ins5",1,idia, imx, imy);     

//ans=ask("4 VB_ins",DB_action);
//DBaction((DBSTEP_,DBSTRACE_),ON_)


     VB_ins[0].Print();

     VB_ins[1].Print();
<<" exit cmf xic to here !!\n"
    
    VB_ins[2].Print();
//ans=ask(DB_prompt,DB_action);


    VB_ins[0].SetShape(3);
    VB_ins[0].Print();

    idia = 4.5;
    VB_ins[0].SetDia(idia);
    VB_ins[0].Print();

    imx =17;
    imy = 42;
    dr = 42;
    mr= imx *imy;
    
    r2=VB_ins[0].SetMid(imx, dr);
    
    VB_ins[0].Print();
    <<"%V $mr $r2\n";
      ok=chkN(mr,r2);


        mr= imx * 30;
	// 30.0 is a double needs to match arg
    r2=VB_ins[0].SetMid(imx,30.0);
    
    VB_ins[0].Print();
    <<"%V $mr $r2\n";

ok = chkN(mr,r2);
<<"%V $ok \n"




iname = "Altimeter";
  VB_ins[0].setName(iname);

  VB_ins[0].Print();

  VB_ins[0].setName("Sage");

  VB_ins[0].Print();

   int j1 = 1;
   int k1 = 2;

   <<" $VB_ins[1].mx   $VB_ins[1].my\n";

float gmx;

    gmx = VB_ins[j1].mx;


     gmx.pinfo();



     gmx = ShowMxy(VB_ins,j1, k1);
<<"%V $gmx\n"

     ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"

     j1++;
     k1++;

     gmx= ShowMxy(VB_ins,j1, k1);
<<"%V $gmx\n"


   ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"



//pinfo(gmx);

    gmx = ShowMxy(VB_ins,j1+1, k1+1);
<<"%V $gmx\n"
//pinfo(gmx);

 ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"


    gmx = ShowMxy(VB_ins,j1+2, k1+2);
<<"%V $gmx\n"
//pinfo(gmx);

 ok = chkN(gmx,-1.0,GT_)

<<"%V $ok \n"


     chkOut();



/*
  float SetMid(double x, double y)
  {
  <<" In $_proc ! %V $x $y\n";
     mx = x;
     my = y;
     return (mx * my);
  };
*/