
#include "debug";

   if (_dblevel >0) {

     debugON();

     }

   allowErrors(-1) ; // keep going;

   chkIn();

allowDB("ic_,oo_,spe_exp,spe_proc,spe_state,spe_cmf,spe_scope,ds_sivbounds")

   wdb=DBaction((DBSTEP_),ON_) ;



int RunDirTests(Str Td, Str Tl )
{
<<"$_proc <|$Td|>  <|$Tl|> \n"


    return 1;
}

void RunStrTests(Str Td, Str Tl )
{
<<"$_proc <|$Td|>  <|$Tl|> \n"

}

  Str mod = "Bops"
  Str prgs = "bops,fvmeq,fsc1,mainvar,snew"

ok=RunDirTests(mod,prgs);

<<"%V $ok \n"

RunStrTests("Bops","bops,fvmeq,fsc1,mainvar,snew");





ok=RunDirTests("Bops","bops,fvmeq,fsc1,mainvar,snew");


RunStrTests(mod,prgs);


chkT(1)


chkOut()

exit(0)
