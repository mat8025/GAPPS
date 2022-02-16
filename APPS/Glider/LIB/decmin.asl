///
///
///
//3712.191N,10752.152
//old = "3913.066N,10440.816"
old = _clarg[1]

lin = ssub(old,"N,"," -")

//nn=sele(lin,0,2)
//scpy(nn,lin,2)
//<<"$nn\n"
//nn=scat(sele(lin,0,2)," ",scut(lin,2))
//nn=scat(scut(nn,-6)," ",sele(lin,-6,6))
//<<"$nn\n"




new=scat(scut(scat(sele(lin,0,2)," ",scut(lin,2)),-6)," ",sele(lin,-6,6))


<<"$new\n"