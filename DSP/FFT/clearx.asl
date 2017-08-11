///
///
///
/// look for executable asl progs - list and remove
///


na = argc()



 mat = 0;
 rem = 0;
 for (i = 1; i < na ; i++) {
   fn = _clarg[i];
   rc = spat(fn,".asl",0,1,&mat,&rem)
//<<"$i $fn $mat $rem $rc\n"
   pma =  regex(fn,"\.a.l")
//<<"$pma \n"
  if (mat == 0) {

//
// so fn should not be #foo# but \#foo#  else head will hang as will more
// fl = !!"head -1 $fn"
// <<"$fl \n"
//


//<<"opening $fn\n"
A=ofr(fn)

 if (A !=-1) {
//<<"$A\n" 
fl1 = readline(A,120)

   rc = spat(fl1,"#!",0,1,&mat,&rem)
   if (mat) {
   rc = spat(fl1,"/bin/asl",0,1,&mat,&rem)
   if (mat) {
<<"EXE $fn $mat $rem $fl1\n"
!!"ls -l $fn"
!!"rm -f $fn"
   }
}
cf(A)
}
   }
 }


exit()