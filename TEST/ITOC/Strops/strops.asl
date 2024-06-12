///
///
///


#include "debug"

   if (_dblevel >0) {

     debugON();

   

     }

   chkIn();

   db_ask = 0;
   db_allow = 1;


allowDB("opera_,str,array_parse,parse,rdp_,pex",db_allow)



astr = "Cheese and Pickle"

<<"%V $astr \n"

chkStr(astr, "Cheese and Pickle")

Svar name[] = { "Mark Terry", "use standard libraries!" }

<<" $(typeof(name)) $name \n"

<<" $name \n"

<<"assignment: $name[0] \n"

<<"%v $name[1] \n"


 subname = sele(name[0],3,5) ;  // index 3 get 5 chars

<<"%V $subname \n"

 chkStr(subname,"k Ter")

 subname = sele(name[1],3,5)

<<" $subname \n"

 subname = sele(name[1],0,-2)

<<"sele(name[1],0,-2) $subname \n"


 subname = name[1]->trimStr(0,-4)

<<" trimstr (0,-4) $subname \n"

 subname = name[1]->trimStr(4,-5)

<<" trimstr (4,-5) $subname \n"

 subname2 = name->GetSubStr(3,5)


<<"GetSubStr:  $subname2 \n"


 subname1 = name[1]->GetSubStr(3,5)


<<"%I $subname1 \n"



 subname0 = name[0]->GetSubStr(3,5)

<<"%v $subname0 \n"


 subname0 = name[0]->GetSubStr(-6,4)


<<"%v <$subname0> \n"

 subname0 = name[0]->GetSubStr(-6,-4)


<<"%v <$subname0> \n"

 subname0 = name[0]->GetSubStr(3,5)

<<"%v $subname0 \n"
 subname0 = name[1]->GetSubStr(3,5)

<<"%v $subname0 \n"


 mkname = name[0].GetSubStr(3,5) @+ name[1].GetSubStr(3,5)


<<"addition vi @+ operator: %v $mkname \n"



 mkname = name[1]->Getsubstr(3,5) @+ name[0]->GetSubStr(3,5)


<<"%v $mkname \n"


// SPLICE


 name[0].Splice("splice this",3)


<<" $name[0] \n"

 name[0].Splice("and this at end__",-1)

<<"Splice: $name[0] \n"

//  PASTE


 name[0].Paste("paste this ON",3)


<<"Paste: $name[0] \n"



// STRCAT

 name[2].Cat("this ", " is ", "the ", "place ","to be")

<<"Cat:  $name[2] \n"


 name[8].Cpy("into record 8 ")

<<"Cpy:  $name[8] \n"

// SUBSTITUTE


name[0].Substitute("paste this ON"," Substitute my truth with lies ") 
 
<<"Substitute: $name[0] \n"

chkOut(1)


/////////////////////


/// TBD /////


// subscript the svar variable
// name[0:5:2]->DoSomething()
// ns = name[0:5:2]->GetSomething()
