///
///
///


setdebug(1,@pline,@~step,@trace,@showresults,1)
filterFuncDebug(ALLOWALL_,"proc");
filterFileDebug(ALLOWALL_,"ic_op");



tname = _clarg[1];



proc foo()
{

        RT=ofr(tname);
       
<<"$tname fh $RT \n"

       if (RT != -1) {
      
          posn = fseek(RT,0,2)
<<"EOF @ $posn\n";

          posn =seekLine(RT,-1);
<<"LL @ $posn\n";
          rtl = readline(RT)
<<"%V$posn $rtl \n"	  
          rtwords = Split(rtl);
<<"%V$rtwords \n"

          posn = seekLine(RT,-1)

          rtl = readline(RT)
<<"%V$posn $rtl \n"	  
          nrtwords = Split(rtl);
<<"%V$nrtwords \n"
          k = 0;
          while (posn != 0) {
	  
          posn = seekLine(RT,-1)

          rtl = readline(RT)
<<"%V$posn $rtl \n"	  
          nrtwords = Split(rtl);
<<"%V$nrtwords \n"
          if (k++ > 3) {
              break;
          }
          }


  }

    cf(RT);
}


   foo();

   foo();