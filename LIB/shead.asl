/* 
 *  @script shead.asl                                                   
 * 
 *  @comment shead.asl                                                  
 *  @release CARBON                                                     
 *  @vers 1.10 Ne Neon [asl 6.4.31 C-Be-Ga]                             
 *  @date 06/17/2022 07:53:06                                           
 *  @cdate Sun Dec 23 09:23:42 2018                                     
 *  @author Mark Terry 23 09:23:42 2018                                 
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
//----------------<v_&_v>-------------------------//                 

allowDB("spe")
   
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

   int new_main = 1;
   A= -1;
   int BERR=ofw("err_shead");  // error file err	
   // if script found
   // then  read current vers and  bump number and update date
   // if no @vers line -- then prepend the vers header lines
   
   Str srcfile = _clarg[1];
   
   if (srcfile == "") {
   <<[BERR]"no script file entered\n"
     exit();
   }
   
   sz= fexist(srcfile,RW_,0);
   
   <<[BERR]" RW sz $sz \n"

   int mas[2];
   p=spat(srcfile,".asl",0,1,mas)
   is_asl_script = 0;
   if (mas[0] ) {
      is_asl_script = 1;
   }
   create_template =0;

   if (sz == -1) {
   <<[BERR]"can't find script file $srcfile\n"
   ans=query("create minimal template y/n ?")
   if (ans != "y") {
         exit()
   }


   create_template =1;
    A=ofw(srcfile);
    <<[A]"///\n chkOut();\n  exit();\n;///--------(^-^)--------///\n"
    cf(A);
   
   }




   set_vers = 0;
   set_cdate = 0;

   date = date(GS_MDYHMS_);
   cdate = date(GS_MDYHMS_);
   na = argc();
   <<[BERR]"%V $na $cdate \n"
   comment ="";
   comment2 ="";
   
   if (na > 2) {

    comment = _clarg[2];
   
   }

   Str new_vers = "1.1";

   if (na > 3) {
    set_vers = 1;   
    new_vers = _clarg[3];
// should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100  
   }

   if (na > 4) {
    set_cdate = 1;   
    cdate = _clarg[4]; // use M/D/YYYY
   }
   
   file= fexist(srcfile,ISFILE_,0);
   
   //<<[2]" FILE $file \n"
   
   dir= fexist(srcfile,ISDIR_,0);
   
   <<[BERR]" DIR $dir \n"
   author = "Mark Terry"
   fname = srcfile
   release = "CARBON"


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

   A=ofr(srcfile);
   T=readfile(A);
   tsz= Caz(T);
//<<[2]"$tsz $T[0] \n"

//for (i = 0 ; i < tsz; i++)
//{
//<<"$i $T[i] \n"
//}





   fseek(A,0,0);

   found_vers =0;
Str R;
Svar L;

   for (i = 0; i < 5;i++) {
    R = readline(A);
   <<[BERR]"$i $R\n"   
   where = ftell(A)
   L = Split(R);
   if (scmp(L[1],"@vers")) {
     found_vers =1;
     release = L[2];    
     cvers = L[3];
     <<[BERR]"$where $R\n"
     break;
   }
   found_where = where;
  }

if (found_vers) {

<<"Already has a header $srcfile - exiting!\n"
 exit();

}



   fseek(A,0,0);
  

   cf(A);
   
 
 !!"cp $srcfile old-$srcfile"  ; // 
   
   //ns = spat(srcfile,".asl",-1)
//  Str newsrc=srcfile;
  newsrc=srcfile;
<<"$newsrc \n"
  //newsrc.pinfo();
   if (!create_template) {
   
      newsrc=scat("hd_",srcfile)

  }
   
// allines should be padded out to 70
   A=ofw(newsrc);

   vers="@vers ${pmaj}.$pmin $min_ele $min_name [asl $(getversion())]"
   vlen = slen(vers);
   pad = nsc(70-vlen," ")
   <<[A]"/* \n"
   <<[A]" *  @script $fname \n"
   <<[A]" * \n"
   <<[A]" *  @comment $comment \n"
   <<[A]" *  @release $release \n"   
   <<[A]" *  $vers $pad\n"
   <<[A]" *  @date $date \n"
   <<[A]" *  @cdate $cdate \n"      
   <<[A]" *  @author $author \n"
   <<[A]" *  @Copyright © RootMeanSquare $(date(GS_YEAR_))\n"           
   <<[A]" * \n"
   <<[A]" */ \n"
   <<[A]"//-----------------<V_&_V>------------------------//\n"                          

<<[A]"\n";

ESL='//==============\_(^-^)_/==================//';

 if ( new_main ) {
if (is_asl_script) {

<<[A]"Str Use_= \" Demo  of $comment \";";
<<[A]"\n"

<<[A]"\n#define _CPP_ 0\n"
<<[A]"\n#define _ASL_ 1\n"

<<[A]"\n\n#include \"debug\" \n\n"

<<[A]"  if (_dblevel >0) { \n"
<<[A]"   debugON() \n"
<<[A]"   <<\"\$Use_ \\n\" \n"
<<[A]"} \n\n"
<<[A]"   allowErrors(-1); // set number of errors allowed -1 keep going \n\n"

<<[A]"  chkIn(_dblevel) ;\n\n"
<<[A]"  chkT(1);\n\n"
<<[A]" \n\n\n"


<<[A]"// goes after procs\n"
<<[A]"#if _CPP_\n"

<<[A]"int main( int argc, char *argv[] ) { // main start \n"
///
<<[A]"#endif       \n"        

fflush(A)



}
}
//<<"now tack on file %V $tsz\n"
   for (i = 0; i < tsz; i++) {
    ln = T[i];
  // <<"$i $ln\n"
   <<[A]"$ln"
//   <<[2]"$ln\n"
   }
//<<[A]"$T[i]"  // bug
<<" a new main \n"
if (new_main) {


<<[A]"\n\n#if _CPP_           \n"   
  //////////////////////////////////
<<[A]"  exit(-1); \n"
<<[A]"  }  /// end of C++ main \n"
<<[A]"#endif     \n"       


   <<[A]"\n\n///\n\n chkOut();\n\n  exit();\n\n$ESL\n"
}
   fflush(A)
   cf(A)

<<"output to $newsrc\n"
   
//!!"mv $newsrc $srcfile"
cf(BERR);
/////