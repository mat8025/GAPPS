setdebug(1)
!!"date"

ds=!!"date"

wks = "";

svar W;

  wks= !!"date +\%V"
<<" we are in week $wks\n";
         A= ofr("track_Week_12.txt")

         DT= readfile(A);

<<"$DT\n"


         fseek(A,0,0)
       while (1) {
         nw = W->read(A)
         if (nw == -1)
	    break
<<"$W\n"
      }

         fseek(A,0,0)
int k = 0;


svar W1;
           nw = W1->readWords(A)
	   
  <<"%Vnw $W1[0] $W1[1] $W1[2]\n"

           nw = W1->readWords(A)
	   
  <<"%Vnw $W1[0] $W1[1] $W1[2]\n"




       while (1) {
         nw = W->readWords(A)
         if (nw == -1)
	    break
	    k++;
        <<"%V$k $W[0] $W[1]\n"
      }