///
//////////////////////////////////////
//<<"including checkFood\n"

int txtwo = 0
the_carbs = 0
the_cals = 0
the_prot = 0
the_fat = 0
the_satfat = 0.0;

query_res = ""
the_descr = ""
Wans = ""
int Wfi = 0;

proc checkFood()
{

///  get this to return array of fits
///  best to least - max 5?

int best_i = -1;
int main_food_fit = -1;

int qual1_fit = -1;
int qual2_fit = -1;
int qual3_fit = -1;
int ok = 0;
int qfit[5]; // best 5?
int pk= 0;
int score = 0;
int best_score = 0;
int found = 0;
the_amt = 1.0;
str the_unit
svar food_d;
int nfd = 0;
str the_food;

//<<" $_proc looking for $f_amt $f_unit of $myfood \n"

  the_unit = "1";

  food_d = split(myfood,',')

//<<"%V <$food_d> $(typeof(myfood))\n"

  fsz = Caz(food_d)

//<<"%V$fsz\n"

  nfd = fsz;

// <<"$nfd : $food_d \n"

 //food_d[0] = ssub(food_d[0],"y","",-1)

 ynqual = 0

 do_first_word = 0;
 qual0 = "";
 qual1 = "";
 qual2 = "";
 qual3 = "";

 if (nfd > 0) {
   qual0 = eatWhiteEnds(food_d[0]);
 }

 if (nfd > 1) {
   qual1 = eatWhiteEnds(food_d[1]);
 }
 
  if (nfd > 2) {
   qual2 = eatWhiteEnds(food_d[2]);
  }
  
  if (nfd > 3) {
   qual3 = eatWhiteEnds(food_d[3]);
  }
  
 qualt = "";

 q1len = slen(qual1);
 q2len = slen(qual2);
 q3len = slen(qual3); 

 the_food = food_d[0];

<<"$the_food Qualifiers %V <$qual1> $q1len <$qual2> $q2len  <$qual3> $q3len\n"

looked =0;

  while (1) {

     the_unit = "oz"
     the_amt = 1;


    for (i = 0 ; i < Nfoods ; i++) {
     score = 0;
     qual1_mat = 0;    
     qual2_mat = 0;
     qual3_mat = 0;         


//<<"$i $food_d[0]\n"

      //ynfood = Fd[i]->checkPrimary(food_d[0], do_first_word)

    ynfood = Fd[i]->checkPrimary(the_food, do_first_word)

// got to check other qualifiers


     if (ynfood) {

         score++;

//<<" FOUND the food ! $the_food  %V$nfd @ $i\n" 

        ynqual = 1;

        Fd[i]->print()

//ans= i_read(" found - proceed with qualifiers:")


        if (nfd > 1) {

//<<"$nfd now  checking qualifier1 $qual1\n"

           //Fd[i]->print();


           ynqual = Fd[i]->checkQualifier(qual1);
           score += ynqual;
         //<<"Match %V$ynqual \n";
             main_food_fit = 1;

          if (ynqual) {
//<<" $ynqual FOUND_Qualifier1 $food_d[1] \n";
	//	  Fd[i]->print()
                  qual1_mat = 1;    
		  qual1_fit = i;
               //ans= i_read(" found Qual1 @ $best_i");
             }


//<<"%V$nfd $(typeof(nfd))\n"

             if ((nfd > 2) && (q2len > 0)) {

  //        <<"now  checking qualifier2 $qual2 @ $i\n";
         
                  ynqual = Fd[i]->checkQualifier(qual2);
                 score += ynqual;
                 if (ynqual) {
//<<"FOUND_Qualifier2  $food_d[2]\n";
                  //<<"\nFound the food item !!\n"
  //                Fd[i]->print()
                  qual2_mat = 1;
		  qual2_fit = i;
                  //ans= i_read(" found_it with two qualifiers @ $best_i");
                }
             }

             if ((nfd > 3) && (q3len > 0)) {

//         <<"now  checking qualifier3 $qual3 @ $i\n";
         
                  ynqual = Fd[i]->checkQualifier(qual3);
                 score += ynqual;
                 if (ynqual) {
//<<"FOUND_Qualifier3  $food_d[3]\n";
                  //<<"\nFound the food item !!\n"
 //                 Fd[i]->print()
                  qual3_mat = 1;
		  qual3_fit = i;
               
                }
             }
         }


//<<"%V$the_unit \n"       

        if (qual1_mat || qual2_mat || qual3_mat ) {

        the_amt = Fd[i]->getamt()
        the_amt = Fd[i]->amt;

//<<"$i setting the_amt to $the_amt \n"

        the_unit = Fd[i]->getunit()

//<<"setting the_unit $the_unit \n"

        the_unit = Fd[i]->unit

//<<"setting the_unit $the_unit \n"

        the_carbs = Fd[i]->getcarbs()

        the_cals = Fd[i]->getcals()

        the_prot = Fd[i]->getprot()

        the_fat = Fd[i]->getfat()

        the_satfat = Fd[i]->getsatfat()

//<<"%V$myfood $the_unit $Fd[i]->unit $the_amt $the_cals $the_carbs\n"
//<<"%V$myfood $the_unit $the_amt $the_carbs $the_cals $the_prot\n"

        query_res = "%V$myfood $the_unit $the_amt $the_carbs $the_cals $the_prot"
        
        the_descr = Fd[i]->getdescr()

        fit = 0
        amt_fit = 0
        unit_fit = 0

//i_read()

//<<"%V$the_amt $f_amt \n"

        if (the_amt == f_amt) {
           amt_fit = 1;
        }


        if (sstr(the_unit,f_unit,1) != -1) {
           unit_fit = 1
        }

        if (f_unit @= "*") {
           unit_fit = 0
        }

        if (unit_fit && amt_fit) {
       //<<"AMT and UNIT FITS \n"
//<<"%V$the_amt $f_amt \n"
       score++;
        }
	
//         Fd[i]->print()
           Wans = Fd[i]->query(f_amt);
	   Wfi = i;
	   <<"$qual0 "
	  if (qual1_mat) {
          <<"$qual1 "
          }
	 if (qual2_mat) {
          <<"$qual2 "
          }
	  if (qual3_mat) {
          <<"$qual3 "
          }
	  
	   <<" \n"

          <<"$('PRED_') $Wans $('POFF_')\n"
	  <<"%V$score \n"

/{
<<"$('PRED_') $myfood \n $Fd[i]->descr %4.2f $the_amt "
<<"$the_unit %4.2f cals $Fd[i]->cals carbs  $Fd[i]->carbs "
<<"fat %4.2f $Fd[i]->fat chol $Fd[i]->chol "
<<"prot %4.2f $Fd[i]->prot satfat $Fd[i]->satfat $('POFF_')\n"
/}

           found = 1;
           //break;
        
      }

  }

//    if (qual2_mat) {
//          break;
//    }

   

   if (qual1_mat && qual2_mat && qual3_mat ) {
          found = 3;
//<<"all three quals found -- so break!!\n"
        break;
    }
    if (score > 0) {
         if (score > Bestpick[pk][0]) {
           Bestpick[pk][0] = score;
	   Bestpick[pk][1] = i;
	   pk++;
	 }
	 if (pk >= 5) {
             pk = 0;
         }
    }

   if (score > best_score) {
          best_score = score;
	  best_i = i;
   }

  }

   if (looked == 3) {
  // <<"Looked $looked -  break\n"
         break;
    } 

   looked++;

   do_first_word = 0

   if (qual1_mat && qual2_mat ) {
         found = 2;
    }

   if (qual1_mat && qual2_mat && qual3_mat ) {
          found = 3;
//<<"all three quals found -- so break!!\n"
        break;
    }

/{
// flip food & qual1
  if (looked > 2) {
    qualt= the_food;
    the_food = qual1;
    qual1 = qualt;
<<"$the_food flip Qualifiers %V <$qual1>  <$qual2> \n"
}
/}


 }
//=================================================


   if (main_food_fit >= 0) {
   
   //  found = 1;
          <<"$('PGREEN_') "
      Fd[best_i]->print()
      <<"$('POFF_') "
<<"FOOD found %V $found  $best_score $best_i  $qual1_fit @qual2_fit\n"
      Wfi = best_i;

    bp = msortCol(Bestpick,0)
    Bestpick = bp;
<<"$Bestpick\n"
    for (i =0; i < 5; i++) {
        if (Bestpick[i][0] > 1) {
	    <<"$Bestpick[i][0] $Bestpick[i][1] " 
	    Fd[Bestpick[i][1]]->print();
        }
    }


}

      return best_score;
}

////////////////////////////////////////////////

proc listFoods(n)
{
    for (i = 0 ; i < n ; i++) {
           Fd[i]->print()
    }
}
//=================================
//<<"Done inc checkFood\n"