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
;//----------------------//

int Nsuites =0;
int Nspassed =0;


void outcome (str title)
{
   Nsuites++;
   outflsz = caz(FailedList)
   if (inflsz == outflsz) {
   Nspassed++;
    <<"/////////////// $title PASS////////////////\n"
   }
   else {
   //<<"%V$inflsz  $outflsz \n"
<<"/////////////////// $title FAIL $(outflsz-inflsz) //////////////////////\n"
   }
}

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
   atit.pinfo()

  int len = slen(atit)
<<"%V $len\n"


  int rlen = 20- len;

//<<"$_proc  $atit  $len\n"

  tpad = nsc(rlen,"/")

//<<"\n$(time()) ${padtit}${atit}$tpad\n"
<<[Opf]"\n$(time()) ${padtit}${atit}$tpad\n"

//!!"ps wax | grep asl | grep -v emacs"
}
//===============================
Curr_dir = "xyz";

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
  //<<" $_proc $td\n"
  chdir(td)
  Curr_dir = getDir();
}
//===============================

void Run2Test(str td)
{

<<" $_proc $td $Testdir\n"

  td.pinfo()

  chdir(Testdir)

  hdg(td);


  Prev_dir = getDir();

  chdir(td)
  
  Curr_dir = getDir();
  
//<<"changing to $td dir from $Prev_dir in $Curr_dir\n"
}
//===============================

//Str pgname;
void RunDirTests(str Td, str Tl )
{

//<<"$_proc $Td  <|$Tl|> \n"

str pgname = "xx";
str pgxname = "xy";

//Tl.info(1)

//ri=Tl.info()
      chdir(Testdir)
      chdir(Td)
      
     // Run2Test(Td);

      Tl.DeWhite()
      Tp = Split(Tl,",");

      np = Caz(Tp);
      
     // <<"%V $Td $Tl $np\n"
      
      for (i=0 ; i < np; i++) {

//<<"$i  <|$Tp[i]|>\n"

         //if (!(Tp[i] @= "")) 

	    pgname = Tp[i];



        nl = slen(pgname);

	    pgxname = Tp[i];


//<<" $i  <|$Tp[i]|>  <|$pgname|>  <|$pgxname|> \n"

         if (nl > 0) {
	     //<<"%V$pgname \n"
	 //   pgname.pinfo()

         //do_carts(pgname);
	  cart(pgname);

	// do_carts(Tp[i] );
	
          cart_xic (pgxname);

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

      //   hdg(wsf)

         chdir(wsf)
	 wd=getDir()
//<<"$i  $wsf $wd\n"	 
	 
	 wsf = slower(wsf);
	 cart(wsf)
	 cart_xic(wsf)
        // do_carts(wsf);
      }
}


/////////////////////////////

int scoreTest(str itname)
{

 //<<"$_proc <|$itname|>  \n"

 int scored = 0;
 int ntests;
 int npass;

 int ntests2;
 int npass2;
 str tname;

//   itname.pinfo();

   tname = itname;

//   tname.pinfo();

        RT=ofr(tname);
       
//<<"$_proc $tname fh $RT \n"

    //RT.pinfo()



      if (RT != -1) {

       
      //<<"RT SCORING  $RT  \n"

          posn = fseek(RT,0,2)

   //<<" @ $posn\n";


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
 if (!do_module) {	  
if (pcc < 100  && pcc > 90){
// <<"\033[1;31m DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\% \033[0m took $took msecs\n"
 <<"$(PRED_)DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%$(POFF_) took $took msecs\n"
}
else if (pcc < 90 ){
// <<"\033[1;31m DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\% \033[0m took $took msecs\n"
 <<"$(PDKRED_)DONE tests $(POFF_)$ntests\tpass $npass\tscore %5.2f$pcc\% took $took msecs\n"
}
else {
 <<"DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\% took $took msecs\n"
}

<<[Opf]"DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%\n"
 }


          scored = 1;

//          n_modules += 1
          n_modules++; 

          if (pcc != 100.0) {
	  //<<"${Curr_dir} inserting $tname into failed list \n"
            FailedList.Insert("${Curr_dir}/${tname}")
	  //<<[Tff]"${Curr_dir}/${tname}\n"  
          }





     }


    if (RT >  0) {
//    <<"closing RT fh $RT\n";
          cf(RT);
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
   <<[2]" NO xic $prog to test\n"
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


void cart_xic(Str aprg)
{


//aprg.pinfo()

str  xwt_prog;
str prg = "xxxxxxxxxxxxxxxxx";

prg = aprg;

//prg.pinfo();

//<<" $_proc  aprg <|$aprg|> prg <|$prg|> \n"



foundit = fexist(prg) ;

//<<"looking for xic file <|$prg|>  found? $foundit \n"


//  if (fexist(prg) != -1) {
      if ( foundit ) {
  
   //<<"found xic file $prg\n"
      str tim = time() ;  //   TBC -- needs to reinstated
     
   // wt_prog = "$tim "

      xwt_prog = "$tim ./${prg}: "

//  <<"$wasl -o ${prg}.xout -e ${prg}.xerr -t ${prg}.xtst -dx $prg  \n  "

      !!"rm -f last_xic_test"

     //  prg = scut(prg,2);

//     !!"nohup $prg  | tee --append $ictout "

        if (do_query) {
<<"$wasl -o ${prg}.xout -e ${prg}.xerr -t ${prg}.xtst -dx $prg  \n  "
         ans = query("$prg run it?")
	 if (ans @="q") {
          exit()
         }
         }

//<<" run xic $wasl\n";

      !!"$wasl -o ${prg}.xout -e ${prg}.xerr -t ${prg}.xtst -x $prg   > /dev/null "

//      !!"ls -l *";
      
// what happens if prg crashes !!

  ntest++

  fflush(1)
  

      tst_file = "${prg}.xtst";
      
     //<<"%V $prg <|$tst_file|>\n"


      if (f_exist(tst_file) > 0) {
         wlen = slen(xwt_prog)
         padit =nsc(40-wlen," ")
	 if (!do_module) {
         <<"${xwt_prog}$padit" // print time prog arg
	 <<[Opf]"${xwt_prog}$padit"
         }
         wscore =scoreTest(tst_file)
      }
     else {

       <<[Tcf]"#CRASH FAIL:--failed to run $prg\n"
       
       CrashList.Insert("${Curr_dir}/xic_${prg}")
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
if (!do_module) {
        <<"${xwt_prog}$padit"      // print time prog arg

        <<[Opf]"${xwt_prog}$padit"
}
         wscore =scoreTest(tst_file)
      }
     else {

       <<[Tcf]"#CRASH FAIL:--failed to run $aprg\n"
       
       CrashList.Insert("${Curr_dir}/xic_${aprg}")
     }

  }
} 
//================================//


void cart (str aprg)
{

// <<"$_proc <|$aprg|> \n"

  //aprg.pinfo()

  int wlen;
  str prg; // TBF  not copied!!


  prg = aprg; // TBF  not copied!!


  //prg.pinfo()
//<<"%V $_proc $prg  $aprg  \n"  

  str wstr ="";
 //  in_pargc = _pargc;
//  aprg.pinfo();
//  prg.pinfo();
  
  xwt_prog = "xxx";

  str tim = time();
  
//  aprg.info(1)

//<<"rm -f $aprg  ${aprg}.tst  last_test* \n"
//<<"rm -f $prg  ${prg}.tst  last_test* \n"
 
  !!"rm -f $prg  ${prg}.tst  last_test*"

   jpid  =0
      
      //aprg.info(1)


           if (do_query) {
	   
      //<<"$wasl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl \n"

      <<"$wasl -o ${prg}.out -e ${prg}.err -t ${prg}.tst $CFLAGS ${prg}.asl \n"
           
	       ans= i_read("run it?")
	       if (ans @="q") {
                  exit()
               }
	       if (ans @="r") {
                  do_query = 0;
               }	       


           }
   

//  <<"$wasl -o ${prg}.out -e ${prg}.err -t ${prg}.tst $CFLAGS ${prg}.asl > /dev/null   2>&1";

//!!"pwd"
//!!"ls -l *";
  
!!"$wasl -o ${prg}.out -e ${prg}.err -t ${prg}.tst $CFLAGS ${prg}.asl > /dev/null   2>&1";

     // !!"ls -l *";
       wstr= prg
//<<"%V$wstr \n"

      tst_file = "${prg}.tst";
      //<<"%V $tst_file\n"
      //tst_file.pinfo()

      if (f_exist(tst_file) > 0) {

         wt_prog = "$(time()) ${wstr}: "
         wlen = slen(wt_prog)
         padit =nsc(40-wlen," ")
	 if (!do_module) {
         <<"${wt_prog}$padit";  // keep

         <<[Opf]"${wt_prog}$padit"	 
         }
         wscore = scoreTest(tst_file)
	// <<"%V $wscore\n"
      }
     else {

       //<<"CRASH FAIL:--failed to run \n"
       // insert works??
       CrashList.Insert("${Curr_dir}/${prg}")

     }
   
   setErrorNum(0)
   w_file(Todo,"$(getdir())/${prg}.asl $jpid $(time())\n")

  //<<"$(getdir())/${aprg}.asl $jpid $(time())\n"
 
    fflush(Todo)
    
     ntest++

//<<"DONE $_proc cart  $prg\n"

   return;
  
}
//===============================



void cart (Str aprg,  Str pa1)
{

//<<"$_proc  $aprg $a1\n"
  int wlen;
  //str tim;
//   <<"%V $_pstack \n"
//   aprg.pinfo()
//   pa1.pinfo()

   str prg;
   str a1;
   prg = aprg;
  
 //  prg->pinfo()

   a1= pa1;
//   a1.pinfo()

   in_pargc = _pargc;
  
   xwt_prog = "xxx";

   str tim = time();

 
  !!"rm -f $prg  ${prg}.tst  last_test*"


   jpid  =0
   

// <<" asl $CFLAGS ${aprg}.asl  $a1 \n"
//  jpid = !!&"asl -o ${aprg}arg.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1"


           if (do_query) {
<<"$wasl -o ${prg}.out -e ${prg}.err -t ${prg}.tst  $CFLAGS ${prg}.asl  $a1 \n "
           //ans=query("$aprg run it?")
	   ans= iread("$aprg run it?")
         }
	 
!!"$wasl -o ${prg}.out -e ${prg}.err -t ${prg}.tst  $CFLAGS ${prg}.asl  $a1  > /dev/null"

     wt_prog = "$(time()) ${prg}:$a1 "
     wlen = slen(wt_prog)
     padit =nsc(40-wlen," ")
     if (!do_module)  {
      <<"${wt_prog}$padit"
      <<[Opf]"${wt_prog}$padit"
      }
      tst_file = "${prg}.tst";
    //  <<"%V $tst_file\n"
      if (f_exist(tst_file) > 0) {
          // should test if DONE
       //!!"grep DONE ${aprg}.tst"
           
	   
           wscore=scoreTest(tst_file)
      }
     else {

       //<<"CRASH FAIL:--failed to run inseting $aprg into crashed list\n"
        CrashList.Insert("${Curr_dir}/${prg}")
//	<<[Tcf]"${Curr_dir}/${aprg}\n"
     }


   w_file(Todo,"$(getdir())/${prg}.asl $jpid $(time())\n")

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


// str as arg should have local copy -- not treat as vec

void do_carts (str aprg)
{
//  <<"%V$_proc  <|$aprg>\n"
//  aprg.pinfo()

//!!"pwd"
//str bprg = "XYZF";  // TBF fails
//bprg.pinfo()
//bprg[2] = "A"; // FAIL sticky offset ele
//bprg.pinfo()

//bprg = aprg;  // TBF fails

//aprg.pinfo()
//bprg.pinfo()

//
str wprg = "xx";
//wprg.pinfo()
wprg = aprg;

//wprg.pinfo()
//  <<"run carts vers  <|$wprg|>  <|$aprg|> \n"

   cart (wprg);

//  <<"run xic vers  $wprg \n"
//  wprg.pinfo()
       cart_xic (wprg);

}
//===============================
