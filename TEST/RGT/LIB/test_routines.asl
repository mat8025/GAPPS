/* 
 *  @script test_routines.asl 
 * 
 *  @comment routines for ASL testing 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.30 C-Li-Zn]                                
 *  @date 03/13/2021 13:11:47 
 *  @cdate 3/13/2021 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 




//////////////////////////////
Ks = 0
void snooze(int ksn)
{
Ks = 0
  for (ks = 0; ks < ksn; ks++) {
    Ks++
  }
}
//===============================

void runModule (int wmod)
{

   mret =0;
//<<"$_proc  $wmod  $mret \n"

   
   if (do_all && (wmod != -1)) {
      mret = 1;
  //    <<"RUN %V $do_all $wmod\n"
   }
   
   if (wmod ==1) {
    //  <<"RUN %V $wmod\n"
      mret =1;
   }
  if ( wmod == -1) {
     // <<"DONT RUN %V $wmod\n"
      mret =0;
  }

  return mret;
}
//===============================

padtit =nsc(15,"/")

void hdg(str atit)
{

  len = slen(atit)


<<"\n$(time()) ${padtit}${atit}$(nsc(20-len,\"/\"))\n"
<<[Opf]"\n$(time()) ${padtit}${atit}$(nsc(20-len,\"/\"))\n"

//!!"ps wax | grep asl | grep -v emacs"
}
//===============================
Curr_dir = "xx";

void Help()
{
 <<" run regression tests for asl\n"
 <<" asl ASL_TEST_VER \n"
 <<" runs all tests \n"
 <<" asl ASL_TEST_VER bops mops\n"
 <<" would run basic and math regression tests and return scores\n"
 <<" asl ASL_TEST_VER all pause\n"
 <<" would run every test -pausing at end of each rof keyboard input to continue\n"
 
 <<" current tests:\n"
 <<" %(5,, ,\n) $Opts \n"

}
//==========================//


void changeDir(str td)
{
  <<" $_proc $td\n"
  chdir(td)
  Curr_dir = getDir();
}
//===============================

void Run2Test(str td)
{

//<<" $_proc $td $Testdir\n"
  //td->info(1)

  chdir(Testdir)

  hdg(td)


  Prev_dir = getDir();

  chdir(td)
  
  Curr_dir = getDir();
  
//<<"changing to $td dir from $Prev_dir in $Curr_dir\n"
}
//===============================

//Str pgname;
void RunDirTests(str Td, str Tl )
{

//<<"$Td  $Tl\n"

str pgname = "xx";

//Tl->info(1)

//ri=Tl->info()
      chdir(Testdir)
      chdir(Td)
      
     // Run2Test(Td);

      Tl->DeWhite()
      Tp = Split(Tl,",");

      np = Caz(Tp);
      
//    <<"%V $Td $Tl $np\n"
      
      for (i=0 ; i < np; i++) {

//<<"$i  <|$Tp[i]|>\n"

         //if (!(Tp[i] @= "")) 

	    pgname = Tp[i];

        nl = slen(pgname);


         if (nl > 0) {
//	   <<"$pgname \n"

           do_carts(pgname);

         }
      
      }
}
//====================//



void RunSFtests(str Td)
{
// list of dirs  Fabs,Cut,Cmp ...
// goto dir then run cart(fabs) or cart(cmp)
      Str wsf;
      Tp = Split(Td,",");

       np = Caz(Tp);
      for (i=0 ; i < np; i++) {
         wsf = Tp[i];

         chdir(Testdir)

         hdg(wsf)

         chdir(wsf)
	 
	 wsf = slower(wsf);
	 
         do_carts(wsf);
      }
}


/////////////////////////////

void scoreTest(str tname)
{
 int scored = 0;
 int ntests;
 int npass;

 int ntests2;
 int npass2;

//<<"$_proc $tname  \n"

        RT=ofr(tname);
       
//<<"$_proc $tname fh $RT \n"


       if (RT != -1) {
//<<"$tname\n"
/*
       tstf = readFile(RT);
       <<"/////\n"
       <<"$tstf"
       <<"/////\n"
*/       
          posn = fseek(RT,0,2)
//<<"EOF @ $posn\n";

          posn =seekLine(RT,-1);
//<<"LL @ $posn\n";

          rtl = readline(RT)
//<<"%V<$rtl>\n"	  
          rtwords = Split(rtl);
//<<"%V $rtwords \n"

          ntests2 = atoi(rtwords[4]); // TBF returns vec size 2??
          npass2 =  atoi(rtwords[6]);

          rtw4 = rtwords[4];
	  rtw6 = rtwords[6];

//<<"%V $rtw4 $rtw6\n"

          ntests = atoi(rtw4);
	  npass = atoi(rtw6);
	  
 //<<"%V $rtwords[4] $rtwords[6]\n"


// <<"%V $ntests $npass\n"
// <<"%V $ntests2 $npass2\n"
          if (ntests > 0) {
          pcc = npass/(ntests*1.0) *100
          }
	  else {
          pcc = 0.0;
          }
          rt_tests += ntests;
          rt_pass += npass;
	  took = rtwords[12];
	  tmsecs =atoi(took);
	  wextn = scut(tname,-4);
	 // <<"$tname $wextn \n"
          if ((sele(tname,-1,-4)) @= "xtst") {
            x_time += tmsecs; 
	    	    //<<"%V $x_time\n"
          }
	  else {
	    i_time += tmsecs;
	    //<<"%V $i_time\n"
          }
	  
if (pcc < 100){
 <<"$(PRED)DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%$(POFF) took $took msecs\n"
}
else {
 <<"DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\% took $took msecs\n"
}

<<[Opf]"DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%\n"
 
          cf(RT)

          scored = 1;

          n_modules += 1 

          if (pcc != 100.0) {
	  //<<"${Curr_dir} inserting $tname into failed list \n"
            FailedList->Insert("${Curr_dir}/${tname}")
	  //<<[Tff]"${Curr_dir}/${tname}\n"  
          }
       }

    return scored;
}
//===============================

int cbh = 0

void doxictest(str prog)
{
//<<"IN $_proc $prog \n"
str prg;

 if (f_exist("${prog}") != -1) {

  !!"rm -f last_xic_test"

  prg = scut(prog,2);

//     !!"nohup $prog  | tee --append $ictout "

        if (do_query) {
<<"$wasl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -dx $prog  \n  "
         ans = query("$prog run it?")
	 if (ans @="q") {
          exit()
         }
	       if (ans @="r") {
                  do_query = 0;
               }	       

         }

//<<" run xic $wasl\n";

      !!"$wasl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -x $prog   > /dev/null "

//      !!"ls -l *";
      
// what happens if prog crashes !!

  ntest++

  fflush(1)
  }
  else {
   <<" NO xic $prog to test\n"
  }
}
//===============================


void doxictest(str prog, str a1)
{

//<<"IN $_proc  $prog  $a1 \n"
str prg;
 if (f_exist("${prog}") != -1) {


  !!"rm -f last_xic_test"

  prg = scut(prog,2);
  

//<<"XIC test  $prog $a1\n"

       // !!"nohup $prog  $a1 >> $ictout "



     if (do_query) {
<<"$wasl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -dx $prog $a1 "
       query("$prog run it?")
       	 if (ans @="q") {
          exit()
         }
         }
	 
       !!"$wasl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -x $prog $a1  > /dev/null"

// what happens if prog crashes !!

  ntest++

  fflush(1)
  }
  else {
   <<" NO xic $prog to test\n"
  }
}
//===============================


// FIX --- optional args -- have to be default activated -- to work for XIC?
// variable length args ??


void cart_xic(Str prg)
{

//<<"%V $_proc  <|$prg|>  \n"
//aprg->info(1)

str  xwt_prog;
str prog = prg;
    if (fexist(prog) != -1) {

      str tim = time() ;  //   TBC -- needs to reinstated
     
   // wt_prog = "$tim "

      xwt_prog = "$tim ./${prog}: "

     if (f_exist(prog) != -1) {

      !!"rm -f last_xic_test"

       prg = scut(prog,2);

//     !!"nohup $prog  | tee --append $ictout "

        if (do_query) {
<<"$wasl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -dx $prog  \n  "
         ans = query("$prog run it?")
	 if (ans @="q") {
          exit()
         }
         }

//<<" run xic $wasl\n";

      !!"$wasl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -x $prog   > /dev/null "

//      !!"ls -l *";
      
// what happens if prog crashes !!

  ntest++

  fflush(1)
  }

      tst_file = "${prog}.xtst";
    //  <<"%V $tst_file\n"
      if (f_exist(tst_file) > 0) {
         wlen = slen(xwt_prog)
         padit =nsc(40-wlen," ")
         <<"${xwt_prog}$padit" // print time prog arg
	 <<[Opf]"${xwt_prog}$padit"

         scoreTest(tst_file)
      }
     else {

       <<[Tcf]"#CRASH FAIL:--failed to run $prog\n"
       
       CrashList->Insert("${Curr_dir}/xic_${prog}")
     }
  }
  
} 
//================================//

void cart_xic(Str aprg, Str a1)
{

//<<"%V $_proc  $aprg $a1 \n"

    if (fexist(aprg) != -1) {


      tim = time() ;  //   TBC -- needs to reinstated
     
   // wt_prog = "$tim "

     xwt_prog = "$tim ./${aprg}:$a1"
//str aa = a1
      doxictest("./$aprg", "$a1")
      tst_file = "${aprg}.xtst";
      //<<"%V $tst_file\n"
      if (f_exist(tst_file) > 0) {
         wlen = slen(xwt_prog)
         padit =nsc(40-wlen," ")
         <<"${xwt_prog}$padit"      // print time prog arg
	 <<[Opf]"${xwt_prog}$padit"

         scoreTest(tst_file)
      }
     else {

       <<[Tcf]"#CRASH FAIL:--failed to run $aprg\n"
       
       CrashList->Insert("${Curr_dir}/xic_${aprg}")
     }

  }
} 
//================================//


void cart (str prg)
{

//<<"%V $_proc $prg    \n"  

  int wlen;
  //str tim;
  str aprg = prg;
  str wstr ="";
//  in_pargc = _pargc;
  
  xwt_prog = "xxx";

  str tim = time();
  
  //aprg->info(1)

//  <<"rm -f $aprg  ${aprg}.tst  last_test* \n"
  !!"rm -f $aprg  ${aprg}.tst  last_test*"

   jpid  =0
      
      //aprg->info(1)


           if (do_query) {
	   
      <<"$wasl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl \n"
           
	       ans= i_read("run it?")
	       if (ans @="q") {
                  exit()
               }
	       if (ans @="r") {
                  do_query = 0;
               }	       


           }
   
     // <<"here $wasl \n";
 // <<"$wasl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl > /dev/null   2>&1";

//!!"pwd"
//!!"ls -l *";
  
!!"$wasl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl > /dev/null   2>&1";

     // !!"ls -l *";
       wstr= aprg
//<<"%V$wstr \n"

      tst_file = "${aprg}.tst";
      //<<"%V $tst_file\n"
      if (f_exist(tst_file) > 0) {

         wt_prog = "$(time()) ${wstr}: "
         wlen = slen(wt_prog)
         padit =nsc(40-wlen," ")
         <<"${wt_prog}$padit";  // keep

         <<[Opf]"${wt_prog}$padit"	 

         scoreTest(tst_file)
      }
     else {

       //<<"CRASH FAIL:--failed to run \n"
       // insert works??
       CrashList->Insert("${Curr_dir}/${aprg}")

     }
   
   setErrorNum(0)
   w_file(Todo,"$(getdir())/${aprg}.asl $jpid $(time())\n")

  //<<"$(getdir())/${aprg}.asl $jpid $(time())\n"
 
    fflush(Todo)
    
     ntest++

//<<"DONE $_proc cart\n"

   return;
  
}
//===============================


//proc cart (str aprg,  gen a1)
void cart (Str prg,  Str a1)
{

//<<"$_proc  $aprg $a1\n"
  int wlen;
  //str tim;
//   <<"%V $_pstack \n"
   str aprg = prg;
   in_pargc = _pargc;
  
   xwt_prog = "xxx";

   str tim = time();

 
  !!"rm -f $aprg  ${aprg}.tst  last_test*"


   jpid  =0
   

// <<" asl $CFLAGS ${aprg}.asl  $a1 \n"
//  jpid = !!&"asl -o ${aprg}arg.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1"


           if (do_query) {
<<"$wasl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1 \n "
           //ans=query("$aprg run it?")
	   ans= iread("$aprg run it?")
         }
	 
!!"$wasl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1  > /dev/null"

     wt_prog = "$(time()) ${aprg}:$a1 "
     wlen = slen(wt_prog)
     padit =nsc(40-wlen," ")

    //  <<"${wt_prog}$padit"
      <<[Opf]"${wt_prog}$padit"
      tst_file = "${aprg}.tst";
    //  <<"%V $tst_file\n"
      if (f_exist(tst_file) > 0) {
          // should test if DONE
       //!!"grep DONE ${aprg}.tst"
           
	   
           scoreTest(tst_file)
      }
     else {

       //<<"CRASH FAIL:--failed to run inseting $aprg into crashed list\n"
        CrashList->Insert("${Curr_dir}/${aprg}")
//	<<[Tcf]"${Curr_dir}/${aprg}\n"
     }


   w_file(Todo,"$(getdir())/${aprg}.asl $jpid $(time())\n")

//  <<"$(getdir())/${aprg}.asl $jpid $(time())\n"
 
    fflush(Todo)

    
  ntest++;

//str aa = a1
/*
    str arg2 = "$a1";
   
    if (do_xic >0 ) {

      cart_xic(aprg,arg2)
    }
*/
//<<"DONE $_proc cart 2 args\n"

   return;
  
}
//===============================

void do_carts (str aprog)
{
  str wprg = aprog;
//!!"pwd"
//<<"run cart vers  $wprg \n"
       cart (wprg);

//<<"run xic vers  $wprg \n"

       cart_xic (wprg);

}
//===============================
