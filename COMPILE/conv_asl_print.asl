
///
///  convert asl <<" %V $var \n"
///  to a cout
///  cout << "var " << var << endl;






//<<"cmf %V $_scope $_cmfnest $_proc $_pnest\n"

// << _scope

Str s = ' cmf %V $_scope $_cmfnest $_proc $_pnest\n' ;

<<"$s\n"

Svar t = split(' cmf %V $_scope $_cmfnest $_proc $_pnest\n')
sz= Caz(t);
<<"split $sz t: $t\n"
<<"$t[2]\n"
Str wd
 for (i=0;i<sz;i++) {
  wd= t[i]
  if (scmp(wd,'%V',2)) {
//<<[2]"\nis a fmt\n"
  }  
  else if (wd[0] == "\$") {
 // <<[2]"is a var\n"
   var = scut(wd,1)
   <<" <<\" \"<< $var "
  }

  else {
<<" << \"$t[i] \" "
  }
 }
<<"\n";

s1=ssub(s, " ",' <<"  " ',0)

<<"$s1\n"

s1=ssub(s1, "%V"," ",0)

s1=ssub(s1, "\$","<< ",0)

<<"$s1\n"

s1=ssub(s1, "\\n","<< endl ; ",0)

<<"$s1\n"

s1= scat("cout  ",s1)

<<"$s1\n"

exit()
