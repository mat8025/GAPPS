///
///  read via stdin  lines - if line lenght over 80? break the line at '.' ','  or end of word
///

A= 0;
// will need recurse or loop to break up long lines
int LineBrk ()
{
int ok = 0;
     len = slen(L);
     
    <<[2]"start %V$len \n"
     if (len < 80) {
       <<"  $L"
       return 1;
     }

     fperiod = strchr(L,'.',1,60)
   <<[2]"%V $len $fperiod \n"
     if (fperiod >= 80 || fperiod == -1) {
       fperiod = strchr(L,',',1,60)
   <<[2]"%V $fperiod  comma\n"
     }

     if (fperiod >= 80 || fperiod == -1) {
      // fperiod = strchr(L,';')   // FIX
       fperiod = strchr(L,59,1,60)
    <<[2]"%V $fperiod  ;\n"
     }     

     if (fperiod >= 80 || fperiod == -1) {
       fperiod = strchr(L,':',1,60)
    <<[2]"%V $fperiod  :\n"
     }



     if (fperiod >= 80 || fperiod == -1) {
       fperiod = strchr(L,' ',-1,75)
    <<[2]"%V $fperiod  WS\n"
     }

     if (fperiod >= 80 || fperiod == -1) {
       fperiod = strchr(L,' ',1,60)
    <<[2]"%V $fperiod  WS\n"
     }     

     if (fperiod > 80 || fperiod == -1) {

          fperiod = 40
<<"can't find break set @ $fperiod $L\n"

     }
     
     L1= sele(L,0,fperiod+1)
     L2= sele(L,fperiod+1)
     <<[1]"  $L1\n";
     len = slen(L2);
     <<[2]"L2 $len\n"
     if (len <= 80) {
     // does l2 have \n?
      <<[1]"  $L2";

     }
     else {
          L = L2;
	  LineBrk();
     }
      ok =1;
     return ok;
}

str L1;
str L2;
int done = 0;
int nlines = 0;

  while (1) {

     L=readline();   // TBF (0) xic bug
     
     if (feof(0)) {
     <<[2]"EOF break\n"
      break;
     }

      len = slen(L)
<<[2]"$len \n"
     if (len <= 80) {
      <<[1]"  $L";
     }
     else {
     nbrk = 0;
     done = 0;
     

       done = LineBrk();
//<<[2]"%V$done \n"	
     }


  nlines++;
<<[2]"%V$nlines \n"	

  //if (nlines > 5000)       break;



  }


<<"%V$nlines \n"

exit()