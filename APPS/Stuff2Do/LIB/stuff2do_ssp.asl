/* 
 *  @script stuff2do_ssp.asl 
 * 
 *  @comment  
 *  @release CARBON 
 *  @vers 1.2 He Helium [asl 6.3.14 C-Li-Si] 
 *  @date Wed Jan 27 10:03:07 2021 
 *  @cdate  1/1/2018
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 




Use_csv_fmt = 1;
Delc = 44;

//  class for page ops ?
int Curr_row = 0;
int Page_rows = 15;
int Rn = 1;  //global count of rows


//////////////////////   these records needed and used for any GSS /////////////////////



proc getCellValue(int r, int c)
{
 
     if (r >0 && c >= 0 ) {
 <<" %V $r $c \n";
           cvalue = R[r][c];
// <<" %V $cvalue \n";
           if ((c == 0) && (cvalue @= "")) {
             ADDTASK()
           }
           newcvalue = queryw("NewValue","xxx",cvalue,_ex,_ey);
<<[_DB]"%V$newcvalue \n"
           sWo(cellwo,@cellval,r,c,newcvalue);
           R[r][c] = newcvalue;
     }
}
//=====================
proc setPriority(int wr,int wc)
{
   Mans = popamenu("Priority.m")
	
        if (!(Mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,Mans);
           R[wr][wc] = Mans;
        }
}
//===============================//
proc setUpdate(int wr,int wc)
{
   
	   Mans = date(2);
           sWo(cellwo,@cellval,wr,wc,Mans);
           R[wr][wc] = Mans;
        
}
//===============================//


proc setDifficulty(int wr,int wc)
{
   Mans = popamenu("Difficulty.m")
	
        if (!(Mans @= "NULL_CHOICE")) {
           sWo(cellwo,@cellval,wr,wc,Mans);
           R[wr][wc] = Mans;
        }
}
//===============================//
proc HowLong (int wr,int wc)
{
 <<"$_proc\n" 
   Mans = popamenu("Howlong.m")
	
        if (!(Mans @= "NULL_CHOICE")) {
	<<"%V $wr $wc\n"
           sWo(cellwo,@cellval,wr,wc,Mans);
           R[wr][wc] = Mans;
        }
}
//===============================//

proc pickTaskCol (int wcol)
{	       
         sWo(cellwo,@cellbhue,0,swapcol_a,0,cols,YELLOW_);         	 	 

         swapcol_b = swapcol_a;
         swapcol_a = wcol;
	 wcol->info(1);
	 swapcol_a->info(1);
<<[_DB]"%V $wcol $swapcol_a $swapcol_b\n";
         sWo(cellwo,@cellbhue,0,swapcol_a,CYAN_);         	 

}
//===========================================//


//======================
proc DELCOL(int tc)
{
<<[_DB]"in $_proc $tc\n"


}
//======================

proc AddTask()
{
///

/// should write to last active record in record R  size must be Rn+1 or greater

     sz= Caz(R);
    
<<"in $_proc R record %V $rows $Rn $sz $Nrows\n"    

<<"$R\n"


    if (sz <= Rn) {
<<"expand record R!!\n"
    R[Rn] = "";
    }

    if (sz > Rn) {
          Rn = sz;
    }



    er = -1;
    rows_used = 0;
    for (i=0; i < sz; i++) {
     wval = R[i][0];
     <<"empty? $i <$wval>\n"
     if (wval @= "") {
        er = i;
	break;
     }
     rows_used++
    }

   if ( er == -1) {
   <<"no empty rows  have to add used %V $rows_used\n"
  }


   if (Nrows > sz) {
      Nrows = sz;
   }

   if (Nrows < rows_used) {
      Nrows = rows_used;
   }
   

   if (rows > Nrows) {
      rows = Nrows;
   }


   if (er == -1) {
    er = Nrows;
//    rows++;
//    Nrows++;
    R[er] =  TC;
   }
   
   <<"first empty row $er\n"
   


    //er = Rn; // check this is correct for first call

    if (Curr_row < 0) {
        Curr_row = 0;
    }
    
    <<"%V $Curr_row $Page_rows $cols $Rn\n"

    sWo(cellwo,@selectrows,Curr_row,Curr_row+Page_rows);
  
    Curr_row = rows- Page_rows +1;
    if (Curr_row < 0) {
        Curr_row = 0;
    }
    

    rows++;
    Nrows = rows;


    R[er] = TC;

<<"%V $er $R[er]\n"

// make sure expand record to at least one more
    Rn++;
    
    // 0  is the supplied default of this table
    // 1...nt  will be favorite/maintenance tasks
    // has to be written over to display version

    sWo(cellwo,@cellval,R);
    // increase rows/colls

    sWo(cellwo,@selectrows,Curr_row,rows);

    colorRows(Nrows,Ncols);
	       
    sWo(cellwo,@redraw);

    sz = Caz(R);

  <<"New size %V $rows $cols $sz $Rn\n"  
}
//===============================//



proc READ()
{
<<"reading $fname\n"
       // isok =sWo(cellwo,@sheetread,fname,2)
    fsz=fexist(fname);
<<"%V $fsz $fname \n"
    if (fsz > 10) {
           A= ofr(fname)
            R= readRecord(A,@del,Delc)
            cf(A)
           sz = Caz(R);
<<"num of records $sz\n"
<<[_DB]"num of records $sz\n"
   }
   return 
}
//======================
proc SORT()
{

  static int sortdir = 1;
  sortcol = swapcol_a;
  startrow = 1;
  alphasort = 0; // 0 auto alpha or number 1 alpha   2 number

  
  sortRows(R,sortcol,alphasort,sortdir,startrow)
  sortdir *= -1;

     sWo(cellwo,@cellval,R);
     sWo(cellwo,@redraw);
}


//=================== Button Procs ===========
proc ADDTASK()
{
/// should go to last page
    AddTask();

}
//====================================
proc OPEN()
{
   //==================
   // read in new task sheet
  // SAVE();

   // clear out record

 
   Str new_name="xxx";

  // chdir("~/Stuff2Do/TASKS");

   cwd= getdir()
   <<"%V $cwd\n"

   pdir="/home/mark/Stuff2Do/TASKS"

<<"Want to start here $pdir\n"


//   new_fname = naviW("New_Task_File","task sheet? ",pdir,"csv");
   new_fname = naviW("New_Task_File","task sheet? ","xx","csv",pdir);

   fsz=fexist(new_fname);

<<"%V $fsz $new_fname \n"
!i new_name

   sok = sstr(new_fname,"csv")
    <<"%V$sok $(cab(sok))\n"


   if ((fsz != -1) && (sok[0] != -1)) {

    fname = new_fname;
    fsz=fexist(fname);
<<"%V $fsz $fname \n"


  sz = Caz(R);
   deleteRows(R,1,ALL_);
   nsz = Caz(R);
  // <<"%V $nsz\n"


          sWo(cellwo,@cellval,R);
	  sWo(cellwo,@redraw);
	Nrows = nsz;
	
        sWo(cellwo,@cellval,nsz,0,sz,cols,"");
        sWo(cellwo,@cellval,R);
	sWo(cellwo,@redraw);



    READ();


    sWo(txtwo,@textf," loaded $fname",0.2,0.2)
    sWo(txtwo,@scrollclip,UP_,16)
    sWi(vp,@title,"S2D:$fname")

    sz= Caz(R);
    rows = sz;
    Nrows = rows;
    cols = Caz(R[0])



    sWo(cellwo,@cellval,R);
    // increase rows/colls

    sWo(cellwo,@selectrows,0,rows);
    
    paintRows();
    
    sWo(cellwo,@redraw);




    //sWo(txtwo,@print," loaded $fname !\n")
   }
   else {
<<"$new_name not valid task csv file\n";
   }

   cwd= getdir()
   <<"%V $cwd\n"
   eventRead(); // consume stray event
}
//=============================


proc PCDONE(int wr,int wc)
{
  
   //mans = popamenu("MENUS/PCdone.m")
   mans = popamenu("PCdone.m")
	
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
<<"IN $_script $_proc saving sheet %V $fname  $Ncols \n";
	 
            B=ofw(fname);
	 //   TC= Split("Task,Code,Priority,Difficulty,TimeEst,TimeSpent,Startdate,Update,PCDone,Tags,",",");
	  //  R[0]= TC;

            if ( B != -1) {
            nrw=writeRecord(B,R,@del,Delc,@ncols,Ncols);
<<[_DB]"%V $B $nrw  $Ncols \n"
            cf(B);
	    }
	    

}
//========================================================//
proc colorRows(int r,int c)
{
int icr=0;
int jcr = c -1;

   for(icr = 0; icr < r ; icr++) {
	
        if ((icr%2)) {
          sWo(cellwo,@cellbhue,icr,0,icr,jcr,PINK_);

	}
	else {
	    sWo(cellwo,@cellbhue,icr,0,icr,jcr,YELLOW_);
	 }
     }

<<[_DB]"$_proc done\n"
}
//============================================//