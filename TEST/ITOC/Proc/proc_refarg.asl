//%*********************************************** 
//*  @script proc_refarg.asl 
//* 
//*  @comment test ref/val arg proc call 
//*  @release CARBON 
//*  @vers 1.9 F Fluorine [asl 6.2.45 C-He-Rh]                             
//*  @date Sat May  9 16:15:25 2020 
//*  @cdate Sat May  9 16:07:07 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();

///
/// procrefarg


chkIn(_dblevel)

Proc Hoo( int a, int b)
{
<<"$_proc  $a $b\n"
a->info(1)
   a = a +1;
b->info(1)
   b = b +1;
   c = a + b;
c->info(1)
  return c;

}

int n = 2;
int m = 3;


  r= Hoo(n,m)

<<"%V $r $n $m\n"


 chkR (r,7)

  r= Hoo(m,n)

<<"%V $r $n $m\n"


  r= Hoo(&n,m)

<<"%V $r $n $m\n"

 chkR (r,7)
 chkR (n,3)



  r= Hoo(n,&m)

<<"%V $r $n $m\n"

 chkR (r,8)
 chkR (n,3)
 chkR (m,4)



  r= Hoo(&n,&m)

<<"%V $r $n $m\n"

 chkR (r,9)
 chkR (n,4)
 chkR (m,5)


chkOut()


///////////////// TBD //////////////////
// should work? if call as Hoo(x,y) or Hoo(&x,&y)
// difference is &x makes it a ref argument so it can be modified inside of proc
// else modification does not carry to calling scope
//
// xic version fails - fix
//