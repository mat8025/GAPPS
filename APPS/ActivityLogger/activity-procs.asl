//%*********************************************** 
//*  @script activity-procs.asl 
//* 
//*  @comment procs for activity-logger 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Mon Jun 17 12:37:52 2019 
//*  @cdate Mon Jun 17 12:37:52 2019 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2019 → 
//* 
//***********************************************%

proc readTheActivity( fnm)
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
proc colorRows(r,c)
{
int icr=0;
int jcr = c -1;
<<"%V $r $c\n"
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

//===============================//
proc HowLong(wr, wc)
{
 <<"%V $wr $wc\n"
   mans = popamenu("Howlong.m")
        if (!(mans @= "NULL_CHOICE")) {
	<<"%V $mans\n"
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//
proc HowFar(wr, wc)
{

   mans = popamenu("HowFar.m")
        if (!(mans @= "NULL_CHOICE")) {
	<<"%V $mans\n"
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//
proc HowFast(wr, wc)
{

   mans = popamenu("HowFast.m")
        if (!(mans @= "NULL_CHOICE")) {
	<<"%V $mans\n"
           sWo(cellwo,@cellval,wr,wc,mans);
           R[wr][wc] = mans;
        }
}
//===============================//

proc READ()
{
<<[_DB]"reading $fname\n"
       // isok =sWo(cellwo,@sheetread,fname,2)
            A= ofr(fname)
            R= readRecord(A,@del,Delc)
           cf(A)
           sz = Caz(R);
           rows = sz;

  for (i = 0; i < rows;i++) {
<<"[${i}] $R[i]\n"
   }


<<"num of records $sz\n"
<<[_DB]"num of records $sz\n"
//      do display update elsewhere
       sWo(cellwo,@cellval,R);
       sWo(cellwo,@setrowscols,rows+3,cols+1);
       sWo(cellwo,@selectrowscols,0,rows-1,0,cols); // must select section to view       
       sWo(cellwo,@redraw);

           return 
}
//======================


proc OPEN()
{
   //==================
   // read in new task sheet
      SAVE(); // save current mods - query

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


wkn =1;
yrn = 2019;
daydate =1;
dayname ="Monday"
mon = "jun"

proc getWeekYr()
{
  dstr= !!"date "
<<"$dstr \n"
  wks = split(dstr);
  ys = wks[5];
  yrn = atoi(ys)

  mon = wks[1];
  dayname = wks[0];
  daydate = atoi(wks[2]);
  
  wks= !!"date +\%V"
<<"$wks $(typeof(wks)) $(Caz(wks))\n";
<<"%V $wks\n"
ws0=wks[0];
wkn = atoi(ws0);


  dstr= !!"date +\%w"
  dow = atoi(dstr);
///////////////////////
<<"-------------\n"
ds = date(2);
jd = julian(ds);
<<"%V$ds $jd\n"
dow2 = !!"date +\%u"
dn= atoi(dow2);
<<"%V$dow2 $dn\n"
dn--;

<<" we are in week $wkn $yrn mon $mon $dayname $daydate\n";
}

