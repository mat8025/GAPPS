

////
allowErrors(-1) ; // keep going

chkIn(_dblevel);


chkT(1)

allowDB("ic_,oo_,spe_proc,spe_state,spe_args,spe_cmf,spe_scope,tok_func")

 DBaction(DBSTEP_,ON_)



void zoo ( double a) {

<<"IN $_proc  $a\n"
  a.pinfo()
  poo()
}

void poo () {

  <<"IN $_proc\n"

}


float addVar (float ya, float yb) {
<<" $_proc  $ya $yb\n"

   ya.pinfo();
   yc = ya + yb

 <<" $ya +$yb =  $yc \n"
   return yc;
}

  x= 2.6
  y = 3.4
<<"%V $y\n"

  poo()
<<" in main 1\n"





ans=ask("step trace debug? [y,n]",1);
if (ans == "y") {
DBaction((DBSTEP_| DBSTRACE_),ON_)  
}


  zoo(x)

<<" in main 2\n"


z=addVar(y,x)

 <<" $y +$x =  $z \n"

  x1 = 4.5
  y1 = 5.5

chkR(z,(x+y)));

z2 = addVar(addVar(y,x), addVar(y1,x1))

  z3 = y + x +y1 +x1

   <<" %V $x $y $x1 $y1 $z2 == $z3 ?\n"
  
chkR(z2,z3));

  z3.pinfo()

chkOut()

exit()