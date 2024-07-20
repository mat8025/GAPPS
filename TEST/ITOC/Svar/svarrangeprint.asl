//
//
//

//   Svar range print access


Svar L;
  L.pinfo()



T= " *  @cdate Sun Mar 22 11:05:34 2020"

  T.pinfo()
  L.Split(T)

<<"$L[0] \n"
<<"$L[1] \n"
<<"$L[2] \n"
<<"$L[3] \n"
<<"$L[4] \n"

<<"$L[-1] \n"


<<"$L[2::] \n"
<<"$L[2:-1:1] \n"
<<"$L[0:-1:2] \n"

      cdate = "$L[2::]";

<<"%V $cdate \n"


