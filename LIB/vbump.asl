/* 
 *  @script vbump.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.9 F 6.3.79 C-Li-Au 
 *  @date 02/02/2022 12:55:03          
 *  @cdate Sun Dec 23 09:22:34 2018 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare 2022
 * 
 */ 
//----------------<v_&_v>-------------------------//;

  //ignoreErrors();

  setmaxcodeerrors(-1); // just keep going;
  setmaxicerrors(-1);

  DBH_ = -1
  
  Str VersToele(Str& vstr)
  {
  
   pmaj = atoi(spat(vstr,"."))
   pmin = atoi(spat(vstr,".",1))
  <<[DBH_]"%V $pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin)) \n"
   elestr = pt(pmin);
   str ele =" ";
   ele = spat(elestr,",")
  //<<"$ele $(typeof(ele))\n";
 // <<"$ele";
   return ele;
   
  }
  //======================
  A= -1;
<<[DBH_]" trying vbump !\n"
  
  // if script found
  // then  read current vers and  bump number and update date
  // if no @vers line -- then prepend the vers header lines
  
  srcfile = _clarg[1];
  <<[DBH_]"$srcfile \n"

  if (srcfile == "") {
  <<[DBH_]"no script file entered\n"
    exit();
  }
  
  sz= fexist(srcfile,RW_,0);
  
  <<[DBH_]" RW sz $sz \n"

  !!"cp $srcfile ${srcfile}.bak"

  if (sz == -1) {
  <<[DBH_]"can't find script file $srcfile\n"
    exit();
  }
  
  set_vers = 0;
  na = argc();
   
  if (na > 2) {
   set_vers = 1;
   new_vers = _clarg[2];
   <<[DBH_]"%V $new_vers\n"
  // should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100  
  }
  
  
  
  
  file= fexist(srcfile,ISFILE_,0);
  
  <<[DBH_]" FILE $file \n"
  
  dir= fexist(srcfile,ISDIR_,0);
  
  //<<[DBH_]" DIR $dir \n"
  Author = "Mark Terry"
  fname = srcfile
  release = "BORON"
  pmaj = 1;
  pmin = 1;
  
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  
  date = date(GS_MDYHMS_);
 
 
  len = slen(fname);
  
  ind = (80-len)/2;
  //<<[DBH_]"$(date()) $(date(8)) \n"
  //<<[DBH_]" $len $ind\n"
  insp = nsc((60-len)/2," ")
  len= slen(insp)
  //<<[DBH_]"$len <|$insp|> \n"
  sp="\n"
  //<<[DBH_]" $(nsc(5,sp))\n"
  
  //<<[DBH_]" $(nsc(5,\"\\n\"))\n"


 

  A=ofile(srcfile,"r+")
  //T=readfile(A);
 //<<[DBH_]"opened for read/write? $A\n"
  if (A == -1) {
<<[DBH_]"bad file ?\n"
   exit()
  }
  //<<"nlines ? $tsz\n"
  cvers = "1.1"
  //<<"%(1,,,)$T\n"
  
 Str comment ="xxx";
 long where;


 Str T;


 Str Pad;

 Svar L;


  found_vers =0;

cd  fseek(A,0,0);

//   tsz = Caz(T)
   i = 0;

Str old_comment ="yyy"
   allowDB("spe,opera,ic",1)
   while (1) {

    T = readline(A);
   
<<[DBH_]"[$i] line is $T \n"
   if (i ==2) {
     old_comment =T;
   }
   where = ftell(A)
//     L[0:-1:1] = "";
      L.clear(0)
     L.Split(T);
   sz = Caz(L);

// <<"sz $(caz(L)) \n"
//<<[DBH_]"$i $sz $where  $L \n"
   if (sz >2) {
<<[DBH_]"L1 $L[1]\n"

    if (scmp(L[1],"@vers")) {
     found_vers =1;
     cvers = L[2];
     <<[DBH_]"VERS $where $cvers $L[2]\n"
     //q=iread("?")
   }
    else if (scmp(L[1],"@cdate")) {
     cdate = "$L[2:-1:1]";
//<<"found cdate  $L\n"     
<<[DBH_]"%V$cdate  $L[2]\n"     
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
   i++;
  // <<" testing%V $i\n"
   if (i > 17) {
<<[DBH_]"$i not an C header\n"
    found_vers = 0;
    break;
   }


    if (spat(L[0],"///////<v_&_v>//") != "") {
<<[DBH_]"@header end? line $i\n"
      break;
    }
    ans=ask("$L[0] ?",0)
}

   where = ftell(A);

do_old = 0;

if (do_old) {
<<[DBH_]"oldc $old_comment\n"
   L.Split(old_comment);
   sz = Caz(L);
<<[DBH_]"$sz $L[0]  $L[1] $L[2]\n"
   if (L[1] != "") {

    comment = "$L[1::]";
<<[DBH_]"update comment $L[1] $comment\n"
   }
}


Str new_ele = "1.1"

if (found_vers) {
 
  new_ele = VersToele(cvers)
// nele = 7;

<<[DBH_]"found_vers $new_ele $cvers \n"

 }
 else {
 <<[DBH_]" does not have vers number in header\n";
 exit();
 }

 if (set_vers) {
 // set to _clarg[2] - if correct format
    new_ele= VersToele(new_vers)
 }
 else {

    pmin++;
   
   if (pmin > 100) {
       pmin =1;
       pmaj++;
   }
   <<[DBH_]"bumped to major $pmaj minor $pmin\n"
   if (pmaj > 100) {
 <<[DBH_]" need a new major release current \n"
   exit();
   }
 }
 
  date = date(GS_MDYHMS_);
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  min_name = ptname(pmin);


   avers = getversion();

<<[DBH_]"getversion  $avers\n"

 <<[DBH_]"///  @vers $release ${pmaj}.$pmin ${maj_ele}.$min_ele $min_name $avers   \n"

   vers=" @vers ${pmaj}.$pmin $min_ele  $avers "
   vlen = slen(vers);


<<[DBH_]"vlen $vlen <|$Pad|>\n"

 fseek(A,0,0);


<<[A]"/*//////////////////////////////////<**|**>///////////////////////////////////\n"
<<[A]"//$insp $fname \n"
<<[A]"//		          \n"
<<[A]"//    @comment  $comment \n"
<<[A]"//    @release   $release  \n"
<<[A]"//   $vers \n"
<<[A]"//    @date $date    \n"
<<[A]"//    @cdate $cdate    \n"              
<<[A]"//    @author: $Author                                  \n"
<<[A]"//    @Copyright   RootMeanSquare - 1990,$(date(8)) --> \n"                 
<<[A]"//  \n"
<<[A]"// ^.  .^ \n"
<<[A]"//  ( ^ ) \n"
<<[A]"//    - \n"
<<[A]"///////////////////////////////////<v_&_v>//////////////////////////////////*/ \n"
<<[A]"\n"


  here = ftell(A);
     Pad = nsc(where-here-2," ")
   <<[A]"$Pad\n";  
 
    fflush(A);
  
cf(A);


exit(0)

