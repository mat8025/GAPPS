////
////

allowDB("str,svar,spe,rdp",1)

Str s=   "sWi(_woid,bvp,_WDRAW,ON_,_WPIXMAP,ON_,_WSAVE,ON_,_WBHUE,WHITE_,_WREDRAW,ON_)"

<<"$s \n"
// using a mod to regex \L lower case the group \L\1
// using a mod to regex \U upper case the group \U\1

  wlc=ssubrgx(s,"_W([A-Z]*),","_w\\L\\1,",0)

<<"$wlc\n"

  wuc=ssubrgx(wlc,"_w([a-z]*),","_W\\U\\1,",0)

<<"$wuc\n"

s=   "sWi(_woid,bvp,_WREDRAW,ON_)"

 wlc=ssubrgx(s,"_W([A-Z]*),","_w\\L\\1,",0)

<<"$wlc\n"
///

///  now do  a whole file


   fname = "screen_wex.asl"
<<"$fname "
   A=ofr(fname) ;
   B= ofw("screen_wex_lc.asl")


   nl = 1
   wic = "FIXXXX"

      if ( nl > 0 ) {
           nl = 0
      }
  <<"%V $nl \n"
  
//setErrorNum(6)

  while (1) {

      L = readline(A,-1,1);
         nl++
     err = ferror(A)

<<"%V $nl $L \n"

      wlc=ssubrgx(L,"_W([A-Z]*),","_w\\L\\1,",0)


      
  //     is_err =  (ferror(A) == EOF_ERROR_)
   //   <<"%V$err $is_err \n" 

      if ( ferror(A) == EOF_ERROR_ ) {
   
   
     <<"end @ $L\n"
        break;

    }

       <<"$wlc \n"
       <<[B]"$wlc \n"


}

L.pinfo()

     cf(B)
