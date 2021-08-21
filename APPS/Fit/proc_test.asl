///
include "debug"

debugON()

//filterFileDebug(ALLOWALL_,"xxx");
//filterFuncDebug(ALLOWALL_,"xxx")

sdb(2,@pline,@trace)


int a;



 void goo (int p)
 {
<<"covered in $_proc \n"


  }


 void poodoo ( )
 {
 int c= ptan("Au")
<<"and covered in $_proc $c\n"

   
  }


<<"in Main \n"




 goo()

 poodoo()

exit()