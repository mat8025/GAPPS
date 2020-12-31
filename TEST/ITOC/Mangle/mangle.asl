

int Noo(int x,int y,int z)
{
<<" IN Noo $_proc\n"

<<"%V $x $y $z\n"
  ans=query("$_proc proceed? list arg values");

   if (ans @="q")  {
<<"leaving this bad proc!\n"
   return 0;
 }

x->info(1)
y->info(1)
z->info(1)


int m =x;
int n =y;
int p =z;
int i;
 i->info(1);
 ans = "c"
 for (i=0; i< 3; i++) {

  SV2=testargs(-1,m,n,p,1,2,3)
  //<<"%V$SV2 \n"

   <<"%V $m $n $p\n"
    m++;
    n++;

  <<"%V $i $m $n $p\n";
 // ans=i_read();
  //ans=query("proc?");
  
  
  }
  return n;
}

//===========================//


int m = 0;
int  n= 4;

  for (i=0; i< 3; i++) {


   <<"%V $m $n \n"
    m++;
    n++;

  <<"%V $i $m $n \n"
  ans=query("main ?");
  if (ans @="q")
     break;
     
  }


int j=1;
int k=1;
int g=1;
<<" calling Noo with $j $k $m\n"
 ret=Noo(j,k,m);  // call should work
<<"after Noo $ret\n"
short ks = 3;

<<" calling Noo with $j $ks $m\n"

ans=query("call promote arg  should call \n");
ret = 77;
ret= Noo(j,ks,m);  // call should work
<<"after Noo $ret\n"
if (ret == 77) {
   <<" proc call not done \n"
}


 Svar a = "this  an svar "

a->info(1)

Str sv = "this is a str"

<<" calling Noo with $a $k $sv\n"
 ret = 77;
 ret=Noo(a,k,sv);  // call should fail or warn


<<"after Noo $ret\n"
if (ret == 77) {
   <<" proc call not done \n"
}



exit()