/////////////////////////////////////////////////////////////
///  planner
///
///
///  add tasks/goals to Record structure
///  descr category code priority pc_done date_start date_2finish start_date, done_date ...
///
///


setdebug(1) ;

vers="1.1";

Record R[20+];

int Rn = 0;

//Rn[0][7] = "x/x/x";


proc addtask()
{

  pri = "3";
  pcat = "aslsw";
  pcode = "C";
  wrd = "";

  //R[Rn][0:7] = " ";
  //R[Rn][4] = "0";
  
  while (1) {

  tans=i_read("task description :: ")


  R[Rn][0] = tans;

  pcat =query("category  :: ",pcat)

  R[Rn][1] = pcat

  <<"[$Rn ] $R[Rn] \n"


  pcode=query("code [C,M,P]  :: ",pcode)
  R[Rn][2] = pcode;

  pri=query("priority? 1-7 :: ",pri)

  R[Rn][3] = pri;

  // pc done
  if (R[Rn][4] @="") {
    wrd= "0";
  }
  else {
   wrd =R[Rn][4];
  }
  wrd =query("Pc_done? :: ",wrd)
  R[Rn][4] = wrd;


  wrd =R[Rn][5];
  wrd =query("date2finish? :: ",wrd)
  R[Rn][5] = wrd;

  if (R[Rn][6] @="") {
    wrd= dstr;
  }
  else {
   wrd =R[Rn][6];
  }

  wrd =query("startdate? :: ",wrd)
  R[Rn][6] = wrd;

  if (R[Rn][7] @="") {
    wrd="xx"
  }
  else {
   wrd =R[Rn][7];
  }

  wrd =query("donedate? :: ",wrd)
  R[Rn][7] = wrd;
  
<<"[$Rn ] $R[Rn] \n"

  ans ="a";
  ans = query("$tans :: [a]ccept,[e]dit,[r]eject ? ",ans)
  if (scmp(ans,"a",1)) {
   Rn++;
   break;
  }
  elif (scmp(ans,"r",1)) {
      break;
  }
 }


}
//===========================

proc listtasks()
{

<<"current tasks\n"
   svar S;
   for (ir =0; ir < Rn; ir++) { 
//    <<"[$ir ] $R[ir]\n";
    S= R[ir];
      <<"[$ir ] $S\n";
   }

}

//=========================

proc edit_tasks()
{

<<"edit tasks\n"
  wn = "0"
  wn = query("which task? 0-$Rn  :: ",wn);
  tn = atoi(wn);

  if ((tn >= 0) && (tn < Rn)) {

  while (1) {

  tans = R[tn][0] 
  tans=query("task description :: ",tans)
  R[tn][0] = tans;
  
  R[tn][1] =query("category  :: ",R[tn][1])
  
  R[tn][2] =query("code [C,M,P]  :: ",R[tn][2])

  R[tn][3] =query("priority? 1-7 :: ",R[tn][3])
  
  R[tn][4] =query("Pc_done? :: ",R[tn][4])
 
  R[tn][5] =query("date2finish? :: ",R[tn][5])
   
  R[tn][6] =query("startdate? :: ",R[tn][6])
  
  R[tn][7] =query("donedate? :: ",R[tn][7])
  
  
<<"[$tn ] $R[tn] \n"

  ans ="a";
  ans = query("$tans :: [a]ccept,[e]dit,[r]eject ? ",ans)
  if (scmp(ans,"a",1)) {
    break;
  }
  elif (scmp(ans,"r",1)) {
      break;
  }
 }
 }


}

//======================

proc quit()
{

<<"$_proc   --- saving!\n"

 fseek(B,0,0)
 <<[B]"# task desc, cat, code, priority, pc done, date2finish, start_date, date_done \n"
 <<[B]"#\n"
 writeRecord(B,R,"#");
 cf(B)
 
/{
   svar S;
<<" $Rn records to save\n";
   for (ir =0; ir < Rn; ir++) {
    S= R[ir]
    <<"[${ir}]: $S\n"
    <<[B]"%(10,,\,,\n)$S"
   }
 /}
 
 exit();
}

//======================

/// main loop


///////// pp.rec_file ////////////

 lans = "a";
 
 dstr= date(2)
 //ds=ssub(ds,"/","-",0)

 fname = "pp.rec";
 ok=fexist(fname,0);
<<"$ok $fname\n"

 if (ok >0) {
 
 B= ofile(fname,"r+")
 
 R=readRecord(B,@type,RECORD_,@del,',')

/{
 res = readline(B)
    <<"$res\n"
   //svar res;
  // res = "";
// read each entry into Record
 
     while (1) {
       res = readline(B);
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
/}
 Rn = Caz(R)
 <<"nr = $Rn\n"

 }
 else {

   B= ofw(fname)
 }

  if (Rn > 0) {
      listtasks()
  }


   while (1) {

     lans = query("[a]add, [l]ist, [e]dit , [q]uit? ", lans)

     if (scmp(lans,"a",1)) {
          addtask()
     }
     else if (scmp(lans,"l",1)) {
          listtasks()
     }
     else if (scmp(lans,"e",1)) {
          edit_tasks()
     }
     else if (scmp(lans,"q",1)) {
          quit()
     }          


   }


//==================================