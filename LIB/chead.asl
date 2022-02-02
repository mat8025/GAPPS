//*/////////////////////////////////<**|**>/////////////////////////////////////
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
// /. .\ 
// \ ' / 
//   - 
///////////////////////////////////<v_&_v>/////////////////////////////////*/ 

// usage
// chead  xxx.cpp comment  vers date(M/D/YYYY) > new.cpp
// e.g. chead  xxx.cpp "does this" 1.1  date(1/1/2001) > new.cpp
// mv new.cpp xxx.cpp
//


Str vers2ele(str vstr)
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

Str srcfile = _clarg[1];

<<"<|$srcfile|> \n"


srcfile->deWhite();

<<"<|$srcfile|> \n"

headfile = "${srcfile}_head"

<<"<|$srcfile|> <|$headfile|> \n"






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
svers = "1.1"
na = argc();

comment ="";


if (na > 2) {
  comment = _clarg[2];
// should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100  
}

if (na > 3) {
 set_vers = 1;
 svers = _clarg[3];
}

 use_epoch =0;
 
if (na > 4) {
  w4 = _clarg[4];
  use_epoch =1;

}

//<<[2]" $na $use_epoch \n" 


file= fexist(srcfile,ISFILE_,0);

//<<[2]" FILE $file \n"

dir= fexist(srcfile,ISDIR_,0);

//<<[2]" DIR $dir \n"
Author = "Mark Terry"
fname = srcfile
release = "CARBON"
maj = 1;
min = 1;

if (set_vers) {
  maj = atoi(spat(svers,".",-1))
  min = atoi(spat(svers,".",1))  
}


maj_ele = ptsym(maj);
min_ele = ptsym(min);
min_name = ptname(min);
date = date();



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
cf(A);

A=ofw("$headfile")

   vers="    @vers ${maj}.$min $min_ele $min_name "
   vlen = slen(vers);
   pad = nsc(70-vlen," ")

<<[A]"/*//////////////////////////////////<**|**>///////////////////////////////////\n"
<<[A]"//$insp $fname \n"
<<[A]"//		          \n"
<<[A]"//    @comment  $comment \n"
<<[A]"//    @release   $release  \n"
<<[A]"//$vers $pad\n"
<<[A]"//    @date $date    \n"
if (use_epoch) {
 if (w4 @= "epoch") {
<<[A]"//    @cdate Sun Jun  9 08:00:00 1996  \n"
 } else {
<<[A]"//    @cdate $w4              \n"
 }
}
else {
<<[A]"//    @cdate $date    \n"              
}
<<[A]"//    @author: $Author                                  \n"
<<[A]"//    @Copyright   RootMeanSquare - 1990,$(date(8)) --> \n"                 
<<[A]"//  \n"
<<[A]"// ^. .^ \n"
<<[A]"//  ( ' ) \n"
<<[A]"//    - \n"
<<[A]"///////////////////////////////////<v_&_v>//////////////////////////////////*/ \n"
<<[A]"\n"
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
<<[A]"$T[i]"
}

cf(A);


<<"mv $srcfile ${srcfile}.old\n"
<<"mv $headfile $srcfile\n";

!!"mv $srcfile ${srcfile}.old"
!!"mv $headfile $srcfile";



exit();
//==================//