///  
///  Gapps
///

update = 1;
proc vers2ele( vstr)
{
 //int maj = atoi(spat(vstr,"."))
 //int min = atoi(spat(vstr,".",1))
 pmaj = atoi(spat(vstr,"."))
 pmin = atoi(spat(vstr,".",1))

 elestr = pt(pmin);
 str ele =" ";
 ele = spat(elestr,",")
//<<"$ele $(typeof(ele))\n";
//<<"$ele";
 return ele;
 
}
//======================
A=-1;
//fs= fstat("log","size");
logf="vlog"
fs= fexist(logf);
//<<"%V$fs\n"
if (fs> 0) {
A=ofile(logf,"r+")
}

if (A == -1) {
<<"create vlog file\n"
A=ofile(logf,"w+")
<<[A]"$(getdir())\n"
update =1
}

entry="1.0"
int k= 0;
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

lv = split(entry)

//<<"%V$lv[0] $lv[1]\n"
vers = lv[0];
ev = vers2ele(vers)

<<"last  $ev $entry\n"

dt= date()

maj = atoi(spat(vers,"."))
min = atoi(spat(vers,".",1))

//<<"%V$maj $min\n"

if (update) {
 min++;
 if (min > 100) {

  maj++;
  min =1;
 }

}

//<<"%V$maj $min\n"
vers = "${maj}.$min"
ev = vers2ele(vers)
dt= date()
<<"new  $ev $min $maj $dt\n"

if (update) {

<<[A]"$vers $ev $dt\n"
}

