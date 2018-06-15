
setdebug(0)


proc get_str( istr)
{
str asr

<<"$_proc $_pargc $pargv[0]\n"

  asr = scat(istr,"XYZ")

  return asr

}


class Gstr {

 public:
   str astr;


 CMF setstr( istr)
  {

      astr = scat(istr,"Whizzy");

  }


 CMF getstr()
  {

       return astr;

  }

} 



svar word

 word[0] = "hi"
 word[1] = "how"
 word[2] = "are"

<<"$word ||"

<<"$word[0] ||"


stop!





news = get_str("mark")

<<"%V$news \n"


news = get_str("terry")

<<"%V$news \n"


Gstr  bob  


  bob->setstr("hey")


  news = bob->getstr()

<<"%V$news\n"


N = 10

Gstr  Jill[N]

    Jill[0]->setstr("gee")

  news = Jill[0]->getstr()

<<"%V$news\n"




  for (i = 0 ;  i < N ; i++) {

  Jill[i]->setstr(news)

  news = Jill[i]->getstr()

<<"%V$news\n"


  }


stop!