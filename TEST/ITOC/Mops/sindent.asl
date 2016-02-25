# "$Id: sindent.g,v 1.1 1998/02/19 00:11:44 mark Exp mark $"
#set_debug(1)

ascii W[60]
ascii PA[60]
ascii Parg[30]

# OPTIONS
do_blank = 1
always_do_blank = 0
# remove previous debug 
rm_debug = 1

add_debug = 1

fn = get_cl_arg(2)
dbit = "OFF"
dbit = get_cl_arg(3)

define_proc
pr_pa()
{
  k = 1
  pname = str_pat(PA[0],"(",-1,-1)
  sa = 1
    if (pname @= "NULL") {
      pname = PA[0]
      pa = PA[1]
      sa = 2
    }
    else {
      pa = str_pat(PA[0],"(",0,-1)
    }

#o_print(pname," ",pa,"\n")


    for (j = sa ; j <= npa ; j +=1 ) {

# o_print(k," in pa ",pa,"\n")

        while (1) {
# o_print(" ( ",pa,"\n")
          ba = str_pat(pa,"(",1,-1)
            if (ba @= "NULL") {
              break
            }
            else {
              pa = ba
              Parg[k] = "("
# o_print(k," ",Parg[k]," ",pa,"\n")
              k += 1
            }
        }

        while (1) {
# o_print(" , ",pa,"\n")
          ba = str_pat(pa,",",-1,1)
            if (ba @= "NULL") {

              ba = str_pat(pa,")",-1,-1)
                if (ba @= "NULL") {

                    if ( ! (pa @= "MATCH_NULL_STRING") && ! (pa @= "NULL") ) {
                      Parg[k] = pa
# o_print(k," ",Parg[k],"\n")
                      k += 1
                    }
                  pa = ba
                }
              break

            }
            else {
                if ( ! (ba @= "NULL") ) {
                  Parg[k] = ba
#o_print(k," ",Parg[k],"\n")
                  k += 1
                }
            }
          pa = str_pat(pa,",",1,1)
        }

        while (1) {
# o_print(" )"," ",pa,"\n")
          ba = str_pat(pa,")",-1,-1)
            if (ba @= "NULL") {
                if ( ! (pa @= "MATCH_NULL_STRING") && ! (pa @= "NULL") ) {
                  Parg[k] = pa
#o_print(k," ",Parg[k],"\n")
                  k += 1
                }
              break
            }
            else {
                if ( ! (ba @= "NULL") ) {
                  Parg[k] = ba
#o_print(k," ",Parg[k],"\n")
                  k += 1
                }
              break
            }

          pa = ba

        }

      pa = PA[j]
    }

  o_print("db_print(DBPE,\">")

    for (i = 0; i < npa ; i = i +1) {
      o_print(PA[i]," ")
    }
  o_print(" \",")


    for (i = 1; i < k ; i = i +1) {
        if ( ! (Parg[i] @= "(" ) && ! (Parg[i] @= "," ) && ! (Parg[i] @= ")")\
          && ! (Parg[i] @= "MATCH_NULL_STRING" ) ) {
          o_print(Parg[i],",\" \",")
        }
    }

  o_print("\"\\n \"")
  o_print(")","\n")
  print_procargs = 0
# o_print(Parg[k-1]," ",endarg,"\n")
}

isdg = str_pat(fn,".g")
  if (isdg @= "NULL") {
    err_print("not a .g file","\n")
    ff=exit_si()
  }

A=o_file(fn,"rb")

  if ( A == -1) {
    ff=exit_si()
  }

a = W[0]

nlines = cnt_words(A,&W[0])

#o_print("cnt returns ",nlines,"\n")
#o_print("cnt ",W[0]," ",W[1]," ",W[2],"\n")

s_file(A,0,0)

n_words = 0
idl = 0
idn = 2
idls = 1

get_procargs = 0
print_procargs = 0
#set_name_debug("SI_EXP",0)

  while (1) {

    nw = r_words(A,&W[0])


      if (si_error()) {
#o_print("si_error ","\n")
        break
      }

    n_words = n_words + nw

#o_print(n_words," ",nw,"\n")

      if (nw > 0) {

        wd1 = W[0]

#o_print(" wd1  ",wd1,"\n")

          if (str_cmp(wd1,"while",5)) {
            idl = idl +idn
          }

          if (str_cmp(wd1,"define_proc",5)) {
            idl = 0
            o_print("\n")
              if (dbit @= "DB") {
                get_procargs = 1
              }
          }

          if (str_cmp(wd1,"if",2)) {
            idl = idl +idn
          }

          if (str_cmp(wd1,"else",2)) {
            idl = idl +idn
          }

          if (str_cmp(wd1,"for",2)) {
            idl = idl +idn
            o_print("\n")
          }

          if (str_cmp(wd1,"}",1)) {
            idl = idl -idn
          }

# comment

          if ( !str_cmp(wd1,"#",1)) {
              for (i = 0; i < idl ; i = i +1) {
                o_print(" ")
              }
          }

# remove db_print ?

          if ((str_cmp(wd1,"db_print",8)) && (rm_debug)) {
          continue
          }

          if (str_cmp(wd1,"{",1)) {
# add_the debug proc line
              if (get_procargs) {
                print_procargs = 1
                get_procargs = 0
              }
          }

          if (get_procargs) {
              for (i = 0; i < nw ; i = i +1) {
                PA[i] = W[i]
              }
            npa = nw
          }


          for (i = 0; i < (nw-1) ; i = i +1) {
            r_print(W[i])
            o_print(" ")
          }

          if (nw > 0) {
            r_print(W[nw-1])
          }

        o_print("\n")

          if (print_procargs) {
            pr_pa()
          }

          if (str_cmp(wd1,"while",5)) {
            idl = idl +idn
          }

          if (str_cmp(wd1,"if",2)) {
            idl = idl +idn
          }

          if (str_cmp(wd1,"else",2)) {
            idl = idl +idn
          }

          if (str_cmp(wd1,"define_proc",5)) {
            idl = 0
          }

          if (str_cmp(wd1,"for",2)) {
            idl = idl +idn
          }

          if (str_cmp(wd1,"{",1)) {
            idl = idl + idn
          }

          if (str_cmp(wd1,"}",1)) {
            idl = idl -idn
          }

        do_blank = 1
      }
      else {
# only 1 blank line
          if (do_blank || always_do_blank ) {
            o_print("\n")
            do_blank = 0
          }
      }

      if (idl < 0) {
        idl = 0
      }

  }

#o_print(nlines," ",n_words,"\n")

ff=exit_si()

