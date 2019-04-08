//%*********************************************** 
//*  @script loopquery.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 2.18 Ar Argon                                                  
//*  @date Mon Dec 31 14:40:59 2018 
//*  @cdate Mon Dec 31 08:00:00 2015 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%





///
/// total up cals,carbs,...
/// accept,reject or multiply quantity by factor
/// cup to tablespoon 1/16
/// tablespoon -> teaspoon  1/3
/// for each query
/// write to a day log file DD/dd-04-09-2018
/// 

#define MAXFREC 50


Record R[];
Record DDI[3];

Svar Wans;

int Rn = 0;



float Ntrtotals[24];

proc adjustAmounts (svar irs, f)
{
  float a;
  int i;

<<"%V $(typeof(irs)) $irs[::]\n";
//<<"$irs[::]\n";
  for (i = 0; i < Ncols; i++)
    {
    <<"<$i>  $irs[i] \n";
    }

  a = atof (irs[1]) * f;
  <<"%V$a\n";
  irs[1] = "%6.2f$a";


  for (i = 3; i < Ncols; i++)
    {
      a = atof (irs[i]) * f;
    <<"$irs[i] $a\n" ;
    irs[i] = "%6.2f$a";
    }

}


//======================================//
proc showFitems ()
{
<<" $_proc\n"
  for (ir = 0; ir < Rn; ir++)
    {
      //<<"[$ir ] $R[ir][0] $R[ir][1] $R[ir][2] $R[ir][3] $R[ir][4]\n";
      <<"[$ir ] $R[ir]\n";
    }

  computeTotals ();
<<"Items\tCals\tCarbs(g)\tFat(g)\tPrt(g)\tChol(mg)\tSatFat(g)\tvA(dv)\tvC\tCa\n";
//<<"$(Rn) %4.1f\t$Cal_tot\t$Carb_tot\t\t$Fat_tot\t$Prt_tot\t$Chol_tot\t\t$SatF_tot\t\t$vA_tot\t$vC_tot\t$Ca_tot\n";
<<"$(Rn) %4.1f\t$Ntrtotals\n";

}
//================================================



proc readDD (ddfn)
{
  <<"$_proc \n";
//<<"Rsz $(Caz(R))\n"
    // R=ReadRecord(ddfn,@del,',',@comment,"",@pickstr,"@=",0,"must")
// found previous list
// read in lines and add to record
  R = ReadRecord (ddfn, @del, ',');
  //R=ReadRecord(ddfn,@del,44) ;
  // reads as records all lines except those starting with #
  Rn = Caz (R);

  <<"$Rn Rsz $(Caz(R))\n";

  <<" first rec $R[0]\n";
  <<"1 desc <|${R[0][0]}|>\n";
  <<"1 cals <|${R[0][1]}|>\n";
  <<"2 carbs $R[0][2] \n";

  for (i=0; i< Rn ;i++) {
<<"[${i}] $R[i]\n";
  }


//  R[(Rn+5)][0] = "#"; // array index not computed??
    wri = Rn+5
    <<"%V$wri\n"
    R[wri][0] = "#"; 

  for (i=0; i< Rn ;i++) {
<<"[${i}] $R[i]\n";
  }

//  <<"Rsz $(Caz(R))\n";
//
//  check for comment - else read and set food record item


}

//==================================
proc writeDD ()
{
// Ncols - food header should be sset via foodtable.csv
  B = ofile (the_day, "w");

//<<[B] "# Food                       Amt Unit Cals Carbs Fat Protein Chol(mg) SatFat Wt\n";
<<[B]"#Food,Amt,Unit,Cals,Carbs(g),Fat,Prot,Choles(mg),SatFat(g),Wt(g),Choline(mg),vA(dv),vC,vB1Th,vB2Rb,vB3Ni,vB5Pa,vB6,vB9Fo,B12,vE,vK,Ca,Fe,Na,K,Zn\n"
   for (i=0;i<Rn;i++) {
     <<"[${i}] $R[i]\n"
   }


  writeRecord (B, R, "#");


  computeTotals ();

//<<[B]"# totals %4.1f$Cal_tot $Carb_tot $Fat_tot $Prt_tot $Chol_tot $SatF_tot $vA_tot $vC_tot $Ca_tot\n";
<<[B]"# totals %4.1f$Ntrtotals\n";
    cf (B);

//<<"%(1,>>, || ,<<\n)$R[::]\n";

}
//==================================

proc computeTotals ()
{

  Ntrtotals = 0;
  Svar Wtot;
   for (ir = 0; ir < Rn; ir++)
    {
      ok = scmp (R[ir][0], "#", 1);
      if (!scmp (R[ir][0], "#", 1))
	{
	  //<<"adding rec $ir $R[ir][0] \n"

          Wtot =  R[ir];

          <<"$ir $(Caz(Wtot)) <|$Wtot|> \n"


	 
	  TS= Wtot[3:26];
//	  <<"$(Caz(TS)) $(typeof(TS))\n"
          VF = atof(TS);
	 // <<"%V $VF\n"
	  Ntrtotals += VF;
          //Ntrtotals += atof (R[ir][3:5]);	  	  	  
         // <<"adding rec $ir $ok $Cal_tot \n"
	}
    }

  
    <<"%V $Ntrtotals\n"
	  
}

//==================================

proc queryloop ()
{
///
/// loopquery
/// 
  int ret = 0;
  int reck = -1;
  str ans = "";
  int bpick;


  Nrecs = Caz (RF);
  Ncols = Caz (RF,0);


  <<"num of records $Nrecs  num cols $Ncols\n";
  for (i = 0; i < 10; i++)
    {
      nc = Caz (RF[i]);

      //<<"<$i> $nc $RF[i] \n";
       FL=RF[i];
       <<"<$i>  $FL  \n";      
    }

  for (i = Nrecs - 10; i < Nrecs; i++)
    {
      nc = Caz (RF[i]);
     // <<"<$i> $nc $RF[i] \n";
       FL=RF[i];
       <<"<$i>  $FL  \n";      
    }

  while (1)
    {


      Bestpick = -1;		//clear the best pick choices

      <<" New Query\n"
	ans = "new query"
	ans = i_read ("[n]ew,[l]ist,[d]elete,[s]ave,[q]uit ? :: $ans ")
	
	if (scmp (ans, "save", 1))
	{

	  writeDD ();		// update?

	  continue;
	}

      if (scmp (ans, "delete", 1))
	{

	  wrec = "-1";
	  <<"%V$wrec $ans $Rn $(Rn-1)\n";
	  //tans = i_read("?");
	  //<<"%V$tans\n" ;

	  //wrec=i_read("delete which record? 0 - $(Rn-1), :: $wrec");
	  maxrecn = Rn - 1;
	  wrec = i_read ("delete a record 0 $maxrecn  :: number ? ");

	  <<"%V$wrec $ans $Rn $(Rn-1)\n";
	  reck = atoi (wrec);
	  <<"%V$wrec $ans $Rn $(Rn-1) $reck\n";
	  //<<" $(typeof(wrec)) $(typeof(reck))\n";

	  if (reck >= 0 & reck <= Rn)
	    {
	      <<"comment out record $reck\n";
	      R[reck][0] = "#";
	    }
	  ret = 1;		// update
	  continue;
	}


      if (scmp (ans, "qy", 2)) {
          break;
      }
      
      if (scmp (ans, "quit", 1))
	{
	  ans = "no";
	  ans = i_read("need to save changes first?! -really quit ? [y]es :: $ans ");
	  if (scmp (ans, "yes", 1))
	    {
	      break;
	    }
	}


      if (scmp (ans, "list", 1))
	{

	  showFitems ();
//       <<"$Rn Rsz $(Caz(R))\n"
	  continue;
	}



//  ok=reload_src(1)
// <<"reload_src ? $ok \n"

      ans = i_read ("food $myfood ? : ");
      if (scmp (ans, "quit", 4))
	{
	  break;
	}

      if (!(ans @= ""))
	{
	  myfood = ans;
	}


      cookans = i_read("cook method/extra description [f]ried, [b]oiled, [r]aw $cookans ? : ");
      
      x_desc = "raw";

      if (!(cookans @= ""))
	{
	  if (cookans @= "f")
	    {
	      x_desc = "fried";
	    }
	  else if (cookans @= "b")
	    {
	      x_desc = "boiled";
	    }
	  //else if (cookans @="q"){
	  //    break;        
	  // }        
	  else
	    {
	      x_desc = cookans;
	    }

	  <<"cook method $cookans  $x_desc\n";
// WS del  or comma del ?  
	    myfood = scat (myfood, " $x_desc");
	}


      uans = i_read("Unit [c]up,[t]spn,[b]tbsp,[p]iece,[o]z,[i]tem,[s]lice :: $f_unit ?: ");
	if (!(uans @= ""))
	{
	  if (uans @= "c")
	    {
	      f_unit = "cup";
	    }
	  else if (uans @= "p")
	    {
	      f_unit = "piece";
	    }
	  else if (uans @= "i")
	    {
	      f_unit = "itm";
	    }
	  else if (uans @= "t")
	    {
	      f_unit = "tsp";
	    }
	  else if (uans @= "T" || uans @= "b")
	    {
	      f_unit = "tbsp";
	    }
	  else if (uans @= "o")
	    {
	      f_unit = "oz";
	    }
	  else if (uans @= "s")
	    {
	      f_unit = "slice";
	    }
	  else
	    {
	      f_unit = uans;
	    }
	}

      f_amt = 1.0;

///
///  if listed as cup and asked for tablespoon -- adjust quantities by 0.0625
/// 

      Wans->vfree();
      <<"%V$f_amt \n";
      bpick = checkFood ();

      if (bpick != -1)
	{

	  float mf = 1.0;

	  mf = f_amt;

//    <<"should be scalar!! %V $f_amt\n"
//    <<"should be scalar! %V $mf \n"

	  Wans->vfree();


	  nc = Caz (RF,bpick);
	  <<"%V $bpick $nc\n"
	  <<"$RF[bpick] \n";

	  ans = iread (" [a]ccept,[r]eject , [m]ultiply ?\n");

	  if (ans @= "a")
	    {

//<<[B]"$Wans \n"
	      <<"adding @ $Rn Rsz $(Caz(R))\n";
              DDI[0] = RF[bpick];
	      <<"%V $DDI[0]\n"
	      //R[Rn] = Split(Wans,",");
	      
             //<<"%V $(typeof(Wans))  $(Caz(Wans)) $Wans\n";
              Wans = RF[bpick];  // this does not set correct number of fields
	      <<"%V $(typeof(Wans))  $(Caz(Wans)) $Wans\n";
              
	      Wans->resize(Ncols);
	      
	      //<<"%V $(typeof(Wans))  $(Caz(Wans)) $Wans\n";
              R[Rn] = Wans;

	      //<<"added @ $Rn Rsz $(Caz(R,Rn))\n";
	      <<"<$Rn> added $R[Rn] \n";
	      Rn++;

	      ret = 1;
	    }

	  if (ans @= "m")
	    {

	      ans = iread ("adjust by ? factor\n");
	      mf = atof (ans);
	      //<<"adjust by $mf $(typeof(mf)) $(Caz(mf)) \n";
	      <<"adjust by $mf  \n";
	      if (mf > 0)
		{

		  Wans = RF[bpick];
                   
		  //<<"%V $(typeof(Wans))  $(Caz(Wans)) $Wans\n";
		  <<"%V $Wans\n";
		  
	//	    for (i = 0; i < Ncols; i++)
	//	    {
	//	      <<"<$i>  $Wans[i] \n";
	//	    }


		  adjustAmounts (Wans, mf);

//		  for (i = 0; i < Ncols; i++)
//		    {
//		      <<"<$i>  $Wans[i] \n";
//		    }

		  <<"%V $Wans\n";

		  ans = iread (" [a]ccept,[r]eject\n");

		  if (ans @= "a")
		    {
		      // <<[B]"$Wans \n"
		      <<"%V $(typeof(Wans))  $(Caz(Wans)) $Wans\n";
		      <<"adding @ $Rn Rsz $(Caz(R))\n";
		      Wans->resize(Ncols);
		      R[Rn] = Wans;
		      Rn++;
		      ret = 1;
		    }
		}
	    }
	}
    }
  return ret;
}


//========================================
