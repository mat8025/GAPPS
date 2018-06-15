///
//////////////////////////////////////
<<"including checkFood\n"

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
int found = 0;
the_amt = 1.0;
str the_unit
svar food_d;
int nfd = 0;

<<" $_proc looking for %6.2$f_amt $f_unit of $myfood \n"

  the_unit = "1";

  food_d = split(myfood,',')

//<<"%V <$food_d> $(typeof(myfood))\n"

  fsz = Caz(food_d)

  //<<"%V$fsz\n"

  nfd = fsz;

// <<"$nfd : $food_d \n"

 //food_d[0] = ssub(food_d[0],"y","",-1)

 ynqual = 0

 do_first_word = 0

 qual1 = eatWhiteEnds(food_d[1])
 qual2 = eatWhiteEnds(food_d[2])
 q1len = slen(qual1);
 q2len = slen(qual2);

 //<<"Qualifiers %V <$qual1> $q1len <$qual2> $q2len\n"

looked_twice =0

  while (1) {

     the_unit = "oz"
     the_amt = 1;
     qual1_mat = 0;    
     qual2_mat = 0;    

    for (i = 0 ; i < Nfoods ; i++) {

//<<"$i $food_d[0]\n"

      ynfood = Fd[i]->checkPrimary(food_d[0], do_first_word)

// got to check other qualifiers


     if (ynfood) {

//<<" FOUND the food ! $food_d[0] %V$nfd\n" 

        ynqual = 1;

     //   Fd[i]->print()

         if (nfd > 1) {

         // qual = food_d[1]

        //<<"$nfd now  checking qualifier1 $qual1\n"

           //Fd[i]->print();


           ynqual = Fd[i]->checkQualifier(qual1);

//           <<"Match %V$ynqual \n";

             if (ynqual) {
//<<" $ynqual Qualifier1 FOUND $food_d[0] $food_d[1] $food_d[2]\n";
		 // Fd[i]->print()
                  qual1_mat = 1;    
                  //ans= i_read(" found_it")
             }


//<<"%V$nfd $(typeof(nfd))\n"
            if ((nfd > 2) && (q2len > 0)) {

                  //<<"now  checking qualifier2 $qual2\n";
         
                  ynqual = Fd[i]->checkQualifier(qual2);

                 if (ynqual) {
//<<"Qualifier2 FOUND $food_d[0] $food_d[1] $food_d[2]\n";
                  //<<"\nFound the food item !!\n"
                  //Fd[i]->print()
                  qual2_mat = 1;
                  //ans= i_read(" found_it") 
                }
		
             }
         }


//<<"%V$the_unit \n"       

        if (qual1_mat) {

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

<<"%V%4.2f$the_amt $f_amt \n"

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
       <<"AMT and UNIT FITS \n"
//<<"%V$the_amt $f_amt \n"
        }
	
//         Fd[i]->print()
           Wans = Fd[i]->query(f_amt);
	   Wfi = i;
           <<"$(PRED) $Wans $(POFF)\n"

/{
<<"$(PRED) $myfood \n $Fd[i]->descr %4.2f $the_amt "
<<"$the_unit %4.2f cals $Fd[i]->cals carbs  $Fd[i]->carbs "
<<"fat %4.2f $Fd[i]->fat chol $Fd[i]->chol "
<<"prot %4.2f $Fd[i]->prot satfat $Fd[i]->satfat $(POFF)\n"
/}

           found = 1;
           break;
        
      }
     }

    if (qual1_mat) {
         // break
    }
   }

   if (looked_twice) {
         break;
    } 

   looked_twice =1
   do_first_word = 0

    if (qual1_mat) {
          break;
    }
 }
// <<"%V$found\n"
       return found;
}
////////////////////////////////////////////////

proc listFoods(n)
{
    for (i = 0 ; i < n ; i++) {
           Fd[i]->print()
    }
}
//=================================
<<"Done inc checkFood\n"