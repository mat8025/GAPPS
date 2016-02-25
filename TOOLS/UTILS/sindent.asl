#/* -*- c -*- */
# "$Id: sindent.g,v 1.1 1998/02/19 00:11:44 mark Exp mark $"
#set_debug(1)

svar W
ascii PA[60]
ascii Parg[30]

# OPTIONS
do_blank = 0
always_do_blank = 1
# remove previous debug 
rm_debug = 1


int nest = 0;

add_debug = 1

fn = $1

dbit = "OFF"

  //dbit = argv(3)


// defaults

int lhm = 2




proc pr_pa()
{
  k = 1
  pname = spat(PA[0],"(",-1,-1)
  sa = 1
    if (pname @= "NULL") {
      pname = PA[0]
      pa = PA[1]
      sa = 2
    }
    else {
      pa = spat(PA[0],"(",0,-1)
    }




    for (j = sa ; j <= npa ; j++ ) {



        while (1) {

          ba = spat(pa,"(",1,-1)
            if (ba @= "NULL") {
              break
            }
            else {
              pa = ba
              Parg[k] = "("

              k += 1
            }
        }

        while (1) {

          ba = spat(pa,",",-1,1)
            if (ba @= "NULL") {

              ba = spat(pa,")",-1,-1)
                if (ba @= "NULL") {

                    if ( ! (pa @= "MATCH_NULL_STRING") && ! (pa @= "NULL") ) {
                      Parg[k] = pa

# <<"k," ",Parg[k],"\n")

                      k += 1
                    }
                  pa = ba
                }
              break

            }
            else {
                if ( ! (ba @= "NULL") ) {
                  Parg[k] = ba
#<<"k," ",Parg[k],"\n")
                  k += 1
                }
            }
          pa = spat(pa,",",1,1)
        }

        while (1) {
# <<"" )"," ",pa,"\n")
          ba = spat(pa,")",-1,-1)
            if (ba @= "NULL") {
                if ( ! (pa @= "MATCH_NULL_STRING") && ! (pa @= "NULL") ) {
                  Parg[k] = pa
#<<"k," ",Parg[k],"\n")
                  k += 1
                }
              break
            }
            else {
                if ( ! (ba @= "NULL") ) {
                  Parg[k] = ba
#<<"k," ",Parg[k],"\n")
                  k += 1
                }
              break
            }

          pa = ba

        }

      pa = PA[j]
    }

//  <<"db_print(DBPE,\">"

    for (i = 0; i < npa ; i = i +1) {
      <<"$PA[i] "
    }
  <<" \","


    for (i = 1; i < k ; i = i +1) {
        if ( ! (Parg[i] @= "(" ) && ! (Parg[i] @= "," ) && ! (Parg[i] @= ")")\
          && ! (Parg[i] @= "MATCH_NULL_STRING" ) ) {
          <<"Parg[i],",\" \",")
        }
    }

  <<""\"\\n \"")
  <<"")","\n")
  print_procargs = 0
# <<"Parg[k-1]," ",endarg,"\n")
}

isdg = spat(fn,".asl")
  if (isdg @= "NULL") {
    err_print("not a .asl file","\n")
    ff=exit_si()
  }

A=o_file(fn,"rb")

  if ( A == -1) {
      STOP!
  }

a = W[0]


nlines = countwords(A)

//<<"cnt returns $nlines \n")


s_file(A,0,0)

n_words = 0
idl = lhm
idn = 2
idls = 1

last_keyw = ""
get_procargs = 0
print_procargs = 0
#set_name_debug("SI_EXP",0)

int back_tab =0

  while (1) {

    nw = W->Read(A)

  if (nw == -1) {
       break
  }

      if (si_error() == 6) {
#<<""si_error ","\n")
        break
      }

//<<" $(f_error(0)) $nw\n"

    n_words = n_words + nw

#<<"n_words," ",nw,"\n")

      if (nw > 0) {

        wd1 = W[0]

#<<"" wd1  ",wd1,"\n")

          if (scmp(wd1,"while",5,0)) {
            idl += idn
            nest++
            last_keyw = "while"
          }

          if (scmp(wd1,"class",4,0)) {
            idl = lhm
            <<"\n"
            nest++
          }

          if (scmp(wd1,"proc",4,0)) {
            idl = lhm
            <<"\n"
            nest++
              if (dbit @= "DB") {
                get_procargs = 1
              }
          }

          if (scmp(wd1,"if",2,0)) {
	    //            idl += idn
//     <<" found if %v $idl \n"
            //nest++
          }

         
          if (scmp(wd1,"cmf",3,0)) {
            idl = lhm + idn
             nest++
          }

          if (scmp(wd1,"else",4,0)) {
            idl += idn
            nest++
          }

          if (scmp(wd1,"for",3,0)) {
            idl += idn
            <<"\n"
            last_keyw = "for"
            nest++
          }

          if (scmp(wd1,"}",1)) {
             
             nest--
             idl -= idn
//     <<" } $nest \n"

           if (nest == 0) {
             if (last_keyw @= "for") {

             }
             else {
              idl = lhm
             }
           }
          }

# comment

          if ( !scmp(wd1,"#",1)) {
	          if (idl < lhm) {
        	      idl = lhm
          		}
              for (i = 0; i < idl ; i++) {
                <<" "
              }
          }

# remove db_print ?

          if ((scmp(wd1,"db_print",8)) && (rm_debug)) {
          continue
          }

          if (scmp(wd1,"{",1)) {
# add_the debug proc line
              if (get_procargs) {
                print_procargs = 1
                get_procargs = 0
              }
          }

          if (get_procargs) {
              for (i = 0; i < nw ; i++) {
                PA[i] = W[i]
              }
            npa = nw
          }


          for (i = 0; i < (nw-1) ; i++) {
            <<"$W[i] "

          }

          if (nw > 0) {
            <<"$W[nw-1]"
          }

        <<"\n"
//<<"done line $wd1 \n"

          if (scmp(wd1,"if",2,0)) {
            idl += idn
  // <<" found if %v $idl \n"
          }

          if (print_procargs) {
            pr_pa()
          }

          if (scmp(wd1,"while",5)) {
            idl += idn
          }



          if (scmp(wd1,"else",4)) {
            idl += idn
          }


          if (scmp(wd1,"for",3)) {
            idl += idn
          }

          if (scmp(wd1,"{",1)) {
            idl +=  idn
          }

          if (scmp(wd1,"}",1)) {
            do_blank = 1
            idl -= idn
          }
      }
      else {
# only 1 blank line
          if (do_blank || always_do_blank ) {
            <<"\n"
            do_blank = 0
          }
      }

      if (idl < lhm) {
        idl = lhm
      }
  }

#<<"nlines," ",n_words,"\n"

STOP!

