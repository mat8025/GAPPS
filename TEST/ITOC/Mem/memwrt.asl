///
///  MemWrt (tag, value)
///

 where =showEnv()
 <<"$where \n"
<<" it's on the tip of my tongue \n"




  ok=memWrt("tot","maybe not");
<<" %V $ok\n"

  if (ok > 0) {
     val = memRead("tot")

<<"updated tot   $val\n"

  }

  ok =memWrt("focus","on tasks",1);
<<" %V $ok\n"


  ok =memWrt("mem","corrupted",1);
<<" mem %V $ok\n"

  val = memRead("tot")

<<"tot   $val\n"


  val = memRead("focus")

<<"focus  $val\n"


 ok= memWrt("str 2"," 47 79",1);
<<" %V $ok\n"
 ok= memWrt("str 3"," '19,74,13'");
<<" %V $ok\n"

ok= memWrt("mytasks"," these are never ending and I must persevere",1);
<<" %V $ok\n"

val = memRead("str 1")

<<"str 1  <|$val|> \n"

val = memRead("str 2")

<<"str 2  <|$val|> \n"


val = memRead("str 3")

<<"str 3  <|$val|> \n"

 i= memCheck("tot")

<<"tot $i \n"


 i= memCheck("strange")

<<"strange $i \n"

 ok=memWrt("tot","most certainly will ",1)
 <<" %V $ok\n"
  if (ok) {
<<"update tot\n"
  }

  val = memRead("tot")

<<"tot   $val\n"

 ok=memWrt("tot","just not quite there")
 
  if (ok > 0) {
<<"updated tot\n"
  }

  val = memRead("tot")

<<"tot   $val\n"


  val = memRead("mytasks")

<<"mytasks   $val\n"

ok=memWrt("cbump"," what,why",1)

 val = memRead("cbump")

<<"cbump   $val\n"
