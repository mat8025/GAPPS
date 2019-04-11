//%*********************************************** 
//*  @script dayt_procs.asl 
//* 
//*  @comment procs for daytasker 
//*  @release CARBON 
//*  @vers 1.6 C Carbon                                                   
//*  @date Mon Jan 28 08:58:08 2019 
//*  @cdate 6/1/2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


proc makeMyDay (fnm)
{
<<"$_proc \n"
<<[_DB]"making $fnm \n"
    B= ofw(fnm)
    R[0] = Split("Task,Priority,TimeEst,PCDone,TimeSpent,Difficulty,Attrb,Score,Tags",',');
//    <<[_DB]"$R[0] \n"
    R[1] = DF[1];
    R[2] = DF[2];
    R[3] = DF[3];
    R[4] = DF[4];

//<<[_DB]"$R[1] \n"    

<<[_DB]"$R \n"    

    Rn = 5;
    writetable(B,R);
    cf(B);
    B= ofr(fnm)
    R= readRecord(B,@del,',');
    cf(B);
<<"readback of default\n"

   sz = Caz(R);
   Rn = sz;

   ncols = Caz(R,0);
   ncols1 = Caz(R,1);

<<[_DB]"num of records $sz  num cols $ncols $ncols1\n"
<<[_DB]"$R \n"

 for (i=0;i<sz;i++) {
<<[_DB]"%V$R[i][1] \n"
<<[_DB]"%V$R[i][2] \n"
<<[_DB]"%V$R[i][3] \n"
<<[_DB]"%V$R[i][4] \n"
<<[_DB]"%V$R[i][5] \n"
}

<<"done $_proc $Rn\n"

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

     Rn = 0;
    
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

   sz = Caz(R);
   ncols = Caz(R,0);
   ncols1 = Caz(R,1);

 
<<[_DB]"num of records $Rn  num cols $ncols $ncols1\n"

<<"done $_proc\n"

   return isOK
 }
//=================================//



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
/// should go to last page / last row
<<[_DB]"@ $_proc \n"
<<[_DB]" called ADDTASK\n"
<<"%V $Rn $rows \n"
     ADDROW();

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



//int c_i;
//int c_j;
proc colorRows(r,c)
{
int icr=0;
int jcr = c -1;

//    c_j = jcr;
   for(icr = 0; icr < r ; icr++) {
	
        if ((icr%2)) {
		  <<"$icr $jcr\n"
          sWo(cellwo,@cellbhue,icr,1,icr,jcr,LILAC_);
	  // testargs(1,cellwo,@cellbhue,icr,1,icr,jcr,LILAC_);
	  // testargs(1,cellwo,@cellbhue,icr,jcr,LILAC_);

	}
	else {
	  <<"$icr $jcr\n"
	    sWo(cellwo,@cellbhue,icr,1,icr,jcr,YELLOW_);
	    //testargs(1,cellwo,@cellbhue,icr,1,icr,jcr,YELLOW_);
	 //   testargs(1,cellwo,@cellbhue,icr,jcr,LILAC_);
	 }
     }

     <<[_DB]"$_proc done\n"
}

//===================================//
proc SAVE()
{
//<<[_DB]"IN $_proc saving sheet %V $fname  $Ncols \n";
<<"calling $_proc\n"
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
  wrd="";
  <<"%V $Rn $PCDoneCol $DiffCol $DurationCol $ScoreCol\n"


  for (i =1 ; i < Rn; i++) {
  wrd = R[i][PCDoneCol]
 // <<[_DB]"$i $wrd $R[i][PCDoneCol] $R[i][DiffCol]\n"
  //score->info(1)
  //R->info(1)
  
  score = atof(R[i][PCDoneCol]);
//  score = atof(wrd);
//<<"%V $score\n"
  score *= atof(R[i][DiffCol]);
  wrd = R[i][DiffCol];
  score *= atof(R[i][DurationCol]);
 // score *= atof(wrd);
 // wrd = R[i][DurationCol];
//  score *= atof(wrd);
  score *= 0.01;
  total += score;
  
  
  val = "%4.0f$score"
  R[i][ScoreCol] = val;
  sWo(cellwo,@cellval,i,ScoreCol,val);
  sWo(scorewo,@value,total,@update);
  }
<<[_DB],"%V $total\n"
}

//===================================//