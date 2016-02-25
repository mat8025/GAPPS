

CLASS turnpt 
 {

 public:

  str Lat;



CMF checkDir( c_dir)
{
int la = 1

str the_dir ="W";

   the_dir = c_dir
// FIXIT --- XIC won't do the second -unless the first pass did the second comparision

   if ((the_dir @= "E")) {
<<"East is East \n"
         la *= -1
   }

   if (the_dir @= "S") {
<<"South is South \n"
         la *= -1
   }

   if (the_dir @= "W") {
<<"West is West \n"
         la = 1
   }

<<"%V$c_dir $the_dir $la \n"

   return la
 }


}


turnpt T


k = T->checkDir("E")

<<"$k\n"


k = T->checkDir("S")

<<"$k\n"


k = T->checkDir("W")

<<"$k\n"




