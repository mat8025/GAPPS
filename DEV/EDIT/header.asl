
fname = _clarg[1];

A=ofr(fname)
if (A == -1)
 exit()

hdr = scat(scut(fname,-3),"h")
hdr = spat(hdr,"/",1,-1)
<<"$hdr \n"
main= spat(fname,"/",1,-1)
where= spat(fname,"/",-1,-1)

D=ofw(main)
B=ofw(hdr);

<<[B]" \n"
mat = 0;
dbname = "";
founddbf = 0;
first_inc = 0;
done = 0;

 while (1) {

  S= readline(A)
  if (feof(A)) {
     break;
  }
  C= split(S)
  if (C[0] @= "#include") {
  first_inc = 1;
spat(C[1],"dbug",0,1,&mat);
   <<"$C[1] $mat\n"
  if (mat == 1) {
  founddbf = 1;
  dbname = C[1];
  }
  else {

    if (first_inc && !done) {

<<[D]"#include \"$hdr\"\n"
       done = 1;
    }

     <<[B]"$S\n"
     
    <<"$S\n"  ;
     }
  }
  else {
  
  <<[D]"$S\n"

  }
 }


 cf(B)
 
if (founddbf) {

 <<"dbug file is $dbname \n"
 dbf = ssub(dbname,"\"","",0)
 <<"dbug file is $dbf \n"
//D= ofr("/usr/local/GASP/gasp/include/$dbf")
!!"cat $hdr /usr/local/GASP/gasp/include/$dbf > tmp"
!!"cp tmp $hdr"
!!"mv $hdr /usr/local/GASP/gasp/include "
!!"mv $main $where "
}