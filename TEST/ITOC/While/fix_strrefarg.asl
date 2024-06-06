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
db_ask = 0


    allowDB("ic,spe_,svar,str_,parse,pex,vmf",db_allow);



#include "debug.asl"

#include "hv.asl"

#include "fixinc.asl"


   if (_dblevel >0) {

       debugON();
     }


  chkIn(_dblevel)

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

<<"%V $the_ele $(pt(the_ele)) \n"

   k=versToEle(s)

Str Hdrvers = "1.44"

   <<"%V $k \n"
int main_ele = -1;

  main_ele =vers_ele(Hdrvers);


<<"%V $main_ele $(pt(main_ele)) \n"
<<" %V $Fixinc\n"

  main_ele =vers2ele(Hdrvers);

  main_ele.pinfo()

<<"%V $main_ele $(pt(main_ele)) \n"


   chkN(k,5)


  chkOut(1)
  