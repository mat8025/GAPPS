/* 
 *  @script perm.asl 
 * 
 *  @comment get all spellings of a word - test perm  
 *  @release CARBON 
 *  @vers 1.1 H Hydrogen [asl 6.3.3 C-Li-Li]                                
 *  @date Thu Dec 31 08:24:00 2020 
 *  @cdate 1/1/2008 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2020 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 


//  get Permutations


//#include "debug"





// char s[] ="abcdefghik"
char sc[] = {'abcdefghikjlmnopqrstuvwxyz'}
<<"%c$sc \n"


char s[] = {"abcdefghikjlmnopqrstuvwxyz"}
//char s[] = {"working"}

<<"%c$s \n"
<<"%c$s[1] %c$s[2] \n"

N = 3

t = s

  rav = Perm("hey")

//dp=iread("$rav[0] :->")


<<" $rav[0] perms\n"
<<"%($N, ,,\n)$rav[1::] \n"


sz = Caz(rav)
<<"%V$sz[::]\n"

<<"%V$sz[0] $sz[1] $sz[2] \n"

//dp=iread("$rav[0] :->")

  i = 0
 k = 0

//<<"%($N, ,,\n)$rav \n"

  i = 0

int veci[]

  veci = rav[0][::]



<<"veci = $veci[0][::]\n"

  i = 2

  veci = rav[i][::]

//<<"$veci[0][::]\n"

  isv = 0
 i = 0
 cc =0
 for (j = 0; j < sz[1] ; j++) {

  veci = rav[j][::]
  redimn(veci)
//<<"$vec \n"
//<<"$vec[0][::] \n"
//  <<"$(k++) "
  isword = 1
  cc=0
  for (m = 0; m < N; m++) {
     u = veci[m]
//  <<"$u %c$s[u] "
   t[m] = s[u]
  isv = cvow(s[u])
  //<<" %c$s[u] %d$isv "
  if (isv) {
   cc=0
  }
  else {
      cc++
      if (cc >=3) {
        isword = 0
        break
      }
  }

  }
//<<"%c$s[vec[0]] $s[vec[1]] $s[vec[2]]\n"
//  <<" \n"
  if (isword) {
 // <<"%s$t\n"
  }
 }

 <<"\n DONE $sz[1] perms \n"