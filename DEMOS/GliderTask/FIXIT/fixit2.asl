
setdebug(1)

proc namemangle(aname)
{
  // FIXIT --- bad return
  str fname;

 nname=aname
 //<<" %V $nname $aname \n"

  kc =slen(nname)

 if (kc >7) {
 nname=svowrm(nname)
 }

 scpy(fname,nname,7)

 <<"%V$nname --> $fname \n"


 return fname
}




name1= "mississippi"

new_name = namemangle(name1)


<<"%V$name1 $new_name\n"


name1= "boulder"

new_name = namemangle(name1)


<<"%V$name1 $new_name\n"




