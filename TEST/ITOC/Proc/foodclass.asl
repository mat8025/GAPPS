///
///  our food class
/// 

<<"include class food\n"

class Food {

 public:
    svar descr;
    svar unit ; 
    svar ans ;
    svar descr_w;

// per unit

    float amt ;  //could be 1/2
    float wt;     // grams
    float satfat;
    float fat;    
    float carbs;
    float prot;
    float chol;   // mgrams
    float cals;
    int ok;

    float mcals;
    float mcarbs;    


///////////////////////////////
  CMF setval(svar fdw)
    {
    int nsa = 1;

<<"%V$fdw  $fdw[0]\n"
more bad xxx
       int kw = 0;
       descr = fdw[kw++];
       amt = atof(fdw[kw++]);
       unit = fdw[kw++];
       cals = atof(fdw[kw++]);
       carbs = atof(fdw[kw++]);       
       fat = atof(fdw[kw++]);
       prot = atof(fdw[kw++]);
       chol = atoi(fdw[kw++]);
       satfat = atof(fdw[kw++]);       
       wt = atof(fdw[kw++]);

<<"FC: $descr $unit $amt $fat $cals $carbs $wt\n";

      return nsa;
    }
///////////////////////////

  CMF checkPrimary (edsc, fw)
    {
     // find desc anywhere with table desc?
     // want word initial search so white-space then word " PEAR"
     // searches for pear won't get spear
     // like to use regex
//<<"$_proc \n"
//
     ok = 0;
     
     fd_len = slen(edsc)

     descr_w = split(descr)

DBPR"$descr_w[0]  $edsc \n"

      rind = sstr(descr_w[0],edsc, 1)

DBPR">>> $descr $descr_w[0] $edsc $rind $fw \n"

     if (fw != 1) {

       if (rind >= 0) {
        needle = eatWhiteEnds("$edsc")
        rind = sstr(descr, needle, 1)
//<<"$descr $needle $rind\n"
//DBPR"$descr $needle $rind\n"

       }
    }

     if (rind != -1) {
//<<" reloaded ?\n"     

        if (scmp(descr_w[0],edsc,0,0)) {
//<<"first word  perfect!\n"
///<<">>> $descr $descr_w[0] $edsc $rind $fw \n"

//<<">>> $descr $descr_w[0] $edsc $rind $fw \n"
        ok = 3;
        }
	else if (scmp(descr_w[0],edsc,(slen(descr_w[0])-1),0)) {

        ok = 2; // perfect fit
//<<" checking for plural ending Yes! $edsc $descr_w[0] $(slen(edsc)) \n"
        }
        else {
         ok =1;
       }
     }

    yn = ok;

    if (ok >= 1) {
    // <<"is $edsc within  $descr ?? $ok $rind\n"
     //iread("within?")
    }
    
//<<" $edsc within  $descr ?? $ok $rind\n"
    return (ok)

   }
///////////////////////

  CMF checkQualifier (edsc)
    {
     // find qualifier edesc anywhere with table desc?
     // want word initial search so white-space then word
     // " PEAR" searches for pear won't get spear

<<"$_proc CQ <$edsc>   <$descr>\n"

     fd_len = slen(edsc);

     ok = 0;

//<<"%V$descr \n"
//<<" [0]  $descr_w[0] [1] $descr_w[1] [2] $descr_w[2] is $edsc there?\n"


     descr_w = split(descr);
     //descr_w = descr->Split();

<<" [0]  $descr_w[0] [1] $descr_w[1] [2] $descr_w[2] is $edsc there?\n"

//ans=iread("qualifier test:")

     if (!(edsc @= "")) {

     f_qual = descr_w[1];
     s_qual = descr_w[2];
     
//<<"%V$f_qual $s_qual\n"

     rind1 = sstr(f_qual,edsc, 1) ; // test

//<<"%V$f_qual $edsc $rind1\n"

    // if (rind1 != -1) {
     if (rind1 >= 0) {
//<<" first Qualifier? $f_qual $descrs_w[1]  $edsc $rind1\n"
    <<"first Qualifier? found $f_qual $descr_w[1]  $edsc $rind1\n"
    //ans=iread("fqual found")
     ok = 1;
    }

     rind2 = sstr(s_qual,edsc, 1)

//<<"%V$s_qual $edsc $rind2\n"

    if (rind2 != -1) {
//<<" second Qualifier? $s_qual $descr_w[2]  $edsc $rind2 \n"
<<"second qualifier found $s_qual $edsc $rind2\n";
//ans=iread("squal found");
     ok = 1;
    }

//<<">>> $descr $descr_w[0] $edsc $rind  \n"
       rind = -1;
       
       if ((rind1 != -1) || (rind2 != -1)) {

//<<"%V$rind1 $rind2\n"
//<<"%V$descr\n"
//<<"%V$descr_w\n"
//<<" [0] $descr_w[0] [1] $descr_w[1] [2] $descr_w[2] $edsc \n"

        needle =  eatWhiteEnds("$edsc");

//<<"%V$descr\n"

        haystack = descr;

//<<"%V$haystack  $(typeof(haystack))  $needle\n"
//iread()
// ns = supper(needle);

// <<"%V$ns $(typeof(ns)) \n";
// rind = sstr( haystack, slower(needle), 1);
// <<"%V$descr  $haystack $needle $rind\n"

// rind = sstr( haystack, supper(needle), 1);
// <<"%V$descr  $haystack $needle $rind\n"
//iread()

 rind = sstr( haystack, needle, 1);	

//<<"%V$descr  $haystack $needle $rind\n"

    //ans = iread();
    //if (ans @= "quit"){
    //   exit();
   //}
        if (rind != -1) {
          ok = 1;
         }
	 
       }


    if (rind != -1) {
        if (scmp(descr_w[1],edsc,0,0)) {
<<">>> qualifier perfect fit $descr $descr_w[1] $edsc $rind $fw \n"
           ok = 2; // perfect fitappl
        }
        else 
         ok =1;
     }

    yn = ok;

//<<"%V$ok\n"
    if (ok >= 1) {
   <<" <| $edsc |> is within  $descr ?? $ok $rind\n"
    }
    
      return ok;
    }
 }
///////////////

  CMF query(float mf)
    {
    <<"$mf $(typeof(mf))\n"
    if (mf == 1.0) {
 ans ="$descr[0], %3.2f$amt, $unit[0], $cals, $carbs, $fat, $prot, $chol,  $satfat, $wt"
    }
    else {
    mcals = cals *mf;
    mcarbs = carbs *mf;
    
ans ="$descr[0], %3.2f$(amt*mf), $unit[0], $mcals,  $mcarbs,  $(fat*mf),  $(prot*mf),  $(chol*mf),  $(satfat*mf), $(wt*mf)"

    }
    return ans;
    }
//////////////////

  CMF print()
    {
    // <<" $descr[0] $amt $unit[0] %V$cals $carbs $fat $chol(mg) %4.1f$prot $satfat  $wt  \n"
     <<" $descr[0] %2.1f$amt %s$unit[0] %d $cals $carbs $fat $chol mg  %4.1f $prot $satfat  $wt  \n"
    }
////////////////
  CMF printFound()
    {
<<" '\033[1;31m'  $descr[0] $amt $unit[0] %V$cals $carbs $fat $chol(mg) %4.1f$prot $satfat  $wt '\033[0m' \n"
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

  CMF Food()
  {
     ok = 0;
     carbs = 0;
  }
}

//<<"Include class Food!\n"