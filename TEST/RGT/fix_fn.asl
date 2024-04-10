
#include "debug.asl"


if (_dblevel > 0) {
   debugON()
}


db_allow = 0

if (_dblevel == 1) db_allow = 1
<<"%V $_dblevel $db_allow\n"

int inflsz = 0;
int outflsz = 0;
int Report_pass = 1;
wasl = "asl"
ntest = 0;



void cart_xic(Str prg ,int kp[])
{
<<"IN $_proc  $prg \n"

 prg.pinfo()
 kp.pinfo()

  symn = ptan(prg)
  prgx = "${prg}.xic"
  symn.pinfo()
<<"looking for $symn xic file <|$prgx| \n"
 kp.pinfo()
found = findVal(kp,symn)
 found.pinfo()
 if (found >= 0) {
   <<" we found  $prg !\n" 
 }
 ans=ask("OK?", 1) ; if (ans @= "q") exit(-1);
 



}



 m_prg = "Ag"

 m_prg.pinfo()

m_prgx = "${m_prg}.xic"

<<"looking for xic file <|$m_prgx|>  \n"
ans=ask("pgname OK?", 1)

IV = vgen(INT_,20,40,1)

<<" $IV \n"
allowDB("spe_,rdp_,ic",_dblevel)
cart_xic(m_prg, IV)

ans=ask("pgname OK?", 1); if (ans @= "q") exit(-1);

 pk = IV
 pk += 30
<<" $pk \n"

 m_prg = "Au"
      
cart_xic(m_prg, pk)

ans=ask("pgname OK?", 1) ; if (ans @= "q") exit(-1);


 pk += 3
 pk.pinfo()
 
m_prg = "Hg"



cart_xic(m_prg, pk)


exit(-1)

