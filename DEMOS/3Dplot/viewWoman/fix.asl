

setdebug(1);

<<"hey \n"

proc SideView( plt_it)
{

//<<" $_proc $plt_it  $_pargc  $_parg[1]\n"
<<" $_proc $plt_it  $_pargc \n"
 a = plt_it;

<<"%V $a\n"
    <<" hey $plt_it \n"

}

na = argc();

//<<"$na $_clargc  $_clarg[0] \n"
<<"$na   \n"
<<"$na $_clarg[0] $_clarg[1]  \n"
// BUG - _clargc not accessed correctly from xic
<<"$na $_clargc   \n"


<<"calling Sideview\n"
   SideView(1);

   SideView(0);

p = 1;

<<"$p  call \n"
  SideView(p);

p = 0;
<<"$p  call \n"

SideView(p);

