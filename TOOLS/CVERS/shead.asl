//%*********************************************** 
//*  @script shead.asl 
//* 
//*  @comment add a header to the script 
//*  @release CARBON 
//*  @vers 1.2 H.He
//*  @date Fri Dec 21 21:40:49 2018 
//*  @author Mark Terry 
//*  @CopyRight  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%

   
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
   
   comment ="";
   comment2 ="";
   
   if (na > 1) {
    set_vers = 1;
    comment = _clarg[2];
   // should be maj.min e.g 1.1 ,6.1, ... limits 1 to 100  
   }
   
   
   
   
   file= fexist(srcfile,ISFILE_,0);
   
   //<<[2]" FILE $file \n"
   
   dir= fexist(srcfile,ISDIR_,0);
   
   //<<[2]" DIR $dir \n"
   author = "Mark Terry"
   fname = srcfile
   release = "CARBON"
   maj = 1;
   min = 1;
   
   maj_ele = ptsym(maj);
   min_ele = ptsym(min);
   
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
   insp = nsc((60-len)/2," ")
   len= slen(insp)
   //<<[2]"$len <|$insp|> \n"
   sp="\n"
   //<<[2]" $(nsc(5,sp))\n"
   
   //<<[2]" $(nsc(5,\"\\n\"))\n"
   
   A=ofr(srcfile);
   T=readfile(A);
   tsz= Caz(T);
<<"$tsz $T[0] \n"

   fseek(A,0,0);

found_vers =0;

   for (i = 0; i < 5;i++) {
   R = readline(A);
   where = ftell(A)
   L = Split(R);
   if (scmp(L[1],"@vers")) {
     found_vers =1;
     release = L[2];    
     cvers = L[3];
     <<[2]"$where $R\n"
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
   
 
 !!"cp $srcfile old-$srcfile"  
   
   ns = spat(srcfile,".asl",-1)
   newsrc=scat(ns,"-new.asl")

   A=ofw(newsrc);

   <<[A]"//%%*********************************************** \n"
   <<[A]"//*  @script $fname \n"
   <<[A]"//* \n"
   <<[A]"//*  @comment $comment \n"
   <<[A]"//*  @release $release \n"   
   <<[A]"//*  @vers ${maj}.$min ${maj_ele}.$min_ele \n"
   <<[A]"//*  @date $date \n"   
   <<[A]"//*  @author $author \n"
   <<[A]"//*  @CopyRight  RootMeanSquare  2014,$(date(8)) --> \n"           
   <<[A]"//* \n"   
   <<[A]"//***********************************************%%\n"
   fflush(A)

   for (i = 0; i < tsz; i++) {
    ln = T[i];
//    <<"$i $ln\n"
   <<[A]"$ln"
   }

   fflush(A)
   cf(A)
!!"mv $newsrc $srcfile"
/////