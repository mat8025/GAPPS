///
///
A=0;
N=35
comment = 0;
while(1) {
S=readline(A)
comment = 0;
if (slen(S) >0) {
if (scmp(S,"#",1)) {
wrd = S;
comment = 1;
}
else {
L = Split(S,",")
len = slen(L[0]);
fd= L[0];
lsz=Caz(L);
W=Split(fd)
sz=Caz(W);
 wrd=W[0];
 
 for (i=1;i<sz;i++) {
  if (scmp(W[i],"<",1)) {
    n= N-(slen(wrd) + slen(W[i]));
    ws=nsc(n," ")
    wrd= scat(wrd,ws,W[i])
  }
  else {
  wrd= scat(wrd," ",W[i])
  }
 }
len = slen(wrd)
if (len < N) {
n= N-len
ws=nsc(n," ")
wrd= scat(wrd,ws)
}

wrd=scat(wrd,",")

}
if (comment) {
len=writeline(1,wrd);
}
else {
<<"$wrd"
 for (i=1;i<lsz;i++) {
<<"$L[i],"
 }
 <<"\n"
}
}
 if (feof(A)) {
   break;
 }
}