///
///
///
#include "debug"


//debugON()


void Run2Test(str td)
{

//<<" $_proc $td \n"
  td->info(1)
  //changeDir(Testdir)

 // hdg(td)

  //Prev_dir = getDir();

  //chdir(td)
  
 // Curr_dir = getDir();
  
//  <<"changing to $td dir from $Prev_dir in $Curr_dir\n"
}
//===============================
void cart (Str aprg)
{
  int wlen;
  str tim;
  str prg ="xx";
 <<"%V $_proc $aprg    \n"  
//  in_pargc = _pargc;
  
  prg = aprg;

<<"%v $aprg\n"
<<"%v $prg\n"


}
//===============================


//Str wsf;

void RunSFtests(str Td)
{
// list of dirs  Fabs,Cut,Cmp ...
// goto dir then run cart(fabs) or cart(cmp)

      Tp = Split(Td,",");
     str wsf;
     wsf->info(1);
     //  wsf="xx";
       np = Caz(Tp);
      for (i=0 ; i < np; i++) {
         wsf = Tp[i];

//       ans=  query(Tp[i]);    
  <<"%V $wsf\n"
         Run2Test(wsf);
	 wsf = slower(wsf);
         cart(wsf);
      }
}



 //RunSFtests("BubbleSort,Typeof,Variables,Trig,Caz,Sizeof,Limit,D2R,Cbrt,Fabs");
 RunSFtests("BubbleSort,Typeof,Variables");


 RunSFtests("Round,Trunc,Wdata");

