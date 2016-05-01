///
///  rhead
///

/// checks for a GASP/ASL/VOX header on data file
/// then by default prints out the entire header
/// clarg  options to return channel, frame, dfle type, num of data points, data-type etc



 fname = _clarg[1]


 A=ofr(fname)
 if (A == -1) {
<<"ERROR file not found\n"
 }


 // first line line check
 Svar ln;
 Svar words;
   ln = readLine(A)

   words = Split(ln)

   if ((scmp(words[0],"VOX_",4))  || (scmp(words[0],"GASP",4)) \
       || (words[0] @= "START_HEADER")) {
     	  <<"$ln\n"
     while (1) {
          ln = readLine(A);
	  <<"$ln\n"
	  words = Split(ln);
          if (words[0] @= "END_HEADER") {
           break;
	   }
     }

   }
   else {
<<"ERROR not a known header file!\n"
   }

