


chkIn()

//#define RED  1
//#define ORANGE  2
//#define GREEN  3 








chkN(2,RED_)
chkN(ORANGE_,3)
chkN(5,GREEN_)


  color = RED_ ;

 <<"%V $color  $(RED_ + 1) \n"

 <<" rgb  ",RED_,"\n"

  ocolor = ORANGE_ ;

  int t_or_f = 0

<<"%V$t_or_f  \n"

      t_or_f = TRUE_

<<"%V$t_or_f  \n"

<<"%V $ocolor  \n"


  color = GREEN_;


<<"%V $color  \n"
<<"AND %V $(AND_) \n"

  if ( (ocolor == ORANGE_ ) AND_ (color == GREEN_ )) {

        <<"$ocolor   AND $color  is TRUE $(TRUE_)\n"
     

     chkT(TRUE_)
   }


  if ( (ocolor == ORANGE_ ) OR_ (color == RED_ )) {

        <<"$ocolor is  $(ORANGE_)  OR_ $color  is RED is  TRUE\n"
        chkT(TRUE_)
   }


y = 1
<<"%V $y \n"





   chkOut()



;
