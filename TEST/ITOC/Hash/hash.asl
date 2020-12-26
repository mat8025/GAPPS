//%*********************************************** 
//*  @script hash.asl 
//* 
//*  @comment test svar hash key value set get 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.98 C-He-Cf]                            
//*  @date Tue Dec 22 10:38:10 2020 020 
//*  @cdate 1/1/2014 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
//



key = "mark"
a = getHashIndex(key)

b = setKeyVal(key,"strong")

c = getKeyVal(key)


<<"$key $b $c\n"

key = "kram"
a = getHashIndex(key)

b = setKeyVal(key,"weak")

c = getKeyVal(key)

chkStr(c,"weak")
<<"$key $b $c\n"

key = "rkam"
a = getHashIndex(key)

b = setKeyVal(key,"moderate")

c = getKeyVal(key)


<<"$key $b $c\n"
chkStr(c,"moderate")

key = "Mercury"

a = getHashIndex(key)

b = setKeyVal(key,"Hg 80 liquid")


c = getKeyVal(key)


chkStr(c,"Hg 80 liquid")
<<"$key $b $c\n"

//ans=query()

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

chkOut()
//<<"%(1, , ,\n)$SF\n"