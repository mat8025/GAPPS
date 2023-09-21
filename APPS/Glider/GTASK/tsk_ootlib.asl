/* 
 *  @script tsk_ootlib.asl                                              
 * 
 *  @comment task-planner library                                       
 *  @release Silicon                                                    
 *  @vers 4.6 C Carbon [asl 5.14 : B Si]                                
 *  @date 08/11/2023 15:59:39                                           
 *  @cdate 9/17/1997                                                    
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 

//----------------<v_&_v>-------------------------//                      

///
///

#ifndef OOTLIB_

#define OOTLIB_ 1

//  int Ntpts = 0
  
  int Igcfn = -1
  
  Str task_file = "XXX"

  float MSL=0

  int Ntaskpts = 0

   Min_lat = 90.0  // TBF should auto_dec to double?

   Max_lat = 0.0

   float Min_ele = 0.0

   float Max_ele = 0.0

   float Min_W = 109.0

   float Max_W = 105.0
//DBG"%V $nm_to_km $km_to_sm  \n"


  float LatS = 37.5

  float LatN = 42.0

  float LongW= 108.5

  float LongE= 104.8


   float MidLat = (LatN - LatS)/2.0 + LatS


   float Margin = 0.05

   float MidLong = (LongW - LongE)/2.0 + LongE
 


  Str Units = "KM"

  Str lat = "A"

  Str longit = "B"

  float LegK =  0.5 * (7915.6 * 0.86838)
  //DBG" %v $LegK \n"
  //  Main_init = 0
//DBG" read in unit conversions \n"

//  int n_legs = 0
//float Leg[20]
// conversion routines



//============================================



  float IGCLONG [7000]

  float IGCLAT [7000]

  float IGCELE [7000]

  float IGCTIM [7000]




// DBG <<"%V $Igcfn \n"



  float computeGCD(float la1,float la2,float lon1,float lon2)
  {
///  input lat and long degrees - GCD in km
  float rL1,rL2,rlo1,rlo2,D,km
  // TBF 8/12/23  -- ieadlly all rL1,...  should auto_dec

  rL1 = d2r(la1)

  rL2 = d2r(la2)

  rlo1 = d2r(lon1)

  rlo2 = d2r(lon2)

  D= acos (sin(rL1) * sin(rL2) + cos(rL1) * cos(rL2) * cos(rlo1-rlo2))

  km = LegK * D  * nm_to_km
 // printargs ("km ",km)
  return km

  }
//==================================================


  void processIGC()
  {
   int i
   
   Vec<double> sslng(14)
   
   Vec<double> sslat(14)
   
   Vec<double> ssele(14)

   IGCTIM = 1.2

   //IGCTIM.pinfo()


//sdb(2)
   IGCLAT = 3.4
  IGCLONG = 4.5
  IGCELE = 5.6
  IGCLAT[2] = 77.66
  IGCLONG[2] = 47.68
  IGCELE[4] = 12345.678
  IGCELE.pinfo()
//sdb(1)
  //pa("processIGC Igcfn   ",Igcfn)

   //  for (i=0; i < 100; i++) {
   //  <<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n";
     //printf("%d %f %f %f %f\n",i,IGCTIM[i] ,IGCELE[i] ,IGCLAT[i]  ,IGCLONG[i] );
   //  }



  Ntpts= readIGC(Igcfn, IGCTIM, IGCLAT, IGCLONG, IGCELE)
  
// TBF ?  not translating ?
  // <<"sz $Ntpts $(Caz(IGCLONG))   $(Caz(IGCLAT))\n"

  
//<<"%(10,, ,\n) $IGCLONG[0:30] \n"
//<<"%(10,, ,\n) $IGCLONG[k:Ntpts-1] \n"

     for (i=0; i < 100; i++) {
     //<<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n"
     printf("%d %f %f %f %f\n",i,IGCTIM[i] ,IGCELE[i] ,IGCLAT[i]  ,IGCLONG[i] )
     }




//pa("stats 2do ")

 // sslng= stats( IGCLONG)

    sslng=  IGCLONG.stats()
     for (i=0; i < 12; i++) {
        printf("i %d %f \n",i,sslng[i])
      }


//ans=query("?","sslng",__LINE__)

//sslat= stats( IGCLAT) // works

   sslat= IGCLAT.stats() // also works

     for (i=0; i < 12; i++) {
 printf("i %d %f \n",i,sslat[i])
      }
//ans=query("?","sslat",__LINE__);

 //ssele= stats( IGCELE);

ssele= IGCELE.stats()

    for (i=0; i < 12; i++) {
 printf("i %d %f \n",i,ssele[i])
    }

//ans=query("?","ssele",__LINE__)




  int sstart = Ntpts /10

  int sfin = Ntpts /5
    //sstart = 1000
   // sfin = 1500
//     for (i=sstart; i < sfin; i++) {
//      <<"$i $IGCTIM[i] $IGCELE[i] $IGCLAT[i]  $IGCLONG[i] \n"  // BUG FIXIT 9/20/21
//     }


 //<<"%V $ssele \n"

  Min_ele = ssele[5]

  Max_ele = ssele[6]
//<<" min ele $ssele[5] max $ssele[6] \n"


  float min_lng = sslng[5]

  float max_lng = sslng[6]
//<<"%V $min_lng $max_lng \n"

  float min_lat = sslat[5]

  float max_lat = sslat[6]

  //COUT(max_lat);



  LatS = min_lat -Margin

  LatN = max_lat+Margin

  MidLat = (LatN - LatS)/2.0 + LatS   // TBF no ;
  
  //<<"%V $MidLat \n"

  float dlat = max_lat - min_lat
  //<<"%V $dlat \n"
  //<<"%V $LongW \n"
  //<<"%V $LongE \n"

  LongW = max_lng + Margin

  LongE = min_lng - Margin

  MidLong = (LongW - LongE)/2.0 + LongE
  //DBG"%V $MidLong \n"

  float dlng = max_lng - min_lng

  float da = dlat
  
  //DBG"%V $da $dlng $dlat \n"
// TBF if corrupts following expression assignment

  if ( dlng > dlat )
  {

     da = dlng
	//DBG"da = dlng\n"

  }

  else {
  	//DBG"da = dlat\n"

  }
  //DBG"%V $da $dlng $dlat \n"
////////////////////// center //////////
//  longW = MidLong + da
//  DBG"%V $longW $MidLong $da \n"



  LongW = MidLong + da/2.0
  
  
  LongE = MidLong - da/2.0
  //VCOUT(LongW,LongE)

 //pa(LongW,LongE)
//CDBP("LongW")
//AST

  }
//===============================//
//<<"$_include %V$Ntp_id\n"

  Str nameMangle(Str aname)
  {

//<<"$_proc $aname \n"

  Str fname

  Str nname=aname

//  <<" %V $nname $aname \n"  // TBF

  int kc = nname.slen()

  if (kc >7) {

     nname.svowrm()

  }

  //fname.scpy(nname);
  fname = nname

// <<"%V $kc  $nname --> $fname \n"

// is this going to work as cpp 

  return fname

  }
//======================================//

  float totalK = 0

  float getDeg (Str the_ang)
  {
  Str the_dir
  float la
  float y
  Str wd
//DBG"in $_proc $the_ang \n"

  Svar the_parts
  the_parts.split(the_ang,',')

  int sz = the_parts.caz()
//DBG"sz $sz $(typeof(the_parts))\n"
    //DBG"%V $the_parts[::] \n"
//FIX    float the_deg = atof(the_parts[0])

  wd = the_parts[0]

  float the_deg = atof(wd)
        //DBG"%V $wd $the_deg \n"
//    float the_min = atof(the_parts[1])

  wd = the_parts[1]

  float the_min = atof(wd)
        //DBG"%V $wd $the_min \n"
    //DBG"%V$the_deg $the_min \n"
      //  sz= Caz(the_min);
      //DBG" %V$sz $(typeof(the_deg)) $(Cab(the_deg))  $(Cab(the_min)) \n"

  the_dir = the_parts[2]

  y = the_min/60.0

  la = the_deg + y

  if ((the_dir == "E") || (the_dir == "S")) {

  la *= -1

  }


  return (la)

  }
//===============================//



  void nearest (int tp)
  {
  // compute distance from tp to others
  // if less than D
  // print

  }
//====================//

  void IGC_Read(Str igc_file)
  {
//DBG"%V $igc_file \n"

  //T=fineTime()

  int fh=ofr(igc_file)

  if (fh == -1) {
     //DBG" can't open IGC file $igc_file\n"

  return 0

  }

 int ntps =0

//ntps = readIGC(fh,&IGCTIM,&IGCLAT,&IGCLONG,&IGCELE) // vec siv base

  ntps = readIGC(fh,IGCTIM,IGCLAT,IGCLONG,IGCELE) // vec siv base

  IGCELE *= 3.280839 
  
  //  IGCLONG = -1 * IGCLONG
//DBG"read $ntps from $igc_file \n"

 // dt=fineTimeSince(T)
//<<[_DB]"$_proc took $(dt/1000000.0) secs \n"

  cf(fh)

  return ntps

  }
//========================


  float ComputeTC(Turnpt wtp[],int j, int k)
  {

  //<<"$_proc %V $j $k\n"
  //wtp.pinfo()
  float km = 0.0
  float tc = 0.0
  float L1,L2,clo1,clo2
// TBF 08/28/23 translate should ignore redefine? or  delete proc vars at proc end
  
  L1 = wtp[j].Ladeg  // auto dec from definition  of Turnpt not coded

  L2 = wtp[k].Ladeg

//<<"%V $L1 $L2 \n"

  clo1 = wtp[j].Longdeg

  clo2 = wtp[k].Longdeg

//<<"%V $lo1 $lo2 \n"
//  tc = TrueCourse(L1,lo1,L2,lo2)

  tc = TrueCourse(clo1,L1,clo2,L2)

  //printargs(j, k ,L1 ,lo2 ,"tc=", tc)
//<<"%V $tc\n"


  return tc

  }
//===========================//



#endif


//==============\_(^-^)_/===EOS==============//