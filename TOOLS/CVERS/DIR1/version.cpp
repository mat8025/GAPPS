/////////////////////////////////////////<**|**>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////                                      version     
///   CopyRight   - RootMeanSquare   
//    Mark Terry  - 1995 -->                
/////////////////////////////////////////<v_%_v>\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// /. .\
// \ ' /
//   -

#include "sidefs.h"

#include <gasp-conf.h>
#include "si.h"
#include "gwmdefs.h"
#include "chem.h"
#include <iostream>


extern char build_dt[];

extern char asl_version[];  // 

void show_version(void) 
{
  Svar vers;
  vers.findTokens(asl_version,'.');

  int major = atoi (vers.ap[0]);
  int minor = atoi (vers.ap[1]);
  int micro = atoi (vers.ap[2]);
  
  std::cout << major << "." << minor << "." << micro
	    << "  " << Elements[major].getSymbol()
	    << "-"  << Elements[minor].getSymbol()
            << "-"  << Elements[micro].getSymbol()
  	    << " " << build_dt << "\n";

}
//=======================================================

void check_versions (int argc, char *argv[])
{
  // if a number -- return name
  // if a name return atomic number
    int ele;
  if (argc > 2) {

    ele = atoi (argv[2]);

    if (ele > 0 && ele < 120) {
      ;
    }
    else {
      char *ename = argv[2];
      ele = getEle(ename);
    }

    std::cout << ele << " " << Elements[ele].getSymbol() 
              << " " << Elements[ele].getName()  
              << " " << Elements[ele].getWt() <<"\n";
  }
  else {
    show_version();
  }
}
//-------------------------------------------------------


int wc_wait(double delay);

#if RTU
int MC_wait(float delay)
{
int ast_time;
	
   ast_time = (int) (1000.0 * delay);
   ast_time = astpause (50, ast_time);
   while (ast_time > 1)
   ast_time = astpause (50, ast_time);
}
#else
int MC_wait(float delay)
{
  wc_wait(delay);
}
#endif


/* history
 * 06-10-2018      6.15 lhs/rhs obj ptrs
 * 05-25-2018      6.14 lhoffset,froffset (RECORD), exit msg
 * 05-12-2018      6.13 searchRecord , Msg Set Write
 * 04-12-2018      6.12 rework checkNum(a,b,opr,prec)
 * 03-29-2018      6.11 wogetValue
 * 03-07-2018      6.10 rework getExp(exprn,&result) -
 * 02-26-2018      6.9  more debug options and tracing info - testargs reformat
 * 02-18-2018      6.8  added a pool Svars for parsing less memory ops needed
 * 02-14-2018      6.7 added FLsvar - for parsing - (no memory ops - needed)
 * 02-04-2018      6.6 use DBPF as debug throughout
 * 02-03-2018      6.5 added more record functions for edit,sort,delete - buffer record send to xgs
 * 1-24-2018      6.4 added more record functions for edit,sort,delete - code now in separate record dir/lib
 * 1-12-2018      6.3 query function, clsf commandline parser modules rework
 * 1-06-2018       6.2 timer stop fix add timer to test checkout
 * 1-05-2018       6.1 motion events bufered, wcom message rework
 * 1-02-2018       5.100 motion events bufered, wcom message rework
 * 12-17-2017   5.99   fix for nested func expansion - arg debug improvement
 * 11-08-2017   5.97   removed gotos -check pan code
 * 11-01-2017   5.96   using same name h per cpp file to control debug
 * 10-22-2017   5.95   class dev - add torf,yorn
 * 10-14-2017   5.94   split spe lib into rdp,opera,vec,pexpnd,spe libs
 * 10-12-2017   5.93   PTR_ARG
 * 10-06-2017   5.92   array subscript rework
 * 09-30-2017   5.91   submat, sgrid
 * 09-21-2017   5.90   wo_sheet mods
 * 09-20-2017   5.89   navi igc - Realloc downsize fix
 * 09-11-2017   5.88   sivp Gevent
 * 09-11-2017   5.87   gsock member functions for script functions
 * 09-05-2017   5.86   using member functions for script functions
 * 08-27-2017   5.85   revise wcom lib
 * 08-24-2017   5.84   moved stat into math lib -- added wave script class
 * 08-24-2017   5.83   added Tsf,Vsf,Msf script classes for math,top,vec methods
 * 08-22-2017   5.82   fix for parse e fmt number
 * 08-18-2017   5.81   log error numbers to His journal file
 * 08-16-2017   5.80   wcdata,wdata
 * 08-12-2017   5.79   functions - contain module location
 * 08-01-2017   5.78   parset-> reset each print
 * 08-01-2017   5.77   using build dir --- redo lib alias --> gapps/LIB 
 * 08-01-2017   5.76   itoa 
 * 07-23-2017   5.75   declare array's 
 * 07-19-2017   5.74   declare cmplx 
 * 07-9-2017   5.72   timedate_l module
 * 06-21-2017  5.70   fix for getSize - PROC_ARG_REF
 * 06-07-2017  5.69   exeGwmFunc
 * 04-28-2017  5.67   Siv-->ds lib
 * 04-28-2017  5.66   record mods
 * 04-24-2017  5.65   record str select
 * 04-18-2017  5.64   more record functions
 * 04-05-2017  5.63   color print defines
 * 01-19-2017  5.61   use svar[i] as indirect var ptr
 * 01-12-2017  5.60   record print format
 * 01-06-2017  5.59   records lhs ops icode_store
 * 01-03-2017  5.58   records lhs ops exp_lhs assign check revise
 * 12-32-2016  5.57   records lhs ops
 * 12-29-2016  5.56   records == array of Svars with field spec R[1][3] 4th str of 2nd record 
 * 12-20-2016  5.55   iread returns STRV
 * 12-17-2016  5.54   tag arg WS fix
 * 12-05-2016  5.53   continue statement
 * 11-27-2016  5.52   added some internal defines
 * 11-16-2016  5.51   isSivValid(sivp)
 * 11-16-2016  5.50   woselectsheetrowscols, proc arg parsing
 * 10-14-2016  5.49   diff time com.cpp
 * 10-14-2016  5.48   revise trantable (new compiler ptr to function constraint?)
 * 09-24-2016  5.46   vmf event code to event_l
 * 05-08-2016  5.45   nested include
 * 05-06-2016  5.44   include wrtexe fix
 * 04-30-2016  5.43   svar cpy token Variable -rework
 * 04-26-2016  5.42   parse error for loop end now causes exit, playfile args
 * 04-26-2016  5.41   Data frame,channel headers
 * 04-22-2016  5.40   Vox headers
 * 04-21-2016  5.39   fix SQ argument '\n' for fprint
 * 04-19-2016  5.38   split out datastructure routines from gscom to ds (lib)
 * 04-18-2016  5.37   GS_window add curs_id
 * 04-13-2016  5.36   reworking transcription routines - just major,minor as version
 * 04-11-2016  5.2.36 reworking transcription code
 * 04-11-2016  5.2.35 scalar offset fix var_get_class_member 
 * 04-10-2016  5.2.34 MD icode fix
 * 04-07-2016  5.2.33 vmf read, clear class_dec
 * 03-30-2016  5.2.32 added efree for Svar --  global sub of DBT for DBP -- for debug
 * 03-26-2016  5.2.31 readWsTokens - refactor svar.cpp
 * 03-24-2016  5.2.30 spreadsheet wo cells (litewt TBD) some header refactoring
 * 03-21-2016  5.2.29 audio header routines now read old/new vox, aud and pcm 
 * 03-20-2016  5.2.28 navi takes a regex search pattern for files
 * 03-17-2016  5.2.27 dobject AW flag set used for verifiying delete operation
 * 03-16-2016  5.2.26 STRV icode fix
 * 03-13-2016  5.2.25 exp_e - fix morestatement, fix arrayspecs (nested class array dec)
 * 03-11-2016  5.2.24 refactor storevar,getvar,scope,class 
 * 03-09-2016  5.2.23 svar was vector now can be mdimn array
 * 03-07-2016  5.2.22 rdp code break up
 * 03-05-2016  5.2.21 post op A[k++] unary rework  (extra debug confuses error report)
 * 02-29-2016  5.2.19 stateparse added asl_error_codes to functions
 * 02-28-2016  5.2.18 function trace debug, findvar recursion bug fixed
 * 02-27-2016  5.2.17 rework si.h, asl_error_codes
 * 02-26-2016  5.2.16 static OOC fix
 * 02-25-2016  5.2.16 svar getWord , Ann reboot
 * 02-24-2016  5.2.14 OOC fix, added filter builtin while input loop for building pipe modules.
 * 02-22-2016  5.2.13 -k <fname> option to keep code from -s one liner option.
 * 02-22-2016  5.2.12 string splice, semsf functions, -s one-liner code loops now "compiled".
 * 02-21-2016  5.2.10 declare
 * 02-17-2016  5.2.9 sleep, nanosleep, semwait, 
 *                   continuous record have to release AI_mutex to allow other gthreads to proceed
 * 02-16-2016  5.2.8 rework threads have a AI_mutex around each separate gthread statement
 * 02-10-2016  5.2.7 pan-->Decimal pushn
 * 02-09-2016  5.2.6 Ssf,Msf
 * 02-09-2016  5.2.5 pan Init, Cmp ,  pushL
 * 02-06-2016  5.2.4 refactor some ap code - added more Pan member functions
 * 02-03-2016  5.2.3 refactor some dsp code - sp_swab
 * 02-03-2016  5.2.2 Vmf and Asf class -- doxygen comments for functions
 * 01-27-2016  5.2.1 template version of sp_spec,gsFFT
 * 01-26-2016  5.1.9 bitrev,fft decimation in time version, define NOB num of obs,token refactor 
 * 01-25-2016  5.1.8 vector opeq
 * 01-17-2016  5.1.7 strcmp, pan error, dcmplx,testCW,store_copy_var,
 * =====================================================================
 * 01-17-2016  5.1.6 icode reworked as separate lib, reworked test suite
 * 04-11-2014  4.87  can use clarg[] in include ---- include "$_clarg[i]" for control of include setup file 
 * 07-21-2013  4.77  paraex pan fix
 * 07-21-2013  4.76  revising ap math - pan routines - icode
 * 07-13-2013  4.75  revise token module
 * 06-21-2013  4.71  revise args_e module
 * 06-20-2013  4.69  revise Gsocket routines
 * 06-16-2013  4.68  added incr -o -e -t options to direct stdout stderr and test function output
 * 06-14-2013  4.67  added incr and decr methods for Siv
 * 06-12-2013  4.66  Aop used for array ops - activated when siv becomes array
 * 06-10-2013  4.63  reworking class - fixed some HTML color defs
 * 06-02-2013  4.63  fix vs operations - getdate reworked
 * 05-25-2013  4.62  better var hash
 * 05-18-2013  4.61  added nanosleep - thread safe
 * 05-05-2013  4.60  added julmdy
 * 04-05-2013  4.59  fix for missing value gline plot
 * 04-13-2013  4.58  bindec -- can use commas in input to parse bytes
 * 07-29-2012  4.53  write dbi,dbx,his to GS_WORK
 * 07-28-2012  4.52  readMatrix
 * 05-07-2012  4.51  added some top functions - centroid
 * 05-12-2012  4.47  reworked regex, sele functions to search and delete/paste patterns from/into strings 
 * 04-14-2012  4.45  use ^ for BXOR  ^^ for exp -- added GCONTOUR for image segmentation work
 * 12-08-2010  FindSubSet rework
 * 12-29-2008  consts
 * 07-04-2008  He.Be  'this' pointer?
 * 06-21-2008  Helium version start
 * 06-07-2008  rework indirect var 
 * 05-19-2008  transferSvar
 * 05-10-2008  reworking getexp for cleaner transfer of RHS to LHS 
 *         - needed more robust subscript of array info storage on both sides. 
 * 04-22-2008  reworked FindVar,var_ptr,var_index,VarArrayIndexs 
 * 04-19-2008  wo_vtile
 * 04-16-2008  started 1-4.0 version 
 * 03-16-2008  reworking threads
 * 03-08-2008  added break,list to debug
 * 03-05-2008  isArgNumber
 * 03-04-2008  fixed rangextend in dynamic array set operation I[0:30]->Set(0,2)
 * 03-03-2008  sint.c -- contains functions to access internal variables, free, realloc
 * 03-02-2008  CopyScalar STRV
 * 03-01-2008  rework ACLASS class declare
 * 02-25-2008  GetArgSiv - arg offset
 * 02-24-2008  debug stack trace- ptr args rework
 * 02-21-2008  rework bscan   1.3.00
 * 02-20-2008  str dec, rework sscan, pcl_line
 * 02-18-2008  rework CheckProcFunc
 * 02-18-2008  _pargc
 * 02-17-2008  const char* storeString,Dtype,...-  checkConstantExp 
 * 02-16-2008  sort,reverse,shuffle SVAR
 * 02-14-2008  str declaration, CO_siv
 * 02-14-2008  CPS_siv - stack, CP_siv - current proc
 * 02-13-2008  token->isOperator,token->isNum
 * 02-12-2008  hex array dec, print j delimiter specifier
 * 02-02-2008  checkContext
 * 01-31-2008  STRV --- use size 1 (locked) Svar as string - copy value if arg
 * 01-17-2008  LFILL
 * 01-15-2008  sort,reverse,shuffle Lists 
 * 04-01-2008  added Lists type to SIV
 * 01-01-2008  b = $a --- b is a reference to a
 * 10-15-2007  gsocket -- added gsockrecv and gsocksendto
 * 11-23-2007  pass thru CL args if we are running executable script
 * 08-25-2007  NIF number of include files was 5 now 15 --- needs to be dynamic
 * 03-28-2007  LSIVELE --- in <<[B]" $D[0] \n"
 * 03-18-2007  rework gline-wob
 * 18-03-2007  rework matrix op -- 
 * 04-03-2007  rework GS_SYS read
 * 10-10-2006  rework getvar
 * 10-04-2006  record type
 * 10-02-2006  added sqlclose
 * 10-01-2006  added sql query dll
 * 09-26-2006  fix in sob , fix in prtexp
 * 09-26-2006  Opera namespace 
 * 09-24-2006  vmf substr,     added
 * 09-23-2006  bugfix range.compute
 * 09-12-2006  do-while/until
 * 09-01-2006  rework gthreads
 * 08-14-2006  rework spawn from xasl
 * 07-20-2006  XYP - for Gline
 * 05-07-2006  Rework ShowTerrain
 * 06-26-2006  HowFar,TrueCourse
 * 06-22-2006  rework Gline/Swin/GetRP
 * 06-20-2006  p3D -- TerrainGrid
 * 15-03-2006  cmplx Mag/Phase  version 1.2.2
 * 15-03-2006  cmplx vv ops, wo plot,  version 1.2.0
 * 15-01-2006  arg passing for threads
 * 12-01-2006  mods-for AMD64 gcc version 4.0.0 
 * 07-01-2006  PRT_EXP icode, vmf redimn, cmplx math ops
 * 12-29-2005  thread mutexs, bug-fix list-expression
 * 12-21-2005  gthreadsendsig
 * 12-17-2005  revise gthreads
 * 12-01-2005  added CheckEOF
 * 10-09-2005  bugfix - use of scalloc - %,a control array delimiter csv
 * 10-09-2005  vscale - SVD routines -msmooth - mcolsmooth
 * 10-01-2005  bug fix scalar/vector divide
 * 09-25-2005  mv_op -- matrix-vector ops
 * 09-18-2005  IsColVector -- VMF Convert
 * 09-10-2005  matrowcat & matcolcat
 * 08-31-2005  with gcc 4.0.0 used optimize O (instead of O2) -prevent realloc runtime errors -- FIX?
 * 08-14-2005  bug fix proc return in for-if construction
 * 08-07-2005  Prt file handle
 * 07-31-2005  ReadRecord filename or FileHandle
 * 07-23-2005  getargv
 * 07-18-2005  compile for paraexpansion strings
 * 07-03-2005  PEX instruction
 * 05-05-2005  Xstate -- compile
 * 04-21-2005  svar W ; W->Read(A)
 * 04-20-2005  Vmf  variables now have member functions sz=V->Caz() rather than sz= Caz(V)
 * 03-04-2005 - include read for asl
 * spi rename to asl  March 1 2005  - version now 1.0.0
************************************************
 * 12-01-04 - opcode-compiler
 * 10-23-04 - labels and ooc
 * 3.1.8
 * 10-17-04 - GetPtime - time ins secs from process start
 * 10-09-04 - readrecord - ("col:<=",wcol,value) .... acceptance of record
 * 10-03-04 - reuse lstack - reduce new/delete 
 * 10-02-04 - rework msg - event reading from xgs
 * 09-26-04 - SIGCHLD handle of killchild
 * 09-26-04 - dec of char vec via quotes is param expanded
 * 09-19-04 - ReadChildMsg, ReadMotherMsg
 * 09-12-04 - ReadRecord revise
 * 09-12-04 - unique debug file use SetDebug(0,"unique")
 * 09-05-04 - siv::Store methods
 * 08-29-04 - rework of w_data
 * 08-22-04 - packv - dbp -moved gtty.c to spil lib 
 * 08-15-04 - arg passing with SpiSpawn (32 args)
 * 07-31-04 - spi modules - with pipe coms
 * 06-06-04 - popen,bg system
 * 3.0.0
 * 05-23-04 - Icode -> byte code for faster execution
 * 2.11.1
 * 05-19-04 - packb - bunpack
 * 05-17-04 - rescape - vfindval
 * 2.11.0
 * 05-14-04 - ssub - multiple pass using svar fields
 * 05-13-04 - checksum
 * 2.10.9
 * 05-07-04 - hexdec, octdec, bindec - can svar input of multiple fields 
 *          - fix store_copy_sivar 
 *          - ShowSivFlags
 * 2.10.8
 * 05-06-04 - CheckDoState() - for,while,proc
 * 2.10.7
 * 05-04-04 - optional memory checking
 * 2.10.6
 * 05-04-04 - breakout bug - rascii - use scalloc - else false memdebug
 * 2.10.5
 * 05-02-04 - WS tidy - \x in string expansion - wordexp
 * 2.10.4
 * 04-27-04 - IF - SM version
 * 2.10.3
 * 04-21-04 - CodeBlock - proc references CodeBlock
 * 2.10.2
 * 04-17-04 - CodeBlock - Filec/gthread parsing object
 * 2.10.1
 * 04-12-04 - gthread -SwhileSM
 * 2.10
 * 04-10-04 - gthread - DoOtherthreads - for, while, do
 * 2.9
 * 03-28-04 - gthread - started BIG Mutex around spi statement - round-robin - equal priority
 * 2.8
 * 03-24-04 - gsocket - gsockcreate, gsocklisten, gsockaccept, gsock{connect,close,read,write} socket functions
 * 2.7
 * 03-14-04 - gtty - sdev - serial device functions: sdevopen, sdevget, sdevread, sdevwrite, sdevset, sdevclose
 * 2.6
 * 03-11-04 - vexpand, vsplice
 * 2.5
 * 03-09-04 - signal routines sendsig, getsig - use sigaction & sigqueue - can send values <-->
 * 2-4
 * 02-26-04 - signal handle routines sighandler(routine,SIGNAL,[SIGNAL2,...])
 * 2-3
 * 12-31-03 - object array
 * 12-29-03 - multiple inheritance 
 * 2-2
 * 12-23-03 - public,private class member access
 * 12-20-03 - exclamation function stop!  ! indicates no args to call should be last char no space
 * 12-13-03 - Class member function implemented
 * 12-07-03 - Class datamember implemented
 * 2-1
 * 12-03-03 - REGEX use in ssub,spat - started
 * 11-21-03 - Object Orientated Version started
 * 1-101
 * 11-13-2003 <<" %r $A[*]"      the value(s) of SVAR variable A are printed one pre line
 * 11-13-2003 A=<"ls -l"      the listing is the value(s) of SVAR variable A
 * 6-1-2003   <<" %\ $a \n" will prevent \n translated to CRLF
 * 6-1-2003   s2= s[0]{0;3} first 4 chars of svar string to svar s2
 * 5-31-2003  B = { 0;10;2 }  declares an int array 1 dimn  elements 0 2 4 6 8 10 
 *            i.e. from start to finish inclusive if step coincides
 * 1-100
 * 5-15-2003  foo( {1,2,3}}
 * 1.99
 * 5-11-2003  Glines
 * 5-10-2003  Memblock fix 
 * 5-4-2003 - debug print options revise
 * 5-3-2003 - A[j;e] += M   - fix
 * 1.98
 * 3-4-2003 - fix wo_setrs - fix svar init
 * 1.97
 * 2-15-2003 - fix for :  I[("<",0)] = 7   
 * 1.96
 * 1-29-2003 - r_ascii fix, move to screen,switchscreen
 * 1-21-2003 - procedure reference fix
 * 1.95
 * 1-15-2003 - rotaterow
 * 1-15-2003 - dynamic typing -GENERIC type revision
 * 1.94
 * 1-4-2003 - dynamic expand of multidimension arrays
 * 1.93
 * 12-26-2002 - #{ #} comment fixed - 3D functions createscene, moveobject, rotateobject
 * 1.92
 * 12-4-2002 mem-leaks fixed
 * 12-2-2002 shm startup improved
 * 1.91
 * auto-open of DLL's
 * 1.90
 * 10-26-2002 - opera local copies of arrays - only when necessary
 * 1.89
 * 10-19-2002 Saw & Square functions, fix multi-assign
 * 1.88
 * most window calls now can use last window number as implied
 * 1.87
 * renamed to spi signal processing interpreter
 *
 * 1.86
 * 9-10-2002 - r_ascii, r_data to fio dll
 * 9-1-2002 - MinMaxI , Peaks to math dll

 * 1.85 
 * 3-1-2002 - rework of all malloc/free operations
* 1.84
* 1-1-2002  - rework interpretor to give intermediate code
* 12-7-2001 - added Ceil,Floor
* 12-6-2001 - SetRGB
* 12-5-2001 - Mdimn
* 12-4-2001 - Rework of PlotLine,PlotPoint
* 1.83
* 11-22-2001 - Sel array/scalar comparison to give integer array of selected elements
* 11-19-2001 - lset,lsize for extraset reference of array elements A[I[*]] += 1
* 11-18-2001 - Cmp array comparison
* 11-17-2001 - Grand/Urand random functions
* 11-15-2001 - matrix inversion
* 1.82
* 4-15-2001  - added seek_line for positioning at start of any line in file
* 4-15-2001  - split up into shared libs (ap,dsp,gspf,wcom,gscom) and dynamic libs (audiolab,imagelab,math,tran)
* 4-12-2001  - ap_cmp for SINUM GT,GTE,LT,LTE arbitary precision now in shared library libap
* 4-8-2001   -  linked in readline
* 4-7-2001   - Dll_open,Dll_close to access dynamic libs
* 4-2-2001   - sip spawn XGS for xterm command line of plot operations
* 2-23-01    - compile with gcc -2.95.2   (ftime used now instead of gettimeof day)
* 2-20-01    - matmul and other array operations for SINUM
* 1.81
* 2-9-01     - array subscripting   D=C[2;5] or D=C[a,b,c] or D=C[B]] where B is array and recursive as D=C[B[2;5]]
* 1-*-01     - use of C++  class Siv and Svar with member functions
* 1-1-01     - added opera_div_sv   B=1.0/A where A is a vector B is vector of result 
* 1.80
* 12-31-2000 - PTR type pointers to arrays, $ is dereference, can do ++,-- on pointers
* 12-26-2000 - moved some w_ functions to operate via SHM
* 12-23-2000 - NaN error detection -  changed function table calling of tran functions 
* 10-28-2000 -
* 1.79
* 6-20-2000 - matrix multiplication added   C = A ** B    ( int A[2][3] , int B[3][2])  C is [2][2])
* 6-15-2000 - arrays can be manipulated via arithmetic operations  A = B * 3   C = A + B , where A,B are arrays
* 6-1-2000  - template instructions
* 1.78
* 4-11-2000 - scope resolution  ::a (main a)  :b make local - used  :b= 1 - autocreate local (other than int b; b =1;)
* 4-10-2000 - num->sivar - sivar number string ok to eval as array index
* 4-1-2000  - shared memory xgs <-> sip 
* 3-29-2000 - C++ (g++) compile complete - (can't link in readline yet) - OO design start
* 1.77
* 
* 3-23-2000 %v$vname in << statement will print vname value - the format v flag needs to go before others for this feature
* 3-23-2000 added NAND and bitwise XOR ( but because I use ^ as raise to power operator have to use ^^ as bitwise XOR 
* 3-22-2000 allow expression eval in print operator << "$a $(4*7) %6.4f$(4.5*7.68) \n"
*           - (does not apply to sinum yet  but %r will output sinum according to its radix)
*           as specified via preceeding fmt as defined in C language 
* 3-21-2000 format print added e.g. <<"%6.2f$fn\n" the float number fn is formatted into output string 
* 1.76
* 3-20-2000 list usage :  G= "laser_scr(@0)" ;  @G(@0,lw,pw,Spw,Twin,Ele_w) ; sfree(&G) ;
* 3-20-2000 iteration construction :   sinum x=2; C="@0=@0*@0*@0" ; @C'30("x")
* 3-20-2000 added template instructions G="@0=@1+@2" called as @G("x",4,5) ; 
* 1.75
* 3-20-2000 added step -through debugging - option to execute an instruction, skip, stop on error
* 2-28-2000 type promotion/demotion in expr parsing
* 2-28-2000 arbitary length numbers stored and parsed in SINUM format 
* 2-27-2000 input number as e format  e.g. -21.56789e-23  
* 1.74
* 2-19-2000 revise ap_math routines - added ap_sqrt
* 1.73
*          offset and bounds are passed - so shouldn't be able to overun within procedure
*          arrays by reference only. Use -  foo (char x[], int y[])  -  foo (&a[0],&b[10]), 
* 02-03-2000 proc arg call - by value, or by reference foo(x,y) or foo(&x,&y) can be called either way
* 01-25-2000 placement of {} around if, for , while now more flexible
* 1-20-2000 multistatements per line - terminated by ;
* 1-5-2000 added debug options to write out proc call and args DEBUG_PROC_ENTRY DEBUG_PROC_ARGS
* 1-3-2000 AP operations ++/-- == added (bug fix of apsub10
* 1.72
* 23-12-99 sivar variable becomes dynamic array of varchar
* 20-12-99 dynamic arrays
* 1.71
* 12-15-99 redone argument parsing (arbitary length, arbitary number as dependent on memory availiable)
* 12-1-99  added ^=  @+ @- |& operators 
* 11-30-99 set_precision sets number of places after dec point (need tran functions in AP)
* 11-9-99  added arbitary precision AP mul,add,sub,div works in radix 256
* 1.70 
* 10-27-99 added another Balance condition to ANN - any output unit can be favored
* 10-27-99 removed incf from proc structure - bug fix in serror related to src_file of proc
* 1.69
* 10-25-99 procedure variable compound name - hash of proc name + 16 char variable name
* 10-19-99 args and white-space tidied up in passing via send_func to GWM
* 10-14-99 Unary operation minus bug 
* 10-14-99 args delimited by null chars 
* 1.68
* 10-8-99 auto create SIVAR s in scpy(&new,&old) 
* 1.67
* 10-5-99 char * get_arg_sptr()  used to decode str args 
* 10-5-99 arg tags used code strings and addresses
* 10-1-99 ofw,ofr
* 1.66
* 9-29-99 sivar now use dynamic storage
* 1.65
* 9-27-99 reworked quoting of arg list
* 1.64
* 9-26-99 added checkscpy for strcpy abc checksscan for scan input strings
* 1.63
* 9-23-99 using readline GNU lib for cl edit and history
* 9-22-99 include files - exit_si end line auto added
* 1.62
* 9-21-99 sp_ann - ann structure reworked 
* 9-21-99 bug fix a=b=c=d=0 (this was preventing  error reporting of undeclared variables)
* 9-20-99 set_maxerrors (in script before it quits- default 3)
* 9-20-99 redone ann.h header write_net,read_net_wts
* 9-10-99 added v_tanh, get_nodes_layer
* 9-8-99 added get_df_hdsize 
* 9-4-99 added julday - julian day from mon,day-of-month,year (1999) 
* 1.61
* 9-3-99 vv_m can be repeated -cycled by shorter mul vector m times sp_vv_m(x, y, z, n, s1, s2,m)
* 9-1-99 added sele  str operations to get n element of a string  e= sele(str,n)
* 8-27-99 can have more then four-layers in net (need to revise write/read net 
* 8-26-99 get_net_act - return string activation function
* 8-25-99 da4 logger format
* 8-25-99 buf fix char type assignment
* 8-19-99 func hash table written to WORK/stable
* 8-19-99 free_net 
* 8-18-99 check_parc_count
* 8-18-99 add_node,prune_conn,set_conn
* 8-15-99 revise set_net_arch
* 8-14-99 bug fix on else if (foo()) {
* 1.60
* 7-15-99 sort_labels - order_tokens (deletes duplicates)
* 1.59
* 7-9-99 add \t as tab in print command
* 7-9-99 add get_net_ss (sp_ann.c)
* 7-9-99 fix back_up_a_line
* 1.58 
*  =- =+ =*  not defined double operators correctly parsed : b =-4 b =+4 correct
* "-" bug fix
* 6-1-99 sp_ann code now allows flexible wiring of nodes via wire_nodes 
* v_realloc bug fix for ascii type variables
* 1.57
* 5-16-99 read/write on xgs/sip pipes revise for wait and read/write checking
* 5-1-99  y2k date format now year format good y10k
* 1.56
* 3-3-99  test_vars_cw set_vars_cw (was test_cw) - cw for SI_VAR
* 3-3-99  v_realloc (won't work for multidimension arrays yet)
* 2-19-99 added GS_BOX and GS_LINE 
* 2-18-99 command-line args parsing revised
* 2-17-99 added sp_ann code to run nets via script ( should be a library)
* 2-15-99 wcom revision - changed Msg header graphic routine added to Msg header , also target win and wo
* 1.55
* 1-16-99   header now -- GASP size_in_bytes -> END_HEADER
* 1-16-99   fix r_words ascii W[1024]{725} now knows size of ascii variable (default 512)
* 1.54
* 11-17-98  bug-fix check-brace in back-quoted string
* 11-16-98  bug-fix delimiter parse (=
* 1.53
*            but  a= (b >= c) should flag b uninitialised;  b would be a null string if not created prior  
* 11-15-98  a= (b = c) ; vars on LH are created if unknown i.e.  a = b =c even if a and b not created before 
* 11-6-98  <" ls *.vox "   equiv to command(" ls *.vox ")
* 11-5-98  cl arg numbering $0 script-name $1 first cl arg 
* 10-30-98 added set_f_error, clr_f_error to set file status for a file handle (0 OK, other error EOF)
* 10-30-98 added f_error to check file status for a file handle (0 OK, other error EOF)
* 1.52
* 10-23-98 char array string declaration, array list declaration int A[] = { 1, 2, 3}
* 10-15-98 fixed recursion bug - scope name incorporates recursion level so local values not destroyed in recursion
* 1.51
* 10-12-98 parameter expansion in strings " $var " expands value of var into string
* 10-2-98  count_labels count the number of identical tokens
* 9-24-98  isdigit to check whether sivar holds number string
* 9-24-98  str_cpy to sivar preserves spaces, i_read_str returns line without the newline char
* 9-14-98  proc (define) array-bug in procedure call fixed
* 6-28-98 fixed get_exp_in bug (problem with matrix nested expressions )
* 1.50
* null strings dealt with in sip
* 1.48
* debug pid - N_errors reported - func_not_found now a reported error
* 1.47
* alien frame read
* ENDIAN stuff
* 1.46
* if - else if - else construction 
* ++/-- added but postinc not implemented
* 1.45
* 3-4-98 paint_labels - plot if any part in window
* 1.44
* 12-25-97 tack on ff=exit_si() to mark end of code
* 12-25-97 CODE_DB_SI_VAR
* 1.43
* 12-19-97 bug in search_label_time -closest mid_pt
*          is first in msg header
* 12-19-97 attempt to keep track of lost messages after TIME-OUT(magic number
* 12-19-97 changed dbug file to name instead of pid
* 12-18-97 added continue statement
* 12-14-97 bug-fix malloc view_mcs
* 1.42
* 12-04-97 view_mcs - remote file (rd_ascii)
* 1.41
* 11-22-97 use memp in SI_VARS - redid free arrays in procedures
* 1.40
* 11-21-97 si_free -not freeing up array's ( fixed num of SIVARS ?)
* 11-21-97 get_gs_HOME
* 1.39
* 11-15-97 recover_bquote bug fix
* 11-15-97 added reload_src feature to interactively reload code
* 1.38
* 10-06-97 v_symbol
* 10-06-97 n % 0 (bug fix)
* 10-06-97 v_frand
* ascii type can set wordlength in arrays e.g. ascii W[100]{50} wordlen 50
* 1.37
* conditional vv_copy
* m_sort
* sip error line
* 1.36
* 07-25-97 fixed bug in array bound spec A[n * 2 ]
* 07-25-97 v_read returns n of objects read
* 1.35
* 07-18-97 added get_exp in array bound spec , e.g. A[n*2]
* 1.34
* added get_df_para
* 07-02-97 find-menu precedence search
* 1.33
* 05-08-97 fixed str_cpy, added str_ncat
* 1.32
* 05-01-97 fixed sip remove dbug file (has include start dir in path)
* 1.31
* 04-28-97 fic read_channel_file - error in nvals when averaged
* 1.30
* 04-11-97 bit shift operators >> << added
* 04-03-97 RMT and RLT wrong counts in mesg count (fixed ?)
* 04-03-97 added GS_WOTEXT
* 1.29
* 04-01-97 revised get_wrds
* 1.28
* 03-31-97  fixed rwl_file from end bug
* 03-27-97  fixed v_write bug for int
* 1.27
* 03-15-97  fixed byte_order  (bug) get_channel_para, get_byte_order
* 1.26
* 03-05-97  asr_net_input -array size bug
* 02-11-97  sip script file fsize silent
* 1.25
* moded asr_gen_net_input to do word tokens
* 01-30-97  added hsx,hsy shift center to plot_symbol
* 1.24
* 01-29-97  added get_script_dir
* 01-29-97  finetime - calls gettimeofday
* 01-26-97  get_script_dir
* 1.23
* 01-26-97  mod to wcom_gs (write to char buf before pipe write)
* 01-21-97  mod to asr_gen_input
* 01-21-97  vv_smooth
* 1.22
* 01-03-97  +=,-=,*=,/= operators added to sip
* 12-21-96  added char-ascii short-ascii to v_write
            get_channel_para
* 12-13-96  fixed bug in read_channel_head error return for 
* 11-26-96   v_write,v_read auto-detect internal type
* 1.21
* 11-25-96   fixed bug in read_signal_array
* 11-25-96  added check_file_type to inspect header
* 11-15-96  GS_EOF to allow read_chn to check eof and return items read
* 11-15-96  hdrprintf (to allow changes to header-set field length)
* 11-05-96  r_words
* 10-29-96  gs_pad_header size to 64,"    ...
* 10-28-96  added a dbprint for sip dbprint([1,0],"    ...
* 10-27-96  plot_chan - default not to use break-value added extra para ubv
* 10-25-96  added extra message to serror to show name of variable undef,etc
* 1.20
* 10-25-96  can include \n in o_print e.g. o_print("ret\n")
*           can now test string NULL
* 10-25-96  str_pat now has two extra parameters match and charremaining 
* 1.19
* 10-23-96  up CL_args and length
* 10-21-96  version.c,v 1.19 1996/10/22 15:40:08 mark Exp mark $";
* 10-21-96  changed si_pause to use wc_wait si_sop.c & sig.c
* 10-21-96  upped buffer size to VRMLT in view_mcs ed_sigdraw.c
* 10-21-96  upped buffer size to VRMLT in gs_plot_chn dfplot.c
* 10-21-96  changed Wait-interval down to .001 from .4 (big speed up) maybe pipe write blocking now? wcom.c
* 10-21-96  added comparison condition to v_stats
* 10-20-96  added read_signal_array (deleted read_signal_buffer)
* 10-20-96  bug fix v_read (short->float)
* 10-14-96  read_chan average bug  
* 10-14-96  paint_labels will put label if mid-label is in window 
* 10-10-96  added char to v_read,v_write 
* 10-5-96 fixed bug in parse_args 
* 10-2-96 added get_argc 
* 9-26-96 fixed init array bug in read_frame averager 
* 9-3-96 added include files - so we can have "libraries" 
* added delta frame spacing - si_df.c 
* line numbering in debug mode now consistent 
* added break statement - fixed empty line else bug 18-7-96 
* added get_rcs_id and get_script (info on script rcs version) 15-2-96 
* fixed get_env bug 14-2-96 
* but needs a mod for rcs to accept 
* check in/out when releasing new versions of sip 
*
*/




///////////////////////////////////// TODO //////////////////////////////////////
// 
