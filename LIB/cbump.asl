//%*********************************************** 
//*  @script cbump.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.7 N Nitrogen                                               
//*  @date Tue Jan  1 09:18:09 2019 
//*  @cdate Sun Dec 23 09:22:34 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%


 
  
  
  proc vers2ele( vstr)
  {
  
   pmaj = atoi(spat(vstr,"."))
   pmin = atoi(spat(vstr,".",1))
  <<[2]"%V $pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   elestr = pt(pmin);
   str ele =" ";
   ele = spat(elestr,",")
  //<<"$ele $(typeof(ele))\n";
  //<<"$ele";
   return ele;
   
  }
  //======================
  A=-1;
  
  
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
  <<[2]"can't find script file $srcfile\n"
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
  
  
  
  
  file= fexist(srcfile,ISFILE_,0);
  
  //<<[2]" FILE $file \n"
  
  dir= fexist(srcfile,ISDIR_,0);
  
  //<<[2]" DIR $dir \n"
  Author = "Mark Terry"
  fname = srcfile
  release = "CARBON"
  pmaj = 1;
  pmin = 1;
  
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  
  date = date();
  
 
 
  len = slen(fname);
  
  ind = (80-len)/2;
  //<<[2]"$(date()) $(date(8)) \n"
  //<<[2]" $len $ind\n"
  insp = nsc((60-len)/2," ")
  len= slen(insp)
  //<<[2]"$len <|$insp|> \n"
  sp="\n"
  //<<[2]" $(nsc(5,sp))\n"
  
  //<<[2]" $(nsc(5,\"\\n\"))\n"


  release = "";

  A=ofile(srcfile,"r+")
  //T=readfile(A);
 //<<[2]"opened for read/write? $A\n"
  if (A == -1) {
<<"bad file ?\n"
   exit()
  }
  //<<"nlines ? $tsz\n"
  cvers = "1.1"
  //<<"%(1,,,)$T\n"
  found_vers =0;



  fseek(A,0,0);

//tsz = Caz(T)
   for (i = 0; i < 8;i++) {
   T = readline(A);
   where = ftell(A)
   L = Split(T);
   if (scmp(L[1],"@vers")) {
     found_vers =1;
     cvers = L[2];
     //<<[2]"$where $T\n"
     break;
   }
   found_where = where;
  }
 
 
 if (found_vers) {
 
 nele = vers2ele(cvers)
 <<[2]"found_vers $cvers $nele\n"
 }
 else {
 <<" does not have vers number in header\n")
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
   <<"$pmaj $pmin\n"   
   if (pmaj > 103) {
 <<" need a new major release current \n"
   exit();
   }
 }
 
  date = date();
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  min_name = ptname(pmin);



   fseek(A,found_where,0)

   vers="    @vers ${pmaj}.$pmin $min_ele $min_name "
   vlen = slen(vers);
   pad = nsc(69-vlen," ")
<<[A]"//$vers $pad"
seekline(A,1)
<<[A]"//    @date $date"   


// <<[A]" ??? \n"

//  fseek(A,0,0)

//<<[A],"new line \n"

  fflush(A);
  

cf(A);
// used for asl bump version -- no interaction!

// lets' log this change 
logfile= "~gapps/LOGS/aslcodemods.log"
A=ofile(logfile,"r+")
fseek(A,0,2)

ans=iread("asl code-what modification?:")
<<"$ans\n"
<<[A]"$srcfile\t ${pmaj}.$pmin\t $date $ans\n"
cf(A)


exit()

