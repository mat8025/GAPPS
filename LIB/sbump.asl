/* 
 *  @script sbump.asl                                                   
 * 
 *  @comment update the script date&vers                                
 *  @release Beryllium                                                  
 *  @vers 1.14 Si Silicon [asl 6.4.34 C-Be-Se]                          
 *  @date 06/21/2022 07:03:49                                           
 *  @cdate Sun Dec 23 09:22:34 2018                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  


                    

  
Str Use_ = "update asl script version" ;

#include "debug"


if (_dblevel >0) {
  debugON()
    <<"$Use_\n"   
}

 ignoreErrors();


  void vers2ele(Str& vstr)
  {
  //<<"%V $vstr\n"
   pmaj = atoi(spat(vstr,".",-1))
   <<[2]"$pmaj $(typeof(pmaj)) $(ptsym(pmaj)) \n"  
   pmin = atoi(spat(vstr,".",1))

//<<[2]"$pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   elestr = pt(pmin);
   str ele =" ";
   ele = spat(elestr,",")
  <<"$ele $(typeof(ele))\n";
  <<"$ele\n";
   //return ele;
  }
  //======================

  void padHdr(Str ln)
  {
    Str pad;
    Str hl = ln;
 //   <<[2]"$ln\n"
    pad = nsc(70- slen(ln)," ")
  //  <<[2]"$hl $pad\n"
   <<[A]"$hl $pad\n"
   }

  int A = -1;

Str comment ="";
Str release ="xyz";
Str cdate ="";


  
  // if script found
  // then  read current vers and  bump number and update date
  // if no @vers line -- then prepend the vers header lines
  
   Str srcfile = _clarg[1];

   len = slen(srcfile);

<<"$len $srcfile|\n"


  if (srcfile @= "") {
  <<[2]"no script file entered\n"
    exit();
  }
  
  sz= fexist(srcfile,RW_,0);
  
  //<<[2]" RW sz $sz \n"
  
  if (sz == -1) {
  <<[2]"can't find script file $srcfile\n";
    exit();
  }

pid=getpid()

<<[2]"make a bakup ${srcfile}.${pid}.bak \n"

!!"cp $srcfile  ${srcfile}.${pid}.bak"



  set_vers = 0;
  na = argc();
   
  if (na > 2) {
   set_vers = 1;
   new_vers = _clarg[2];
   <<[2]"%V $new_vers\n"
  // should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100  
  }
  
Str cvers ="0.0";  
  
  
  file= fexist(srcfile,ISFILE_,0);
  
  <<[2]" FILE $file \n"
  
  dir= fexist(srcfile,ISDIR_,0);
  
  <<[2]" DIR $dir \n"

 if (dir) {

 <<[2]"error $srcfile is DIR! \n"
}



  author = "Mark Terry"
  fname = srcfile


  release = "CARBON"
  
  int pmaj = 1;
  
  int pmin = 1;
  
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  
  date = date(GS_MDYHMS_);
   
  len = slen(fname);
  
  ind = (80-len)/2;
  <<[2]"$(date()) $(date(8)) \n"
  <<[2]" $len $ind\n"
  insp = nsc((60-len)/2," ")
  len= slen(insp)
  //<<[2]"$len <|$insp|> \n"
  sp="\n"
  //<<[2]" $(nsc(5,sp))\n"
  
  //<<[2]" $(nsc(5,\"\\n\"))\n"


  TR = Split(split(getversion()),".")

  release = ptname(TR[1]);


  A=ofile(srcfile,"r+")
  //T=readfile(A);
 <<[2]"opened for read/write? $A\n"
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
   
   while (1) {

    T = readline(A);
    
   
//<<[2]"$i line is $T \n"
// L.clear()
   L.vfree();


   where = ftell(A)
   L.Split(T);
   sz = Caz(L);
<<[2] "sz $(caz(L)) \n"
<<[2]"$i $sz $where  $L \n"
   if (sz >2) {
<<[2]"L1 $L[1]  $L[::]\n"

    if (scmp(L[1],"@vers")) {
     found_vers =1;
     cvers = L[2];
     <<[2]"$where $cvers $L[2]\n"
   }
    else if (scmp(L[1],"@cdate")) {
     cdate = "$L[2::]";
<<"found cdate  $L\n"     
<<[2]"cdate <|$cdate|>  $L[2]\n"     
   }
    else if (scmp(L[1],"@comment")) {
     comment = "$L[2::]";
   }
  //  else if (scmp(L[1],"@release")) {
      //release = "$L[2::]";
  //    release = "$L[2]";
//<<[2]"release: <|$release|>  $L[2]\n"           
 //  }
    else if (scmp(L[1],"@author")) {
      author = "$L[2::]";
   }
   
   }
   
   //found_where = where;
   i++;
   if (i >16) {
<<[2]"not an sheader\n"
    found_vers = 0;
    break;
   }

    if (scmp(L[0],"//****",6)) {

      <<[2]"old header end? line $i\n"


      break;
    }



    if (scmp(L[0],"*/",2)) {
<<[2]"header end? line $i\n"
    // check for new
        T = readline(A);
        L.Split(T);
       if (scmp(L[0],";//-",4)) {
      <<[2]" <|$T|>\n"       
      <<[2]"new header end? line $i\n"
       }
       else {
         // step back
	 fseek(A,where,0);
       }
    break;
    }

}
 
  where = ftell(A);

<<[2]" end of current header is $where \n";

B=ofw("body");

  while (1) {
         T = readline(A);
	 <<[B]"$T";
	 if (feof(A))
	 break;
  }

  cf(B);
  



 if (found_vers) {
 
  vers2ele(cvers)
// nele = 7;

<<[2]"found_vers $cvers \n"
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
   <<[2]"bumped to $pmaj $pmin\n"
   if (pmaj > 100) {
 <<" need a new major release current \n"
   exit();
   }
 }
 
  date = date(GS_MDYHMS_);
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  min_name = ptname(pmin);



 <<[2]"///  @vers $release ${pmaj}.$pmin ${maj_ele}.$min_ele $min_name    \n"


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
Str hl="xxx";

   <<[A]"/* \n"
   padHdr(" *  @script $fname ")
   <<[A]" * \n"
   padHdr(" *  @comment $comment ");
   padHdr(" *  @release $release ");
   padHdr(" * $vers ");
   padHdr(" *  @date $date ")
   padHdr(" *  @cdate $cdate ")
   padHdr(" *  @author $author ");
   padHdr(" *  @Copyright © RootMeanSquare $(date(8)) -->");           
   <<[A]" * \n"
   <<[A]" */ \n"
   padHdr(";//----------------<v_&_v>-------------------------//;") ;
   <<[A]"\n";
     here = ftell(A);
<<[2]"%V $where $here  \n"
    if (where > here) {
     Pad = nsc(where-here-2," ")
    <<[A]"$Pad\n";  
    }
    fflush(A);
  
 

<<[2]"%V$where $here\n"


cf(A);



ans=iread("app code -what modification?:")
<<"$ans\n"

log_it = 1;

if (log_it) {
// lets' log this change 
logfile= "~/gapps/LOGS/appmods.log"
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
