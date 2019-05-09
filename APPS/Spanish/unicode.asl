





<<"©→ ⋲∑\n"


uchar UC[>10];

UC = "A ©→ ⋲∑\n"

<<"$UC\n"

UC = "ABC→"

<<"$UC\n"


UC = "ABC©"

<<"$UC\n"

UC[4] = 167
UC[5] = 0

<<"%s $UC\n"

<<"$UC   :  %s $UC\n"

uchar SC[] = "       "

<<"%s $SC\n"

<<"%d $SC\n"

SC[7] = 195
SC[8] = 163;

<<"%s $SC\n"

<<"%d $SC\n"


k= 190

while (k < 255) {

k++
SC[7] = k
 for (i=161; i<=191;i++) {
SC[8] = i
<<"$k $i %s $SC\n"
 }

goon = iread("carryon")
if (goon @= "q")
  break

}


exit()



/{
val = "${stem}\xe8is"
!!"echo -e 'com\xi8is' | iconv -f iso-8859-1 -t UTF-8 "
!!"echo -e $val | iconv -f iso-8859-1 -t UTF-8 "
val2 = "éàö"

!!"echo -e $val2 | iconv -f iso-8859-1 -t UTF-8 "
!!"echo -e $val2 "
/}