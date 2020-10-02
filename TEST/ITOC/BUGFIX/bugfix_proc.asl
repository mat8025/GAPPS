///
///
///



proc ADDBR()
{
  <<"CALL ADD BUG ROW \n"
   AddTask(0);
   // check this was filled in correctly and then  bump BugN
   BugN++;
   DF[0][0] = BugN++;
}

//=====================================//

proc SAVE()
{
<<[_DB]"IN $_proc saving sheet %V $fname  $Ncols \n";

  R[0] = Split("Bug#,descr,code,priority,status,reportDate,upDate,",",")

            B=ofw(fname);
            if ( B != -1) {
            nrw=writeRecord(B,R,@del,Delc,@ncols,Ncols);
<<[_DB]"%V $B $nrw  $Ncols \n"
            cf(B);
	    }
	    
  
}
//======================
proc setStatus(wr, wc)
{

   mans = popamenu("Status.m")
	
   if (!(mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
   }
}
//===============================//
proc setUpDate(wr, wc ,td)
{

           sWo(cellwo,@cellval,wr,wc,td);
           R[wr][wc] = td;
}
//===============================//
