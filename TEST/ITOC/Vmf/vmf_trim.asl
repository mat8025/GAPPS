/* 
 *  @script vmf_trim.asl 
 * 
 *  @comment test trim func 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.55 C-Li-Cs] 
 *  @date 10/15/2021 09:07:09 
 *  @cdate Tue Mar 12 07:50:33 2019 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                     

<|Use_=
Trim(S)
Trims a string variable (or array of strings)
S->Trim(nc) - trims chaaracters from head or tail of string
S[a:b]->Trim(- 4)
would trim four chars from end of  a range of an array of strings - where S is an array
S->Trim(4)
would trim four chars from nead of  a range of an array of strings - where S is an array 
|>


#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_ \n"    
}

allowErrors(-1) ; // keep going

chkIn(_dblevel)


svar  S = "una larga noche"

<<"%V $S\n"

<<" $(typeof(S)) $(Caz(S)) \n"

S[1] = "el gato mira la puerta"

<<"%V $S[1] \n"


S[2] = "espera ratones"

<<"%V $S[2] \n"

S[3] = "123456789"

<<"%V $S[3] \n"


<<"%V $S[0] \n"




<<"%(1,,,\n)$S \n"

S.pinfo()

S.trim(-3)

<<"%(1,,,\n)$S \n"


chkStr(S[3],"123456")

S[3].trim(3)

<<"%V$S[3]\n"

chkStr(S[3],"456")

S.trim(3)

chkStr(S[3],"")


<<"%(1,,,\n)$S \n"

//chkStage("Trim")
chkOut()
