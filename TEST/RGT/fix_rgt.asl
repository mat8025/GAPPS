///
///
///
#include "debug.asl"

   if (_dblevel > 0) {

     debugON();

     }

   db_allow = 0;
   db_ask = 0
   db_allow = 1
   if (_dblevel == 1) db_allow = 1

   <<"%V $_dblevel $db_allow\n";
do_next_ask =0
   int rt_crash = 0;

    int rt_fail= 0

   int rt_pass = 0;

   int inflsz = 0;

   int outflsz = 0;

   int Report_pass = 1;
   Curr_dir = "";

do_cart = 1
do_cart_xic = 1

int rt = -1;

   wasl = "asl";

   ntest = 0;

   CFLAGS = "-cwl";

   Todo=ofw("to_test");

   do_query = 1;

   CrashList = ( "xxx",  )  ; // empty list;

   CrashList.LiDelete(0) ; // make empty;

   FailedList = ( "fail",  )  ; // empty list --- bug first item null?;

   FailedList.LiDelete(0);

   //allowDB("spe_statex,spe_proc,vmf",db_allow);
   //rejectDB("spe_proc_sivs",db_allow);


   int cart (Str prg)
   {

   <<"$_proc <|$prg|> \n";


  // pinfo(prg)
   <<" this should be variable prg! $prg\n";

   int wscore;

   int wlen;


   <<"$_proc  prg <|$prg|> ==   arg copied correctly?  \n";

   Str wt_prog = "";

   Str wstr ="";

   Str tst_file ="";

   int kt1;
//  in_pargc = _pargc;


   xwt_prog = "xxx";

   Str tim = time();

   wtim = tim;

   wtim.deWhite() ;  // does this VMF wreck it?

   !!"rm -f $prg  ${prg}.tst  last_test*";

   jpid  =0;

 //  jpid.pinfo()  // does this VMF pinfo wreck it?


   if (do_query) {

    //pinfo(prg)
    <<"$do_query \n"

     prg.pinfo() // this one VMF wrecks the program
ans=ask("pinfo OK?", 0) ; if (ans @= "q") exit(-1);
     wprg = "$prg xxx"
     <<"$wprg \n"
     wprg.deWhite() // does this VMF wreck it?  NO
     
     <<"$wprg \n"

      wprg.pinfo() // does this VMF wreck it?
     
     
ans=ask("$wprg OK?", 0) ; if (ans @= "q") exit(-1);

    
     <<"$wasl -o ${prg}.out -e ${prg}.err -t ${prg}.tst $CFLAGS ${prg}.asl \n";



        run_it  = 1;
	if (db_ask) {
     ans= i_read("run it? [y/n]");	
     if (ans @= "n") {
       run_it  = 0;
       }
        }
     }

   <<" this should be variable prg! $prg\n";

   pinfo(prg);
  if (run_it) {
   <<"$wasl -o ${prg}.out -e ${prg}.err -t ${prg}.tst $CFLAGS ${prg}.asl \n";
     !!"$wasl -o ${prg}.out -e ${prg}.err -t ${prg}.tst $CFLAGS  $prg   > /dev/null "
           ans=ask("wait for it", 0) ; 
  }



   <<" Should give same info \n";

   wstr= prg ; // TBF xic error?;

   pinfo(wstr);

   wstr.deWhite() ; // this one VMF wrecks the program ?
   
   <<"%V $wstr \n";
// Str tst_file = "";

   tst_file = "${prg}.tst";

   <<"%V $tst_file\n";

   

!!"pwd"
   cwd= getDir()

   kt =f_exist(tst_file);

 <<"%V $kt $tst_file $cwd\n"
  //    if (f_exist(tst_file) > 0)   // TBF asl ERROR 12/8/23

   if ( kt > 0) {

     wt_prog = "$(time()) ${wstr}: ";
/*
         wlen = slen(wt_prog)
         padit =nsc(40-wlen," ")
	 if (!do_module) {
         <<"${wt_prog}$padit";  // keep

         <<[Opf]"${wt_prog}$padit"	 
         }
*/

     rt_pass++;

     <<"%V $rt_pass \n";
        // wscore = scoreTest(tst_file, wt_prog)
	//<<"%V $wscore\n"

     }

   else {
       //<<"CRASH FAIL:--failed to run \n"
       // insert works??
     pinfo(prg)

  <<"%V $Curr_dir $prg \n"
     rt_crash++;
     wcrash = "${Curr_dir}/${prg}"
     <<"%V $wcrash\n"
     CrashList.Insert("${Curr_dir}/${prg}");

     }

   setErrorNum(0);

   w_file(Todo,"$(getdir())/${prg}.asl $jpid $(time())\n");

//<<"$(getdir())/${aprg}.asl $jpid $(time())\n"

   fflush(Todo);

   ntest++;

   <<"DONE $_proc cart $rt_pass  $prg\n";

   return rt_pass;

   }
//===============================

  void cart_xic(Str prg)
  {

  <<"IN $_proc  $prg \n";

  pinfo(prg);

  int wscore;

  Str  xwt_prog;

  Str lprg = "xxxxxxxxxxxxxxxxx";

  lprg = prg;

  if (!scmp(lprg,prg)) {

   <<"FAIL $_proc  lprg <|$lprg|> ==  prg <|$prg|> \n";

   }
//   allowDB("spe_,pex_",1);
  prgx = "${prg}.xic";

  <<"  <|$prg|> looking for xic file <|$prgx|>  \n";
ans= ask("correct name  ?  <|$prgx|> ",0)
  foundit = fexist(prgx) ;


  <<"looking for xic file <|$prgx|>  found? $foundit \n";

  ans=ask("OK?", db_ask) ; if (ans @= "q") exit(-1);

  if ( foundit > 0) {

   Str tim = time() ;  //   TBC -- needs to reinstated;
   // wt_prog = "$tim "

   xwt_prog = "$tim ./${prg}: ";
//      xwt_prog = "$tim x ${prg}: "
//<<"%V $xwt_prog \n"
//  <<"$wasl -o ${prg}.xout -e ${prg}.xerr -t ${prg}.xtst -dx $prg  \n  "
//ans=query(": ");
        //sleep(0.5);

   !!"rm -f last_xic_test";
     //  prg = scut(prg,2);
//     !!"nohup $prg  | tee --append $ictout "

   if (do_query) {

     <<"$wasl -o ${prg}.xout -e ${prg}.xerr -t ${prg}.xtst -dx ${prg}.xic  \n  ";

    // ans = query("$prg run it?");

     if (ans @="q") {

       exit();

       }

     }
//<<" run xic $wasl <|${prg}.xic|>\n";

   !!"$wasl -o ${prg}.xout -e ${prg}.xerr -t ${prg}.xtst -x ${prg}.xic   > /dev/null ";
// what happens if prg crashes !!

   ntest++;

   fflush(1);

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
!!"ls -l $tst_file"
   //  wscore = scoreTest(tst_file,xwt_prog);

     }

   else {

     <<[Tcf]"#CRASH FAIL:--failed to run $prg\n";

     rt_crash++;

     CrashList.Insert("${Curr_dir}/xic_${prg}");

     }

   }

  }
//================================//


  void RunDirTests(Str Td, Str Tl )
  {
//<<"$_proc $Td  <|$Tl|> \n"

  Str pgname = "xx";

  Str pgxname = "xy";
//pgname.aslpinfo();
//
 Tl.pinfo()
//ri=Tl.info()

  chdir(Testdir);

  chdir(Td);

  Curr_dir = getDir();
     // <<"$Curr_dir $Td\n"
!!"rclup "
  //allowDB("spe_proc,",1);
  Tl.DeWhite()
//allowDB("spe_,rdp_",0)      

  dwtl = Dewhite(Tl);

  Tp = Split(Tl,",");

  np = Caz(Tp);

  <<"%V $Tp $np\n"

  kp =0;


<<"%V $np  how many tests?\n"

ans=ask("$np OK?", db_ask) ; if (ans @= "q") exit(-1);

  for (i=0 ; i < np; i++) {
<<"[$i] <|$Tp[i]|>  \n"

  pgname = Tp[i];

  kp++;
<<"[$i] $kp <|$Tp[i]|>  $pgname\n"

  nl = slen(pgname);

  pgxname = Tp[i];

  prgx = "${pgname}.xic";

  <<"[$i]  $nl <|$Tp[i]|>  == <|$pgname|> ==  <|$pgxname|> $prgx  \n";

 ans=ask("$nl OK?", db_ask) ; if (ans @= "q") exit(-1);

  if (nl > 0) {

   <<"%V $pgname \n";

   pinfo(pgname);
   wpgn = Td;


<<"%V $wpgn \n"
   ans=ask("running $pgname OK?", db_ask) ; if (ans @= "q") exit(-1);
   ntest++

   <<" %V $do_cart\n"
   if (do_cart) {
   
   rt = cart(pgname);
   
   <<"just done cart ? $rt \n"
   ans=ask("$pgname OK?", db_ask) ; if (ans @= "q") exit(-1);
   }
   
   <<"%V $pgname $pgxname  .xic \n";
   if (do_cart_xic) {
   cart_xic (pgxname);

   ans=ask("DONE test $i OK? $nl", db_ask) ; if (ans @= "q") exit(-1);
   }
   
   }

ans=ask("LOOP_<$i> $pgname %V $ntest  $rt_pass OK?", 0)
  }


<<" DONE %V $ntest  $rt_pass exit !\n"

  }
//====================//


  void RunDirFoo(Str Td, Str Tl )
  {
   <<"$_proc $Td  <|$Tl|> \n"

  Str pgname = "xx";

  Str pgxname = "xy";

   Tl.pinfo()
   Tp = Split(Tl,",");

  np = Caz(Tp);

  <<"%V $Tp $np\n"

  for (i=0 ; i < np; i++) {
<<"[$i] <|$Tp[i]|>  \n"

<<" LOOP_<$i> %V $ntest  $rt_pass  !\n"
ans=ask("loop $i OK?", 0)
  }

<<" DONE %V $ntest  $rt_pass EXIT !\n"

  }
//====================//




  pdir=updir();

  chdir("ITOC");

  Testdir = getdir();

  <<"Test Dir is $Testdir\n";

  <<"Starting tests !\n";

// RunDirTests("Array","ae");

 //RunDirTests("Array","ae,arraycmp");

   
 //RunDirTests("Array","ae,arraycmp,arrayele")

 tdir = "Array"
 tscripts = "ae,arraycmp,arrayele"


// RunDirTests( tdir, tscripts)

//  RunDirFoo("Array","ae,arraycmp");


 RunDirTests("Logic","logic,logicops,logicdef")

 ans= ask("do OO next set ?",do_next_ask)
 
// RunDirTests("OO","oa,rpS,rp2,oa2,class_array,simple_class");
 
 RunDirTests("Class","classbops,classmfcall,class2,classvar");

 ans= ask("do next set ?",do_next_ask)
 
  RunDirTests("Proc","procdeclare,proc,procret,procsv0");

 

  <<"Done tests $ntest !\n";

  exit(-1);

//==============\_(^-^)_/==================//
