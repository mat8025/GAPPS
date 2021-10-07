//%*********************************************** 
//*  @script ASL_TEST_VER.asl 
//* 
//*  @comment asl test modules 
//*  @release CARBON 
//*  @vers 1.42 Mo Molybdium                                              
//*  @date Thu Feb  7 09:45:52 2019 
//*  @cdate 1/1/2005 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
     
     
     
//
// test asl first and second stage (xic)
// 
     include "debug.asl"; 
     include "hv.asl"; 
     
     debugOFF(); 
     
     #define PGREEN '\033[1;32m'; 
     #define PRED '\033[1;31m'; 
     #define PBLACK '\033[1;39m'; 
     #define POFF  '\033[0m'; 
     
     
     
//ws= getenv("GS_SYS")
     
     !!"rm -f ../*/*.tst"; 
     !!"rm -f ../*/*.xtst"; 
     !!"rm -f ../*/*.out"; 
     !!"rm -f ../*/*.xout"; 
     
// do not remove our own debug
     
//!!"rm -f ../*/*.idb"
//!!"rm -f ../*/*.xdb"
     
     
     
     setdebug(1,@keep,@~pline,@~step,@~trace,@showresults,1); 
     filterFuncDebug(ALLOWALL_,"proc");
     filterFileDebug(ALLOWALL_,"ic_op");
     
     
     
//envdebug();
     str S = "all,array,matrix,bugs,bops,vops,sops,fops,class,\
     declare,include,exp,if,logic,for,do,paraex,proc,switch,\
     types,func,command,lhsubsc,dynv,mops,scope,oo,sfunc,\
     svar,record,ivar,lists,stat,threads, while,pan,unary,ptrs,help";
     
     Svar Opts[] = Split(S,",");
     
     
//<<"$Opts \n"
     
     
     proc RunTests( Tp )
     {
       np = Caz(Tp);
       for (i=0 ; i <np; i++) {
         cart(Tp[i]);
         }
       }
//====================//
     
     
//<<"$Testdir\n"
     TM= FineTime();
     
     today=getDate(1);
     <<"$today $(get_version())\n"; 
     
     cwd=getdir(); 
     
//Opf=ofw("Scores/score_$(date(2,'-'))")
     Opf=ofw("current_score"); 
     
     
     Tcf=ofw("test_crashes"); 
     Tff=ofw("test_fails"); 
     Dbf=ofw("test_debug"); 
     
     
     <<[Opf]"$today $(get_version())\n"; 
     
     do_pause = 0;
     do_error_pause = 0; 
     
     do_xic = 1;
     
     int n_modules = 0; 
     int rt_tests = 0; 
     int rt_pass = 0; 
     int rt_fail = 0; 
     int i_time = 0;
     int x_time = 0;
     
     
     Todo=ofw("to_test"); 
     
     
//////////////////////////////
     Ks = 0; 
     proc snooze(ksn)
     {
       Ks = 0; 
       for (ks = 0; ks < ksn; ks++) {
         Ks++; 
         }
       }
//===============================
     
     padtit =nsc(15,"/"); 
     
     proc hdg(str atit)
     {
       
       len = slen(atit); 
       
       <<"\n$(time()) ${padtit}${atit}$(nsc(20-len,\"/\"))\n"; 
       <<[Opf]"\n$(time()) ${padtit}${atit}$(nsc(20-len,\"/\"))\n"; 
       
//!!"ps wax | grep asl | grep -v emacs"
       }
//===============================
     Curr_dir = "xx";
     
     proc help()
     {
       <<" run regression tests for asl\n"; 
       <<" asl ASL_TEST_VER \n"; 
       <<" runs all tests \n"; 
       <<" asl ASL_TEST_VER bops mops\n"; 
       <<" would run basic and math		\
         		 regression tests and return scores\n"; 
       <<" asl ASL_TEST_VER all pause\n"; 
       <<" would run every test -pausing at end		\
         		 of each rof keyboard input to continue\n"; 
 
       <<" current tests:\n"; 
       <<" %(5,, ,\n) $Opts \n"; 
       
       }
//==========================//
     
     
     
     proc changeDir(td)
     {
       chdir(td); 
       Curr_dir = getDir();
       }
//===============================
     
     proc Run2Test(td)
     {
       
       changeDir(Testdir); 
       
//!!"pwd"
       
       hdg(td); 
       
       Prev_dir = getDir();
       
       chdir(td); 
  
       Curr_dir = getDir();
  
  //<<"changing to $td dir from $Prev_dir in $Curr_dir\n"
       }
//===============================
     
     
     proc RunTests2( Td, Tl )
     {
       Run2Test(Td);
      
       Tp = Split(Tl,",");
       
       np = Caz(Tp);
       <<[Dbf]"$Td $Tl $np\n"; 
       for (i=0 ; i <np; i++) {
         if (!(Tp[i] @= "")) {
           cart(Tp[i]);
           }
         }
       }
//====================//
     
     proc RunSFtests(Td)
     {
// list of dirs  Fabs,Cut,Cmp ...
// goto dir then run cart(fabs) or cart(cmp)
       
       Tp = Split(Td,",");
       
       np = Caz(Tp);
       for (i=0 ; i < np; i++) {
         wsf = Tp[i];
         Run2Test(wsf);
         wsf = slower(wsf);
         cart(wsf);
         }
       }
     
     
/////////////////////////////
     
     proc scoreTest( tname)
     {
       int scored = 0;
       int ntests;
       int npass;
       
       int ntests2;
       int npass2;
 
       RT=ofr(tname);
       
//<<"$_proc $tname fh $RT \n"
       
       
       if (RT != -1) {
//<<"$tname\n"
         /{/*; 
         tstf = readFile(RT);
         <<"/////\n"; 
         <<"$tstf"; 
         <<"/////\n"; 
         /}*/; 
         posn = fseek(RT,0,2); 
//<<"EOF @ $posn\n";
         
         posn =seekLine(RT,-1);
//<<"LL @ $posn\n";
         
         rtl = readline(RT); 
//<<"%V<$rtl>\n"	  
         rtwords = Split(rtl);
//<<"%V $rtwords \n"
         
         ntests2 = atoi(rtwords[4]); // TBF returns vec size 2??; 
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
           pcc = npass/(ntests*1.0) *100; 
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
           x_time += tmsecs;; 
	    	    //<<"%V $x_time\n"
           }
         else {
           i_time += tmsecs;
	    //<<"%V $i_time\n"
           }
	  
         if (pcc < 100){
           <<"$(PRED)DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%$(POFF)		\
             		 took $took msecs\n"; 
           }
         else {
           <<"DONE tests $ntests\tpass $npass\tscore %5.2f$pcc\%		\
             		 took $took msecs\n"; 
           }
         
         <<[Opf]"DONE tests $ntests\tpass		\
           		 $npass\tscore %5.2f$pcc\%\n"; 
 
         cf(RT); 
         
         scored = 1;
         
         n_modules += 1; 
         
         if (pcc != 100.0) {
	  //<<"${Curr_dir} inserting $tname into failed list \n"
           FailedList->Insert("${Curr_dir}/${tname}"); 
	  //<<[Tff]"${Curr_dir}/${tname}\n"  
           }
         }
       
       return scored;
       }
//===============================
     
     
     
     
     
     int cbh = 0; 
     
     proc doxictest(prog, a1)
     {
//<<"IN $prog\n"
       
       if (f_exist("${prog}") != -1) {
         
//<<"$prog exists!\n"
         !!"rm -f last_xic_test"; 
         
         if (_pargc > 1) {
           
//<<"XIC test  $prog $a1\n"
           
       // !!"nohup $prog  $a1 >> $ictout "
           
//      !!" $prog  $a1 > xres.txt "
           
           !!"asl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst		\
             		 -x $prog $a1  > fooxpar"; 
           
      //!!" $prog  $a1  | tee --append $ictout "
           }
         else {
           
  //    <<"XIC test  $prog \n"
           
      //!!" $prog   >> $ictout "
//!!" $prog   > xres.txt "
           
//     !!"nohup $prog  | tee --append $ictout "
//      <<"asl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst -x $prog "
           !!"asl -o ${prog}.xout -e ${prog}.xerr -t ${prog}.xtst		\
             		 -x $prog   > fooxpar"; 
           
           }
         
// what happens if prog crashes !!
         
         ntest++; 
         
  //<<"tail -3 $ictout > last_xic_test"
  //!!"tail -3 $ictout > last_xic_test"
         
//  <<"XIC ---"
//<<"%4d$(cbh++) $rt_tests $rt_pass "
         \\FIX \\  !!"grep \"DONE:\" last_xic_test"; 
  //!!"grep $prog last_xic_test"
         
         
         fflush(1); 
         }
       else {
//<<" NO xic $prog to test\n"
         }
       }
//===============================
     
     
// FIX --- optional args -- have to be default activated -- to work for XIC?
// variable length args ??
     
     proc cart_xic(aprg, a1, in_pargc)
     {
       
//<<"%V xic vers  $aprg $a1 $in_pargc\n"
       
       if (fexist(aprg) != -1) {
         
         cart_arg = " $a1"; 
         a1arg = a1;
         
//<<"RUNNING XIC $cart_arg \n"
         
         tim = time() ;  //   TBC -- needs to reinstated; 
     
   // wt_prog = "$tim "
         
         xwt_prog = "$tim ./${aprg}: $cart_arg"; 
         
     //xwt_prog = "$(time())./${aprg}:$a1arg"
         
//<<"$xwt_prog \n"
         
  // <<"%V  $in_pargc > 1 ? \n"
         
   //in_pargc->info(1);
   
         if ( in_pargc > 1) {
      
//<<"./$aprg   $a1  $xwt_prog\n"
           doxictest("./$aprg", a1); 
           }
         else {
   
//<<" no arg $in_pargc <= 1 \n"
           tim = time() ;  //   TBC -- needs to reinstated; 
           xwt_prog = "$tim ./${aprg}: "; 
      //xwt_prog = "$(time()) ./${aprg}: "
           
           doxictest("./$aprg"); 
           }
         
         if (f_exist("${aprg}.xtst") > 0) {
           wlen = slen(xwt_prog); 
           padit =nsc(40-wlen," "); 
           <<"${xwt_prog}$padit"; 
           <<[Opf]"${xwt_prog}$padit"; 
           
           scoreTest("${aprg}.xtst"); 
           }
         else {
           
           <<[Tcf]"#CRASH FAIL:--failed to run $aprg\n"; 
       
           CrashList->Insert("${Curr_dir}/xic_${aprg}"); 
           }
         
         }
       
  
       }; 
//================================//
     
     
     proc cart (aprg, a1)
     {
       int wlen;
       str tim;
       in_pargc = _pargc;
  
       xwt_prog = "xxx";
       cart_arg = ""; 
       a1arg = "";
       
       tim = time();
       
       if (_pargc >1) {
         cart_arg = " $a1"; 
         a1arg = a1;
         }
       
//<<"%V $_proc $aprg  $cart_arg <$a1arg> $tim \n"
       
  //ans=iread("?")
       
 
       !!"rm -f $aprg  ${aprg}.tst  last_test*"; 
       
//<<"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl \n"
// !!"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl "
//  !!" asl $CFLAGS ${aprg}.asl  | tee --append $tout "
       
       jpid  =0; 
   
// icompile(0)
       
       if (in_pargc > 1) {
         
// <<" asl $CFLAGS ${aprg}.asl  $a1 \n"
//  jpid = !!&"asl -o ${aprg}arg.out -e ${aprg}.err -t ${aprg}.tst  $CFLAGS ${aprg}.asl  $a1"
         
         !!"asl -o ${aprg}arg.out -e ${aprg}.err -t ${aprg}.tst 		\
           		 $CFLAGS ${aprg}.asl  $a1  > foopar"; 
         
         wt_prog = "$(time()) ${aprg}:$a1arg "; 
         wlen = slen(wt_prog); 
         padit =nsc(40-wlen," "); 
         
         <<"${wt_prog}$padit"; 
         <<[Opf]"${wt_prog}$padit"; 
         
         if (f_exist("${aprg}.tst") > 0) {
          // should test if DONE
       //!!"grep DONE ${aprg}.tst"
           scoreTest("${aprg}.tst"); 
           }
         else {
           
       //<<"CRASH FAIL:--failed to run inseting $aprg into crashed list\n"
           CrashList->Insert("${Curr_dir}/${aprg}"); 
//	<<[Tcf]"${Curr_dir}/${aprg}\n"
           }
         
         }
       else {
         
//<<" asl $CFLAGS ${aprg}.asl  >> $tout & \n"
//    jpid = !!&"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS ${aprg}.asl"
         
         !!"asl -o ${aprg}.out -e ${aprg}.err -t ${aprg}.tst $CFLAGS		\
           		 ${aprg}.asl > foo   2>&1"; 
         
         if (f_exist("${aprg}.tst") > 0) {
           
           wt_prog = "$(time()) ${aprg}: "; 
           wlen = slen(wt_prog); 
           padit =nsc(40-wlen," "); 
           <<"${wt_prog}$padit"; 
           <<[Opf]"${wt_prog}$padit"; 
           
           scoreTest("${aprg}.tst"); 
           }
         else {
           
       //<<"CRASH FAIL:--failed to run \n"
       // insert works??
           CrashList->Insert("${Curr_dir}/${aprg}"); 
           
           }
         
         
         
//  !!" asl $CFLAGS ${aprg}.asl  > res_${aprg}.txt "
//    <<"%V$jpid \n"
         }
       
       w_file(Todo,"$(getdir())/${aprg}.asl $jpid $(time())\n"); 
       
//  <<"$(getdir())/${aprg}.asl $jpid $(time())\n"
 
       fflush(Todo); 
       
// icompile(1)
//<<"$jpid \n"
//    snooze(15000)
// nanosleep(1,500)
       
    
       ntest++; 
       
       if (do_pause) {
         onward = iread("carryon? {no to quit}:)->");
	
         if (scmp(onward,"no")) {
           exit("quit ASL tests");
           }
         }
       
       
//!!"tail -3 $tout "
 // TBC if (do_xic)  // FAILS
       
       
       if (do_xic >0 ) {
         cart_xic(aprg,a1,in_pargc); 
         }
       
       
  
       }
//===============================
     
     
     
     
     tout ="testoutput"; 
     ictout ="ictestoutput"; 
     
//!!"echo ictest > $tout"
//!!"echo ictest > $ictout"
     
     
     CFLAGS = "-cwl"; 
     
     ntest = 0; 
     
     
     int do_all = 1;
     int do_array = 0;
     int do_matrix = 0;
     int do_bugs = 0;
     int do_bops = 0;
     int do_vops = 0;
     int do_sops = 0;
     int do_fops = 0;
     int do_class = 0;
     int do_declare = 0;
     int do_include = 0;
     int do_exp = 0;
     int do_if = 0;
     int do_logic = 0;
     int do_for = 0;
     int do_do = 0;
     int do_paraex = 0;
     int do_proc = 0;
     int do_switch = 0;
     int do_types = 0;
     int do_func = 0;
     int do_command = 0;
     int do_lhsubsc = 0;
     int do_dynv = 0;
     int do_mops = 0;
     int do_scope = 0;;
     int do_oo = 0;
     int do_sfunc = 0;
     int do_svar = 0;
     int do_record = 0;
     int do_ivar = 0;
     int do_lists = 0;
     int do_stat = 0;
     int do_threads = 0;
     int do_while = 0;
     int do_pan = 0;
     int do_unary = 0;
     int do_ptrs = 0;
     int do_help = 0;
     
     
     
     
     CrashList = ( "",  )  // empty list; 
     CrashList->LiDelete(0); 
     FailedList = ( "",  )  //		\
       		 empty list --- bug first item null?; 
     FailedList->LiDelete(0); 
 
     updir(); 
     Testdir = getdir(); 
     <<"Test Dir is $Testdir\n"; 
     
     
     nargs = ArgC(); 
     
     if (nargs > 1) {
       do_all = 0; 
//<<" selecting tests \n"
       }
     
     i = 1; 
     
     while (1) {
       
       
       wt = _argv[i]; 
       
//   if (wt @= "bops")
//        do_bops = 1  
       
       do_arg = "do_$wt"; 
       $do_arg = 1;
       
//<<" $i $wt $do_arg \n"
       
       i++;
       
       if (i >= nargs); 
       break;; 
       
       }
     
     
     if (do_help) {
       
       help();
       exit();
       }
     
     <<"%V $do_bops $do_mops \n"; 
     
// always
     Run2Test("Bops"); 
     cart("bops",7); 
//================
     
     if (do_all  || do_bops) {
       
       Run2Test("Bops"); 
       
       
// !!!! if basics fail warn/ask before going on to rest of testsuite
       
       cart("bops",7); 
  
       cart("bops"); 
       
       cart("fvmeq"); 
       
       cart("fvmeq",3); 
       
       cart("fsc1"); 
       
       updir(); 
       
       changeDir("Contin"); 
       
       cart("contin"); 
       
       updir(); 
       
       changeDir("Mod"); 
       
       cart("mod"); 
       
       
       updir(); 
       
       
       }
     
     
     
     
     if (do_all  || do_types) {
  
       RunTests2("Types","float,str,char,long		\  
              ,short,double,pan_type,ato");; 
      
       RunTests2("Cast","cast,cast_vec"); 
       
       RunTests2("Efmt","efmt",);
       
       }
     
     
     if (do_all  || do_vops) {
       
       RunTests2("Vops","vops,vopsele"); 
       
       RunTests2("Vector","vec,veccat,vecopeq"); 
       
   //     RunTests2("Reverse","reverse") ; // BUG needs more than one
       Run2Test("Reverse"); 
       cart("reverse"); 
       
       }
     
//////////////////////////////////////////////////
     
     if (do_all  || do_sops) {
      //  need more str ops tests than this!
       
       RunTests2("Sops","scat,scmp,ssub,stropcmp");
       
  // make this a pattern OP
       RunSFtests("Date,Sele,Sstr,Spat,Regex,Str");
       
       Run2Test("Splice"); 
       cart("strsplice"); 
       
       }
     
/////////////////////////////////////////////////
     
     if (do_all  || do_fops) {
       
       Run2Test("Fops"); 
       
       cart("readfile"); 
       
       Run2Test("Fexist"); 
       
       cart("fexist","fexist.asl"); 
       }
     
     
     if (( do_all ==1) || (do_declare == 1) ) {
       
       Run2Test("Consts"); 
       
       cart ("consts_test"); 
       
       RunTests2("Declare","declare,promote,declare_eq,chardeclare		\  
              ,scalar_dec,floatdeclare,arraydeclare,proc_arg_func");; 
  // RunTests2("Declare","chardeclare,floatdeclare");
       
       Run2Test("Resize"); 
       
       cart ("resize_vec"); 
       
       Run2Test("Redimn"); 
       
       cart ("redimn"); 
       
       
       
/////////////////////////////////////////////////////////////////////////////////
       
       }
     
     if (( do_all ==1) || (do_include == 1) ) {
       
       Run2Test("Include"); 
       
       cart ("main_ni",2); 
  
       
       
/////////////////////////////////////////////////////////////////////////////////
       
       }
     
     changeDir(Testdir); 
     
     if ( do_all || do_exp ) {
       
       
       Run2Test("Sexp"); 
       
       cart("sexp", 10); 
       
       
       
       }
     
////////////// IF ///////////////////////
     
     if ( do_all || do_if ) {
       
       Run2Test("If"); 
       
       cart("if0",10); 
       
       RunTests2("If","if4,md_assign,if5,if6"); 
       
       RunTests2("Logic","logic,logic2,logic_def"); 
       
       Run2Test("Bitwise"); 
       cart("bitwise"); 
       
       Run2Test("Define"); 
       cart("define"); 
       
       Run2Test("Enum"); 
       
       cart("colors_enum"); 
       
       
////////////////////////////////////////////////////////////////////////
       
       }
     
     if ( do_all || do_for ) {
       
       Run2Test("For"); 
       
       cart("for"); 
       
       
       
////////////////////////////////////////////////////////////////////////
       }
     
     if ( do_all || do_while ) {
       
       Run2Test("While"); 
       cart("while"); 
       cart("while0", 10); 
       cart("while1"); 
       
       
       }
////////////////////////////////////////////////////////////////////////
     
     
     
     if ( do_all || do_switch ) {
       
       RunTests2("Switch","switch,switch2"); 
       
       }
/////////////////////////////////////////////
     
     
     if ( do_all || do_do ) {
       
       Run2Test("Do"); 
       
       cart("do0", 5); 
       
       cart("do1", 6); 
       
       
       
////////////////////////////////////////////////////////////////////////
       }
     
     
     if (do_all || do_paraex ) {
       
       Run2Test("ParaEx"); 
       
       cart("paraex"); 
       
       
       
       }
     
     
/////////////// ARRAY //////////////////////
     
     if ( do_all || do_array ) {
       
       
       
   //   Tp = Split("ae,arraystore,arrayele,arrayele0,arrayele1,arraysubset,arrayrange,arraysubvec,arraysubsref,arraysubsrange,dynarray,lhrange,lhe,joinarray,vec_cat,vgen,array_sr,mdele,vsp",","); // TBF - this long line somewhere is overwriting array ?? but we are using Svar - which are not fixed len
       
       RunTests2("Array","ae,arraystore,arrayele,arrayele0,arrayele1		\
         		,arraysubset,arrayrange,arraysubvec,arraysubsref,arraysubsrange"); 
       RunTests2("Array","dynarray,lhrange,lhe,joinarray,vec_cat		\
         		,vgen,array_sr,mdele,vsp,arrayindex"); 
       
       Run2Test("Scalarvec"); 
       
       cart("scalarvec"); 
       
       Run2Test("Subrange"); 
       
       cart("subrange");
  
       cart("subrange2");
  
       Run2Test("PrePostOp"); 
       
       cart("prepost_opr"); 
       
       
       Run2Test("M3D"); 
       
       cart("m3d"); 
       cart("m3d_assign"); 
       
       Run2Test("Sgen"); 
       
       cart("sgen"); 
       
       Run2Test("VVgen"); 
       
       cart("vvgen"); 
       
       Run2Test("Vfill"); 
       
       cart("vfill"); 
       
       
       
       }
     
     
/////////////////////////////////////////
     
     if ( do_all || do_matrix ) {
 
       Run2Test("Mdimn"); 
       
       cart("mdimn0"); 
       
       
       
       RunTests2("Matrix","mat_mul,msquare,mdiag");
   
       
       Run2Test("Msort"); 
       cart("msort"); 
       Run2Test("Setv"); 
       cart("setv"); 
       
       
       }
     
     
/////////////////////////////////////////
     
     if ( do_all || do_dynv ) {
       
       hdg("DYNAMIC_V"); 
       
       RunTests2("Dynv","dynv0,dynv2");
       
       
       }
     
/////////////////////////////////////////
     
     if ( do_all || do_lhsubsc ) {
       
       Run2Test("Subscript"); 
       
       cart("lharraysubsrange"); 
       
       }
     
/////////////////////////////////////////
     
     if ( do_all || do_func ) {
       
       Run2Test("Func"); 
       cart("func", 3,4); 
       
       RunTests2("Func","func0,func1,funcargs"); 
       
       
       Run2Test("Ifunc"); 
       
       cart ("iproc"); 
       
       }
     
/////////////////////////////////////////
     
     if ( do_all || do_unary ) {
       
       
       Run2Test("Unary"); 
       
       cart("unaryexp"); 
       
       
       }
     
/////////////////////////////////////////
     
     if ( do_all || do_command ) {
       
       RunTests2("Command","command,command_parse"); 
       
       }
     
     
/////////////////////////////////////////
     if ( do_all || do_proc ) {
       
       RunTests2("Proc","proc,proc_declare,procret0,procarg,proc_sv0		\  
              ,proc_rep,proc_str_ret,procrefarg,proc_ra");; 
       
       cart("proc_var_define", 10); 
       
       Run2Test("ProcArray"); 
  
       hdg("ProcArray");; 
       
       cart("arrayarg1"); 
  
       cart("arrayarg2"); 
       
       
       RunTests2("Swap","swap1","swap"); 
       
       Run2Test("Static"); 
  
       hdg("Static") ;; 
       
       cart("static");
       
  
       }
     
     
     if ( do_all || do_scope ) {
       
       Run2Test("Scope") ;; 
       
       cart("scope");
       
       }
     
     if ( do_all || do_mops ) {
       
       Run2Test("Mops"); 
       
       cart("xyassign"); 
       
       cart("atof"); 
       
       hdg("RECURSION"); 
       
       Run2Test("Fact"); 
       
       cart("fact", 10); 
       
       
       Run2Test("Cmplx"); 
       cart("cmplx"); 
    
       Run2Test("Rand"); 
       
       cart("urand"); 
       
       
       }
     
     
     
     if ( do_all || do_svar ) {
       
       Run2Test("Svar"); 
       cart("svar1", "string operations are not always easy" ); 
       
       RunTests2("Svar","svar_declare,svelepr		\  
              ,svargetword,svarsplit");; 
       
       }
     
     
     
     if ( do_all || do_ivar ) {
       
       Run2Test("Ivar"); 
       
       cart("ivar"); 
       
       }
     
     
     if ( do_all || do_record ) {
       
       RunTests2("Record","rec1,record,readrecord,prtrecord		\  
              ,recprt,recatof,reclhs,rectest");; 
       
       
       }
     
     changeDir(Testdir); 
     
     if ( do_all || do_mops ) {
 
       Run2Test("Math"); 
       
       cart ("inewton"); 
       cart ("inewton_cbrt"); 
       cart ("opxeq"); 
       
       
       Run2Test("Prime"); 
       
    //    cart ("prime_65119")
       cart ("prime_127"); 
       
       
       Run2Test("Pow"); 
       
       cart("pow"); 
       
       }
     
     
     changeDir(Testdir); 
     
     if ( do_all || do_stat ) {
       
       hdg("STAT"); 
       
       Run2Test("Polynom"); 
       cart("checkvm"); 
       cart("polyn"); 
       
       
       
       }
     
     if ( do_all || do_pan ) {
       
       hdg("PAN"); 
       
       Run2Test("Pan"); 
       cart("pan"); 
       cart("derange",100); 
       
       
       }
     
     
     if ( do_all || do_lists ) {
       
       RunTests2("Lists","list,list_declare,listele,list_ins_del");
       
       }
     
     if ( do_all || do_ptrs ) {
       
       RunTests2("Ptrs","ptrvec,indirect");
       
       }
     
     if ( do_all || do_class ) {
       
       RunTests2("Class","classbops,class2,classvar");
       
       }
     
     
     
     if ( do_all || do_oo ) {
       
       RunTests2("OO","class_array,rp2,oa,oa2,sh");
       
       Run2Test("Obcopy"); 
       
       cart("obcopy"); 
       
    //  cart("objivar")
       
       Run2Test("Mih"); 
       
       cart("mih"); 
       
       }
     
     
     if ( do_all || do_sfunc ) {
       
       hdg("S-FUNCTIONS"); 
       
       RunSFtests("Sscan,Bscan,Cut,Cmp,Sel		\  
              ,Shift,Median,Findval,Lip");; 
       
//============================
       RunSFtests("BubbleSort,Typeof,Variables,Trig,Caz,Sizeof		\  
              ,Limit,D2R,Cbrt,Fabs");; 
       RunSFtests("Round,Trunc");
//============================
       
/// chem    -- find an atomic number for an element
       
       Run2Test("Chem"); 
       cart("chem0"); 
       
       RunTests2("Packb","packb,packalot");
    
//============================    
       
       }
     
     
     
//////////////////// BUGFIXs/////////////////////////////////////////
     
     if ( do_all || do_bugs ) {
      //cart("bf_40")   // this has intentional error and exits before test checks
       
       RunTests2("BUGFIX","bf_46,bf_59,bf_64,bf_75,bf_76,bf_78,bf_79		\  
              ,bf_80,bf_83,bf_84,bf_89,bf_91,bf_96");; 
    
       }
     
     /{
       if ( do_all || do_threads ) {
         Run2Test("Threads"); 
         cart("threads"); 
    
         }
       /}
  ///////////////////////////////////////////////////////////////////////////////////////////
     
     
// and the Grand Total is ???
     
     pcc = rt_pass/(1.0*rt_tests) * 100; 
     
     flsz = caz(FailedList); 
     
//<<"failed list size $flsz \n"
     
     if (flsz >= 1) {
       
       <<"\n These $flsz modules  failed! \n"; 
       <<[Opf]"\n These $flsz modules  failed! \n"; 
       
       FailedList->Sort(); 
       
//<<" %(2,\t, ,\n)$FailedList \n"  // would like this to work like for vectors ---
       
       for (i = 0; i < flsz ; i++) {
         <<"$FailedList[i] \n"; 
         <<[Opf]"$FailedList[i] \n"; 
         <<[Tff]"$FailedList[i] \n"; 
         }
       }
     <<"----------------------------------------------------------------------------\n"; 
     
     
     lsz = caz(CrashList); 
     
//<<"$lsz \n"
     
     if (lsz > 1) {
       
       <<"\n These $lsz modules   crashed! \n"; 
       <<[Opf]"\n These $lsz modules   crashed! \n"; 
       
       CrashList->Sort(); 
       
//<<" $CrashList \n"
       for (i = 0; i < lsz ; i++) {
         <<"$CrashList[i] \n"; 
         <<[Opf]"$CrashList[i] \n"; 
         <<[Tcf]"$CrashList[i] \n"; 
         }
   
       }
     <<"----------------------------------------------------------------------------\n"; 
     <<"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass 		\
       		 Score %6.2f$pcc Fail %d$(flsz[0]) Crash $(lsz[0]) vers $(get_version())\n"; 
     
     <<[Opf]"$(date(1)) Modules $n_modules Tests $rt_tests  Passed $rt_pass 		\
       		 Score %6.2f$pcc Fail %d$(flsz[0]) Crash $(lsz[0]) $(get_version())\n"; 
     
     
     fflush(Opf); 
     cf(Opf); 
     
     fflush(Tcf); 
     cf(Tcf); 
     
     fflush(Tff); 
     cf(Tff);
     
     changeDir(cwd); 
     
//!!"pwd"
     
//<<"cp Scores/score_$(date(2,'-')) current_score \n"
     
     
     
//!!"cp Scores/score_$(date(2,'-')) current_score"
     !!"cp current_score Scores/score_$(date(2,'-')) "; 
     
     dtms= FineTimeSince(TM);
     secs = dtms/1000000.0; 
     
     
     <<"script vers $_ele_vers took %6.3f$secs secs		\
       		 %d %V $i_time $x_time\n"; 
     today=getDate(1);
     <<"$today tested $(get_version())\n"; 
     sipause(1); 
     if (pcc < 100.0) {
       <<"$pcc fixes needed!! \n"; 
       }
     else {
       <<"$pcc Success Hooray! \n"; 
       }
     exit(0); 
     
     
     
     
