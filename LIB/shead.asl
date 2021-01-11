//%*********************************************** 
//*  @script shead.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.8 O Oxygen                                                   
//*  @date Tue Jan  1 09:16:41 2019 
//*  @cdate Sun Dec 23 09:23:42 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2020 --> 
//* 
//***********************************************%

   
   proc vers2ele(str vstr)
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
   set_cdate = 0;

   date = date();
   cdate = date();
   na = argc();
   <<"%V $na $cdate \n"
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
   
   //<<[2]" DIR $dir \n"
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
Svar T;

   A=ofr(srcfile);
   T=readfile(A);
   tsz= Caz(T);
//<<"$tsz $T[0] \n"
//for (i = 0 ; i < 10; i++)
//{
//<<"$i $T[i] \n"
//}





   fseek(A,0,0);

   found_vers =0;
Str R;
Svar L;
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
   
   //ns = spat(srcfile,".asl",-1)
   newsrc=scat(srcfile,"-new")

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
   <<[A]" *  @Copyright © RootMeanSquare  2010,$(date(8)) → \n"           
   <<[A]" * \n"
   <<[A]" *  \\\\-----------------<v_&_v>--------------------------//  \n"                          
   <<[A]" */ \n"
   //<<[A]"myScript = getScript();\n"
fflush(A)

   for (i = 0; i < tsz; i++) {
    ln = T[i];
//    <<"$i $ln\n"
   <<[A]"$T[i]"
   }

   fflush(A)
   cf(A)
!!"mv $newsrc $srcfile"
/////