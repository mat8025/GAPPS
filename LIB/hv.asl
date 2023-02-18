//%*********************************************** 
//*  @script hv.asl 
//* 
//*  @comment parse @vers from script header 
//*  @release CARBON 
//*  @vers 1.12 Mg Magnesium [asl 6.2.91 C-He-Pa]                          
//*  @date Mon Nov 30 09:29:21 2020
//*  @cdate 12/15/2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

//  parses header creates hdr_xxx vars from @ tags in header 
//

//filterFileDebug(REJECT_,"array_");
#if CPP
#warning HV USING_CPP
#include "cppi.h"
#endif

Str H_ele = "1";
Str Hdr_script = "none";
Str Hdr_vers = "1.1";
Str Hdr_release = "CARBON";
Str Hdr_author = "mt";
Str Hdr_cdate = "1964";
Str Hdr_date = "1964";

   int hv_found =0;
   int hv_show =0;

   Str  rs = "comment ca va";

  void vers2ele(Str& vstr)
  {
  //<<"%V $vstr\n"
   int pmaj = atoi(spat(vstr,".",-1));
//   <<[2]"$pmaj $(typeof(pmaj)) $(ptsym(pmaj)) \n"  
   int pmin = atoi(spat(vstr,".",1));

//<<[2]"$pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   Str elestr = periodicName(pmin); // need CPP
   H_ele =" ";
   H_ele = spat(elestr,",");


  }
  //======================


// to work with xic code ?

 void hdrv_func()
   {
     Svar L;
     Str val;
     Str fl;
     int sz;
     int header_valid = 1;
     int wln;
     int vl;
     
     for (wln = 1; wln <= 10; wln++) {

      fl = getcodeln(wln,0);
      
  //fl = readLine(A);
     vl = fl.slen();
//<<"$vl $fl\n"

     if (header_valid  == 0) {
           break;
     }
     if (vl == 0) {
         break;
         }

//       <<"$wln <|$fl|>\n";


         L=split(fl);

         sz=Caz(L);


         if (sz >= 3) {

//	 <<"L1 <|$L[1]|> \n"

         rs = L[1];
	// rs.pinfo()

         vl=slen(rs);
//	 <<"vl $vl \n"


            if (vl > 0) {
//           <<"$wln $rs $L[1] \n"

             if (scmp(rs,"@",1)) { // first @ should be @script 

// val = spat(fl,rs,1);
//	       val.pinfo()


               if (!hv_found) {
                   // rs.pinfo();
//                   <<"$wln check $rs for @script \n";
		   
               if (scmp(rs,"@script")) {
//                <<"it is an asl script header!\n";
                    hv_found = 1;
               }
               else {
                   printf("no header found!\n");
		     header_valid = 0;
               }
             }

            //     rs.pinfo()
//		 <<"$wln $rs  $L[1] $L[2] \n"

               if (scmp(rs,"@script")) {

                    Hdr_script = L[2];
               }
                else if (scmp(rs,"@vers")) {

                  Hdr_vers = L[2];
                }
                else if (scmp(rs,"@author")) {

                  Hdr_author = scat(L[2],L[3])
                }
                else if (scmp(rs,"@release")) {

                  Hdr_release = L[2];
                }
                else if (scmp(rs,"@cdate")) {

                  Hdr_cdate = L[2];
                }
                else if (scmp(rs,"@date")) {
                  Hdr_date = scat(L[2],L[3],L[4]);
                }

                 } // scmp

 //              <<" $rs $val \n";

               } // vl

             } //sz 
         } // 

}


///////////////////////////////







   hdrv_func();

printf("Hdr_vers %s\n",Hdr_vers.cptr());

  vers2ele(Hdr_vers);

H_ele_vers = Hdr_vers;

if (hv_show) {

pa(Hdr_script);

#if ASL
<<"%V $Hdr_vers\n"
<<"%V $Hdr_release\n"
<<"%V $Hdr_author\n"
<<"%V $Hdr_date\n"
<<"%V $Hdr_cdate\n"
#endif

}

  if (hv_found) {
    ScriptVers(Hdr_vers);
 }


//printf("Done hv %s\n", Hdr_vers.cptr());
;//==============\_(^-^)_/==================//;

/////////////////////////// DEV //////////////////////////
/*
   make proc and call
   otherwise have globals
   delete any tmp? globals

TBF  11/24/21  if (rs == "@script")  - this Str comparison corrupts  memory

*/

//===***===//

