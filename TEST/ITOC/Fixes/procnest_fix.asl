///
//
//
//

Str goo(str a1, str a2)
{
<<"$_proc $a1 $a2\n"
a1.pinfo()
ina1 =a1
ina2 =a2
<<"$_proc $ina1 $ina2\n"
ina1.pinfo()
a1s= scat(a1,a2)
        a2r=goo2(a1,a1s)
<<"$a2r\n"
       return a2r;
}

Str goo2(str a1, str a2)
{
<<"$_proc $a1 $a2\n"
a2s= scat(a2,a1)
        a3r=goo3(a1,a2s)
<<"$a3r\n"
      return a3r;
}

Str goo3(str a1, str a2)
{
<<"$_proc $a1 $a2\n"

  a3= scat(a1,a2)

   return a3
}

  str m_a1 = "_hey_"
  str m_a2 = "_now_"
  

  // gr= goo("_hey_","_now_")

 gr= goo(m_a1,m_a2)


<<"$gr\n"


