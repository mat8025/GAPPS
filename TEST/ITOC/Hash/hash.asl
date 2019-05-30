//
setdebug(1)



key = "mark"
a = getHashIndex(key)

b = setKeyVal(key,"strong")

c = getKeyVal(key)


<<"$key $b $c\n"

key = "kram"
a = getHashIndex(key)

b = setKeyVal(key,"weak")

c = getKeyVal(key)


<<"$key $b $c\n"

key = "rkam"
a = getHashIndex(key)

b = setKeyVal(key,"moderate")

c = getKeyVal(key)


<<"$key $b $c\n"


key = "Mercury"

a = getHashIndex(key)

b = setKeyVal(key,"Hg 80 liquid")


c = getKeyVal(key)



<<"$key $b $c\n"


key = "park"
a = getHashIndex(key)

b = setKeyVal(key,"weather")

val = getKeyVal(key)

<<"$key $b $val\n"

key = "krap"
a = getHashIndex(key)

b = setKeyVal(key,"sunny")

val = getKeyVal(key)

<<"$key $b $val\n"


SF=functions()
SF->sort()

<<"%(1, , ,\n)$SF\n"