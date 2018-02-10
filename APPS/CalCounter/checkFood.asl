///
//////////////////////////////////////
//<<"including checkFood\n"

proc Compare(phr1,phr2)
{
   int fit = 0;
// how many words in phr1 (svar)
// are in (partially) phrase 2
// all in  order -- 100 - none 0
   int match;
   int charrem;
   int k;
   int fit = 0; 

  n = Caz(phr1); // how may words/field in svar phr1

  fwds = Split(phr2);
  n2 = Caz (fwds);
  for (k = 0; k < n; k++) {
    wd = supper(phr1[k]);
    rs=spat(phr2,wd,0,1,&match,&charrem); // TBF if don't capture return
                                                                     // next if garbaged ???
    if ( match == 1) {
       fit += 10;
       if (k < n2) {
         if (wd @= fwds[k]) {
           fit += (5 + (n-k));
         }
       }
     }
   }
    
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

  the_unit = "1";

  nci = scin(myfood,",")
  if (nci > 0)
    food_d = split(myfood,',')
  else
      food_d = split(myfood)
      
//<<"%V <$food_d> $(typeof(myfood))\n"

  fsz = Caz(food_d)

  <<"%V$fsz\n"

  nfd = fsz;

   the_food = food_d[0];

//<<"$the_food \n"

     the_unit = "oz"
     the_amt = 1;

    N = Nrecs -1;
    
    for (i = 1 ; i < N ; i++) {

        score = Compare(food_d,RF[i][0]);

      if (score > 0) {
        //  <<"$('PRED_') $Wans $('POFF_')\n"
	//  <<"%V$score \n"
         found =1;        
        if (score > Bestpick[pk][0]) {
	<<"%V $pk $score  $Bestpick[pk][0]\n"
           Bestpick[pk][0] = score;
	   Bestpick[pk][1] = i;
	   pk++;
	 }
	 
	 if (pk > (Nbp-1)) {
             pk = 0;
         }
  
      if (score > best_score) {
          best_score = score;
	  best_i = i;
      }
  }
}

 
//=================================================


   if (found) { // some match was found
          <<"$('PGREEN_') "
  <<"$RF[best_i] \n"
   <<"$('POFF_') "
<<"FOOD found %V $best_score $best_i  \n"
      Wfi = best_i;

/{
<<"pre sort %V$Bestpick\n"

     for (i= 0; i < Nbp; i++) {
<<"$i $Bestpick[i][::]\n"
     }

//<<"$(typeof(Bestpick)) $(Cab(Bestpick))\n"

/}

     bp = msortCol(Bestpick,0);
/{
     for (i= 0; i < Nbp; i++) {
<<"$i $bp[i][::]\n"
     }
/}

     Bestpick = bp;

/{
<<"after sort %V$Bestpick\n"

     for (i= 0; i < Nbp; i++) {
<<"$i $Bestpick[i][::]\n"
     }
/}


    best_score = 0;
    
    for (i =0; i < Nbp; i++) {
        if (Bestpick[i][0] > 1) {
	      wi = Bestpick[i][1] ;
              wscore = Bestpick[i][0] ;
            <<"<$i> $Bestpick[i][0] $Bestpick[i][1] " 
            <<"$RF[wi] \n"
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


//<<"Done inc checkFood\n"