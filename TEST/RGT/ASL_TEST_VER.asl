//%*********************************************** 
//*  @script ASL_TEST_VER.asl 
//* 
//*  @comment asl test modules 
//*  @release CARBON 
//*  @vers 1.63 Eu Europium [asl 6.2.51 C-He-Sb]                           
//*  @date Sun May 24 09:28:05 2020 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%

//
// test asl first and second stage (xic)
//
//<<"TESTING\n"
#include "debug"


#include "hv.asl"


//debugON()
//sdb(1,@~pline,@~trace)

setmaxcodeerrors(-1); // just keep going
setmaxicerrors(-1);

#define PGREEN '\033[1;32m'
#define PRED '\033[1;31m'
#define PBLACK '\033[1;39m'
#define POFF  '\033[0m'


wasl = "aslx"   // alsx should be stable
wasl = "asl"
<<"using $wasl for testing \n"

//str Progname = "abcd";
//str Dirname = "Fact"
//ws= getenv("GS_SYS")

!!"rm -f ../*/*.tst"
!!"rm -f ../*/*.xtst"
!!"rm -f ../*/*.out"
!!"rm -f ../*/*.xout"

// do not remove our own debug

//!!"rm -f ../*/*.idb"
//!!"rm -f ../*/*.xdb"



str S = "all,array,matrix,bugs,bops,vops,sops,fops,class, declare,include,exp,if,logic,for,do,paraex,proc,switch,"
S->cat("types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc, svar,record,ivar,lists,stat,threads,while,pan,unary,ptrs,help");


svar Opts[] = Split(S,",");


//<<[2]"$Opts \n"




//<<"$Testdir\n"
TM= FineTime();

today=getDate(1);
<<"$today $(get_version())\n"

cwd=getdir()

//Opf=ofw("Scores/score_$(date(2,'-'))")
Opf=ofw("current_score")


Tcf=ofw("test_crashes")
Tff=ofw("test_fails")

Tlogf=ofile("test.log","ar+")


Dbf=ofw("test_debug")


<<[Opf]"$today $(get_version())\n"

do_pause = 0;
do_error_pause = 0

do_xic = 1;   // option?

int n_modules = 0
int rt_tests = 0
int rt_pass = 0
int rt_fail = 0
int i_time = 0;
int x_time = 0;


Todo=ofw("to_test")


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
  //<<" $_proc $td\n"
  chdir(td)
  Curr_dir = getDir();
}
//===============================

void Run2Test(str td)
{

//<<" $_proc $td $Testdir\n"
  //td->info(1)

  changeDir(Testdir)

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
      changeDir(Testdir)
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
	   //<<"$pgname \n"

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

         changeDir(Testdir)

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


void cart_xic(Str aprg)
{

//<<"%V $_proc  <|$aprg|>  \n"
//aprg->info(1)

//str  xwt_prog;
//str prog;
    if (fexist(aprg) != -1) {

      str tim = time() ;  //   TBC -- needs to reinstated
     
   // wt_prog = "$tim "

      str xwt_prog = "$tim ./${aprg}: "

      str prog = aprg;
      // doxictest("./$aprg")


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

      tst_file = "${aprg}.xtst";
    //  <<"%V $tst_file\n"
      if (f_exist(tst_file) > 0) {
         wlen = slen(xwt_prog)
         padit =nsc(40-wlen," ")
         <<"${xwt_prog}$padit" // print time prog arg
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


void cart (str aprg)
{

//<<"%V $_proc $aprg    \n"  

  int wlen;
  //str tim;
  str prg ="xx";
  str wstr ="";
//  in_pargc = _pargc;
  
  xwt_prog = "xxx";

  str tim = time();
 // aprg->info(1)

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
void cart (Str aprg,  Str a1)
{

<<"$_proc  $aprg $a1\n"
  int wlen;
  //str tim;
   <<"%V $_pstack \n"
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

//<<"run cart vers  $wprg \n"
       cart (wprg);

//<<"run xic vers  $wprg \n"

       cart_xic (wprg);

}
//===============================

tout ="testoutput"
ictout ="ictestoutput"

//!!"echo ictest > $tout"
//!!"echo ictest > $ictout"


CFLAGS = "-cwl"

//CFLAGS = "-cwlm"     // m to mask src lines in exe file --- broke

ntest = 0


int do_all = 1;
int do_level2 = 0;
int do_query = 0;
int do_tests = 0;
int do_array = 0;
int do_matrix = 0;
int do_math = 0;

int do_bugs = 0;
int do_bops = 0;
int do_vops = 0;
int do_sops = 0;
int do_fops = 0;
int do_class = 0;


int do_declare = 0;
int do_recurse = 0;

int do_syntax = 0;
int do_include = 0;
int do_if = 0;
int do_bit = 0;
int do_logic = 0;
int do_for = 0;
int do_do = 0;
int do_proc = 0;
int do_switch = 0;
int do_scope = 0;;
int do_while = 0;
int do_try = 0;

//======================================//



int do_exp = 0;


int do_paraex = -1;

int do_types = 0;

int do_func = 0;
int do_command = 0;
int do_lhsubsc = 0;
int do_dynv = 0;
int do_mops = 0;

int do_oo = -1;
int do_sfunc = 0;
int do_svar = 0;
int do_record = 0;
int do_ivar = 0;
int do_lists = 0;
int do_stat = 0;
int do_threads = 0;

int do_pan = 0;
int do_unary = 0;
int do_ptrs = 0;
int do_vmf = 0;
int do_help = 0;
int do_release = 0;



  pdir=updir()
  chdir("ITOC")
  Testdir = getdir()
//<<[2]"Test Dir is $Testdir\n"



 CrashList = ( "",  )  // empty list
 CrashList->LiDelete(0)
 FailedList = ( "",  )  // empty list --- bug first item null? 
 FailedList->LiDelete(0)
 



  nargs = ArgC()

//<<[2]"%V$nargs\n"

  if (nargs > 1) {
    do_all = 0
   //<<[2]" selecting tests \n"
  }

  i = 1;

    while (1) {


      wt = _argv[i]
    <<"$i $wt \n"  
    if (wt @= "") {
      break
    }
     if (wt @= "bops") {
        do_bops = 1  
     }
   
      do_arg = "do_$wt"
     

    if (scmp(wt,"~",1) ){
        wt=scut (wt,1);
	<<"don't run $wt\n"
	do_arg = "do_$wt"
	$do_arg = -1;
     }
      else {
      $do_arg = 1;
     }
     
//<<[2]" $i $wt $do_arg \n"

     i++;

    if (i >= nargs)
          break;     

  }


  if (do_help) {

      Help();
      exit();
  }

//<<[2]"%V $do_all $do_bops $do_mops \n"


//================

<<"%V $do_all \n"

if (do_release) {
  wasl = "aslx"
  <<"testing release vers \n"
  !!"$wasl -v"
}


if (do_level2) {
    do_bops =1;
    do_syntax =1;
    do_types =1;    
}


if (do_syntax ==1) {

 do_if = 1;
 do_logic = 1;
 do_for = 1;
 do_do = 1;
 do_switch = 1;
 do_while = 1;
 do_scope = 1;  
 do_include = 1;
 do_try = 1;  
}

if (do_syntax == -1) {

 do_if = -1;
 do_logic = -1;
 do_for = -1;
 do_do = -1;
 do_switch = -1;
 do_while = -1;
 do_scope = -1;
 do_include = -1;  

}

if (do_math) {
    do_mops = 1;
}


<<" check Include $do_include $do_types\n"

<<"%V $do_query\n"


if ((do_include || do_all ) && (do_include != -1)) {

  Run2Test("Include")
  cart("include")

}

//================================//

  if ((do_bops || do_all) && (do_bops != -1)) {

    RunDirTests("Assign","assign");

    RunDirTests("Assign","assign");

    RunDirTests("Bops","bops,fvmeq,fsc1,mainvar,snew");



    Run2Test("Bops")


// !!!! if basics fail warn/ask before going on to rest of testsuite

  cart("bops","7")

  cart("fvmeq","3")


  updir()

  changeDir("Contin")

  cart("contin")

  updir()

  changeDir("Mod")

  cart("mod")

  updir()


  changeDir("Info")

  cart("info")

   //RunDirTests("Assign","assign");

   }


////////////// IF ///////////////////////

if ((do_if || do_all) && (do_if != -1)) {

  
  RunDirTests("If","if")

  Run2Test("Define")
  cart("define")

  Run2Test("Enum")

  cart("colors_enum")

  }
////////////////////////////////////////////////////////////////////////

if ((do_bit || do_all) && (do_bit != -1)) {

  Run2Test("Bitwise");
  cart("bitwise");

}



  if ((do_logic || do_all) && (do_logic != -1)) {

   RunDirTests("Logic","logic,logic-ops,logic-def")

  }

 if ((do_for || do_all) && (do_for != -1)) {

   RunDirTests("For","for,for-exp")
}


////////////////////////////////////////////////////////////////////////
 

  if ((do_all || do_while ) && (do_while != -1)) {

    RunDirTests("While","while-nest,while")

    }
////////////////////////////////////////////////////////////////////////






if ((do_all || do_do ) && (do_do != -1)) {

      RunDirTests("Do","do")

    }

if ((do_all || do_try ) && (do_try != -1)) {

      RunDirTests("TryThrowCatch","trythrowcatch")

    }
////////////////////////////////////////////////////////////////////////


//======================================//
    if ((do_switch || do_all) && (do_switch != -1)) {

      <<"switch $do_all $do_switch \n"

       RunDirTests("Switch","switch")
   }

//======================================//

    if ( (do_types || do_all) && (do_types != -1)) {
  
      RunDirTests("Types","types");
      
      RunDirTests("Cast","cast,cast-vec")

      RunDirTests("Efmt","efmt",);

      RunDirTests("Swab","swab")

      //rdb()
  }
//======================================//

  if ((do_vops || do_all ) && (do_vops != -1)) {

     RunDirTests("Reverse","reverse") ; // BUG needs more than one


     RunDirTests("Vops","vops")

     RunDirTests("Vector","vector")


  }



//////////////////////////////////////////////////

  if ( (do_sops || do_all) && (do_sops != -1)) {
      //  need more str ops tests than this!

  RunDirTests("Sops","sops");
  
  RunDirTests("Splice","splice,strsplice");
 
  // make this a pattern OP

 // RunSFtests("Date,Sele,Sstr,Spat,Str,Split,Regex,Fread,Trunc,Tranf");
   RunSFtests("Date,Sele,Sstr,Spat,Split,Regex,Fread,Trunc,Tranf");


  }

/////////////////////////////////////////////////

  if ((do_fops || do_all) && (do_fops != -1)) {

  Run2Test("Fexist")

  cart("fexist","fexist.asl")

  Run2Test("Fops")

  cart("fops")


  }
//======================================//

if ((do_all  || do_declare ) && (do_declare != -1))  {


   RunDirTests("Declare","declare,dec1,dec-char,dec-pan,dec-vec");

 //  Run2Test("Consts")

 //  cart ("consts_test")


   Run2Test("Resize")

   cart ("resize")

   Run2Test("Redimn")

   cart ("redimn")

/////////////////////////////////////////////////////////////////////////////////

    }



//<<" checkSwitch $do_switch\n"




/////////////////////////////////////////////





changeDir(Testdir)

 if ((do_exp || do_all) && (do_exp != -1)) {


   Run2Test("Sexp")

   cart("sexp", 10)



    }

//rdb()

 if ((do_all || do_paraex ) && (do_paraex != -1)) {

  Run2Test("ParaEx")

  cart("paraex")



 }


/////////////// ARRAY //////////////////////

if ((do_all || do_array ) && (do_array != -1)) {


  RunDirTests("VVcomp","vvcomp");

  RunDirTests("Vfill","vfill");


   RunDirTests("Subrange","subrange");

   RunDirTests("VVcopy","range-copy,vvcopy")

   RunDirTests("Array","ae,arraystore,arrayele,arraysubset")

   RunDirTests("Array","array-range,array-subvec,arraysubsref,array-subsrange,arraysubscbyvec")

   RunDirTests("Array","dynarray,lhrange,lhe,joinarray,vec-cat,vgen,array-sr,mdele,vsp,array-index")

  RunDirTests("Scalarvec","scalarvec")

  Run2Test("PrePostOp")

  //cart("prepostop")

   do_carts("prepostop")

/*





  


  RunDirTests("M3D","m3d,m3d_assign")

  Run2Test("Sgen")

  cart("sgen")

  Run2Test("VVgen")

  cart("vvgen")
*/



    }


/////////////////////////////////////////

 if ((do_all || do_matrix ) && (do_matrix != -1)) {
 
   RunDirTests("Mdimn","mdimn")


   RunDirTests("Matrix","mat-mul,mat-inv,mat-sum,msquare,mdiag");
   

   Run2Test("Msort")
   cart("msort")


   }


/////////////////////////////////////////

 if ((do_all || do_dynv ) && (do_dynv != -1)) {

    hdg("DYNAMIC_V")

    RunDirTests("Dynv","dynv");


    }

/////////////////////////////////////////

if ((do_all || do_lhsubsc )   && (do_lhsubsc != -1)) {

  Run2Test("Subscript")

  cart("lharraysubsrange")

    }

/////////////////////////////////////////

if ((do_all || do_func ) && (do_func != -1)) {

  Run2Test("Func")
  cart("func", 3)

  RunDirTests("Func","func")
  RunDirTests("Args","args")  


  Run2Test("Ifunc")
  cart ("ifunc")   //TBC

  Run2Test("IProc")
  cart ("iproc")   //TBC
   <<" skip iproc TBF \n"
}

/////////////////////////////////////////

   if ((do_all || do_vmf) && (do_vmf != -1)) {
  <<"trying vmf \n"
    RunDirTests("Vmf","vmf,vmf-range,genv")
  }

/////////////////////////////////////////


if ((do_all || do_unary ) && (do_unary != -1)) {


  Run2Test("Unary")

  cart("unaryexp")


}

/////////////////////////////////////////
//rdb()
   if ((do_all || do_command ) && (do_command != -1)) {

     RunDirTests("Command","command,command_parse")

    }


/////////////////////////////////////////
if ((do_all || do_proc ) && (do_proc != -1)) {

  RunDirTests("Proc","proc,proc-declare,proc-ret,proc-arg,proc-sv0");
  
  RunDirTests("Proc","proc-refarg,proc-ra,proc-refstrarg,proc-loc-main-var");

  cart("proc-var-define", 10)

  RunDirTests("ProcArray","poffset,arrayarg1,arrayarg2")

  Run2Test("Static")
  
  hdg("Static") ; 

  cart("static");

  
  }

//rdb()
  if ((do_all || do_scope ) && (do_scope != -1)) {

   Run2Test("Scope") ; 

   cart("scope");

  }


 changeDir(Testdir)

if ((do_all || do_recurse ) && (do_recurse != -1)) {

     hdg("RECURSION")
    
     Run2Test("Fact")

     cart("fact", 10)

     cart_xic("fact",10)


}



if ((do_all || do_mops ) && (do_mops != -1)) {

     RunDirTests("Mops","mops")

     
     Run2Test("Cmplx")

     do_carts("cmplx")


     Run2Test("Rand")

     do_carts("rand")


    }


   if ((do_all || do_svar ) && (do_svar != -1)) {

    RunDirTests("Svar","svar");
    RunDirTests("Hash","hash,svar-table,svar-hash")    
    }

  if ((do_all || do_ivar ) && (do_ivar != -1)) {

     Run2Test("Ivar")

     cart("ivar")

    }


  if ((do_all || do_record ) && (do_record != -1)) {

   

   RunDirTests("Record","record,rec-read,rec-prt,rec-atof,rec-lhs,rec-test,rec-md,rec-dyn");


  }
 changeDir(Testdir)

 if ((do_all || do_mops ) && (do_mops != -1)) {
  
    Run2Test("Math")

    do_carts ("inewton")

    
    do_carts ("inewton_cbrt")

    
    do_carts ("opxeq")

/*
     Run2Test("Prime")
    //    cart ("prime_65119")
    cart ("prime_127")
*/

    Run2Test("Pow")

    do_carts("pow")

    }


 changeDir(Testdir)

 if ((do_all || do_stat ) && (do_stat != -1)) {

//    hdg("STAT")

    RunDirTests("Polynom","checkvm,polynom")
}

 if ((do_all || do_pan )  && (do_pan != -1)) {

    hdg("PAN")

    //RunDirTests("Pan","pan,pan-loop-test,pancmp,panarray")
    RunDirTests("Pan","pan,pancmp,panarray")

   // cart("derange","100") ; /// TBF
 }


   if ((do_all || do_lists ) && (do_lists != -1)) {

     RunDirTests("Lists","lists,list-declare,list-ele,list-ins-del");

    }

   if ((do_all || do_ptrs ) && (do_ptrs != -1)) {
     <<"running ptrs !\n"
      RunDirTests("Swap","swap,swap1");
      RunDirTests("Ptrs","ptr,ptrvec,ptr-numvec,ptr-svarvec,ptr-varvec,indirect");


   }

oo_ok =1;  /// OO broke 1/14/2021 FIX

   if ((do_all || do_class )  && (do_class != -1)) {
  if (oo_ok) {
        RunDirTests("Class","class_mfcall,classbops,class2,classvar");
   }
    }



   if ((do_all || do_oo ) && (do_oo != -1)) {

  if (oo_ok) {
    RunDirTests("OO","oa2,rpS,rp2,wintersect,oa,class_array");

    RunDirTests("Obcopy","obcopy,obprocarg");

    RunDirTests("Mih","sh,mih")
  }

  }


 if ((do_all || do_sfunc ) && (do_sfunc != -1)) {

    hdg("S-FUNCTIONS")

    RunSFtests("Fio,Sscan,Fscanf,Bscan,Cut,Cmp,Sel,Shift,Median,Findval,Lip");
    

   RunSFtests("Pow,Minof,Maxof,Ftest,Convert,Return,Dec2,Pincdec,Rowzoom");

   RunSFtests("Quicksort,Readfile,Skeyval,ReadRecord,Icall");



//============================
    RunSFtests("BubbleSort,Typeof,Variables,Trig,Caz,Sizeof,Limit,D2R,Cbrt,Fabs");
    RunSFtests("Round,Trunc,Wdata,Fscanv,Cmpsetv,Vrange,MDRange,Flipdim");

//============================

    RunDirTests("Funcs","abs");


/// chem    -- find an atomic number for an element

    RunDirTests("Chem","chem0")

    RunDirTests("Packb","packb,packalot");
    
//============================    

    }






//////////////////// BUGFIXs/////////////////////////////////////////

  if ((do_all || do_bugs )  && (!do_bugs == -1)) {
      //cart("bf_40")   // this has intentional error and exits before test checks
    changeDir(Testdir)

     chdir("BUGFIX")
<<"Doing bug tests"
!!"pwd"

BFS=!!"ls bf*.asl "
<<"$(typeof(BFS)) $BFS\n"
bflist="$BFS"

   bug_list = ssub(bflist,".asl"," ,",0)
   
<<"$bug_list\n"

      RunDirTests("BUGFIX",bug_list)
    
  }


  if ((do_all || do_tests ) && (do_tests != -1)) {
    changeDir(Testdir)
//  get a list of asl files in this dir and run them
     chdir("Tests")
<<"Doing Tests"
!!"pwd"

TS=!!"ls *.asl "
<<"$(typeof(TS)) $TS\n"
tslist="$TS"
//<<"$(typeof(tslist)) $tslist\n"
   test_list = ssub(tslist,".asl",",",0)
   
<<"%V $test_list\n"
     RunDirTests("Tests",test_list);
    
  }

/{
if ((do_all || do_threads )) {
        Run2Test("Threads")
        cart("threads")
    
}
/}
  ///////////////////////////////////////////////////////////////////////////////////////////


// and the Grand Total is ???

   pcc = rt_pass/(1.0*rt_tests) * 100

   flsz = caz(FailedList)
   

    fseek(Tlogf,0,2)



  if (flsz >= 1) {

<<"\n$flsz modules  failed! \n"
<<[Opf]"\n$flsz modules  failed! \n"
<<[Tlogf]"\n$flsz modules  failed! \n"

   FailedList->Sort()

//<<" %(2,\t, ,\n)$FailedList \n"  // would like this to work like for vectors ---

   for (i = 0; i < flsz ; i++) {
       <<"$FailedList[i] \n"

       <<[Opf]"$FailedList[i] \n"

      <<[Tff]"$FailedList[i] \n"
       
       <<[Tlogf]"$i $FailedList[i] \n"       
    }
}
<<"----------------------------------------------------------------------------\n"

  
   lsz = caz(CrashList)
//<<"failed list size $flsz crash $lsz \n"
//   flsz->info(1)
//   lsz->info(1)
   

if (lsz >= 1) {

<<"\n$lsz modules   crashed! \n"
<<[Opf]"\n$lsz modules   crashed! \n"
<<[Tlogf]"\n$lsz modules   crashed! \n"


   CrashList->info(1);
   CrashList->Sort()

<<" crashlist $lsz   \n"
   for (i = 0; i < lsz ; i++) {
   <<"$i $CrashList[i] \n"
   <<[Opf]"$CrashList[i] \n"
   <<[Tcf]"$CrashList[i] \n"
   <<[Tlogf]"$i $CrashList[i] \n"
//   if (i > clsz)       break;
   }
   
}


<<"----------------------------------------------------------------------------\n"
<<"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz vers $(get_version())\n"

<<[Opf]"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz $(get_version())\n"
<<[Tlogf]"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz $(get_version())\n"    

fflush(Opf)
cf(Opf)

fflush(Tcf)
cf(Tcf)

fflush(Tff)
cf(Tff);
fflush(Tlogf)
cf(Tlogf);
changeDir(cwd)

//!!"pwd"

//<<"cp Scores/score_$(date(2,'-')) current_score \n"

ut=utime()

A=ofw("Tresults/score_$ut")
<<[A]"$ut $(date(1)) Modules $n_modules Tests $rt_tests  Pass $rt_pass  Score %6.2f$pcc Fail %d$flsz Crash $lsz it $i_time xt $x_time vers $(get_version())\n"
cf(A)




//!!"cp Scores/score_$(date(2,'-')) current_score"
!!"cp current_score Scores/score_$(date(2,'-')) "

dtms= FineTimeSince(TM);
secs = dtms/1000000.0


<<"script vers $_ele_vers took %6.3f$secs secs %d %V $i_time $x_time\n"
today=getDate(1);
<<"used $wasl for tests \n"
!!"$wasl -v"
<<"$today tested $(get_version())\n"
sipause(1)
if (pcc < 100.0) {
<<"$pcc fixes needed!! \n"
}
else {
<<"$pcc Success Hooray! \n"
}
exit(0)


//// TBD///
/*

how to not do test item

*/


