//
// test asl and compiler
// 

#define PGREEN '\033[1;32m'
#define PRED '\033[1;31m'
#define PBLACK '\033[1;39m'
#define POFF  '\033[0m'

vers = 7;

//ws= getenv("GS_SYS")

!!"rm -f ../*/*.tst"
!!"rm -f ../*/*.xtst"
!!"rm -f ../*/*.out"
!!"rm -f ../*/*.xout"

envdebug();

//<<"$tdir\n"
TM= FineTime();

today=getDate(1);
<<"$today $(get_version())\n"

cwd=getdir()

Opf=ofw("Scores/score_$(date(2,'-'))")


Tcf=ofw("test_crashes")
Tff=ofw("test_fails")


<<[Opf]"$today $(get_version())\n"

do_pause = 0
do_error_pause = 0

do_xic = 1

int n_modules = 0
int rt_tests = 0
int rt_pass = 0
int rt_fail = 0



Todo=ofw("to_test")


//////////////////////////////
Ks = 0
proc snooze(ksn)
{
Ks = 0
  for (ks = 0; ks < ksn; ks++) {
    Ks++
  }
}


padtit =nsc(15,"/")

proc hdg(atit)
{

len = slen(atit)

<<"\n$(time()) ${padtit}${atit}$(nsc(20-len,\"/\"))\n"
<<[Opf]"\n$(time()) ${padtit}${atit}$(nsc(20-len,\"/\"))\n"

//!!"ps wax | grep asl | grep -v emacs"
}

Curr_dir = "xx";

proc changeDir(td)
{
  chdir(td)
  Curr_dir = getDir();
}


proc Run2Test(td)
{
  hdg(td)

  Curr_dir = getDir();
  chdir(td)
  Curr_dir = getDir();
  
  <<"changing to $td dir from $Curr_dir\n"
}

/////////////////////////////

proc scoreTest( tname)
{
 int scored = 0;

       RT=ofr(tname)
//<<"in scoreTest $c_proc $tname $RT \n"

       if (RT != -1) {

          fseek(RT,0,2)

          seekLine(RT,-1)

          rtl = readline(RT)
          rtwords = Split(rtl)
          ntests = atoi(rtwords[4])
          npass =  atoi(rtwords[6]);
          pcc = npass/(ntests*1.0) *100

          rt_tests += ntests;
          rt_pass += npass;
if (pcc < 100){
 <<"$(PRED)DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%$(POFF)\n"
}
else {
 <<"DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%\n"
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

//----------------------




int cbh = 0

proc doxictest(prog, a1)
{
//<<"IN $prog\n"

 if (f_exist("${prog}") != -1) {

//<<"$prog exists!\n"
  !!"rm -f last_xic_test"

  if (_pargc > 1) {

  //<<"XIC test  $prog $a1\n"

       // !!"nohup $prog  $a1 >> $ictout "

//      !!" $prog  $a1 > xres.txt "

       !!"asl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst  $prog $a1  > fooxpar"

      //!!" $prog  $a1  | tee --append $ictout "
  }
  else {

  //    <<"XIC test  $prog \n"

      //!!" $prog   >> $ictout "
//!!" $prog   > xres.txt "

  //     !!"nohup $prog  | tee --append $ictout "
       !!"asl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst  $prog   > fooxpar"

  }

// what happens if prog crashes !!

  ntest++

  //<<"tail -3 $ictout > last_xic_test"
  //!!"tail -3 $ictout > last_xic_test"

//  <<"XIC ---"
//<<"%4d$(cbh++) $rt_tests $rt_pass "
\\FIX \\  !!"grep \"DONE:\" last_xic_test"
  //!!"grep $prog last_xic_test"


  fflush(1)
  }
  else {
//<<" NO xic $prog to test\n"
  }
}



// FIX --- optional args -- have to be default activated -- to work for XIC?
// variable length args ??

proc cart (aprg, a1)
{
  int wlen;
  in_pargc = _pargc;
  xwt_prog = "xxx";
  cart_arg = ""
  a1arg = "";
  if (_pargc >1) {
  cart_arg = "arg is $a1"
  a1arg = a1;
  }
  
  tim = time();

//<<"$_proc $aprg $a1 $cart_arg \n"

  !!"rm -f $aprg  ${aprg}.tst  last_test*"

//  !!" asl $CFLAGS ${aprg}.asl  | tee --append $tout "

   jpid  =0
// icompile(0)

  if (in_pargc > 1) {

// <<" asl $CFLAGS ${aprg}.asl  $a1 \n"
//  jpid = !!&"asl -o ${aprg}arg.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1"

     !!"asl -o ${aprg}arg.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1  > foopar"

     wt_prog = "$(time()) ${aprg}:$a1arg "
     wlen = slen(wt_prog)
     padit =nsc(40-wlen," ")

     <<"${wt_prog}$padit"
      <<[Opf]"${wt_prog}$padit"

      if (f_exist("${aprg}.tst") > 0) {
          // should test if DONE
       //!!"grep DONE ${aprg}.tst"
           scoreTest("${aprg}.tst")
      }
     else {

       //<<"CRASH FAIL:--failed to run inseting $aprg into crashed list\n"
        CrashList->Insert("${Curr_dir}/${aprg}")
//	<<[Tcf]"${Curr_dir}/${aprg}\n"
     }

   }
   else {

//<<" asl $CFLAGS ${aprg}.asl  >> $tout & \n"
//    jpid = !!&"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl"

      !!"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl > foo   2>&1"

      if (f_exist("${aprg}.tst") > 0) {

         wt_prog = "$(time()) ${aprg}: "
         wlen = slen(wt_prog)
         padit =nsc(40-wlen," ")
         <<"${wt_prog}$padit"
         <<[Opf]"${wt_prog}$padit"	 

         scoreTest("${aprg}.tst")
      }
     else {

       //<<"CRASH FAIL:--failed to run \n"
       // insert works??
       CrashList->Insert("${Curr_dir}/${aprg}")

     }



//  !!" asl $CFLAGS ${aprg}.asl  > res_${aprg}.txt "
//    <<"%V$jpid \n"
   }

   w_file(Todo,"$(getdir())/${aprg}.asl $jpid $(time())\n")

//  <<"$(getdir())/${aprg}.asl $jpid $(time())\n"
 
    fflush(Todo)

// icompile(1)
//<<"$jpid \n"
//    snooze(15000)
// nanosleep(1,500)

//!!" grep DONE\: res_${aprg}.txt >> $tout "
//!!" tail -3 $tout > last_test_$aprg"

//<<"$E\n"
//  !!" tail -3 $tout > last_test_$aprg"
// <<"$aprg %4d$(cbh++) $rt_tests $rt_pass \n"


//<<" GREP\n"
//!!" grep DONE last_test_$aprg"
//!!" grep $aprg last_test_$aprg"

    if (do_pause) {

      onward = iread("ERRORS :)->")
	if (onward @= "quit") {
          STOP("quit ASL tests");
        }
    }

  ntest++

//!!"tail -3 $tout "

   if (do_xic) {


    if (fexist(aprg) != -1) {

      //<<"RUNNING XIC $cart_arg \n"
     tim = time()
     
   // wt_prog = "$tim "

      //xwt_prog = "$tim ./${aprg}: wtf $cart_arg"

   xwt_prog = "$tim ./${aprg}:$a1arg"

//<<"$xwt_prog \n"

   if (in_pargc > 1) {
   
//<<"%V$_pargc \n"



      
//<<"./$aprg   $a1  $xwt_prog\n"
      doxictest("./$aprg", a1)
   }
   else {
   
//<<" no arg \n"

      xwt_prog = "$tim ./${aprg}: "
      doxictest("./$aprg")
   }

      if (f_exist("${aprg}.xtst") > 0) {
         wlen = slen(xwt_prog)
         padit =nsc(40-wlen," ")
         <<"${xwt_prog}$padit"
	 <<[Opf]"${xwt_prog}$padit"

         scoreTest("${aprg}.xtst")
      }
     else {

       //<<"CRASH FAIL:--failed to run\n"

       CrashList->Insert("${Curr_dir}/xic_${aprg}")
     }

   }

    if (do_pause) {
        onward = iread(":)->")
	if (onward @= "quit") {
          STOP("quit ASL tests");
        }
    }
 }

}
//-------------------------------------------------



tout ="testoutput"
ictout ="ictestoutput"

//!!"echo ictest > $tout"
//!!"echo ictest > $ictout"


CFLAGS = "-cwl"

ntest = 0


int do_all = 1
int do_array = 0
int do_matrix = 0
int do_bugs = 0
int do_bops = 0
int do_vops = 0
int do_sops = 0
int do_fops = 0
int do_class = 0
int do_declare = 0
int do_include = 0
int do_exp = 0
int do_if = 0
int do_logic = 0
int do_for = 0
int do_do = 0
int do_paraex = 0
int do_proc = 0
int do_switch = 0
int do_types = 0
int do_func = 0
int do_command = 0
int do_lhsubsc = 0
int do_dynv = 0
int do_mops = 0

int do_oo = 0
int do_sfunc = 0
int do_svar = 0
int do_record = 0
int do_ivar = 0
int do_lists = 0
int do_stat = 0
int do_threads = 0
int do_while = 0
int do_pan = 0
int do_unary = 0;
int do_ptrs = 0;

 CrashList = ( "",  )  // empty list
 CrashList->Delete(0)
 FailedList = ( "",  )  // empty list --- bug first item null? 
 FailedList->Delete(0)
 
  updir()
  tdir = getdir()



  nargs = ArgC()

  if (nargs > 1) {
    do_all = 0
//<<" selecting tests \n"
  }

  i = 1

    while (1) {


   wt = _argv[i]
  
   //<<" $i $wt \n"

   if (wt @= "bops")
        do_bops = 1  

   if (wt @= "mops")
        do_mops = 1


   if (wt @= "sops")
        do_sops = 1

   if (wt @= "fops")
        do_fops = 1  

   if (wt @= "vops")
        do_vops = 1  

   if (wt @= "svar")
        do_svar = 1

   if (wt @= "record")
        do_record = 1  

   if (wt @= "bugs")
        do_bugs = 1  

   if (wt @= "proc")
        do_proc = 1  

   if (wt @= "do") 
       do_do = 1  

   if (wt @= "stat") 
       do_stat = 1  

   if (wt @= "switch")
        do_switch = 1  

   if (wt @= "types")
        do_types = 1  

   if (wt @= "if")
        do_if = 1  

   if (wt @= "for")
        do_for = 1

   if (wt @= "include")
        do_include = 1  

   if (wt @= "while")
        do_while = 1  

   if (wt @= "exp")
        do_exp = 1  

   if (wt @= "lh")
    do_lhsubsc = 1

   if (wt @= "func")
        do_func = 1

   if (wt @= "unary")
        do_unary = 1  

   if (wt @= "command")
        do_command = 1  

   if (wt @= "array")
        do_array = 1  

  if (wt @= "dynamic")
       do_dynv = 1

   if (wt @= "matrix")
       do_matrix = 1  

   if (wt @= "pan")
        do_pan = 1  

   if (wt @= "lists")
      do_lists = 1

   if (wt @= "sfunc")
      do_sfunc = 1

   if (wt @= "class")
        do_class = 1

   if (wt @= "ptrs")
        do_ptrs = 1  

   if (wt @= "oo")
        do_oo = 1  

   if (wt @= "threads")
      do_threads = 1


   if (wt @= "all")
        do_all = 1  

   if (wt @= "pause")
        do_pause = 1  

   if (wt @= "error_pause")
        do_error_pause = 1  

   i++

    if (i >= nargs)
          break     

  }


  if (do_all  || do_bops) {

    Run2Test("Bops")


// !!!! if basics fail warn/ask before going on to rest of testsuite

  cart("bops",7)
  
  cart("bops")

  cart("fvmeq")

  cart("fvmeq",3)

  cart("fsc1")

  updir()

  changeDir("Contin")

  cart("contin")

  updir()

  changeDir("Mod")

  cart("mod")


  updir()


      }




  if (do_all  || do_types) {
  
      Run2Test("Types")
      cart("str")
      cart("char")
      cart("long")
      cart("short")
      cart("double")
      cart("float")
      cart("pan_type")
      cart("ato")
      updir()
      Run2Test("Cast")
      cart("cast0")
      cart("cast_vec")
      updir();

      Run2Test("Efmt");
      cart("efmt");
      updir();
  }







  if (do_all  || do_vops) {

   Run2Test("Vops")

  cart("vops")
  cart("vopsele")

  updir()

  }

//////////////////////////////////////////////////

  if (do_all  || do_sops) {

  Run2Test("Sops")

//  need more str ops tests than this!

  cart("scat")

  cart("scmp")

  cart("ssub")

  cart("stropcmp")

  updir()

  Run2Test("Date")
  cart("date")
  updir()

  Run2Test("Sele")
  cart("sele")
  updir()


  Run2Test("Splice")
  cart("strsplice")
  updir()

  Run2Test("Sstr")
  cart("sstr")
  updir()

  Run2Test("Regex")
  cart("regex")
  updir()



  }

/////////////////////////////////////////////////

  if (do_all  || do_fops) {

  Run2Test("Fops")

  cart("readfile")

   updir()

  }


if (( do_all ==1) || (do_declare == 1) ) {

  Run2Test("Declare")

  cart ("declare")

  cart ("promote")

  cart("declare_eq")

  cart("chardeclare")

  cart("scalar_dec")

  cart("floatdeclare")

  cart("arraydeclare")

  cart("proc_arg_func")

   updir()

   changeDir("Consts")

   cart ("consts_test")

   updir()

/////////////////////////////////////////////////////////////////////////////////

    }

if (( do_all ==1) || (do_include == 1) ) {

  Run2Test("Include")

   cart ("main_ni",2)
  
   updir()

/////////////////////////////////////////////////////////////////////////////////

    }

changeDir(tdir)

if ( do_all || do_exp ) {

hdg("EXPRESSION")

changeDir("Sexp")

   cart("sexp", 10)

updir()

    }

////////////// IF ///////////////////////

if ( do_all || do_if ) {

  Run2Test("If")


  cart("if0",10)

  cart("if4")

  cart("md_assign")

  cart("if5")

  cart("if6")

  updir()


  Run2Test("Logic")

  cart("logic")
  cart("logic2")
  cart("logic_def")

  updir()

  Run2Test("Bitwise")
  cart("bitwise")
  updir()

  Run2Test("Define")

  cart("define")

  updir()

  Run2Test("Enum")

  cart("colors_enum")

  updir()

////////////////////////////////////////////////////////////////////////

    }

if ( do_all || do_for ) {

   Run2Test("For")

   cart("for")

updir()

////////////////////////////////////////////////////////////////////////
    }

if ( do_all || do_while ) {

  Run2Test("While")

  cart("while0", 10)

  updir()

////////////////////////////////////////////////////////////////////////
    }




if ( do_all || do_switch ) {

  Run2Test("Switch")

  cart("switch")

  cart("switch2")

  updir()
}
/////////////////////////////////////////////


if ( do_all || do_do ) {

   Run2Test("Do")

   cart("do0", 5)

   cart("do1", 6)

   updir()

////////////////////////////////////////////////////////////////////////
    }


 if (do_all || do_paraex ) {

  Run2Test("ParaEx")

  cart("paraex")

  updir()

 }


/////////////// ARRAY //////////////////////

if ( do_all || do_array ) {

  Run2Test("Array")

  cart("ae")

  cart("arraystore")

  cart("array_ele")

  cart("arrayele0")

  cart("arrayele1")

  cart("arraysubset")
  
  cart("arrayrange")

  cart("arraysubvec")

  cart("arraysubsref")

  cart ("arraysubsrange")

  cart ("lhrange")

  cart ("lhe")

  cart ("joinarray")

  cart ("vec_cat")

  cart("vgen")

  cart("array_sr")

  cart("mdele")

  cart("vsp")

  updir()

  changeDir("Scalarvec")

  cart("scalarvec")

  updir();

  changeDir("Subrange")

  cart("subrange")
  cart("subrange2")

  updir();

  changeDir("PrePostOp")

  cart("prepost_opr")

  updir()

  changeDir("M3D")

  cart("m3d")
  cart("m3d_assign")

  updir()


    }


/////////////////////////////////////////

if ( do_all || do_matrix ) {
   

   changeDir("Mdimn")

   cart("mdimn0")

updir()

    Run2Test("Matrix")
    cart("mat_mul")
    cart("msquare")
    cart("diag")

updir()
   changeDir("Setv")
   cart("setv")
updir()

    }


/////////////////////////////////////////

 if ( do_all || do_dynv ) {

  hdg("DYNAMIC_V")


  changeDir("Dynv")

  cart("dynv0")

  cart("dynv2")

  updir()


    }

/////////////////////////////////////////

if ( do_all || do_lhsubsc ) {

  changeDir("Subscript")

  cart("lharraysubsrange")

  updir()


    }

/////////////////////////////////////////

if ( do_all || do_func ) {

  hdg("FUNC")

  changeDir("Func")

  cart("func")

  cart("func0")

  cart ("func1")

  cart ("funcargs")

  updir()
}

/////////////////////////////////////////

if ( do_all || do_unary ) {

  hdg("UNARY")

  changeDir("Unary")

  cart("unaryexp")

  updir()
}

/////////////////////////////////////////

if ( do_all || do_command ) {
  hdg("COMMAND")

  changeDir("Command")

  cart("command")
  cart("command_parse")

  updir()
    }


/////////////////////////////////////////
if ( do_all || do_proc ) {
  hdg("PROC")


  changeDir("Proc")

  cart ("proc")

  cart ("proc_declare")

  cart ("procret0")

  cart("procarg")

  cart("proc_sv0")

  cart("proc_rep")

  cart("procrefarg")

  updir()

  changeDir("ProcArray")
  
  hdg("ProcArray");  

  cart("arrayarg1")
  
  cart("arrayarg2")

  updir()

  changeDir("Swap")

  cart ("swap")

  updir()

  changeDir("Static")
  
  hdg("Static") ; 

  cart("static");

  updir()

  Run2Test("Scope") ; 

  cart("scope");

  updir()

  }

if ( do_all || do_mops ) {

     Run2Test("Mops")

    //changeDir("Mops")

    cart("xyassign")

    updir()

    hdg("RECURSION")

    changeDir("Fact")

    cart("fact", 10)

    updir()

    changeDir("Cmplx")
    cart("cmplx")

    updir()
    
    changeDir("Rand")

    cart("urand")

    updir()
    }






if ( do_all || do_svar ) {

    Run2Test("Svar")

    //changeDir("Svar")

    cart("svar1", "string operations are not always easy" )

    cart("svar_declare")

    cart("list_declare"); // should be other list tests elsewhere

    cart("svelepr")

    cart("svargetword")


    updir()

    }



  if ( do_all || do_ivar ) {

     Run2Test("Ivar")

    //changeDir("Ivar")

    cart("ivar")

    updir()

    }


if ( do_all || do_record ) {

     Run2Test("Record")

    //changeDir("Record")

    cart("record")

    cart("prtrecord")

    updir()
}

 changeDir(tdir)

 if ( do_all || do_mops ) {
 
    Run2Test("Math")

    cart ("inewton")
    cart ("inewton_cbrt")
    cart ("opxeq")
    updir()

    changeDir("Prime")

    //    cart ("prime_65119")
    cart ("prime_127")

    updir()


    changeDir("Pow")

    cart("pow")

    updir()



    }


 changeDir(tdir)

 if ( do_all || do_stat ) {

    hdg("STAT")

    changeDir("Polynom")
    cart("checkvm")
    cart("polyn")

  updir()

}

 if ( do_all || do_pan ) {

    hdg("PAN")

    changeDir("Pan")
    cart("pan")
    cart("derange",10)
    updir()

}


if ( do_all || do_lists ) {

    Run2Test("Lists")

    cart ("list")

    cart ("listele")

    cart ("list_ins_del")

    updir()

    }


if ( do_all || do_ptrs ) {

    Run2Test("Ptrs")

    cart ("indirect");

      updir()
}

if ( do_all || do_class ) {

    Run2Test("Class")

    cart ("classbops");

    cart ("class2");

    cart ("classvar");

    updir()
    }




if ( do_all || do_oo ) {

  Run2Test("OO")

  cart("class_array")

  cart("rp2")

  cart("oa")

  cart("oa2")

  cart("sh")

  changeDir("../Obcopy/")

  cart("obcopy")

    //  cart("objivar")

  changeDir("../Mih/")

  cart("mih")

  updir()


  }


 if ( do_all || do_sfunc ) {

    hdg("S-FUNCTIONS")

    changeDir("Sscan")

    cart("sscan")

    updir()

    changeDir("Bscan")

    cart("bscan")

    updir()

    changeDir("Cut")

    cart("cut")

    updir()

    changeDir("Cmp")

    cart("cmp")

    updir()

    changeDir("Sel")

    cart("sel")

    updir()



    

    Run2Test("Shift")

    cart("shift")

    updir()


    Run2Test("Median")

    cart("median")

    updir()


#{
/// findval -- find a value in a vector

    changeDir("findval")

    cart("findval0")

    updir()
#}

/// chem    -- find an atomic number for an element

    Run2Test("Chem")

    cart("chem0")

    updir()

    changeDir("Lip");
    cart("lip");
    updir();

//============================
    changeDir("BubbleSort");
    cart("bubblesort");
    updir();
//============================

//============================
    changeDir("Typeof");
    cart("typeof");
    updir();
//============================
    changeDir("Variables");
    cart("variables");
    updir();
//============================
    changeDir("Trig");
    cart("trig");
    updir();
//============================
    changeDir("Caz");
    cart("caz");
    updir();
//============================
    changeDir("Sizeof");
    cart("sizeof");
    updir();
//============================
    changeDir("Limit");
    cart("limit");
    updir();
//============================
    changeDir("D2R");
    cart("d2r");
    updir();
//============================
    changeDir("Cbrt");
    cart("cbrt");
    updir();
//============================
    changeDir("Packb");
    cart("packb");
    updir();
//============================    

    }



//////////////////// BUGFIXs/////////////////////////////////////////

if ( do_all || do_bugs ) {
      Run2Test("BUGFIX")
      // lets get a list and work through them
      //cart("bf_40")   // this has intentional error and exits before test checks
      
      cart("bf_46")
      cart("bf_59")
      cart("bf_64")
      cart("bf_75")
      cart("bf_76")
      cart("bf_78")
      cart("bf_79")
      cart("bf_80")
      cart("bf_83")
      cart("bf_84")
      cart("bf_89")
      cart("bf_91")                                                
      updir()
}

/{
if ( do_all || do_threads ) {
        Run2Test("Threads")
        cart("threads")
        updir()
}
/}
  ///////////////////////////////////////////////////////////////////////////////////////////


// and the Grand Total is ???

   pcc = rt_pass/(1.0*rt_tests) * 100

   flsz = caz(FailedList)

//<<"failed list size $flsz \n"

  if (flsz >= 1) {

<<"\n These $flsz modules  failed! \n"
<<[Opf]"\n These $flsz modules  failed! \n"

   FailedList->Sort()

//<<" %(2,\t, ,\n)$FailedList \n"  // would like this to work like for vectors ---

   for (i = 0; i < flsz ; i++) {
       <<"$FailedList[i] \n"
       <<[Opf]"$FailedList[i] \n"
       <<[Tff]"$FailedList[i] \n"
   }
}
<<"----------------------------------------------------------------------------\n"


   lsz = caz(CrashList)

//<<"$lsz \n"

if (lsz > 1) {

<<"\n These $lsz modules   crashed! \n"
<<[Opf]"\n These $lsz modules   crashed! \n"

   CrashList->Sort()

//<<" $CrashList \n"
   for (i = 0; i < lsz ; i++) {
   <<"$CrashList[i] \n"
   <<[Opf]"$CrashList[i] \n"
   <<[Tcf]"$CrashList[i] \n"   
   }
   
}
<<"----------------------------------------------------------------------------\n"
<<"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$(flsz[0]) Crash $(lsz[0]) vers $(get_version())\n"

<<[Opf]"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass  Score %6.2f$pcc Fail %d$(flsz[0]) Crash $(lsz[0]) $(get_version())\n"


fflush(Opf)
cf(Opf)

fflush(Tcf)
cf(Tcf)

fflush(Tff)
cf(Tff);


changeDir(cwd)

//!!"pwd"

//<<"cp Scores/score_$(date(2,'-')) current_score \n"



!!"cp Scores/score_$(date(2,'-')) current_score"
dtms= FineTimeSince(TM);
secs = dtms/1000000.0


<<"script vers $(periodicName(vers))($vers) took%6.3f$secs secs\n"

STOP()





