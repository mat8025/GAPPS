/* 
 *  @script aslinfo.asl                                                 
 * 
 *  @comment find routine description in ASLMAN                         
 *  @release Beryllium                                                  
 *  @vers 1.16 S Sulfur [asl 4.4.84 Be-Be-Po]                           
 *  @date 04/03/2023 11:22:40                                           
 *  @cdate Sun Dec 23 09:22:34 2018                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2023 -->                               
 * 
 */ 
;//----------------<v_&_v>-------------------------//;                  




Str Use_ = " info on asl functions";

ignoreErrors();

#define DBG ~!

//#define  DBG <<	


gssys= GetEnv("GS_SYS")

<<" ENV $gssys \n"
<<" looking for manual in $gssys\n"

int w = 0;

Svar Wd;

void prest()
{
 Str awd;
   int k=0;
   int kb = -1;
   int kf = 1;   
   long sl;

     while (1) {
     
                   if (k++ > 2000) {
		          break;
                   }
                            awd=rwl_file(A,1);
			//  <<"<|$awd|>\n";

                     //awd.aslpinfo();
			  
                          if (awd == ".EF") {
			   // <<"found EF break\n";
                                   break;
                            }

                      if (awd == ".BF") {
			  //  <<"found BF break\n";
                                   break;
                            }			    

			    //seekline(A,-1);
			    seekline(A, kb);
			    if (awd == ".FD" || awd == ".)x") {

	
			    //w=pcl_file(A,1);
			    
                            sl=seekLine(A,kf);
		    //<<"$k $sl $A\t";
                            }
			    else {
                            <<" \t"; // format print a tab offset for the line
                            w=pcl_file(A,1);
			    }

             }


}

void pr_fun()
{

//<<" $_proc %V$i\n"
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
Str npat = "xyz";

int k = 0;

long f_i = 0;

//DBG"%I $f_i \n"
//DBG" $(typeof(f_i)) \n"
//DBG" $(sizeof(f_i)) \n"

  
  pat = GetArgStr();

 //<<"\tsearch for $pat \n"
  <<"looking up $pat in manual \n"
     int A= -1;

     A=ofr("~/gapps/DOCS/ASLMAN.txt")


    if (A <= 0 ) {

      << "can't find manual in DOCS or SRC directories \n"

        exit(-1)
     }

int Nfs = 0;
int w1 =0;
int w2 =0;
int last = -1;




	 f_i=fseek(A,0,1); 


         if ( pat == "q" ) {
          exit(-1)
         }

          pat = scat("^*",pat);

          first =1;

          i=search_file(A,"^APPENDIX",0);
//<<"APPENDIX @ $i \n"
          last_i = -1;

int kloop = 1;
    while (1) {
	    
              w2++;
              Nfs++;

               f_i=fseek(A,0,1);

              // k=searchFile(A,".BF",0,1,0,1);    // next function
//<<"$kloop search for .BF from pos $f_i\n"
   k=searchFile(A,".BF",0,1,0,1,SEEK_CUR_);    // next function
//<<"$kloop found .BF at pos $k\n"

              // pcl_file(A,1);
	       //<<"print 2 lines \n";

              i = fseek(A,k,0)

                if (i == last_i) {
		//<<"exit why $i $last_i\n"
                  exit(-1);
                }

              last_i = i;

  //<<"$kloop %V$Nfs search for $pat $k @ $i \n"

              i=searchFile(A,pat,0,1,0,1,SEEK_CUR_);   // looking for pat in function name
//<<"%V $i\n"

          // pcl_file(A,1,1);

              if (i == -1) {

             <<" no more $pat \n"

                  npat = ssub(pat,"_","",0)

            i= fseek(A,k,0) // reset position

            i=search_file(A,npat,0,1,0)   // try looking for pat without underlines in function name

                  if (i == -1) {
                   <<" $npat not found in DOC \n";
                         exit(-1);
                  }

                  pat = npat;

                }

                 <<"\t";
		 
		 pclFile(A,1);
//<<"print 3 lines \n"
                wd=rwl_file(A,1);

//<<"wd is  $npat <|$wd|> \n"

                 first = 0;
		 
                 if ( wd == ".(x" ) {
                       //pr_fun()
		       //<<" Do prest .(x\n"
		       prest();
		       exit(0);
                 }


                 if ( wd == ".)x" ) {
//<<" do Prest .)x \n"
                     prest();


		      exit(0);
                 }
		 
               wd=rwlFile(A,1);
//<<"wd is <|$wd|> \n"

                 if ( wd == ".)x" ) {
                       prest();
		      exit(0);
                 }

                nwr=readwords(A,Wd,1);
                i=fseek(A,0,1)

//<<"end loop $kloop $nwr $Wd $i \n";

  kloop++;
  
    }

exit(0);

///////////////////////////////////