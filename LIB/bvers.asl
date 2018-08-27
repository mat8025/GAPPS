///  
///  evers - updates counter adds date/time appends msg 
///  


msg = _clarg[1];

update = 1;


A= -1;

logf="build.cpp"
fs= fexist(logf);

if (fs > 0) {
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
//<<"$k $ln\n"
k++;

while (1) {


ln =readline(A);
//<<"$k $ln\n"

 k++;
 
if (slen(ln) > 3) {
  entry = ln;
  //<<"%V $k $entry\n"
 }

if (feof(A)) {
//<<"EOF \n"
 break;
 }

}

lv = split(entry)

num = atoi(lv[3]);

//<<"[3] $lv[3] $num\n"

//<<"%V $lv[::]\n"

//<<"last $entry   $num\n"

num++;

//<<"%V $num\n"

dt= date()
cf(A)
<<"int build_n = $num ; char build_dt[32] = \"$dt\"; \n" ;

A=ofw(logf);
 fseek(A,0,0)

<<[A]"// build\n"

<<[A]"int build_n = $num ; char build_dt[32] = \"$dt\";\n " ;


cf(A);
