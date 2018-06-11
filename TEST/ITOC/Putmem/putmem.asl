///
///  PutMem (tag, value)
///

setDebug(1,@keep,@pline);


  putMem("toft","maybe");

  putMem("focus","on tasks");

  putMem("mem","confused");


  val = getMem("toft")

<<"  $val"


  val = getMem("focus")

<<"  $val"


  putMem("str 2"," 47 79",1);

  putMem("str 3"," '19,74,13'",1);


val = getMem("str 1")

<<"  <|$val|> \n"

val = getMem("str 2")

<<"  <|$val|> \n"


val = getMem("str 3")

<<"  <|$val|> \n"