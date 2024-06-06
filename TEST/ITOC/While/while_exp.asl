///
///
///

//   TBF  09/08/23 this idiom     
//   while ((stem = clarg()) != "")
//   exp (a=1) == (exp)   :: needs to work

  i = 1
    
   while ((stem = clarg()) != "") {

    orig = stem
    stem.scut(-4) ;     stem.splice("spe_",0) ;     stem.cat(".h") ;
<<"$i $orig $stem \n"
!!"ls -l $orig"
!a
  i++
  } 

