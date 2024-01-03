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


int Nsuites =0;
int Nspassed =0;

int last_npass = 0
int last_ncrash = 0

void outcome (Str title)
{
   Nsuites++;
   outflsz = caz(FailedList)
//     <<"%V $inflsz $outflsz \n"
   if ((inflsz == outflsz) && (rt_crash == last_ncrash)) {
   Nspassed++;
   len = slen(title);
        Pad = nsc(12-len," ")
	rtn = (rt_pass - last_npass);
	rta = "$rtn";
	len= slen(rta)
	Pad2 =nsc(5-len,"/") 
    <<"/////////////// ${title}$Pad///PASS/////${Pad2}$rta///////////\n"
   }
   else {
   //<<"%V$inflsz  $outflsz \n"
<<"$(PRED_)/////////////////// $title FAIL $(outflsz-inflsz) /////CRASH $(rt_crash-last_ncrash)///$(POFF_)/////////\n"
   }
   last_npass = rt_pass;
   last_ncrash = rt_crash;
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

void hdg(Str atit)
{
//<<"IN $_proc   $atit \n"

   //atit.aslpinfo()

  int len = slen(atit)
//<<"%V $len\n"


  int rlen = 20- len;

//<<"$_proc  $atit  $len\n"

  tpad = nsc(rlen,"/")

//<<"\n$(time()) ${padtit}${atit}$tpad\n"
<<[Opf]"\n$(time()) ${padtit}${atit}$tpad\n"

//!!"ps wax | grep asl | grep -v emacs"
}
//===============================
Curr_dir = "";

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


void changeDir(Str td)
{
  //<<" $_proc $td\n"
  chdir(td)
  Curr_dir = getDir();
}
//===============================

void Run2Test(Str td)
{

//<<" $_proc $td $Testdir\n"

  //td.aslpinfo()
//!a
  chdir(Testdir)

  hdg(td);


  Prev_dir = getDir();

  chdir(td)
  
  Curr_dir = getDir();
  
//<<"changing to $td dir from $Prev_dir in $Curr_dir\n"
}
//===============================

//Str pgname;
void RunDirTests(Str Td, Str Tl )
{
int _DBH = -1
//<<"$_proc $Td  <|$Tl|> \n"

Str pgname = "xx";
Str pgxname = "xy";


  //pgname.aslpinfo();
  
//Tl.info(1)

//ri=Tl.info()

      chdir(Testdir)

      chdir(Td)
      Curr_dir = getDir();
  
     // Run2Test(Td);

      Tl.DeWhite()
      Tp = Split(Tl,",");

      np = Caz(Tp);
      
     // <<"%V $Td $Tl $np\n"
      
      for (i=0 ; i < np; i++) {


	    pgname = Tp[i];

//<<"[$i]  <|$Tp[i]|>  $pgname\n"

            nl = slen(pgname);

	    pgxname = Tp[i];


//<<"[$i]  $nl <|$Tp[i]|>  == <|$pgname|> ==  <|$pgxname|> \n"

         if (nl > 0) {

        <<[_DBH]"%V $pgname \n"

          cart(pgname);

<<[_DBH]"%V $pgname xic \n"

        cart_xic (pgname);
//ans=ask(DB_prompt,2        )
         }
      
      }
}
//====================//



void RunSFtests(Str Td)
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

int scoreTest(Str itname, Str wt_prog)
{
// dbh = -1 no debug , 2 stderr print 
int _DBH = -1

//<<"$_proc <|$itname|>  <|$wt_prog|> \n"

<<[_DBH]"$_proc <|$itname|>  \n"

 int scored = 0;
 int ntests;
 int npass;
 
//  wt_prog.pinfo()
// ans=ask("second str arg?",1)
 
 Str tname;

   //itname.aslpinfo();

 //  tname = itname;

   //tname.aslpinfo();

        RT=ofr(itname);
       
<<[_DBH]"%V fh $RT \n"

    //RT.pinfo()


      if (RT != -1) {

       
<<[_DBH]"RT SCORING  $RT  \n"

          posn = fseek(RT,0,2)

<<[_DBH]" @ $posn\n";


          posn =seekLine(RT,-1);
//<<"LL @ $posn\n";

          rtl = readline(RT)
//<<"%V<$rtl>\n"	  
          rtwords = Split(rtl);
	  
<<[_DBH]"%V $rtwords \n"

          ntests = atoi(rtwords[2]); // TBF returns vec size 2??
          npass =  atoi(rtwords[4]);

	  
<<[_DBH]"%V $rtwords[2] $rtwords[4]\n"


<<[_DBH]"%V $ntests $npass\n"

          if (ntests > 0) {
          pcc = npass/(ntests*1.0) *100
          }
	  else {
          pcc = 0.0;
          }
          rt_tests += ntests;
          rt_pass += npass;
	  took = rtwords[10];
	  tmsecs =atoi(took);
	  wextn = scut(itname,-4);
	 // <<"$tname $wextn \n"
          if ((sele(itname,-1,-4)) @= "xtst") {
            x_time += tmsecs; 
	    	    //<<"%V $x_time\n"
          }
	  else {
	    i_time += tmsecs;
	    //<<"%V $i_time\n"
          }
	  
 if (!do_module) {

         wlen = slen(wt_prog)
         padit =nsc(40-wlen," ")

  if (pcc <100.0 || Report_pass) {
         <<"${wt_prog}$padit" // print time prog arg
	 <<[Opf]"${wt_prog}$padit"
    }

  blue= PGREEN ;
//<<"%V $pcc\n"
if ((pcc < 100)  && (pcc >= 90)) {
 <<"\t$(PBLUE)DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\% took $took msecs $(POFF_)\n\n"
}
else if ((pcc < 90) && (pcc >= 70) ){

<<"\t$(PPURPLE)DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\% took $took msecs \033[0m \n\n"
}
else if (pcc < 70) {

<<"\t$(PRED)DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\% took $took msecs \033[0m \n\n"

}
else {
 if (Report_pass) {
<<"$(PGREEN_)\tDONE tests $ntests\tpass $npass\tscore %5.2f$pcc\% took $took msecs $(POFF_)\n"
 //<<"\t$(blue) DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\% took $took msecs \n"
 }
}

<<[Opf]"DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%\n"
 }


          scored = 1;

//          n_modules += 1
          n_modules++; 

          if (pcc != 100.0) {
	  //<<"${Curr_dir} inserting $tname into failed list \n"
            FailedList.Insert("${Curr_dir}/${itname}")
	  //  <<"${Curr_dir}/${itname}\n"
	  //<<[Tff]"${Curr_dir}/${tname}\n"  
          }
     }


    if (RT >  0) {
<<[_DBH]"closing RT fh $RT\n";
          cf(RT);
    }
     

    return scored;
}
//===============================

int cbh = 0

void doxictest(Str prog)
{
//<<"IN $_proc $prog \n"
Str prg;

 if (f_exist("${prog}") != -1) {

  !!"rm -f last_xic_test"

  prg = scut(prog,2);

//     !!"nohup $prog  | tee --append $ictout "

        if (do_query) {
<<"$wasl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -dx ${prog}.xic  \n  "
         ans = query("$prog run it?")
	 if (ans @="q") {
          exit()
         }
	       if (ans @="r") {
                  do_query = 0;
               }	       

         }

//<<" run xic $wasl\n";

      !!"$wasl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -x ${prog}.xic   > /dev/null "

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


void doxictest(Str prog, Str a1)
{

//<<"IN $_proc  $prog  $a1 \n"
Str prg;
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

int _DBH = -1

//aprg.pinfo()
int wscore;
Str  xwt_prog;
Str lprg = "xxxxxxxxxxxxxxxxx";

lprg = prg;

//prg.pinfo();
//lprg.pinfo();

if (!scmp(lprg,prg)) {
<<"FAIL $_proc  lprg <|$lprg|> ==  prg <|$prg|> \n"

}

     prgx = "${prg}.xic"

<<[_DBH]"looking for xic file <|$prgx|>  \n"

     foundit = fexist(prgx) ;

     //prg.pinfo();

<<[_DBH]"looking for xic file <|$prgx|>  found? $foundit \n"

      if ( foundit ) {
  

      Str tim = time() ;  //   TBC -- needs to reinstated
     
   // wt_prog = "$tim "

      xwt_prog = "$tim ./${prg}: "

//      xwt_prog = "$tim x ${prg}: "
//<<"%V $xwt_prog \n"
//  <<"$wasl -o ${prg}.xout -e ${prg}.xerr -t ${prg}.xtst -dx $prg  \n  "

//ans=query(": ");

    
        //sleep(0.5);

        !!"rm -f last_xic_test"

     //  prg = scut(prg,2);

//     !!"nohup $prg  | tee --append $ictout "

        if (do_query) {
<<"$wasl -o ${prg}.xout -e ${prg}.xerr -t ${prg}.xtst -dx ${prg}.xic  \n  "
         ans = query("$prg run it?")
	 if (ans @="q") {
          exit()
         }
         }

//<<" run xic $wasl <|${prg}.xic|>\n";

    !!"$wasl -o ${prg}.xout -e ${prg}.xerr -t ${prg}.xtst -x ${prg}.xic   > /dev/null "
      
// what happens if prg crashes !!

  ntest++

  fflush(1)
  

      tst_file = "${prg}.xtst";
      
//  <<"%V <|$prg|> <|$tst_file|>\n"


      if (f_exist(tst_file) > 0) {

/*
        wlen = slen(xwt_prog)
         padit =nsc(40-wlen," ")
	 if (!do_module) {
         <<"${xwt_prog}$padit" // print time prog arg
	 <<[Opf]"${xwt_prog}$padit"
         }
	 //<<"$tst_file "
*/	 
         wscore = scoreTest(tst_file,xwt_prog)
      }
     else {

       <<[Tcf]"#CRASH FAIL:--failed to run $prg\n"
       rt_crash++;
       
       CrashList.Insert("${Curr_dir}/xic_${prg}")
     }
  }
  
} 
//================================//

void cart_xic(Str aprg, Str a1)
{
int wscore;
  //<<"%V $_proc  $aprg $a1 \n"

    if (fexist(aprg) != -1) {


      tim = time() ;  //   TBC -- needs to reinstated
     
   // wt_prog = "$tim "

     xwt_prog = "$tim ./${aprg}:$a1"
//Str aa = a1

     // doxictest("./$aprg", "$a1")

  doxictest(aprg, a1)
      
      tst_file = "${aprg}.xtst";

//<<"%V $tst_file\n"


      if (f_exist(tst_file) > 0) {
/*
wlen = slen(xwt_prog)
         padit =nsc(40-wlen," ")
if (!do_module) {
        <<"${xwt_prog}$padit"      // print time prog arg

        <<[Opf]"${xwt_prog}$padit"
}
*/
         wscore = scoreTest(tst_file,xwt_prog)
      }
     else {

       <<[Tcf]"#CRASH FAIL:--failed to run $aprg\n"
       rt_crash++;
       CrashList.Insert("${Curr_dir}/xic_${aprg}")
     }

  }
} 
//================================//


void cart (Str prg)
{

//<<"$_proc <|$prg|> \n"

  //aprg.pinfo()
  int wscore;
  int wlen;

 // aprg.pinfo()
 // prg.pinfo()
//<<"$_proc  prg <|$prg|> ==   aprg <|$aprg|>  arg copied correctly?  \n"

  Str wStr ="";
 //  in_pargc = _pargc;
//  aprg.pinfo();
//  prg.pinfo();
  
  xwt_prog = "xxx";

  Str tim = time();
  
//  aprg.info(1)

//<<"rm -f $aprg  ${aprg}.tst  last_test* \n"
//<<"rm -f $prg  ${prg}.tst  last_test* \n"
 
  !!"rm -f $prg  ${prg}.tst  last_test*"

   jpid  =0
      
      aprg.pinfo()


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
   

//    <<"$wasl -o ${prg}.out -e ${prg}.err -t ${prg}.tst $CFLAGS ${prg}.asl > /dev/null   2>&1";

//!!"pwd"
//!!"ls -l *";
  
!!"$wasl -o ${prg}.out -e ${prg}.err -t ${prg}.tst $CFLAGS ${prg}.asl > /dev/null   2>&1";

     // !!"ls -l *";
       wstr= prg
//<<"%V$wstr \n"

      tst_file = "${prg}.tst";
      //  <<"%V $tst_file\n"

  //tst_file.pinfo()
  kt =f_exist(tst_file);
 // <<"%V $kt\n"

  //    if (f_exist(tst_file) > 0) {  // TBF asl ERROR 12/8/23
      if ( kt > 0) {

         wt_prog = "$(time()) ${wstr}: "
/*
         wlen = slen(wt_prog)
         padit =nsc(40-wlen," ")
	 if (!do_module) {
         <<"${wt_prog}$padit";  // keep

         <<[Opf]"${wt_prog}$padit"	 
         }
*/	 
         wscore = scoreTest(tst_file, wt_prog)
	//<<"%V $wscore\n"
      }
     else {

       //<<"CRASH FAIL:--failed to run \n"
       // insert works??
       rt_crash++;
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



void cart (Str prg,  Str pa1)
{

//<<"$_proc  $prg $pa1\n"
  int wlen;
  int wscore;
  //str tim;
//   <<"%V $_pstack \n"
//   aprg.pinfo()

//pa1.aslpinfo()

   Str aprg;
   Str a1;
//   prg = aprg;
  
 //  prg->pinfo()

   a1= pa1;


//   a1.pinfo()

   in_pargc = _pargc;
  
   xwt_prog = "xxx";

   Str tim = time();

 
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

     wt_prog = "$tim ${prg}:$a1 "
     /*
     wlen = slen(wt_prog)
     padit =nsc(40-wlen," ")
     if (!do_module)  {
      <<"${wt_prog}$padit"
      <<[Opf]"${wt_prog}$padit"
      }
*/
      tst_file = "${prg}.tst";
    //  <<"%V $tst_file\n"
      if (f_exist(tst_file) > 0) {
          // should test if DONE
       !!"grep DONE ${aprg}.tst"
           
	   
           wscore= scoreTest(tst_file, wt_prog)
      }
     else {

       //<<"CRASH FAIL:--failed to run inseting $aprg into crashed list\n"
      rt_crash++;
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

void do_carts (Str aprg)
{
//  <<"%V$_proc  <|$aprg>\n"
//  aprg.pinfo()

//!!"pwd"
//Str bprg = "XYZF";  // TBF fails
//bprg.pinfo()
//bprg[2] = "A"; // FAIL sticky offset ele
//bprg.pinfo()

//bprg = aprg;  // TBF fails

//aprg.pinfo()
//bprg.pinfo()

//
Str wprg = "xx";
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
