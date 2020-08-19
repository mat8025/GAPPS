///
/// @vers
///

checkIn()

srcfile = _clarg[1];

if (srcfile @= "") {
<<"no script file entered\n"
  exit();
}

sz= fexist(srcfile,RW_,0);

<<"$srcfile exists  RW size $sz \n"

if (sz == -1) {
<<"can't find script file $srcfile\n"
  exit();
}

checkNum(sz,0,GT_);

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
checkNum(ret,1);
dret=fstat(fn,"cdate")
<<"$fn cdate $dret\n"

fn = "goo"

ret=fstat(fn,"size")
<<"$fn size $ret\n"

ret=fstat(fn,"mode")
<<"$fn mode %o $ret\n"

ret=fstat(fn,"isreg")
<<"$fn regular $ret\n"
checkNum(ret,0);
dret=fstat(fn,"cdate")
<<"$fn cdate $dret\n"

checkOut()