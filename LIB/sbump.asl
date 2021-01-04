//%*********************************************** 
//*  @script sbump.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.10 Ne Neon [asl 6.2.91 C-He-Pa]                               
//*  @date Mon Nov 30 09:30:26 2020 
//*  @cdate Sun Dec 23 09:22:34 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
  
  
  void vers2ele(str vstr)
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
  int A = -1;

comment ="";
release ="";
cdate ="";


  
  // if script found
  // then  read current vers and  bump number and update date
  // if no @vers line -- then prepend the vers header lines
  
  srcfile = _clarg[1];
  
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
  
  //<<[2]" FILE $file \n"
  
  dir= fexist(srcfile,ISDIR_,0);
  
  //<<[2]" DIR $dir \n"
  author = "Mark Terry"
  fname = srcfile
  release = "CARBON"
  
  int pmaj = 1;
  
  int pmin = 1;
  
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  
  date = date();
  
 
 
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


  release = "";

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

where->info(1)

Str T;

T->info(1)

Str Pad;

Pad->info(1)

Svar L;

L->info(1)

   for (j=0; j<15; j++) {
     T = readline(A);
     where = ftell(A)
<<"$j $where line is $T \n"

   }

     found_vers =0;

  fseek(A,0,0);

//   tsz = Caz(T)

   for (i = 0; i < 12;i++) {
   
   T = readline(A);
   
//<<[2]"$i line is $T \n"

   where = ftell(A)
   L = Split(T);
   sz = Caz(L);
// <<"sz $(caz(L)) \n"
//<<[2]"$where $i $L \n"
   if (sz >2) {
//<<[2]"L1 $L[1]\n"
    if (scmp(L[1],"@vers")) {
     found_vers =1;
     cvers = L[2];
     <<[2]"$where $cvers $L[2]\n"
   }
    else if (scmp(L[1],"@cdate")) {
     cdate = "$L[2::]";
   }
    else if (scmp(L[1],"@comment")) {
     comment = "$L[2::]";
   }
    else if (scmp(L[1],"@release")) {
      release = "$L[2::]";
   }
    else if (scmp(L[1],"@author")) {
      author = "$L[2::]";
   }         
   }
   //found_where = where;
  }
 

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
 
  date = date();
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
   min_name = ptname(pmin);



 <<[2]"///  @vers $release ${pmaj}.$pmin ${maj_ele}.$min_ele $min_name    \n"


   vers=" @vers ${pmaj}.$pmin $min_ele $min_name [asl $(getversion())]"
   vlen = slen(vers);

//   Pad = nsc(67-vlen," ")
//<<[2]"vlen $vlen <|$Pad|>\n"


where = ftell(A);

j= 0;






  fseek(A,0,0)
   <<[A]"/* \n"
   <<[A]" *  @script $fname \n"
   <<[A]" * \n"
   <<[A]" *  @comment $comment \n"
   <<[A]" *  @release $release \n"   
   <<[A]" * $vers \n"
   <<[A]" *  @date $date \n"
   <<[A]" *  @cdate $cdate \n"      
   <<[A]" *  @author $author \n"
   <<[A]" *  @Copyright © RootMeanSquare  2010,$(date(8)) → \n"           
   <<[A]" * \n"
   <<[A]" *  \\\\-----------------<v_&_v>--------------------------//  \n" ;
   <<[A]" */ \n"
   
  fflush(A);
  
   here = ftell(A);
   for (j=0; j<3; j++) {
   T = readline(A);
   

   white_out =0;
   where = ftell(A)
//<<[2]"$j $where line is $T \n"
//L = Split(T);
  if (scmp(T,"//****",5)) {
      white_out = 1;
      <<"need to clean this line $T\n";
      break;
      }
   }

  if (white_out) {
    fseek(A,here,0)
    nsp = where - here;
    for (i=0;i<nsp-1;i++) {
    <<[A]" ";
    }

   }

cf(A);

// lets' log this change 
logfile= "~/gapps/LOGS/appmods.log"
A=ofile(logfile,"r+")
fseek(A,0,2)

ans=iread("app code -what modification?:")
<<"$ans\n"
len = slen(srcfile)
Pad = nsc(24-len," ")
<<[A]"${srcfile}${Pad}${pmaj}.${pmin}\t$date $ans\n"
cf(A)





 for (i = 0; i < 3;i++) {
  //<<"$T[i]"
   ln=T[i]
  <<"$ln"  
  }  


 // so bump minor if over 100 then bump maj and min to 1
 
 
//  for (i = 4; i < tsz;i++) {
//   ln=T[i]
//  <<"$ln"
//  }




/*////////////////////////////////  TBD ///////////////////////////

    MFN fix for missing //* --- done ?








*/
