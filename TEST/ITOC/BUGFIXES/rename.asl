///
///
///


//   na=argc()
//<<"%V $na\n"

 // for (i=1; i < argc(); i++) <<"git mv $_argv[i] $(scat(\"bf\",scut(_argv[i],6))) \n"     


   for (i=1 ;i < argc() ; i++) {
     nm = _argv[i]
     tail = scut(nm,7)
     num = scut(tail,-4)
     newnm = scat("bugfix",num,".asl")
     //<<"$nm $tail  $num   $newnm\n"

     <<"git mv $nm $newnm \n"
     !!"git mv $nm $newnm "
     
     //<<"git mv $_argv[i] $(scat(\"bf\",scut(_argv[i],6))) \n"     

   }



/*
   for (i=1 ;i < argc() ; i++) {
    nm = _argv[i]
  // tail = scut(nm,2)
  //   rnm =  scat("bugfix",scut(nm,2))
  //   <<" $nm $_argv[i] \n"
   <<"git mv $nm $(scat(\"bugfix\",scut(nm,2))) \n"
  // <<"git mv $nm $(scat(\"bugfix\",scut($_argv[i],2))) \n"
   }


*/