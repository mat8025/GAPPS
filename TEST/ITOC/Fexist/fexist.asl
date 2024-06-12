/* 
   *  @script fexist.asl
   *
  *  @comment text status of file
  *  @release CARBON
  *  @vers 1.4 Be Beryllium [asl 6.3.65 C-Li-Tb]
  *  @date 12/10/2021 08:45:56
  *  @cdate 1/1/2001
  *  @author Mark Terry
  *  @Copyright © RootMeanSquare  2010,2021 →
  *
  *  \\-----------------<v_&_v>--------------------------; //
 */ 


  ;//----------------------//;
  
<|Use_= 
  Demo  of text status of file
/////////////////////// 
|>

#include "debug"

  if (_dblevel >0) {

  debugON();

  <<"$Use_ \n";

  }

  chkIn();
//na = argc();

  na = Caz(_clarg);

  <<"$na $(argc())\n";

  srcfile = "";
//if (argc() > 0) {

  if (na > 0) {

  srcfile = _clarg[1];

  }

  <<"%V$srcfile\n";

  if (srcfile @= "") {
//<<"no script file entered\n"

  srcfile = "fexist.asl";

  }

  <<" %V $srcfile\n";

  sz= fexist(srcfile,RW_,0);

  <<"$srcfile exists  RW size $sz \n";

  if (sz == -1) {

  <<"can't find script file $srcfile\n";

  exit();

  }

  chkN(sz,0,GT_);

  for (i = 1; i<=10; i++) {

  ok= fexist(srcfile,i,0);

  <<"mode $i $ok\n";

  }

  A=ofw("foo");

  cf(A);

  fn = "foo";

  ret=fstat(fn,"size");

  <<"$fn size $ret\n";

  ret=fstat(fn,"mode");

  <<"$fn mode %o $ret\n";

  ret=fstat(fn,"isreg");

  <<"$fn regular $ret\n";

  chkN(ret,1);

  dret=fstat(fn,"cdate");

  <<"$fn cdate $dret\n";

  fn = "goo";

  ret=fstat(fn,"size");

  <<"$fn size $ret\n";

  ret=fstat(fn,"mode");

  <<"$fn mode %o $ret\n";

  ret=fstat(fn,"isreg");

  <<"$fn regular $ret\n";

  chkN(ret,0);

  dret=fstat(fn,"cdate");

  <<"$fn cdate $dret\n";

  chkOut();

//===***===//
