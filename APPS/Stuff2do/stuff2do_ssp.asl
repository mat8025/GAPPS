//%*********************************************** 
//*  @script stuff2do_ssp.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H.H 
//*  @date Sat Dec 22 23:28:03 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///
///  
///


//=================== Button Procs ===========
proc ADDTASK()
{
/// should go to last page
    AddTask(0);
    return 
}
//====================================
proc OPEN()
{
   //==================
   // read in new task sheet
   SAVE();

   // clear out record
          sWo(cellwo,@cellval,R);
	  sWo(cellwo,@redraw);
   // get new fname for task

   sz = Caz(R);
//   <<"%V $sz\n"
  // R->deleteRows(1,ALL_);
   deleteRows(R,1,ALL_);
   nsz = Caz(R);
  // <<"%V $nsz\n"


          sWo(cellwo,@cellval,R);
	  sWo(cellwo,@redraw);
	Nrows = nsz;
	
        sWo(cellwo,@cellval,nsz,0,sz,cols,"");
        sWo(cellwo,@cellval,R);
	sWo(cellwo,@redraw);


   new_fname = naviW("New_Task_File","task sheet? ","./","csv");


   fsz=fexist(new_fname);

<<"%V $fsz $new_fname \n"

   if (fsz != -1) {
    fname = new_fname;
    READ();
   }

}
//=============================


proc PCDONE(wr,wc)
{
  
   mans = popamenu("MENUS/PCdone.m")
	
        if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//
proc SCORE()
{

 <<"calculating the score for all tasks\n"
  int total = 0;
  for (i =1 ; i < Nrows; i++) {
  score = atof(R[i][PCDoneCol]);
  score *= atof(R[i][DiffCol]);

// score *= atof(R[i][DurationCol]);  
  total += score;
//  <<"%V $i $score $total\n"
  val = "%4.1f$score"
// R[i][ScoreCol] = val;
//  sWo(cellwo,@cellval,i,ScoreCol,val);
  sWo(scorewo,@value,total,@update);
  }
}
//========================================================//
proc SAVE()
{
//<<"IN $_script $_proc saving sheet %V $fname  $Ncols \n";
	 
            B=ofw(fname);
	    R[0]= Split("Task,Code,Priority,Difficulty,TimeEst,TimeSpent,Startdate,Update,PCDone,Tags,",",");
            if ( B != -1) {
            nrw=writeRecord(B,R,@del,Delc,@ncols,Ncols);
<<[_DB]"%V $B $nrw  $Ncols \n"
            cf(B);
	    }
	    

}
//========================================================//
proc colorRows(r,c)
{
int icr=0;
int jcr = c -1;

   for(icr = 0; icr < r ; icr++) {
	
        if ((icr%2)) {
          sWo(cellwo,@cellbhue,icr,1,icr,jcr,LILAC_);

	}
	else {
	    sWo(cellwo,@cellbhue,icr,1,icr,jcr,YELLOW_);
	 }
     }

<<[_DB]"$_proc done\n"
}
//============================================//