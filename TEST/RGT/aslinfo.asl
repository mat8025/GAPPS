//
// ALSM --- info
//
// 


envDebug();

gssys= GetEnv("GS_SYS")

<<" ENV $gssys \n"
<<" looking for manual in $gssys\n"

#define DBG <<
//#define DBG ~!

void pr_fun()
{
DBG" $_proc %V$i\n"
int ret = 1;
               if ( first ) {
                      f_i = i
                      first = 0
DBG"%V $wd $f_i $first\n"
               }
               else {

DBG"%V $wd $i $f_i $first\n"

                  if (i == -1) {
                       ret = 0;
                  }

                  else if ( i <= f_i ) {
                       ret = 0;
                  }

                   j=ftell(A);
                   j=search_file(A,"^.FD",1)
		    <<"\n"

DBG"%V$j \n"

                      k2= search_file(A,"^.EF",0)  // look for end function
//DBG"%V$k2 \n"

                      fseek(A,j,0)

                      k1= search_file(A,"^.EF",0)  // back up otherwise the start of next function 

DBG"%v $k1 \n"

//DBG"%V $k1  $k2 $k \n"

                          if ((k1 > k2) && (k2 != -1)) { 
                              k = k2; 
                          }
                          else {
                              k = k1;
                          } 

//DBG"%V$k1  $k2 $k \n"

DBG"%V $j $k \n"
                        s_file(A,j,0)

                        while (1) {
//<<"pr\n"
                            w=pcl_file(A,1)
//DBG"%V $w $k\n"
                            if ( w >= (k-4) ) {
                              break
                            }
                            if (w == -1) {
                              break
                            }
                        }
     <<"=====================================\n"
# backup
                       DBG" done print section \n"
                      // k = s_file(A,-10,1)

                    }

                    k = s_file(A,0,1)

                    if (k == -1) {
                     <<"stopping\n"
                      ret = 0;
                    }
	return ret;	    
}
//========================================



Str pat
int k = 0;

long f_i = 0;

//DBG"%I $f_i \n"
//DBG" $(typeof(f_i)) \n"
//DBG" $(sizeof(f_i)) \n"

  
  pat = GetArgStr()

<<"search for $pat \n"
!a
    if ( pat @= "" ) {
      DBG" function name:"
      pat =i_read()
    }

//  DBG"looking up $pat in manual \n"

A= -1;

A=ofr("$gssys/DOCS/ASLMAN")

    if (A <= 0 ) {
       A= ofr("/usr/local/GASP/gasp/DOCS/ASLMAN");
    }

    if (A <= 0 ) {
      << "can't find manual in DOCS or SRC directories \n"
        STOP!
     }

int nfs = 0;

int keep_searching = 1;
int search_success = 0;
 while (keep_searching) {

         if ( pat @= "q" ) {
          STOP!
         }

         // pat = scat("^*",pat)
	  pat = scat("^",pat);

          first =1;

          i=search_file(A,"^APPENDIX",0)

          //pcl_file(A,1,1);

          last_i = -1;


            while (keep_searching) {

              nfs++

              k=search_file(A,"^.BF",0)    // next function

            //  pcl_file(A,1,3);

              i = fseek(A,k,0)

                if (i == last_i) {
                  STOP!
                }

              last_i = i

DBG"%V$nfs search for $pat $k @ $i \n"

              i=search_file(A,pat,0,1,0)   // looking for pat in function name
DBG"search returns $i and print the next 3 lines\n"

DBG"->///\n"
              //pcl_file(A,1,3);
DBG"<-///\n"

              if (i == -1) {

                  DBG" no more $pat \n"

                  npat = ssub(pat,"_","",0)

                  i = fseek(A,k,0) // reset position

                  i=search_file(A,npat,0,1,0)
		  // try looking for pat without underlines in function name

//               DBG"%V$npat $i\n"

                  if (i == -1) {
                   //DBG" notfound exit \n"
                  <<"$pat not found\n"
		     keep_searching = 0;
                     break;
                  }

                  pat = npat;

                }
                else {
                DBG"Found %V $pat @ posn $i \n"
                }

// seek no print
                pcl_file(A,0,1);

                wd=rwl_file(A,1)

DBG"<|${wd}|> \n"

                 first = 0;


                if ( wd @= ".FD" ) {
                    search_success =pr_fun();
		    //keep_searching = 0;
		    //break;
                 }


                 else if ( wd @= ".(x" ) {
                    search_success =pr_fun();
		    //keep_searching = 0;
		   // break;		      
                 }
		 
                 else if ( wd @= ".)x" ) {
                      search_success =pr_fun();

                    //keep_searching = 0;
		    //break;
                 }
              }
            }

<<"%V $search_success\n"

exit()
///////////////////////////////////