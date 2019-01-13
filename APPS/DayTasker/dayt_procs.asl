//%*********************************************** 
//*  @script dayt_procs.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.5 B Boron                                                    
//*  @date Tue Dec 25 08:08:48 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%





proc makeMyDay (fnm)
{
<<[_DB]"making $fnm \n"
    B= ofw(fnm)
    R[0] = Split("Task,Priority,TimeEst,PCDone,TimeSpent,Difficulty,Attrb,Score,Tags",",");
//    <<[_DB]"$R[0] \n"
    R[1] = DF[1];
    R[2] = DF[2];
    R[3] = DF[3];
    R[4] = DF[4];    
    
    Rn = 5;
    writetable(B,R);
    cf(B);
    B= ofr(fnm)
    R= readRecord(B,@del,',');
<<[_DB]"$R \n"
    cf(B);
}
//===============================================================//
proc readTheDay( fnm)
 {
  int isOK = 0;
  int nl = 0;
  
   B= ofile(fnm,"r+")
 
 <<[_DB]" $_proc $fnm $B\n" 
   if (B != -1) {
    setferror(B,0);
    fseek(B, 0,0);
  
    
      while (1) {
      
        res = readline(B)

      if (f_error(B) == EOF_ERROR_) {
          //<<"@ EOF\n"
 	   break;
  	}

<<[_DB]"$nl $res\n"


     sl = slen(res);



     if (( sl > 1) && !scmp(res,"#",1)) {

<<[_DB]"<$Rn> $res\n";
  
         R[Rn] = Split(res,",");
         Rn++;

        if (Rn > 100) {
	 <<"%V$Rn break\n"
            break;
         }
 	}
	
	nl += 1;

	
      }

       isOK = 1;
       cf(B);
    }
 <<[_DB]" $_proc read $nl lines returns $isOK \n";
   return isOK;
 }
//=================================//

     // if (f_error(B) == EOF_ERROR_) {
//	 <<"@ EOF\n"
 //	   break;
 //	}
   //  if ((slen(res) > 1) && !scmp(res,"#",1)) {
    // if (( sl > 1) && !scmp(res,"#",1)) {

proc PCDONE(wr,wc)
{
  
   mans = popamenu("PCdone.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//

proc HowLong(wr, wc)
{

//  wr->info(1)
//  wc->info(1)
   mans = popamenu("Howlong.m")
	//mans->info(1)
        if (!(mans @= "NULL_CHOICE")) {
//	<<"%V $mans\n"
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//


proc setAttribute(wr,wc)
{
   mans = popamenu("Attributes.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,AttrCol,mans);
           R[wr][wc] = mans;
        }
}
//===============================//

proc ADDTASK()
{
/// should go to last page
<<[_DB]"@ $_proc \n"
<<[_DB]" called ADDTASK\n"

     ADDROW();
     return;
}
//===============================================================//


proc ADDFAV()
{

  // enum Guitar
  
         mans = popamenu("Favorites.m")

       // <<[_DB]"%V$mans\n"

	
        if (!(mans @= "NULL_CHOICE")) {

            sWo(txtwo,@textr,"adding activity $mans",0.1,0.2);
	   
                wt = atoi(mans);
                AddTask(wt);
           
	  }
}
//============================//

proc colorRows(r,c)
{
int i;
int j;

    for (i = 0; i< r ; i++) {
     for (j = 0; j< c ; j++) {
   //  <<[_DB]"%V $i $j $r $c\n"
        if ((i%2)) {
             sWo(cellwo,@cellbhue,i,j,LILAC_);         
	}
	else {
              sWo(cellwo,@cellbhue,i,j,YELLOW_);
	 }
       }
     }
     <<[_DB]"$_proc done\n"
}

//===================================//
proc SAVE()
{
<<[_DB]"IN $_proc saving sheet %V $fname  $Ncols \n";
 R[0] = Split("Task,Priority,TimeEst,PCDone,TimeSpent,Difficulty,Attrb,Score,Tags",",");	 
            B=ofw(fname);
            if ( B != -1) {
            nrw=writeRecord(B,R,@del,Delc,@ncols,Ncols);
<<[_DB]"%V $B $nrw  $Ncols \n"
            cf(B);
	    }
	    
  
}
//======================

proc SCORE()
{

 <<[_DB]"calculating the score for all tasks\n"
  int total = 0;
  float score = 0;
//  <<"%V $PCDoneCol $DiffCol $DurationCol $ScoreCol\n"
  for (i =1 ; i < Rn; i++) {
  score = atof(R[i][PCDoneCol]);
  score *= atof(R[i][DiffCol]);
  score *= atof(R[i][DurationCol]);
  score *= 0.01;
  total += score;
  
  
  val = "%4.0f$score"
  R[i][ScoreCol] = val;
  sWo(cellwo,@cellval,i,ScoreCol,val);
  sWo(scorewo,@value,total,@update);
  }
}

//===================================//