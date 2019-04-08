//%*********************************************** 
//*  @script chead.asl 
//* 
//*  @comment add  header to C or include module 
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                               
//*  @date Mon Feb 25 00:26:14 2019 
//*  @cdate 12/18/2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

// use
// chead  xxx.cpp vers(1.1) comment("does this")  date(1/1/2001) > new.cpp
// mv new.cpp xxx.cpp
//


proc vers2ele( vstr)
{

 pmaj = atoi(spat(vstr,"."))
 pmin = atoi(spat(vstr,".",1))

 elestr = pt(pmin);
 str ele =" ";
 ele = spat(elestr,",")
//<<"$ele $(typeof(ele))\n";
//<<"$ele";
 return ele;
 
}
//======================
A=-1;


// if cprog found
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
svers = "2.4"
na = argc();

comment ="";
comment2 ="";

if (na > 2) {
 set_vers = 1;
 svers = _clarg[2];
// should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100  
}

if (na > 3) {
 comment = _clarg[3];

}

 use_epoch =0;
 
if (na > 4) {
  w4 = _clarg[4];
  use_epoch =1;

}

<<[2]" $na $use_epoch \n" 


file= fexist(srcfile,ISFILE_,0);

//<<[2]" FILE $file \n"

dir= fexist(srcfile,ISDIR_,0);

//<<[2]" DIR $dir \n"
Author = "Mark Terry"
fname = srcfile
release = "CARBON"
maj = 2;
min = 4;

if (set_vers) {
  maj = atoi(spat(svers,".",-1))
  min = atoi(spat(svers,".",1))  
}


maj_ele = ptsym(maj);
min_ele = ptsym(min);
min_name = ptname(min);
date = date();

/{
////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\ 
//
//  engine_e.cpp
//
//     CARBON  1.4 H.Be Wed Dec 19 09:47:35 2018    
//     CopyRight   - RootMeanSquare - 1990,2018 --> 
//     Author: Mark Terry                                           
//     parser engine
//
// /. .\ 
// \ ' / 
//   - 
////////////////////////////<v_&_v>\\\\\\\\\\\\\\\\\\\\ 
/}

len = slen(fname);

ind = (80-len)/2;
//<<[2]"$(date()) $(date(8)) \n"
//<<[2]" $len $ind\n"
insp = nsc((76-len)/2," ")
len= slen(insp)
//<<[2]"$len <|$insp|> \n"
sp="\n"
//<<[2]" $(nsc(5,sp))\n"

//<<[2]" $(nsc(5,\"\\n\"))\n"

//<<[2]"cdate is $w4\n"

A=ofr(srcfile)
T=readfile(A);
   vers="    @vers ${maj}.$min $min_ele $min_name "
   vlen = slen(vers);
   pad = nsc(70-vlen," ")

<<"///////////////////////////////////<**|**>///////////////////////////////////\n"
<<"//$insp $fname \n"
<<"//    $comment2   \n"
<<"//    @comment  $comment \n"
<<"//    @release   $release  \n"
<<"//$vers $pad\n"
<<"//    @date $date    \n"
if (use_epoch) {
 if (w4 @= "epoch") {
<<"//    @cdate Sun Jun  9 08:00:00 1996  \n"
 } else {
<<"//    @cdate $w4              \n"
 }
}
else {
<<"//    @cdate $date    \n"              
}

<<"//    @Copyright   RootMeanSquare - 1990,$(date(8)) --> \n"                 
<<"//    @author: $Author                                  \n"
<<"//  \n"
<<"// ^. .^ \n"
<<"// ( ' ) \n"
<<"//   - \n"
<<"///////////////////////////////////<v_&_v>/////////////////////////////////// \n"
<<"\n"
tsz = Caz(T)
//<<[2]"nlines ? $tsz\n"

//<<"%(1,,,)$T\n"
first_inc =0;
 for (i = 0; i < tsz;i++) {
 if (scmp(T[i],"#include",8)) {
   first_inc =i;
   break;
 }
 if (scmp(T[i],"#ifndef",7)) {
   first_inc =i;
   break;
 }
 
}

//<<[2]"%V $first_inc \n"

for (i = first_inc; i < tsz;i++) {
<<"$T[i]"
}