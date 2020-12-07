///
///  filter pick a column
///
wf=getArgI();
//<<"$wf\n"
  while (1) {

  L=split(readline(0))
   if (!(L[wf] @="")) {
    <<"\t$L[wf]\n"
   }
   
   if (feof(0) )   break;
  }


/////