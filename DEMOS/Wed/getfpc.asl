// headers to fpc log
do_loop = 1


//include "wed_query"


//<<"#                          Fat  Carbohydrate Protein  Cholesterol  Weight Saturated_Fat Calories \n"
//<<"#                          (Grams) (Grams) (Grams) (Milligrams)    (Grams)  (Grams)     (cals) \n"
//<<"#  computed from food_log.dat  and food_table.dat   via getfpc.asl \n"


//  food class

class Food {

 public:

    str descr;
    str amt ;
    str unit ; //could be 1/2


 // per unit

    float wt     // grams
    float satfat
    int fat    
    int carbs
    int prot
    int chol   // mgrams
    int cals


  CMF setval(fdsc,rs)
    {
     // <<"$fdsc \n"
     // <<"$rs \n"

   nsa=sscan(rs,'%s %s %d %d %d %d %d %f %f',&amt,&unit,&fat,&cals,&carbs,&prot,&chol,&wt,&satfat)

         //nsa =sscan(rs,'%s %s %d %d %d %d %d %f %f',unit,amt,fat,cals,carbs,prot,chol,wt,satfat)
//      <<"%V$nsa \n"
         descr = fdsc
//      <<"$descr $unit $amt $fat $cals $carbs $wt\n"
      return nsa
    }

  CMF check (edsc, fw)
    {

     // find desc anywhere with table desc?

     fd_len = slen(edsc)

     ok = 0

//  <<"$descr  $edsc \n"


     descr_w = split(descr)

 //<<"$descr_w[0]  $edsc \n"

     rind = sstr(descr_w[0],edsc, 1)

//<<"FW $fw $descr_w[0]  $edsc $rind\n"

     if (fw != 1) {

      if (rind != 0) {

     needle = " $edsc"

     rind = sstr(descr,needle, 1)

<<"SW $descr  $needle $rind\n"
      }
     }

     if (rind != -1) {
        ok =1
     }

    yn = ok


    if (ok == 1) {
<<"is $edsc within $descr ?? $ok\n"
//iread()
    }

      return (ok)
    }



  CMF print()
    {

     <<"%V$descr $amt $unit $fat $prot $cals $carbs $wt\n"

    }

  CMF getamt()
    {
//<<" getting  amt $amt\n"

      return amt

    }

  CMF getunit()
    {
      return unit
    }

  CMF getcarbs()
    {
//<<" getting carbs $carbs\n"
      return carbs
    }

  CMF getcals()
    {
      return cals
    }

  CMF getprot()
    {
      return prot
    }


}




proc checkFood()
{

<<" looking for $f_unit of $myfood \n"

int nfd
the_amt = "1";
the_unit = "oz";
the_carbs = 0
the_cals = 0
the_prot = 0
// split myfood into words via commas (so WS can be part of search string - no commas in database string!) 
// check for presence of each word (partial word is ok) but all of search string has to be present
// any order of search strings is ok
// lets check for commas - use that to split
// else use WS to split


   food_d = split(myfood,',')

<<"%V$food_d \n"
nfd = Caz(food_d)

<<"$nfd : $food_d[0] \n"

ynqual = 0



    for (i = 0 ; i < jf ; i++) {


      ynfood = Fd[i]->check(food_d[0],1)

// got to check other qualifiers

      if (ynfood) {

        ynqual = 1

        Fd[i]->print()

         if (nfd > 1) {
         qual = food_d[1]
         <<"$nfd now  checking qualifier $food_d[1] $qual\n"
          ynqual = Fd[i]->check(qual)
         if (ynqual) {
           <<"Qualifier FOUND $food_d[0] $food_d[1] \n"
         }
         else {
             <<"Qualifier NOT found $food_d[0] $food_d[1] \n"
         }
         }


//<<"%V$the_unit \n"       
        if (ynqual) {

        the_amt = Fd[i]->getamt()

        //the_unit = Fd[i]->getunit()

        the_unit = Fd[i]->unit

        the_carbs = Fd[i]->getcarbs()

        the_cals = Fd[i]->getcals()

        the_prot = Fd[i]->getprot()

 //<<"%V$myfood $the_unit $Fd[i]->unit $the_amt $the_carbs $the_cals\n"
 <<"%V$myfood $the_unit $the_amt $the_carbs $the_cals $the_prot\n"



        fit = 0
        amt_fit = 0
        unit_fit = 0

<<"$the_amt $f_amt \n"
//i_read()



        if (sstr(the_amt,f_amt,1) != -1) {
           amt_fit = 1
        }

        if (f_amt @= "*") {
           amt_fit = 1
        }

        if (sstr(the_unit,f_unit,1) != -1) {
           unit_fit = 1
        }

        if (f_unit @= "*") {
           unit_fit = 1
        }



        if (amt_fit && unit_fit) {
         Fd[i]->print()

   <<" $myfood $the_amt $the_unit carbs  $Fd[i]->carbs  cals $Fd[i]->cals  fat $Fd[i]->fat prot $Fd[i]->prot chol $Fd[i]->chol satfat $Fd[i]->satfat\n"

         break
        }
      }
     }
 }

}


proc listFoods(n)
{

    for (i = 0 ; i < n ; i++) {
           Fd[i]->print()
    }
}


//////////////////////////////////////////////////////////////////////
// read in food_table

myfood ="POTATO"
f_unit = "*"
f_amt = "*"

 na = argc()

wa = _clarg[1]

 if (! (wa @= "")) {

  myfood = wa
<<" looking for $myfood \n"
 }

 if (na > 1) {
  f_unit = _clarg[2]
 }

 if (na > 2) {
  f_amt = _clarg[3]
 }

str fd

// BUG -- FIX
//float unit
//str amt

float fat

//float cals
//float carbs
//float prot
//float chol
//float wt
//float satfat

ftfile = "food_table.dat" 

A=  ofr(ftfile)





  S=readfile(A)

  nlines = Caz(S)

//<<" read ok %V$nlines!\n"


#{
<<" \n \n \n"

 for (i = 0; i < 10 ; i++) {
   <<"$i $S[i] "
 }
#}




  if (nlines < 3) {
    exit(" not enuf foods! -- file $ftfile \n")
  } 
     

 Nfoods  = nlines + 10

 Food Afd

//<<" one food is good!\n"
//<<" now for $Nfoods foods\n"
 int n_f = 950
 Food Fd[n_f]

//<<" done food object array size $n_f !\n"

// Food Fd[Nfoods]



 k = 0

 str fline

 jf = 0
 int err = 0

 while (1) {

   fline = S[k]

   k++

   if (!scmp(fline,"#",1)) {


// split line into first 30 chars and rest

//<<"%V$fline \n"

    fd = sele(fline,0,30)

//<<"%V$fd \n"

//<<"trying sele \n"

    rs = sele(fline,31,-1)

//<<"%V$jf $rs \n"

//<<"trying setval \n"

     err= Fd[jf]->setval(fd,rs)

//<<"ret setval $err\n"
//<<"trying print \n"

//    Fd[jf]->print()

    jf++

//<<"$k $jf <${fd}> $unit $amt $fat $cals $carbs $wt\n"
//i_read()

   if (err <= 0) { 
       break
   }

   }


  if (k >= (nlines-1))
     break

 }



//<<" we have $jf foods \n"


//  listFoods(2)  
//  Fd[3:7]->print()


  checkFood()




<<"///////////////////\n"


// entering query loop !

if (do_loop ) {

while (1) {

<<" New Query\n"

//  ok=reload_src(1)
// <<"reload_src ? $ok \n"

 //  foo()
//<<" doing foo \n"
  ans=i_read("food $myfood ? : ")

  if (! (ans @="") ) {
    myfood = ans
<<"new food is $myfood\n"
  }

  if (myfood @= "quit") {
    break;
  }

  uans = i_read("unit $f_unit ?: ")

  if (! (uans @="")) {
    f_unit = uans
  }

  aans = i_read("amt $f_amt ?: ")

  if (! (aans @="")) {
    f_amt = aans
  }

  checkFood()

 }

}
;


stop!
;



////////////////////////////  TBD /////////////////////////////////
// fix str amt -- not returned svar amt is
//