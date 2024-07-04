/* 
 *  @script shead.asl                                                   
 * 
 *  @comment shead.asl                                                  
 *  @release Carbon                                                     
 *  @vers 1.11 Na Sodium [asl 6.40 : C Zr]                              
 *  @date 06/30/2024 14:43:37                                           
 *  @cdate Sun Dec 23 09:23:42 2018                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 

//----------------<v_&_v>-------------------------//                 



#include "debug";

if (_dblevel > 0) {
   debugON()
}

allowErrors(-1) ; // keep going

chkIn(_dblevel);

 rvers = getversion()
 <<"%V $rvers\n"


   Str vers2ele(Str& vstr)
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
 Str padHdr(Str ln)
  {
    Str pad;
    Str hl = ln;
    Str el;
 //   <<[2]"$ln\n"
    pad = nsc(70- slen(ln)," ")
  //  <<[2]"$hl $pad\n"
   //<<[A]"$hl $pad\n"
    el = "$hl $pad"
    return el;
 }


   int new_main = 0;
   A= -1;
   //int BERR=ofw("err_shead");  // error file err

  int BERR= 2  // error file err
   
   // if script found
   // then  read current vers and  bump number and update date
   // if no @vers line -- then prepend the vers header lines
   
   Str aslfile = _clarg[1];

   if (aslfile == "-h") {
   <<" shead new.asl  \"test does what?\" vers(maj.min e.g. 1.2)  date(01/01/2020)\n"
   <<" if newasl does not exist then creates a template\n"
    exit(1)
   }

   
   if (aslfile == "") {
   <<[BERR]"no script file entered\n"
     exit();
   }
   
   sz= fexist(aslfile,RW_,0);
   
   //<<" RW sz $sz \n"

   int mas[6];
   p=spat(aslfile,".asl",0,1,mas)
   is_asl_script = 0;
   if (mas[0] ) {
      is_asl_script = 1;
   }
   
   create_template =0;   

   if (sz == -1) {
   <<"can't find script file $aslfile  so create template\n"
   ans=query("create minimal template y/n ?")
   if (ans != "y") {
         exit()
   }

   A=ofw(aslfile)
   <<[A]"----- \n" // stub
   cf(A)
   create_template =1;
   new_main = 1
   }




   set_vers = 0;
   set_cdate = 0;

   date = date(GS_MDYHMS_);
   cdate = date(GS_MDYHMS_);
   na = argc();
   <<[BERR]"%V $na $cdate \n"
   comment ="";
   comment2 ="";

///  get remaining args
///  vers
///  comment
///  cpp template
///  date 

<<"%V $na \n"

   if (na > 2) {
    comment = _clarg[2];
   }

   Str new_vers = "1.1";


   if (na > 3) {
   
    set_vers = 1;   
    new_vers = _clarg[3];
// should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100
<<"new_vers set to $new_vers \n"
   }

   if (na > 4) {
    set_cdate = 1;   
    cdate = _clarg[4]; // use M/D/YYYY
   }


   file= fexist(aslfile,ISFILE_,0);
   
   //<<[2]" FILE $file \n"
   
   dir= fexist(aslfile,ISDIR_,0);
   
   <<[BERR]" DIR $dir \n"
   
   author = "Mark Terry"
   fname = aslfile
   // current release is 
   release = rvers


   pmaj = 1;
   pmin = 1;

   if (set_vers) {
     vers2ele(new_vers);
   }
   
   maj_ele = ptsym(pmaj);
   min_ele = ptsym(pmin);
   min_name = ptname(pmin);
   
   
   len = slen(fname);
   
   ind = (80-len)/2;
   <<[BERR]"$(date()) $(date(8)) \n"
   //<<[2]" $len $ind\n"
   insp = nsc((60-len)/2," ")
   len= slen(insp)
   //<<[2]"$len <|$insp|> \n"
   sp="\n"
   //<<[2]" $(nsc(5,sp))\n"
   
   //<<[2]" $(nsc(5,\"\\n\"))\n"
  Svar T;

   A=ofr(aslfile);
   T=readfile(A);
   tsz= Caz(T);



   found_vers =0;
  Str R;
  Svar L;
  Svar M;

  int i = 0;
   
   while (1) {

    M = readline(A);
   
<<[2]"$i line is <|$M|> \n"
    L.clear()

 //  L.vfree();


   where = ftell(A)
   L.Split(M);
   sz = Caz(L);
<<[2] "sz $(caz(L)) \n"
<<[2]"$i $sz $where  $L \n"

   if (sz >2) {
   
<<[2]"L1 $L[0] $L[1]  \n"

    if (scmp(L[1],"@vers")) {
     found_vers =1;
     cvers = L[2];
     <<[2]"$where $cvers $L[2]\n"
   }
    else if (scmp(L[1],"@cdate")) {
     cdate = "$L[2] ";
     
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
      author = "$L[2] $L[3]";
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
        M = readline(A);
        L.Split(M);
       if (scmp(L[0],";//-",4)) {
      <<[2]" <|$M|>\n"       
      <<[2]"new header end? line $i\n"
       }
       else {
         <<[BERR]"step back \n"
	 fseek(A,where,0);
       }
    break;
    }

   //     ans=ask("? $i one-line?  ")	 
}

  where = ftell(A);

<<" end of current header is $where \n";

  if (!found_vers) {
<<" No Header - back to start of file for body \n"
   fseek(A,0,0);
  }

  T.clear()

  B=ofw("body");

  int kl = 1;
  while (1) {
  
         T = readline(A);
         <<[B]"$T[0]";
	 if (feof(A)) {
	     break;
	 }
	 kl++;
  }

  cf(B);

<<"\nwrote $kl lines to body\n"

   cf(A);
  
 !!"cp $aslfile old_$aslfile"  ; // 

  newsrc=aslfile;


////////////////////////////////////////////////////



<<"$newsrc \n"
  //newsrc.pinfo();

  if (!create_template) {
   
      newsrc=scat("hd_",aslfile)

  }
   
// allines should be padded out to 70
 if (found_vers) {
   vers2ele(cvers)
 
    pmin++;
   
   if (pmin > 100) {
       pmin =1;
       pmaj++;
   }
 }

 vers="@vers ${pmaj}.$pmin $min_ele $min_name [asl $(getversion())]"






   A=ofw(newsrc);
   Str hl="xxx";

   padHdr(" *  @script $fname ")

   <<[A]"/* \n"
   hl=padHdr(" *  @script $fname ")
   <<[A]"$hl\n"
   <<[A]" * \n"
   hl=padHdr(" *  @comment $comment ");
   <<[A]"$hl\n"

<<[BERR]" %V $vers $release \n"

  hl=padHdr(" *  @release $release ");
   <<[A]"$hl\n"
   
   hl=padHdr(" *  $vers                 ");
   <<[A]"$hl\n"
   hl=padHdr(" *  @date $date                ")
   <<[A]"$hl\n"
   hl=padHdr(" *  @cdate $cdate            ")
   <<[A]"$hl\n"
   hl=padHdr(" *  @author $author           ");
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
  
ESL='//==============\_(^-^)_/==================//';


new_main = 1
 
 if ( new_main ) {
    if (is_asl_script) {

<<[A]"\n#define __CPP__ 0\n\n"

<<[A]"#if __ASL__\n"
<<[A]"\n Str Use_= \" Demo  of $comment \";\n";


<<[A]"\n Svar argv = _argv;  // allows asl and cpp to refer to clargs\n"
<<[A]" argc = argc();\n"

<<[A]"\n\n#include \"debug\" \n\n"

<<[A]"  if (_dblevel >0) { \n"
<<[A]"   debugON() \n"
<<[A]"   <<\"\$Use_ \\n\" \n"
<<[A]"} \n\n"
<<[A]"   allowErrors(-1); // set number of errors allowed -1 keep going \n\n"
<<[A]"#endif       \n"


<<[A]"\n"

<<[A]"// CPP main statement goes after all procs\n"
<<[A]"#if __CPP__\n"

<<[A]"#include <iostream>\n"
<<[A]"#include <ostream>\n"

<<[A]"using namespace std;\n"
<<[A]"#include \"vargs.h\"\n"
<<[A]"#include \"cpp_head.h\"\n"
<<[A]"#define PXS  cout<<\n"
<<[A]"\n"
<<[A]"#define CPP_DB 0\n\n"


<<[A]"  int main( int argc, char *argv[] ) {  \n"
///
<<[A]"    init_cpp() ; \n\n"
<<[A]"#endif       \n"        

<<[A]"\n\n  chkIn(1) ;\n\n"
<<[A]"  chkT(1);\n\n"
<<[A]" \n\n"

  fflush(A)
 }
}

<<[_DBH]"now tack on body %V $tsz\n"

 B=ofr("body");

  kl = 1;
  T.clear()
  Str wmyln =""
  while (1) {
  
         T = readline(B);
	 wmyln = T[0];
	 in= sstr(T[0],"chkin",1)
         out = sstr(T[0],"chkout",1)	 
	 if (in == -1 && out == -1) {
         <<[A]"$T[0]";
	}
	// <<"<||$T[0]||>"
       // ans=ask("? $kl one-line?  ")	 
	 if (feof(B)) {
	     break;
	 }
	 kl++;
  }

   cf(B);


if (new_main) {
<<" a new main \n"
 <<[A]"\n\n///\n\n  chkOut(1);\n\n"
<<[A]"\n\n#if __CPP__           \n"   
  //////////////////////////////////
<<[A]"  exit(-1); \n"
<<[A]"  }  // end of C++ main \n"
<<[A]"#endif     \n"       
<<[A]"\n \n\n$ESL\n"
}

  fflush(A)
   cf(A)

<<"output to $newsrc\n"
   
//!!"mv $newsrc $aslfile"
//cf(BERR);
/////