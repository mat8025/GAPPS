///
/// conver cup lat,lon to deg decmin   listing
///

cup_file = "bbrief.cup"

 A=ofr(cup_file)

if (A == -1){
  exit(-1,"file not found")
}

// skip title

 svar Wval;
 
    C=readline(A);

  while (1) {

     nwr = Wval->ReadWords(A,0,',')

   if (nwr == -1) {
	      break
            }
   if (nwr > 6) {

   lat = scut(Wval[3],-1)
   lat = scat(sele(lat,0,2), " ", scut(lat,2))
   lon = scut(Wval[4],-1)
   lon = scat("-",sele(lon,0,3), " ", scut(lon,3))
<<"$Wval[0]  $lat $lon \n"
   }
}