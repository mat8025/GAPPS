///
/// @vers supdate.asl 1.1 H/H Tue Dec 18 04:07:52 2018
///



//   so find or insert @vers line which will look like
//   a three line comment header at top of the file
//   like
// ---------------------------------
///
/// @vers 'name'.asl maj.min majele/minele date time
///
// ---------------------------------

//
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



set_vers = 0;
svers = "2.4"
na = argc();

comment ="";
comment2 ="";

if (na > 1) {
 set_vers = 1;
 svers = _clarg[2];
// should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100  
}

if (na > 2) {
 
 comment = _clarg[3];
// should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100  
}



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
///////////////////////////////////<**|**>/////////////////////////////////// 
//                                  mat_m.cpp 
//    matrix operations   
//     
//    @release   CARBON  
//    @vers 2.11  Sodium (Na) 
//    @date Sun Dec 30 11:05:52 2018    
//    @Copyright   RootMeanSquare - 1990,2018 --> 
//    @author: Mark Terry                                  
//  
// /. .\ 
// \ ' / 
//   - 
///////////////////////////////////<v_&_v>/////////////////////////////////// 
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

<<"///////////////////////////////////<**|**>/////////////////////////////////// \n"
<<"//$insp $fname \n"
<<"//    $comment   \n"
<<"//    $comment2 \n"
<<"//    @release   $release  \n"
<<"//    @vers ${maj}.$min  $min_name ($min_ele) \n"              
<<"//    @date $date    \n"              
<<"//    @Copyright   RootMeanSquare - 1990,$(date(8)) --> \n"                 
<<"//    @author: $Author                                  \n"
<<"//  \n"
<<"// \/. .\\ \n"
<<"// \\ ' / \n"
<<"//   - \n"
<<"///////////////////////////////////<v_&_v>/////////////////////////////////// \n"
<<"\n"
