/* 
 *  @script scmp.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.46 C-Li-Pd]                               
 *  @date 08/10/2021 08:14:03 
 *  @cdate 08/10/2021 08:14:03 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
;//

<|Use_=
  check str compare syntax     s == "string" ;  s != "abc";
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


chkIn(_dblevel)


float f = 3;

k = f->gettype()


<<" $k \n"

  if (k == FLOAT_) {

<<" $k is a FLOAT \n"
chkT(1)
  }


  if (!(k == INT_)) {

<<" $k is not an INT \n"
  }


  if (k != INT_) {

<<" $k is not an INT \n"
  }



Str  s = "NO_MSG"


<<"%V $s $(typeof(s)) \n"


k = s->gettype()



<<"%V $k $(STRV_) \n"

  if ( s @= "NO_MSG" ) {

<<" $s  @= NO_MSG \n"
              chkT(1)
  }
  else {
        chkT(0)
  }

  if ( s == "NO_MSG" ) {

<<" $s  == NO_MSG \n"

  }
  else {
        chkT(0)
  }


  if ( s @= "NO_MSGX" ) {

<<" $s  @= NO_MSGX \n"

  }


  if ( !( s @= "NO_MS") ) {

<<" ! $s  @= NO_MS \n"

  }


  if (  s != "NO_MS" ) {

<<" $s  != NO_MS \n"

  }


  if ( !( s @= "NO_MSG") ) {

<<" ! $s  @= NO_MSG \n"

  }


Svar emsg = ""

     emsg = "NO_MSG"

<<"%V $emsg[0] \n"


  if ( emsg[0] @= "NO_MSG" ) {

<<" %V $emsg[0]  @= NO_MSG \n"

  }


  if ( emsg[0] == "NO_MSG" ) {

<<" %V $emsg[0]  == NO_MSG \n"
     chkT(1)
  }

  if ( !(emsg[0] @= "NO_MSG") ) {

<<" ! $emsg[0]  @= NO_MSG \n"

  }


  if ( !(emsg[0] @= "NO_MSGX") ) {

<<" ! $emsg[0]  @= NO_MSGX \n"

  }


  if ( emsg[0] != "NO_MSGX" ) {

<<" $emsg[0]  != NO_MSGX \n"
  chkT(1)
  }


chkOut()