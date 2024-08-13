//
//
//
//  TBF 8/5/24    global ref not working

 db_ask = 0;
 db_allow = 1;

 checkMemory(0)
 alm =alignMemory(32)
 <<"%V $alm\n"


 chkIn(1)

allowDB("spe,rdp,ds",1)

int Ntp_id =0

void cons()
{

   Ntp_id++;

<<"$_proc $Ntp_id \n"

}


  for (i=0; i<5; i++) {

       cons()
  }


<<"%V $Ntp_id\n"


 chkN(Ntp_id,5)


 /*
  FIXED 8/5/24

  spe_scopesindex.cpp 
  needed to which_siv = checkGlobalVar (name, vc);
  
  before looking for and or make local proc variabls 




  spe_scopesindex.cpp  needs refactoring




*/