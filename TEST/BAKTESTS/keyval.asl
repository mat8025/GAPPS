// key-val pairs via Svar


setdebug(1)

Svar kv


  kv->addKeyVal("mark","is")
  kv->addKeyVal("terry","good")
  kv->addKeyVal("work","when")
  kv->addKeyVal("smarter","pushed")

<<"$kv \n"

  iv = kv->lookup("work")


<<"%V$iv \n"


  wi = kv->findVal("work")

<<"$wi \n"

wi = kv->keySort()

<<"$kv \n"

wi = kv->valueSort()

<<"%(2,, ,\n)$kv \n"

Svar kvn


  kvn->addKeyVal("mark",1)
  kvn->addKeyVal("terry",3)
  kvn->addKeyVal("work",7)
  kvn->addKeyVal("smarter",0)

wi = kvn->valueNumSort()

<<"%(2,, ,\n)$kvn \n"


stop!