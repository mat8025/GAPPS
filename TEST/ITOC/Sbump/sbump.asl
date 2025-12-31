/* 
 *  @script sbump.asl                                                         
 * 
 *  @comment the script date&vers      *                                      
 *  @release Carbon                                                           
 *  @vers 1.17 Cl Chlorine [asl 6.65 : C Tb]                                  
 *  @date 12/30/2025 10:46:43                                                 
 *  @cdate Sun Dec 23 09:22:34 2018    *                                      
 *  @author Mark Terry                                                        
 *  @Copyright © RootMeanSquare 2025 -->                                     
 * 
 */ 



//----------------<v_&_v>-------------------------//



                    

  
int DBH_ = 2
/*
#include "debug"


if (_dblevel >0) {
  debugON()
}

<<"update asl script version \n" ;

*/  
  // if script found
  // then  read current vers and  bump number and update date
  // if no @vers line -- then prepend the vers header lines


  void vers2ele(Str& vstr)
  {
  //<<"%V $vstr\n"
   pmaj = atoi(spat(vstr,".",-1))
   <<[DBH_]"$pmaj $(typeof(pmaj)) $(ptsym(pmaj)) \n"  
   pmin = atoi(spat(vstr,".",1))

//<<[DBH_]"$pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   elestr = pt(pmin);
   str ele =" ";
   ele = spat(elestr,",")
  <<"$ele $(typeof(ele))\n";
  <<"$ele\n";
   //return ele;
  }
  //======================

  Str padHdr(Str ln)
  {
    Str pad;
    Str hl = ln;
    Str wl;
    static Str sel = "xxxxxxxxxx"
 //   <<[DBH_]"$ln\n"
    ll = slen(ln)
 //   <<"%V $ll\n"
   pad = nsc(70- ll," ")


 // <<"$hl $pad end\n"
   //<<[A]"$hl $pad\n"
 //   pl = "$hl $pad"

//<<"%V $pl\n"
    sel = "$hl    $ll   "
//<<"%V $sel\n"
    sel = "$hl    $pad   "
//<<"%V $sel\n"
    wl = "$hl    $ll   "
    wl.pinfo()
    wl = "$hl    $pad   "
  //  ask("$wl ")

  return sel;
 }
/////////////////////////////////////////////



   Str srcfile = _clarg[1];

   len = slen(srcfile);

<<"$len $srcfile|\n"

  ignoreErrors();

  int A = -1;

Str comment ="";
Str release ="xyz";
Str cdate ="";




  if (srcfile == "") {
  <<[DBH_]"no script file entered\n"
    exit();
  }
  
  sz= fexist(srcfile,RW_,0);
  
  //<<[DBH_]" RW sz $sz \n"
  
  if (sz == -1) {
  <<[DBH_]"can't find script file $srcfile\n";
    exit(-1);
  }

pid=getpid()

<<[DBH_]"make a bakup ${srcfile}.${pid}.bak \n"

  !!"cp $srcfile  ${srcfile}.${pid}.bak"
////////////////////////////////////////


  set_vers = 0;
  na = argc();
   
  if (na > 2) {
   set_vers = 1;
   new_vers = _clarg[2];
   <<[DBH_]"%V $new_vers\n"
  // should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100  
  }
  
Str cvers ="0.0";  
  
  
  file= fexist(srcfile,ISFILE_,0);
  
  <<[DBH_]" FILE $file \n"
  
  dir= fexist(srcfile,ISDIR_,0);
  
  <<[DBH_]" DIR $dir \n"

 if (dir) {

 <<[DBH_]"error $srcfile is DIR! \n"
}


  author = "Mark Terry"
  fname = srcfile



  
  
  int pmaj = 1;
  
  int pmin = 1;
  
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  
  date = date(GS_MDYHMS_);
   
  len = slen(fname);
  
  ind = (80-len)/2;
  <<[DBH_]"$(date()) $(date(8)) \n"
  <<[DBH_]" $len $ind\n"
  insp = nsc((60-len)/2," ")
  len= slen(insp)
  //<<[DBH_]"$len <|$insp|> \n"
  sp="\n"
  //<<[DBH_]" $(nsc(5,sp))\n"
  
  //<<[DBH_]" $(nsc(5,\"\\n\"))\n"




  TR = Split(split(getversion()),".")



  release = ptname(TR[0]);





  A=ofile(srcfile,"r+")
  //T=readfile(A);
 <<[DBH_]"opened for read/write? $A\n"
  if (A == -1) {
<<"bad file ?\n"
   exit()
  }
  //<<"nlines ? $tsz\n"
  cvers = "1.1"
  //<<"%(1,,,)$T\n"
  found_vers =0;

long where;

where.pinfo()

Str T;

T.pinfo()

Str Pad;



Svar L;

   L.pinfo()


   found_vers =0;

   fseek(A,0,0);

//   tsz = Caz(T)
   i = 0;
   int hwi;
   while (1) {

    T = readline(A,-1,1);

  
   
<<[DBH_]"$i line is <||$T||> \n"

  // L.clear()
//ans = ask("line OK? L.clear()",1)   
 //  L.vfree();

//ans = ask("line OK? L.vfree()",1)
//if (ans == "q") exit()

   L.clear(0)
   where = ftell(A)
   L.Split(T);

 //  hwi= Chi(L);
   


   sz = Caz(L);
<<[DBH_] "%V $sz $(caz(L)) $hwi \n"


<<[DBH_]"$i $sz $where  $L \n"
   
<<[DBH_]"L1 $L[1]  $L[:-1:]\n"

    if (scmp(L[1],"@vers")) {
     found_vers =1;
     cvers = L[2];
     <<[DBH_]"$where $cvers $L[2]\n"
   }
    else if (scmp(L[1],"@cdate")) {
     
<<"found cdate  $L\n"     
<<[DBH_]"cdate <|$cdate|>  $L[2]\n"     
    cdate = "$L[2:hwi:]";
   }
    else if (scmp(L[1],"@comment")) {
     comment = "$L[2:hwi:]";
   }
  //  else if (scmp(L[1],"@release")) {
      //release = "$L[2::]";
  //    release = "$L[2]";
//<<[2]"release: <|$release|>  $L[2]\n"           
 //  }
    else if (scmp(L[1],"@author")) {
      author = "$L[2:-1:1]";
   }
   
   
   
   //found_where = where;
   i++;
   if (i >16) {
<<[DBH_]"not an sheader\n"
    found_vers = 0;
    break;
   }

    if (scmp(L[0],"//****",6)) {

      <<[2]"old header end? line $i\n"


      break;
    }



    if (scmp(L[0],"*/",2)) {
<<[DBH_]"header end? line $i\n"
    // check for new
        T = readline(A);
        L.Split(T);
       if (scmp(L[0],";//-",4)) {
      <<[DBH_]" <|$T|>\n"       
      <<[DBH_]"new header end? line $i\n"
       }
       else {
         // step back
	 fseek(A,where,0);
       }
    break;
    }

}
 
  where = ftell(A);

<<" end of current header is $where \n";

B=ofw("body");

int kl = 1;
  while (1) {
         T = readline(A);

         <<[B]"$T";
	 <<"$T"
//ans=query("? $kl  ")	 
	 if (feof(A)) {
	     break;
	 }
	 kl++;
  }

  cf(B);
  
<<"wrote $kl lines to body\n"


 if (found_vers) {
 
  vers2ele(cvers)
// nele = 7;

<<[DBH_]"found_vers $cvers \n"
 }
 else {
 <<[2]" does not have vers number in header\n";
 exit();
 }





 if (set_vers) {
 // set to _clarg[2] - if correct format
  vers2ele(new_vers)
 }
 else {

    pmin++;
   
   if (pmin > 100) {
       pmin =1;
       pmaj++;
   }
   <<[DBH_]"bumped to $pmaj $pmin\n"
   if (pmaj > 100) {
 <<" need a new major release current \n"
   exit();
   }
 }
 
  date = date(GS_MDYHMS_);
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  min_name = ptname(pmin);



 <<[DBH_]"///  @vers $release ${pmaj}.$pmin ${maj_ele}.$min_ele $min_name    \n"


   vers=" @vers ${pmaj}.$pmin $min_ele $min_name [asl $(getversion())]"
//   vers=" @vers ${pmaj}.$pmin $min_ele $(getversion())"
   vlen = slen(vers);

  
//<<[2]"vlen $vlen <|$Pad|>\n"


int nsp = 0;
j= 0;




cf(A);
   

 A=ofw("hdr_tmp");

    fseek(A,0,0)

// all lines shold be padded out to 70
    hl="xxx";
   padHdr(" *  @script $fname ")

   <<[A]"/* \n"
   hl=padHdr(" *  @script $fname ")
   <<[A]"$hl\n"
   <<[A]" * \n"
   hl=padHdr(" *  @comment $comment ");
   <<[A]"$hl\n"
   hl=padHdr(" *  @release $release ");
   <<[A]"$hl\n"
   hl=padHdr(" * $vers ");
   <<[A]"$hl\n"
   hl=padHdr(" *  @date $date ")
   <<[A]"$hl\n"
   hl=padHdr(" *  @cdate $cdate ")
   <<[A]"$hl\n"
   hl=padHdr(" *  @author $author ");
   <<[A]"$hl\n"
   hl=padHdr(" *  @Copyright © RootMeanSquare $(date(8)) -->");           
   <<[A]"$hl\n"
   <<[A]" * \n"
   <<[A]" */ \n"
   <<[A]"\n";
     here = ftell(A);
<<[2]"%V $where $here  \n"
    if (where > here) {
     Pad = nsc(where-here-2," ")
    <<[A]"$Pad\n";  
    }
    fflush(A);
  
 

<<[DBH_]"%V$where $here\n"


cf(A);



ans=iread("app code -what modification?:",1)
<<"$ans\n"
if (ans =="q") exit()
   
log_it = 1;

if (log_it) {
// lets' log this change 
logfile= "~/GAPPS/LOGS/appmods.log"
//logfile= "LOGS/appmods.log"
A=ofile(logfile,"r+")
fseek(A,0,2)


len = slen(srcfile)
Pad = nsc(24-len," ")
<<[A]"${srcfile}${Pad}${pmaj}.${pmin}\t$date $ans\n"
cf(A)
}




 for (i = 0; i < 3;i++) {
  //<<"$T[i]"
   ln=T[i]
  <<"$ln"  
  }  


 // so bump minor if over 100 then bump maj and min to 1
 
!!"cat hdr_tmp body > $srcfile"


/*////////////////////////////////  TBD ///////////////////////////

    MFN fix for missing //* --- done ?








*/

