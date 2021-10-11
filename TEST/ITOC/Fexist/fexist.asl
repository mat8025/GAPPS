///
/// @vers
///


                                                                       
<|Use_=
Demo  of fexist;
///////////////////////
|>


#include "debug.asl"


if (_dblevel >0) {
   debugON()
      <<"$Use_\n"   
}


chkIn(_dblevel)

<<" $(argc())\n"

srcfile = _clarg[1];

<<"%V$srcfile\n"

if (srcfile @= "") {
//<<"no script file entered\n"
  srcfile = "fexist.asl"
}
<<" %V $srcfile\n"
sz= fexist(srcfile,RW_,0);

<<"$srcfile exists  RW size $sz \n"

if (sz == -1) {
<<"can't find script file $srcfile\n"
  exit();
}

chkN(sz,0,GT_);

for (i = 1; i<=10; i++) {
 ok= fexist(srcfile,i,0);
 <<"mode $i $ok\n"
}

A=ofw("foo")
cf(A);

fn = "foo"

ret=fstat(fn,"size")
<<"$fn size $ret\n"

ret=fstat(fn,"mode")
<<"$fn mode %o $ret\n"

ret=fstat(fn,"isreg")
<<"$fn regular $ret\n"
chkN(ret,1);
dret=fstat(fn,"cdate")
<<"$fn cdate $dret\n"

fn = "goo"

ret=fstat(fn,"size")
<<"$fn size $ret\n"

ret=fstat(fn,"mode")
<<"$fn mode %o $ret\n"

ret=fstat(fn,"isreg")
<<"$fn regular $ret\n"
chkN(ret,0);
dret=fstat(fn,"cdate")
<<"$fn cdate $dret\n"

chkOut()