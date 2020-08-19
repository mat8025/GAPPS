Float f = 3

k = f->gettype()


<<" $k \n"

  if (k == FLOAT) {

<<" $k is a FLOAT \n"
  }


  if (!(k == INT)) {

<<" $k is not an INT \n"
  }


  if (k != INT) {

<<" $k is not an INT \n"
  }



Str  s = "NO_MSG"


<<"%V $s $(typeof(s)) \n"


k = s->gettype()


<<" $k \n"

  if ( s @= "NO_MSG" ) {

<<" $s  @= NO_MSG \n"

  }

  if ( s @= "NO_MSGX" ) {

<<" $s  @= NO_MSGX \n"

  }


  if ( !( s @= "NO_MS") ) {

<<" ! $s  @= NO_MS \n"

  }


  if ( !( s @= "NO_MSG") ) {

<<" ! $s  @= NO_MSG \n"

  }


Svar emsg = ""

     emsg = "NO_MSG"

<<"%V $emsg[0] \n"


  if ( emsg[0] @= "NO_MSG" ) {

<<" $emsg[0]  @= NO_MSG \n"

  }

  if ( !(emsg[0] @= "NO_MSG") ) {

<<" ! $emsg[0]  @= NO_MSG \n"

  }


  if ( !(emsg[0] @= "NO_MSGX") ) {

<<" ! $emsg[0]  @= NO_MSGX \n"

  }



stop!

g = STRV

<<"%V $g \n"

  if ( k == STRV ) {

<<" k is a STRV \n"

  }

  if ( k != FLOAT ) {

<<" k is not  a FLOAT \n"

  }

  if ( !(k == FLOAT) ) {

<<" k is not  a FLOAT \n"

  }

  if ( !(k == STRV) ) {

<<" k is not  a STRV \n"

  }

;