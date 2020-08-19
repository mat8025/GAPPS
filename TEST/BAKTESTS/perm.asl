setdebug(1)

//  get Permutations


N = 7

// char s[] ="abcdefghik"
// char s[] = {"abcdefghik"}
char s[] = {"working"}

<<"%c$s \n"
<<"%c$s[1] %c$s[2] \n"

t = s

  rav = Perm(N)

dp=iread("$rav[0] :->")


<<" $rav[0] perms\n%($N, ,,\n)$rav[1::] \n"


sz = Caz(rav)
<<"%V$sz[::]\n"

<<"%V$sz[0] $sz[1] $sz[2] \n"

dp=iread("$rav[0] :->")

  i = 0
 k = 0

<<"%($N, ,,\n)$rav \n"

  i = 0

int vec[]

  vec = rav[0][::]



<<"vec = $vec[0][::]\n"

  i = 2

  vec = rav[i][::]

<<"$vec[0][::]\n"

  isv = 0
 i = 0
 cc =0
 for (j = 0; j < sz[1] ; j++) {

  vec = rav[j][::]
  redimn(vec)
//<<"$vec \n"
//<<"$vec[0][::] \n"
//  <<"$(k++) "
  isword = 1
  cc=0
  for (m = 0; m < N; m++) {
     u = vec[m]
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
  <<"%s$t\n"
  }
 }

 <<"\n DONE $sz[1] perms \n"