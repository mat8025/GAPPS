
///
///  convert asl <<" %V $var \n"
///  to a cout
///  cout << "var " << var << endl;
///




//<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"

// << _scope

//Str s = ' cmf %V $_scope $_cmfnest $_proc $_pnest\n' ;



void trans ()
{
<<"$s\n"
s2= ssub(s,"<<\"","'")
//<<"$s2\n"

s2 = ssub(s2,"\\n"," endl ")

s2 = ssub(s2,"\\t","   ")

//<<"$s2\n"
s2 = ssub(s2,";"," ",0)
//<<"$s2\n"
s2 = ssub(s2,"\"","'")
//<<"$s2\n"
s2 = ssub(s2,"\'","",0)
//<<"$s2\n"
Svar t = split(s2)
sz= Caz(t);
//<<"split $sz t: $t\n"
//<<"$t[0] $t[1]\n"
Str wd
 add_name = 0;
 co = 'cout '; 
 char c;
 for (i=0;i<sz;i++) {
  wd= t[i]
  c=wd[0];
//<<[2]"<|$wd|> $c \n"  
  if (scmp(wd,'%V',2)) {
//<<[2]"\nis a fmt\n"
    add_name = 1;
  }  
  else if (c == '$') {
// <<[2]"<|$wd|>is a var\n"
   var = scut(wd,1)
   if (add_name) {
     co=scat(co," <<\"$var \"<< $var ")
     }
   else  {
   co=scat(co," <<\" \"<< $var ")
   }
  }
  else if (wd == "endl") {
  //<<[2]" endofline\n"

   co=scat(co," <<endl ")
  }  

  else {
   co=scat(co," << \"$t[i] \" ")
  }
 }
co=scat(co,";");
}

Str s = '<<" $i $IGCTIM[i] $IGCELE[i] ; $IGCLAT[i] ;  $IGCLONG[i] \n";';
Str s2;
Str co= "";

//s= '<<"%V  $nl $Wtp[nl].Place   $Wtp[nl].fga\n";'

s= '   \
<<"$n_legs $Wval[0] $Wval[1] $Wval[3] $Wval[4] \n" '


 trans()

<<"   $co \n"

do_file = 0;

if (do_file) {

A=ofr("asl_lines")
B=ofw("cpp_lines")

//B=1;
int k =1;
while (1) {
co="";
s=readline(A,-1,1)
 trans()
 <<"$k <|$co|> \n"
<<[B]"$co \n" 
  k++;
if (ferror(A) == EOF_ERROR_) {
  break;
}
 if (k>20) {
;
  }
}


//cf(B)
cf(A)
}

exit()



