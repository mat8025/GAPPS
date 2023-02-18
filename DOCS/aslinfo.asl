/* 
 *  @script aslinfo.asl                                                 
 * 
 *  @comment find routine description in ASLMAN                         
 *  @release Beryllium                                                  
 *  @vers 1.14 Si Silicon [asl 6.4.34 C-Be-Se]                          
 *  @date 06/20/2022 21:13:03                                           
 *  @cdate Sun Dec 23 09:22:34 2018                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2022 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  


Str Use_ = " info on asl functions";

ignoreErrors();

#define DBG ~!  
//#define  DBG <<	


gssys= GetEnv("GS_SYS")

//<<" ENV $gssys \n"
//<<" looking for manual in $gssys\n"

int w = 0;

Svar Wd;

void prest()
{
Str awd;
                       while (1) {
                            <<"\t"; // format print a tab offset for the line
                            w=pcl_file(A,1);
			    seekLine(A,-1);
                            awd=rwl_file(A,1);
			   //<<"$w $awd\n";
                            if (awd @= ".EF") {
                                   break;
                            }
                       }


}

void pr_fun()
{

<<" $_proc %V$i\n"
                    if ( first ) {
                      f_i = i
                      first = 0
//DBG" $wd $f_i $first \n"
                    }
                    else {

//DBG" $wd $i $f_i $first \n"

                        if (i == -1) {
                          exit(-1)
                        }

                        if ( i <= f_i ) {
                          exit(-1)
                        }

                      j=search_file(A,"^.FD",1)

DBG"%V$j \n"

                      k2= search_file(A,"^.EF",0)  // look for end function
DBG"%V$k2 \n"

                      fseek(A,j,0)

                      k1= search_file(A,"^.BF",0)  // back up otherwise the start of next function 

DBG"%v $k1 \n"

DBG"%V $k1  $k2 $k \n"


                          if ((k1 > k2) && (k2 != -1)) { 
                              k = k2; 
                          }
                          else {
                              k = k1;
                          } 

DBG"%V$k1  $k2 $k \n"

DBG"%V $j $k \n"
                      s_file(A,j,0)
        <<"\n/////\n"
                        while (1) {

                            w=pcl_file(A,1)
//DBG"%V $w $k\n"
                            if ( w >= (k-4) ) {
                              break
                            }


                            if (w == -1) {
                              break;
                            }
                        }
        <<"\n/////\n"
# backup
 //                      <<" done print section \n"
                      // k = s_file(A,-10,1)

                    }


                  k = s_file(A,0,1)

                    if (k == -1) {
                      exit(-1)
                    }
}




Str pat = "find";

int k = 0;

long f_i = 0;

//DBG"%I $f_i \n"
///DBG" $(typeof(f_i)) \n"
//DBG" $(sizeof(f_i)) \n"

  
  pat = GetArgStr();

<<"search for $pat \n"

    if ( pat @= "" ) {
 
      <<" function name:"
      pat =i_read()
     
    }

//  <<"looking up $pat in manual \n"
     int A= -1;

     A=ofr("~/gapps/DOCS/ASLMAN.txt")


    if (A <= 0 ) {

      << "can't find manual in DOCS or SRC directories \n"

        exit(-1)
     }

int nfs = 0;
int w1 =0;
int w2 =0;
int last = -1;

while (1) {

         w1++;
	          f_i=fseek(A,0,1)
//<<"top %V $w1  $f_i\n";

         if ( pat == "q" ) {
          exit(-1)
         }

          pat = scat("^*",pat);

          first =1;

          i=search_file(A,"^APPENDIX",0);

          //pcl_file(A,1,1);

          last_i = -1;


            while (2) {
	    
              w2++;
              nfs++;
	      	          f_i=fseek(A,0,1);
//<<"top %V $w2 $f_i\n";

          //    k=searchFile(A,"^.BF",0,1,0,1);    // next function
               k=searchFile(A,".BF",0,1,0,1);    // next function


              pcl_file(A,1,2);

              i = fseek(A,k,0)
//<<"%V $k $i $last_i  $A\n";
//!a
                if (i == last_i) {
                  //exit(-1)
                }

              last_i = i

DBG"%V$nfs search for $pat $k @ $i \n"


              i=searchFile(A,pat,0,1,0);   // looking for pat in function name

//pcl_file(A,1,1);


//ans=query("??","goon",__LINE__,__FILE__);
              if (i == -1) {

             <<" no more $pat \n"

                  npat = ssub(pat,"_","",0)

                  i = fseek(A,k,0) // reset position

                  i=search_file(A,npat,0,1,0)   // try looking for pat without underlines in function name

              //<<"%V$npat $i\n"

                  if (i == -1) {
                   <<" notfound exit \n"
                         exit(-1)
                  }

                  pat = npat

                }
                else {

                //<<"Found %V $pat @ posn $i \n"

                }

              // seek no print

                pcl_file(A,1,1);

                wd=rwl_file(A,1);

//<<"%V $wd $w2\n";


                 first = 0;
		 
                 if ( wd @= ".(x" ) {
                       //pr_fun()
		       prest();
		       exit(0);
                 }


                 if ( wd @= ".)x" ) {
                       prest();
		      exit(0);
                 }
		 
               wd=rwlFile(A,1);

//<<" while 2  ? %V $w1 $w2 $wd\n";
nwr=readwords(A,Wd,1);
         i=fseek(A,0,1)

//<<"nwr $nwr $i $Wd\n"
              }

//<<" while 1 $w1\n";
            }


exit(0);

///////////////////////////////////