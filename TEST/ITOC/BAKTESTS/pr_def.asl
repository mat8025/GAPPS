
OpenDll("math")

#define RED  1
#define ORANGE  2
#define GREEN  3 

//B=i_read("--->")
//<<" OK $B \n"

color = RED ;
// NOTOK
<<"%d $color                $(RED *2)  RED GREEN\n"
<<"%d $color                                $(RED *2)  RED GREEN\n"

//<<"%d $color (RED +GREEN)  $(RED *2)  RED GREEN\n"
//<<"%d $color                  $(RED *2)  RED GREEN\n"
//  FIXIT  calloc of str??
// OK
<<"%d $color             $(RED *2)  RED GREEN\n"





y = 12345678




<<"%v $color (RED +1) $(RED + 1)  RED\n"

<<" $(2 + 1 + RED + GREEN * ORANGE)  RED\n"

<<"%v $color (1 + RED +1) $(RED + 1)  RED\n"


<<"%d %V $y \n"
 


<<" $color (RED +GREEN)  $(RED *2)  RED GREEN\n"

//<<" rgb  ",RED," and jolly good ", "\n"

  // testargs("hey whats up",1,2)

 // printf("hey whats up %d %d",1,2)


<<" GREEN is $(GREEN) %d $y\n"

<<"%d $y GREEN is $(GREEN) %d $y\n"

stop!

;