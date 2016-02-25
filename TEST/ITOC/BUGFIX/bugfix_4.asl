// BUG_FIX 

SetPCW("writeexe","writepic")
SetDebug(1)

// version 1.2.50
// bug if ( foo()) { }
// function result ignored !



S="bug"
S[1]="name is bates"
S[2]="fix me"
S[3]="please fix me"
S[4]="fix the if function comparison"

sz=Caz(S)


for (i = 0; i < sz ; i++) {

 ok=scmp(S[i],"name",4)
//<<" $i $ok $S[i] \n"

  if ( scmp(S[i],"name",4) ) {

  <<" found name \n"
  ;
  }
  else 
   {
     <<"noname $S[i]\n"
   }



}

for (i = 0; i < sz ; i++) {

 ok=scmp(S[i],"name",4)
//<<" $i $ok $S[i] \n"
//if ( (scmp(S[i],"name",4)) == 1) {
//FIX if ( (scmp(S[i],"name",4)) ) {
//if ( scmp(S[i],"name",4) ==1 ) {
//FIX  if ( scmp(S[i],"name",4) ==1 ) {
  if ( (scmp(S[i],"name",4)) ==1 ) {
  <<" found name \n"
  ;
  }
  else 
   {
     <<"noname $S[i]\n"
   }



}

STOP!