///
///
///

//#define DBPR <<
#define DBPR ~!

#define TDBP <<
#define ASK ans=iread();

setdebug(1,"~pline")

//<<"#                          Fat  Carbohydrate Protein  Cholesterol  Weight Saturated_Fat Calories \n"
//<<"#                          (Grams) (Grams) (Grams) (Milligrams)    (Grams)  (Grams)     (cals) \n"
//<<"#  computed from food_log.dat  and food_table.dat   via getfpc.asl \n"


//  food class
DBPR" making food class\n"

class Food {

 public:
    svar descr;
    svar unit ; //could be 1/2
    svar amt ;
    svar ans ;

 // per unit

    float wt     // grams
    float satfat
    int fat    
    int carbs
    float prot
    int chol   // mgrams
    int cals


  CMF setval(fdsc,rs)
    {

      if (slen(rs) < 40) {
      // <<"$fdsc \n"
       //<<"$rs \n"
        <<"description too short $rs \n"
         exit();
      }


         nsa=sscan(rs,'%s %s %d %d %d %f %d %f %f',&amt,&unit,&fat,&cals,&carbs,&prot,&chol,&wt,&satfat)

 // <<"$nsa %V$descr $unit $amt $fat %4.2f $prot %d$cals $carbs $wt\n"

        if (nsa <= 0) {
      <<"ERROR $fdsc \n"
      <<"$rs \n"
        stop!

        }

         //nsa =sscan(rs,'%s %s %d %d %d %d %d %f %f',unit,amt,fat,cals,carbs,prot,chol,wt,satfat)
//DBPR"%V$nsa \n"

         descr = fdsc;
	 

//      <<"$descr $unit $amt $fat $cals $carbs $wt\n"

      return nsa;
    }
///////////////////////////

  CMF check (edsc, fw)
    {
    
     /// find desc anywhere with table desc?
     /// want word initial search so white-space then word " PEAR" searches for pear won't get spear
     /// like to use regex

     fd_len = slen(edsc)

     ok = 0

     descr_w = split(descr)

//TDBP"$descr_w[0]  $edsc \n"


     rind = sstr(descr_w[0],edsc, 1)



 if (rind != -1) {
 ok =1;
TDBP">>> $descr $descr_w[0] $edsc $rind fw $fw \n"
ASK
  if (ans @="q")
     exit()
}

     
     if (fw != 1) {

       if (rind != 0) {

        needle = "$edsc"

        rind = sstr(descr, needle, 1)

DBPR<<"$descr $needle $rind\n"

       }

    }

     if (rind != -1) {
        if (scmp(descr_w[0],edsc,0,0)) {
 <<" perfect!\n"
<<">>> $descr $descr_w[0] $edsc $rind $fw \n"
           ok = 2 // perfect fit
        }
        else 
         ok =1
     }

      yn = ok

      return (ok)
    }
///////////////////////

  CMF checkQualifier (edsc)
    {
     // find qualifier edesc anywhere with table desc?
     // want word initial search so white-space then word " PEAR" searches for pear won't get spear


     fd_len = slen(edsc)

     ok = 0

     descr_w = split(descr)

  <<" Qualifier  ? $descr_w[1]  $edsc \n"


     rind = sstr(descr_w[1],edsc, 1)

//<<">>> $descr $descr_w[0] $edsc $rind  \n"



       if (rind != 0) {

        needle = "$edsc"

        rind = sstr(descr, needle, 1)

//<<"$descr $needle $rind\n"

       }



     if (rind != -1) {
        if (scmp(descr_w[1],edsc,0,0)) {
// <<" Qualifier perfect!\n"
<<">>> $descr $descr_w[1] $edsc $rind $fw \n"
           ok = 2 // perfect fit
        }
        else 
         ok =1
     }

    yn = ok



    if (ok >= 1) {
//<<" $edsc is within  $descr ?? $ok $rind\n"
    }

      return (ok)
    }


///////////////



  CMF query()
    {
     ans ="$descr[0] $amt[0] $unit[0] %V$cals $carbs $fat ${chol} mg %4.1f $prot $satfat $wt"
     return ans
    }
//////////////////

  CMF print()
    {
     <<"$descr[0] $amt[0] $unit[0] %V$cals $carbs $fat $chol(mg) %4.1f$prot $satfat  $wt  \n"
    }
////////////////

  CMF getdescr()
    {
      return descr
    }
/////////////////
  CMF getans()
    {
      return ans
    }
////////////////
  CMF getamt()
    {
     //<<" getting  amt $amt\n"
      return amt
    }
///////////////
  CMF getunit()
    {
     //<<" getting  unit $unit\n"
      return unit
    }
//////////////////
  CMF getcarbs()
    {
DBPR" getting carbs $carbs\n"
      return carbs
    }
///////////////////////
  CMF getcals()
    {
      return cals
    }
////////////////////
  CMF getprot()
    {
      return prot
    }
////////////////////
  CMF getfat()
    {
      return fat
    }
//////////////////
  CMF getsatfat()
    {
      return satfat
    }
////////////////

}




int txtwo = 0

the_carbs = 0
the_cals = 0
the_prot = 0
the_fat = 0
the_satfat = 0.0

query_res = ""
the_descr = ""

proc checkFood()
{

str the_amt;
str the_unit;

int nfd = 0;

<<" looking for $f_amt $f_unit of $myfood \n"

the_unit = "1";

//the_carbs = 0
//the_cals = 0
//the_prot = 0
//the_fat = 0
//the_satfat = 0.0
// split myfood into words via commas (so WS can be part of search string - no commas in database string!) 
// check for presence of each word (partial word is ok) but all of search string has to be present
// any order of search strings is ok
// lets check for commas - use that to split
// else use WS to split


   food_d = split(myfood,',')


//<<"%V$food_d \n"

nfd = Caz(food_d)

//<<"$nfd : $food_d[0] \n"

 food_d[0] = ssub(food_d[0],"y","",-1)

ynqual = 0

do_first_word = 1

looked_twice =0

  while (1) {

     the_unit = "oz"
     the_amt = "1"


    for (i = 0 ; i < jf ; i++) {



      ynfood = Fd[i]->check(food_d[0], do_first_word)

// got to check other qualifiers


      if (ynfood) {

  <<"$i  $food_d[0]\n"
       ASK
        ynqual = 1

        Fd[i]->print()

         if (nfd > 1) {

         qual = food_d[1]

         <<"$nfd now  checking qualifier $qual\n"

          ynqual = Fd[i]->checkQualifier(qual)

          if (ynqual) {
                   if (nfd > 2) {
                   qual = food_d[2]
                   <<"$nfd now  checking qualifier $food_d[2] $qual\n";
                   ynqual = Fd[i]->check(qual,0)
                   }
                 if (ynqual) {  
               //  <<"Qualifier FOUND $food_d[0] $food_d[1] $food_d[2]\n";
                Fd[i]->print()
                 }
          }
          else {
<<"$qual not in \n"
          }


         }


//<<"%V$the_unit \n"       

        if (ynqual) {

        the_amt = Fd[i]->getamt()
        the_amt = Fd[i]->amt

<<"$i setting the_amt to $the_amt \n"

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

        if (sstr(the_amt,f_amt,1) != -1) {
           amt_fit = 1
        }

        if (f_amt @= "*") {
           amt_fit = 0
        }

        if (sstr(the_unit,f_unit,1) != -1) {
           unit_fit = 1
        }

        if (f_unit @= "*") {
           unit_fit = 0
        }

        if (amt_fit && unit_fit) {

<<"AMT  and UNIT FITS \n"
<<"%V$the_amt $f_amt \n"

//         Fd[i]->print()
           wans = Fd[i]->query()
           //<<"$wans \n"

<<"$myfood $the_unit $the_amt carbs  $Fd[i]->carbs  cals $Fd[i]->cals  fat $Fd[i]->fat chol $Fd[i]->chol %4.1f prot $Fd[i]->prot satfat $Fd[i]->satfat\n"

//         break

        }
      }
     }
   }

    if (ynqual) {

//          break
 
   }

    if (looked_twice) {
         break
    } 

   looked_twice =1
   do_first_word = 0
 }

}


proc listFoods(n)
{

    for (i = 0 ; i < n ; i++) {
           Fd[i]->print()
    }
}


//////////////////////////////////////////////////////////////////////////

ftfile = "food_tableV2.dat" 

//ftfile = "food_table_test.dat" 

A=  ofr(ftfile)

if (A == -1) {

<<" can't open food table $ftfile \n"
exit()

}

  S=readfile(A)


  nlines = Caz(S)

<<"%v$nlines\n"

 Nfoods  = nlines + 10

 Food Afd

<<" one food is good!\n"
<<" now for $Nfoods foods\n"

 int n_f = 950
 Food Fd[n_f]

 str fline

 jf = 0
f_unit = "*"
f_amt = "1"


///////////////////////////////////////  PARSE FOOD TABLE //////////////////////////////

 k = 0

 jf = 0
 int err = 0;

 while (1) {

   fline = S[k]

   if (fline @="") {
        break
   }

   k++

   if (!scmp(fline,"#",1)) {


// split line into first 30 chars and rest

//<<"[${k}] $nlines %V$fline \n"

    fd = sele(fline,0,30)

// <<"%V$fd \n"

//<<"trying sele \n"

    rs = sele(fline,31)

//<<"%V$jf $rs \n"

//<<"trying setval \n"

     err= Fd[jf]->setval(fd,rs)

//<<"ret setval $err\n"
//<<"trying print \n"

//   Fd[jf]->print()

    jf++


//<<"$k $jf <${fd}> $unit $amt $fat $cals $carbs $wt\n"
//i_read()

   if (err <= 0) { 
       break
   }

   }


  if (k >= (nlines-1))
     break;
 }



//<<" we have $jf foods \n"
   //listFoods(jf)
//////////////////////////////////////////////////////



  myfood = "strawberr,raw"
  f_unit = "*"
  f_amt = "1"

  wans = Fd[0]->query()


//////////////////////////  PARSE THE COMMAND LINE //////////////////////////////
 do_loop = 0 // default - single shot query via CL args

 na = argc()

 wa = _clarg[1]

 if (! (wa @= "")) {
  myfood = wa
//<<" looking for $myfood \n"
 }

 if (na > 1) {
  f_unit = _clarg[2]
 }

 if (na > 2) {
  f_amt = _clarg[3]
 }


 if (na > 3) {
  val = _clarg[4]
  if (val @= "loop") {
     do_loop = 1
  }
}
 






 checkFood()



//<<" FOUND ?\n"






/////////////////////////////// GUI /////////////////////////////////




do_loop = 0



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




Graphic = CheckGwm()
if (Graphic) {
  include "gui_query.asl"
}

exit();

/// TBD ///
/{/*

 make food table CSV 
 items parsed as float

 script to add food






/}*/