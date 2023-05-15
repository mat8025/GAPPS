/* 
 *  @script cbump.asl 
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
;//----------------<v_&_v>-------------------------//;                              




//  Str Vers2ele(Str& vstr)  4/29/23  ref proc arg broke
//  arg passing type name !

 Str Vers2ele(Str& vstr)  
  {
  
   pmaj = atoi(spat(vstr,"."))
   pmin = atoi(spat(vstr,".",1))



  <<" $pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"



   elestr = pt(pmin);
   Str ele =" ";
   ele = spat(elestr,",")
  //<<"$ele $(typeof(ele))\n";


   return ele;
   
  }
  //======================
 int  A=-1;


 // ? read the entire file into an Svar
 // write the new hdr into a new file
 // skip/delete from the Svar the old
 // then append the Svar to the new
 // make the old a bak
 // mv the new to overwrite the original 
  
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

  !!"cp $srcfile ${srcfile}.bak"

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
  release = "Beryllium"
  pmaj = 1;
  pmin = 1;
  
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  
  date = date(GS_MDYHMS_);
  
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

  TR = Split(split(getversion()),".")

  release = ptname(TR[1]);

  B= ofile(srcfile,"r")
  Svar X;
  X=readfile(B);
  cf(B);
  
  fsz= X.getSize();

<<"%V$fsz\n"

<<"$X\n"


  for (i= 20; i < 30; i++) {
<<"$i $X[i]\n"
  }


  A=ofile(srcfile,"r");
  //T=readfile(A);
 //<<[2]"opened for read/write? $A\n"
  if (A == -1) {
<<"bad file ?\n"
   exit()
  }
  //<<"nlines ? $tsz\n"
  cvers = "1.1"
  //<<"%(1,,,)$T\n"
  
Str comment ="xxx";
long where;

where.pinfo()


Str T;

T.pinfo();

Str Pad;

Svar L;

 L.pinfo()




  found_vers =0;



  fseek(A,0,0);

//   tsz = Caz(T)
   i = 0;

Str old_comment ="yyy"
   
   while (1) {

    T = readline(A);
   
<<[2]"$i line is $T \n"
   if (i ==2) {
     old_comment =T;
   }
   where = ftell(A)

   sz = Caz(L);
<<"Lsz $sz\n"

 //   L[0:-1:1] = ""; // this is Svar clear fields

//<<"clear L $L\n"

   L.Split(T);
   sz = Caz(L);
// <<"sz $(caz(L)) \n"
//<<[2]"$i $sz $where  $L \n"
   if (sz >2) {
<<[2]"L1 $L[1]\n"

    if (scmp(L[1],"@vers")) {
     found_vers =1;
     cvers = L[2];
     <<[2]"$where $cvers $L[2]\n"
   }
    else if (scmp(L[1],"@cdate")) {
     cdate = "$L[2:-1:1]";

<<"found cdate  $L\n"     
<<[2]"%V$cdate  $L[2]\n"     
   }
    else if (scmp(L[1],"@comment")) {
     comment = "$L[2::]";
   }
 //   else if (scmp(L[1],"@release")) {
 //     release = "$L[2::]";
//<<"release line <|$release|>\n"      
//   }
    else if (scmp(L[1],"@author")) {
      author = "$L[2::]";
   }
   
   }
   
   //found_where = where;
   i++;
   if (i >17) {
<<[2]"not an C header\n"
    found_vers = 0;
    break;
   }


    if (spat(L[0],"///////<v_&_v>//") != "") {

<<"@header end? line $i so break\n"

<<"breaking \n";
      break;
    }

}

   where = ftell(A);

<<"%V $found_vers $where \n"

   int end_ln = i;
/*
<<"oldc $old_comment\n"
   L.Split(old_comment);
   sz = Caz(L);
<<"$sz $L[0]  $L[1] $L[2]\n"
   if (L[1] != "") {

    comment = "$L[1::]";
<<"update comment $L[1] $comment\n"
   }
*/

if (found_vers) {
 
  Vers2ele(cvers)
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


   vers=" @vers ${pmaj}.$pmin $min_ele $min_name $(getversion())"
   vlen = slen(vers);


<<[2]"vlen $vlen <|$Pad|>\n"

 fseek(A,0,0);

  cf(A);

A=ofile(srcfile,"w")


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



  here = ftell(A);

//Pad = nsc(where-here-2," ")
//   <<[A]"$Pad\n";  
 
    fflush(A);

// which line is end of old hdr?
//<<"%V $end_ln\n"

 Y = X[end_ln:-1:1];

 D=ofile("stem","w");
 
//<<"$Y \n";
  ysz= Y.getSize();

<<"%V$ysz \n";

   Y.write(D);
 //wfile(D,Y);
//  wfile(D,Y[2]);
//    wfile(D,Y[10]);
 cf(D);

   Y.write(A);
/*   
  for (i= end_ln; i < fsz; i++) {
//<<"$i $X[i]\n"
   wfile(A,X[i]);
  }
*/

  // wfile(A,"NEW END\n");
   
cf(A);




// lets' log this change 

logfile= "~gapps/LOGS/aslcodemods.log"
A=ofile(logfile,"r+")
fseek(A,0,2)

ans=iread("asl code-what modification?:")
<<"$ans\n"
len = slen(srcfile)
nsp = 32-len
ws=nsc(nsp," ")
<<[A]"$srcfile $ws  ${pmaj}.$pmin  $(date(16))  $ans\n"
cf(A)


exit()

