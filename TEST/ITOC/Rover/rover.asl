
#include "debug"

chkIn()


str s1 = "happyHolidays"
str s2 = "xyz"

<<"$s1\n"


s3= rover(s1,s2,4)

<<"$s3\n"

chkStr(s3,"happxyzli",9)



i = 0
while (i < 20) {
s3= rover(s1,s2,i)

<<"$s3\n"
i++

}


s3= rover(s1,s2,LAST_)


<<"LAST_ $s3\n"
chkStr(s3,"happyHolidxyz")

s3= rover(s1,s2,-3)


<<"-3: $s3\n"

chkOut()