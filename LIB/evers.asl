///  
///  evers - updates counter adds date/time appends msg 
///  


msg = _clarg[1];
<<" <|$msg|>\n"

update = 1;


A= -1;

logf="elog"
fs= fexist(logf);

if (fs> 0) {
A=ofile(logf,"r+")
}

if (A == -1) {
<<"create elog file\n"
A=ofile(logf,"w+")
<<[A]"$(getdir())\n"
update =1
}

entry="1"
int k= 1;
ln =readline(A);
<<"$ln\n"

while (1) {
ln =readline(A);

if (feof(A)) {
  break;
 }
 k++;
if (slen(ln) > 3) {
  entry = ln;
 // <<"$k $entry\n"
 }
}

<<"last $entry\n"

dt= date()
<<"new $k $dt\n"

if (update) {

<<[A]"$k \t$dt $msg\n"
}

