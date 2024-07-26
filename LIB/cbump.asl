/* 
 *  @script cbump.asl                                                   
 * 
 *  @comment  update vers of C files                                                   
 *  @release Sulfur                                                     
 *  @vers 1.11 Na Sodium [asl 5.16 : B S]                               
 *  @date 08/13/2023 10:43:54                                           
 *  @cdate Sun Dec 23 09:22:34 2018                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 

                                                                       
  
 db_ask = 0;
 db_allow = 0;


 allowDB("ispe_proc,spe_state,spe_args,spe_cmf,spe_scope,tok_func",db_allow)

int DBH = -1

 Str Vers2ele(Str vstr)
  {
   <<"%V $vstr\n"
  // vstr.pinfo()
   pmaj = atoi(spat(vstr,"."))
   pmin = atoi(spat(vstr,".",1))
  <<"%V $pmaj $(ptsym(pmaj)) $pmin $(ptsym(pmin))\n"
   elestr = pt(pmin);
   str ele =" ";
   ele = spat(elestr,",")
  <<"$ele $(typeof(ele))\n";
  <<"$ele";
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
  <<[DBH]"no script file entered\n"
    exit();
  }
  
  sz= fexist(srcfile,RW_,0);
  
  //<<[DBH]" RW sz $sz \n"

  !!"cp $srcfile ${srcfile}.bak"

  if (sz == -1) {
  <<[DBH]"can't find script file $srcfile\n"
    exit();
  }
  
  set_vers = 0;
  na = argc();
   
  if (na > 2) {
   set_vers = 1;
   new_vers = _clarg[2];
   <<[DBH]"%V $new_vers\n"
  // should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100  
  }
  
//   

  
  
  file= fexist(srcfile,ISFILE_,0);
  
  //<<[DBH]" FILE $file \n"
  
  dir= fexist(srcfile,ISDIR_,0);
  
  //<<[DBH]" DIR $dir \n"
  Author = "Mark Terry"
  fname = srcfile

  // get this from asl -v
  release = "BORON"

  pmaj = 1;
  pmin = 1;
  
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  
  date = date(GS_MDYHMS_);
  
  len = slen(fname);
  
  ind = (80-len)/2;
  //<<[DBH]"$(date()) $(date(8)) \n"
  //<<[DBH]" $len $ind\n"
  insp = nsc((60-len)/2," ")
  len= slen(insp)
  //<<[DBH]"$len <|$insp|> \n"
  sp="\n"
  //<<[DBH]" $(nsc(5,sp))\n"
  
  //<<[DBH]" $(nsc(5,\"\\n\"))\n"


  release = "";
  //release.pinfo()
  TR = Split(split(getversion()),".")

<<[DBH]"%V $TR[0]  $TR[1]\n"
  k= ptan(ptname(TR[0]))
 //k.pinfo()
//<<"%V $k \n"
 // release = itoa(k)
 
//<<"%V $release \n"
 //release.pinfo();
 
  release = scat(itoa(ptan(ptname(TR[0]))),".",itoa(ptan(ptname(TR[1])))," ",ptname(TR[0]),"_",ptname(TR[1]));

<<"%V $release \n"



  B= ofile(srcfile,"r")
  Svar X;
  X=readfile(B);
  cf(B);
  
  fsz= X.getSize();

//<<"%V$fsz\n"

//<<"$X\n"


//  for (i= 20; i < 30; i++) {
//<<"$i $X[i]\n"
//  }

 mans = ltmRead("cbump")

<<"reading last mod message $mans\n"


 mans=ask("$mans ",1)

<<"$mans\n"

if (mans == "q") {
  <<"abandon!"
  exit(-1);
}

  A=ofile(srcfile,"r");
  //T=readfile(A);
 //<<[DBH]"opened for read/write? $A\n"
  if (A == -1) {
<<"bad file ?\n"
   exit()
  }
  //<<"nlines ? $tsz\n"
  cvers = "1.1"
  //<<"%(1,,,)$T\n"
  
Str comment ="xxx";
long where;

//where.pinfo()


 Str T;

//T.pinfo();

Str Pad;



 Svar L;

// L.pinfo()
 
// pinfo(L)



  found_vers =0;



  fseek(A,0,0);

//   tsz = Caz(T)
   i = 0;

Str old_comment ="yyy"
   
   while (1) {

    T = readline(A);
   
//<<[DBH]"$i line is $T \n"
   if (i ==3) {
  // T.pinfo()
   //<<"%V $T\n"
ans = ask("%V $old_comment", db_ask);
    old_comment =T;
    ans = ask("%V $old_comment", db_ask);
   }
   where = ftell(A)

   sz = Caz(L);
//<<"Lsz $sz\n"
    L[0:-1:1] = "";
//<<"clear L $L\n"

   L.Split(T);
   sz = Caz(L);
// <<"sz $(caz(L)) \n"
//<<[DBH]"$i $sz $where  $L \n"
   if (sz >2) {
<<[DBH]"L1 $L[1]\n"

    if (scmp(L[1],"@vers")) {
     found_vers =1;
     cvers = L[2];
     <<[DBH]"$where $cvers $L[2]\n"
   }
    else if (scmp(L[1],"@cdate")) {
     cdate = "$L[2:-1:1]";
     
<<[DBH]"cdate  <|$cdate|>  $L[2]\n"
<<[DBH]"cdate             <|$L|>   \n"

   }
    else if (scmp(L[1],"@comment")) {
     comment = "$L[2:-1:1]";
         ans = ask("%V $comment", db_ask);
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
<<[DBH]"not an C header\n"
    found_vers = 0;
    break;
   }


    if (spat(L[0],"///////<v_&_v>//") != "") {
<<[DBH]"@header end? line $i\n"
      break;
    }

}

   where = ftell(A);



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


<<"%V $cvers \n"
//cvers.pinfo()
//if (found_vers) {
 
  //DBaction(DBSTEP_,ON_)
  //DBaction(DBSTRACE_,ON_)  

   Vers2ele(cvers)

// nele = 7;

<<[DBH]"found_vers $cvers \n"
// }

/*
 else {
 <<[DBH]" does not have vers number in header\n";
 exit();
 }
*/

/*
 if (set_vers) {
 // set to _clarg[2] - if correct format
<<"doing set_vers \n"
 vers2ele(new_vers)
 }
 else {
*/


<<"%V $pmin pmaj \n"

    pmin++;
   
   if (pmin > 100) {
       pmin =1;
       pmaj++;
   }

 <<"bumped to $pmaj $pmin\n"
   
   if (pmaj > 100) {
 <<" need a new major release current \n"
   exit();
   }

 
  date = date(GS_MDYHMS_);
  maj_ele = ptsym(pmaj);
  min_ele = ptsym(pmin);
  min_name = ptname(pmin);



 <<"///  @vers $release ${pmaj}.$pmin ${maj_ele}.$min_ele $min_name    \n"


   vers=" @vers ${pmaj}.$pmin $min_ele $min_name "
   vlen = slen(vers);


<<[DBH]"vlen $vlen <|$Pad|>\n"

 fseek(A,0,0);

  cf(A);

    ans = ask("%V $comment", db_ask);

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

<<[DBH]"%V$ysz \n";
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

logfile= "~/gapps/LOGS/aslcodemods.log"
A=ofile(logfile,"r+")
fseek(A,0,2)

// Use LTM MEM

<<"ltmwrt  $mans\n"

 if (mans != "") {
  ltmWrt("cbump",mans,1)
}
else {
 ans = mans
}


len = slen(srcfile)
nsp = 32-len
ws=nsc(nsp," ")
<<[A]"$srcfile $ws  ${pmaj}.$pmin  $(date(16))  $mans\n"
cf(A)


exit()

