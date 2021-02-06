/*
 *  @script nsc.asl 
 * 
 *  @comment Test nsc SF  
 *  @release CARBON 
 *  @vers 1.3 Li Lithium [asl 6.3.2 C-Li-He]                            
 *  @date Wed Dec 30 16:56:00 2020 0 
 *  @cdate 1/1/2007 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2020 → 
 * 
 *  ws=nsc(n,w1)
 *  self concatenates w1 n times and returns the result
 */


#include "debug"

allowErrors(-1)

chkIn()
  ws = nsc(10,"\"")
!i ws  
<<"<|$ws|>\n"
len = slen(ws)
<<"%V$len\n"
chkN(len,11)
c=ws[3]

!i c
!i ws





  ws = nsc(10,"\\")
<<"$ws\n"



  ws = nsc(10,"AZ")
<<"$ws\n"




\\  ws = nsc(3,"\\\")
\\<<"$ws\n"



  ws = nsc(10,'\\')
<<"$ws\n"



  ws = nsc(10,'\\\')
<<"$ws\n"



//  ws = nsc(10,'\\')
//<<"$ws\n"

//  ws = nsc(10,92)
//<<"$ws\n"



  ws = nsc(10,"\\AB")
<<"$ws\n"
len = slen(ws)
<<"%V$len\n"
chkN(len,33)

chkOut()
exit()
