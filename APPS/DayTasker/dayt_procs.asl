//%*********************************************** 
//*  @script dayt_procs.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.4 Be Beryllium                                               
//*  @date Tue Dec 25 08:08:48 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%



proc readTheDay( fnm)
 {
  int isOK = 0;
   
   B= ofile(fnm,"r+")
 
 <<" $_proc $fnm $B\n" 
   if (B != -1) {
 
    fseek(B, 0,0);
  
    
      while (1) {
        res = readline(B)
     //   <<"$res\n"
         if (f_error(B) == EOF_ERROR_) {
 	   break;
 	}
        if ((slen(res)) > 1 && !scmp(res,"#",1)) {
  <<"$res\n"
         R[Rn] = Split(res,",");
         Rn++;
         if (Rn > 100) {
            break;
         }
 	}
      }
       isOK = 1;
       cf(B);
    }
 <<" $_proc returns $isOK \n";
   return isOK;
 }
//=================================//
 

proc PCDONE(wr)
{
  
   mans = popamenu("PCdone.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,3,mans);
           R[wr][3] = mans;
        }
}
//===============================//

proc HowLong(wr, wc)
{
  
   mans = popamenu("Howlong.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//
/{
// use gss versions
proc setPriority(wr)
{
   mans = popamenu("Priority.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,PriorityCol,mans);
           R[wr][PriorityCol] = mans;
        }
}
//===============================//
proc setDifficulty(wr)
{
   mans = popamenu("Difficulty.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,DiffCol,mans);
           R[wr][DiffCol] = mans;
        }
}
//===============================//
/}
proc setAttribute(wr)
{
   mans = popamenu("Attributes.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,AttrCol,mans);
           R[wr][AttrCol] = mans;
        }
}
//===============================//

proc ADDTASK()
{
/// should go to last page
<<"@ $_proc \n"
<<" called ADDTASK\n"

     ADDROW();
     return 
}
//====================================


proc ADDFAV()
{

  // enum Guitar
  
         mans = popamenu("Favorites.m")

       // <<"%V$mans\n"

	
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
   //  <<"%V $i $j $r $c\n"
        if ((i%2)) {
             sWo(cellwo,@cellbhue,i,j,LILAC_);         
	}
	else {
              sWo(cellwo,@cellbhue,i,j,YELLOW_);
	 }
       }
     }
     <<"$_proc done\n"
}

//============================//


proc SCORE()
{

 <<"calculating the score for all tasks\n"
  int total = 0;
  for (i =1 ; i <Rn; i++) {
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