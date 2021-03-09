//%*********************************************** 
//*  @script checkFood.asl 
//* 
//*  @comment  
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                 
//*  @date Sat Dec 29 11:16:57 2018 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2014,2018 --> 
//* 
//***********************************************%
///

_DB = -1

proc Compare(str phr1,str phr2)
{
   int fit = 0;
// how many words in phr1 (svar)
// are in (partially) phrase 2
// all in  order -- 100 - none 0

   int match;
   int charrem;
   int k;
   int fit = 0;
   str rs = "";



  n1 = Caz(phr1); // how many words/field in svar phr1

  fwds = Split(phr2);
  swds = Split(phr1);
  //swds = phr1;

  n2 = Caz (fwds);

//<<"$n1 $phr1 : $n2   $phr2\n"

///  check food category
# <BREAD>  FRENCH,1,SLICE,100,18,1,3,0,0.3 ,35,,,,,,,,,,,


//  fcat = fwds[n2-1]
  fcat = fwds[0]
  
  if (scmp(fcat,"<",1)) {
//<<" cat is <|$fcat|>\n"
     fcat= sele(fcat,-2)
//<<" cat is <|$fcat|>\n"     
     fcat = sele(fcat,1)

     if (scmp(swds[0],fcat,0,0)) {
        fit += 10;
//<<" fcat  match <|$fcat|>\n"     
    }
  }


  for (k = 0; k < n1; k++) {

    wd = supper(phr1[k]);
//<<"$k $wd $phr2 \n"
    rs=spat(phr2,wd,0,1,&match,&charrem); // TBF if don't capture return
//<<"<|$rs|> $match $charrem \n"
    if ( match == 1) {
//<<"$k $wd $rs $fit\n"
      fit += 10;
       if (k < n2) {
         if (wd @= fwds[k]) {
           fit += (5 + (n1-k));
         }
       }
     }
   }

//<<"%v $fit\n"
    return fit;
}
//==============================




int txtwo = 0
the_carbs = 0
the_cals = 0
the_prot = 0
the_fat = 0
the_satfat = 0.0;

query_res = ""
the_descr = ""

int Wfi = 0;


<<"B4 proc searchFood(str the_food_name\n"

proc searchFood(str the_food_name)
{
  int bpk = -1;
<<"$_proc  $the_food_name \n"
  Bestpick = -1;		//clear the best pick choices
  bpick = -1;
  
   myfood = the_food_name;

<<"search for $the_food_name  $myfood \n";

   bpk = checkFood();


<<"found entry $bpk\n";


   return bpk;
}


//==================================//

proc checkFood()
{

///  get this to return array of fits
///  best to least - max 5?

int best_i = -1;
int ok = 0;

int pk= 0;
int score = 0;
int best_score = 0;
int best_pick = -1;
int found = 0;
the_amt = 1.0;
str the_unit
svar food_d;
int nfd = 0;
str the_food;

//<<" $_proc looking for $f_amt $f_unit of $myfood \n"
<<[_DB]" $_proc looking for $f_amt $f_unit of $myfood \n"

  the_unit = "1";

  nci = scin(myfood,",")

  if (nci > 0) {
      food_d = split(myfood,',');
    }
  else {
      food_d = split(myfood)
  }

<<[_DB]"%V <$food_d> $(typeof(myfood))\n"

  fsz = Caz(food_d)

  <<"%V$fsz\n"

  nfd = fsz;

   the_food = food_d[0];

//<<"$the_food \n"

     the_unit = "oz"
     the_amt = 1;

    N = Nrecs -1;
  //  <<"%V $Nrecs \n"
    jj = 0;
    food_wrd="";

   for (i = 1 ; i < N ; i++) {
    
        food_wrd = "$RF[i][0]";
	
        //score = Compare(food_d,RF[i][0]);
//<<"$i $food_wrd\n"

      // score = Compare(food_d,food_wrd);
       score = Compare(myfood,food_wrd);

      if (score > 0) {
        //  <<"$('PRED_') $Wans $('POFF_')\n"
//more= iread("continue?");
  //      <<"$score $food_wrd\n"
         found =1;        
        if (score > Bestpick[pk][0]) {
	<<[_DB]"%V $pk $score  $Bestpick[pk][0]\n"
           Bestpick[pk][0] = score;
	   Bestpick[pk][1] = i;
	   pk++;
	 }
  
      if (score > best_score) {
          best_score = score;
	  best_i = i;
      }
      
	 if (pk > (Nbp-1)) {
             pk = 0;
         }

      if (best_score >30) {
         break;
      }
	 jj++;
	 if (jj > 1500) {
              break;
         }
    }
}

 
//=================================================


   if (found) { // some match was found
          <<"$('PGREEN_') "
	  FL = RF[best_i];
 // <<"%V$RF[best_i] \n"
 // <<"$FL \n"
   <<"$('POFF_') "
//<<"FOOD found %V $best_score <|$best_i|>  \n"

      Wfi = best_i;

    // testargs(1,Bestpick)
<<[_DB]"pre sort %V$Bestpick\n"

     for (i= 0; i < Nbp; i++) {
       i0 = Bestpick[i][0];
       i1 = Bestpick[i][1];       

//<<[_DB]"$i $Bestpick[i][0] $Bestpick[i][1]\n"
<<[_DB]"$i $i0 $i1\n"
     }

//<<[_DB]"$(typeof(Bestpick)) $(Cab(Bestpick))\n"

//<<"//////////////////\n"

bsz = Caz(Bestpick);
<<[_DB]"%V$bsz \n"

     bpr = msortCol(Bestpick,0);
     bp = mrevrows(bpr);
     
//testargs(1,Bestpick)
// but this is in ascending order
// want to reverse to 0 row is best
     for (i= 0; i < Nbp; i++) {
       i0 = bp[i][0];
       i1 = bp[i][1];       
<<[_DB]"bp $i $i0 $i1\n"
//<<[_DB]"$i bp $bp[i][0] $bp[i][0]\n"
     }


<<[_DB]"//////////////////\n"
     Bestpick = bp;

<<[_DB]"after sort %V$Bestpick[0][1]\n"

     for (i= 0; i < Nbp; i++) {
<<[_DB]"$i $Bestpick[i][0] $Bestpick[i][1] \n"
     }

    best_score = 0;

    for (i =0; i < Nbp; i++) {
        if (Bestpick[i][0] > 1) {
	      wi = Bestpick[i][1] ;
              wscore = Bestpick[i][0] ;
            <<[_DB]"<$i> $Bestpick[i][0] $Bestpick[i][1]\n " 
            FL = RF[wi];
            //<<[_DB]"%V$RF[wi] \n" // BUG
<<"$RF[wi] \n" // BUG	    
	    //<<"%V$FL \n"
	    if (wscore > best_score) {
                 best_pick = wi;
		 best_score = wscore;
            }
         }
    }
   }

      return best_pick; 
}

////////////////////////////////////////////////
<<"Done $_include \n"
