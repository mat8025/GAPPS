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

<<"[2] $entry \n $lv[0] $lv[1] $lv[2]\n"

vers = lv[2];

<<"%V $vers\n"
vers = scut(vers,-1);
vers = scut(vers,1);
<<"%V $vers\n"
v = split(vers,".")
<<"%V $v\n"

bmaj = atoi(v[0]);
bmin = atoi(v[1]);
num = atoi(v[2]);

<<"[2] $v[2] $num\n"

//<<"%V $lv[::]\n"

//<<"last $entry   $num\n"

num++;

<<"%V $num\n"
 if (num > 100) {
     num = 1;
     bmin++;
 }

 if (bmin > 100) {
     bmin = 1;
     bmaj++;
 }
 if (bmaj > 100) {
     bmaj = 1;  // probably never happen
 }

<<"%V $bmaj $bmin $num\n"

dt= date()
cf(A)

<<"char asl_version[32]= \"${bmaj}.${bmin}.$num\" ; char build_dt[32] = \"$dt\"; \n" ;




A=ofw(logf);
 fseek(A,0,0)

<<[A]"// build version\n"

<<[A]"char asl_version[32]= \"${bmaj}.${bmin}.$num\" ; char build_dt[32] = \"$dt\"; \n" ;


cf(A);
