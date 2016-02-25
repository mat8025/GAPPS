
set_debug(1)


 CLASS fruit  {

   public:

    str color

    int y ;

  CMF fruit()
    {
     <<" doing fruit constructor for $_cobj \n"
       color = "white"
       y = 5
    }

  }

 fruit apple

<<" after class dec !\n"

   z= apple->y;

<<" %v $z \n"
<<" %v $apple->color \n"

   apple->color = "green"

<<" %v $apple->color \n"


STOP!