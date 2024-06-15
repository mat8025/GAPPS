/* 
 *  @script fixrefasl 
 * 
 *  @comment tests While syntax 
 *  @release CARBON 
 *  @vers 1.6 C Carbon [asl 6.3.58 C-Li-Ce] 
 *  @date 11/09/2021 14:47:53          
 *  @cdate Sat Apr 18 21:48:17 2020 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 



db_allow = 1
db_ask = 1


    allowDB("ic,spe_,svar,str_,parse,pex,vmf",db_allow);



#include "debug.asl"

#include "hv.asl"

#include "fixinc.asl"


   if (_dblevel >0) {

       debugON();
     }


  chkIn()



  int vers2eleM(Str& vstr)
  {
  <<"%V $vstr\n"
   int pmaj = atoi( spat(vstr,".",-1));
<<[2]"$pmaj $(typeof(pmaj)) $(ptsym(pmaj)) \n"  
   int pmin = atoi(spat(vstr,".",1));

<<"$pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   Str elestr = periodicName(pmin); // need CPP
   H_ele =" ";
   H_ele = spat(elestr,",");

   return pmin;
  }
  //======================



  int vers_ele(str& vstr)
  {
  //<<"%V $vstr\n"
   int Pmaj = atoi(spat(vstr,".",-1));

   int pmin = atoi(spat(vstr,".",1));

//<<[2]"$pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   Str elestr = periodicName(pmin); // need CPP
   H_ele =" ";
   H_ele = spat(elestr,",");

   return pmin;
  }
  //======================




int versToEle(Str& vstr)
  {


   vstr.pinfo()
   
   len = vstr.slen()

<<"%V $vstr $len\n"

   return len;
  }
  //======================



  Str s = "howdy"

  the_ele = 1

<<"%V $the_ele $(pt(the_ele)) \n"

   k=versToEle(s)

  chkN(k,5)

Str Hdrvers = "1.44"

   <<"%V $k \n"
int main_ele = -1;

  main_ele =vers_ele(Hdrvers);

chkN(main_ele,44)

<<"%V $main_ele $(pt(main_ele)) \n"
<<" %V $Fixinc\n"

  main_ele =vers2ele(Hdrvers);

  chkN(main_ele,44)
  
  main_ele.pinfo()

<<"%V $main_ele $(pt(main_ele)) \n"


  main_ele =vers2eleM(Hdrvers);

  chkN(main_ele,44)
  
  main_ele.pinfo()

<<"%V $main_ele $(pt(main_ele)) \n"


   hdrv_func();

  chkOut(1)


/////////////////////////////////////////
//
//   OK what was the fix?
//   unknown  proc/class args
//   fix   for ds_sivflags printing svar fields -- check for null field
//    can occur if Narg/size wrong or if fields have been NULL terminated
//
//////////////////////////////////////