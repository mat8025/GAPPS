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

   ;//------------------------------//;
//  parses header creates hdr_xxx vars from @ tags in header 
//

//filterFileDebug(REJECT_,"array_");

  void vers2ele(str vstr)
  {
  //<<"%V $vstr\n"
   pmaj = atoi(spat(vstr,".",-1))
//   <<[2]"$pmaj $(typeof(pmaj)) $(ptsym(pmaj)) \n"  
   pmin = atoi(spat(vstr,".",1))

//<<[2]"$pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   elestr = pt(pmin);
   _ele =" ";
   _ele = spat(elestr,",")
//  <<"$ele $(typeof(_ele))\n";
//  <<"$ele\n";

  }
  //======================

str _ele = "1";

str hdr_script = "none";
str hdr_vers = "1.1"
str hdr_release = "CARBON";
str hdr_author = "mt";
str hdr_cdate = "1964"
str hdr_date = "1964"

   int hv_found =0;
      int hv_show =0;


    str  rs = "comment ca va"

// to work with xic code ?

 void hdrv_func()
   {
     Svar L;
     Str val;
     Str fl;
     int sz;
     int header_valid = 1;

     for (wln = 1; wln <= 10; wln++) {

      fl = getcodeln(wln,0);
  //fl = readLine(A);
  vl = slen(fl)
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
	        //  if (!(rs == "@script")) 
		  

		//   rs.pinfo()
//                <<"it is an asl script header!\n";
                    hv_found = 1;
               }
               else {
                   <<"no header found!\n";
		     header_valid = 0;
               }
             }

            //     rs.pinfo()
//		 <<"$wln $rs  $L[1] $L[2] \n"


               if (scmp(rs,"@script")) {

                    hdr_script = L[2]
               }
                else if (scmp(rs,"@vers")) {

                  hdr_vers = L[2]
                }
                else if (scmp(rs,"@author")) {

                  hdr_author = scat(L[2],L[3])
                }
                else if (scmp(rs,"@release")) {

                  hdr_release = L[2]
                }
                else if (scmp(rs,"@cdate")) {

                  hdr_cdate = L[2]
                }
                else if (scmp(rs,"@date")) {
                  hdr_date = scat(L[2],L[3],L[4]);
                }
/*
                if (rs == "@script") {

                  hdr_script = L[2]
                }


                else if (rs == "@vers") {

                  hdr_vers = L[2]
                }
                else if (rs == "@author") {

                  hdr_author = L[2]
                }
                else if (rs == "@release") {

                  hdr_release = L[2]
                }
                else if (rs == "@cdate") {

                  hdr_cdate = L[2]
                }
                else if (rs == "@date") {
<<"got date $L[2]\n"
                  hdr_date = scat(L[2],L[3],[4]);
		  
                }								
*/

                 } // scmp

 //              <<" $rs $val \n";

               } // vl

             } //sz 
         } // 

}


///////////////////////////////







   hdrv_func();

  vers2ele(hdr_vers)

_ele_vers = hdr_vers;

if (hv_show) {
<<"%V $hdr_script\n"

<<"%V $hdr_vers\n"

<<"%V $hdr_release\n"

<<"%V $hdr_author\n"

<<"%V $hdr_date\n"

<<"%V $hdr_cdate\n"
}
if (hv_found) {
 ScriptVers(hdr_vers);
}


<<"Done hv\n"
;//==============\_(^-^)_/==================//;

/////////////////////////// DEV //////////////////////////
/*
   make proc and call
   otherwise have globals
   delete any tmp? globals

TBF  11/24/21  if (rs == "@script")  - this str comparison corrupts  memory

*/

//===***===//

/*
                 // if (!(rs == "@script")) 
		  //if (!(rs == "script")) 
		 //  if (!(rso == "script"))
		 
		   if (!(scmp(rso,"script"))) {

                    <<"@ is $rs\n"
                  
                     // break;  // crash  ?? 
                   }
          //  val.pinfo()
	   <<" que pasa?\n"
 */              
