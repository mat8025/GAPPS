/* 
 *  @script sstr.asl 
 * 
 *  @comment test sstr search in str SF 
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.5 C-Li-B] 
 *  @date Mon Jan  4 11:58:11 2021 
 *  @cdate 1/1/2017 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
///
///  sstr
///

vers = "1.3"

<<"%V$vers\n"

chkIn()

str A = "keep going until world tour"
str B = "unti"


iv = sstr(A,B,1)

<<"$iv\n"

chkN(iv[0],11)

iv = sstr(A,"XX",1)

<<"$iv\n"

chkN(iv[0],-1)

iv = sstr(A,"ou",1)

<<"$iv\n"

chkN(iv[0],24)

iv = sstr(A,"OU")

<<"$iv\n"

iv = sstr(A,"OU",1)

<<"$iv\n"

chkN(iv[0],24)

iv = sstr(A,"o",1,1)

<<"o @ $iv\n"

chkN(iv[0],6)
chkN(iv[1],18)
chkN(iv[2],24)


p = regex(A,"ou")

<<"$p \n"

str C = "mat.vox"
str D = "terry.pcm"


p = regex(C,"vox")

<<"%V$p \n"

chkN(p[0],4)

p = regex(D,"pcm")


<<"$p \n"

chkN(p[0],6)

p = regex(C,'vox\|pcm')

<<"%V$p \n"


p = regex(D,'vox\|pcm'  )

<<"%V$p \n"


str E = "abcxxxabcxxxabcyyy"


pos = regex(E,'abc'  )

<<"%V$pos \n"


pos2 = regex(E,'xxx'  )

<<"%V$pos2 \n"

chkN(pos2[0],3)
chkN(pos2[1],6)

chkN(pos2[2],9)
chkN(pos2[3],12)

chkN(pos2[4],-1)




chkOut()