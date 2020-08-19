//%*********************************************** 
//*  @script pan-loop-test.asl 
//* 
//*  @comment test pan assign store  
//*  @release CARBON 
//*  @vers 1.2 He Helium                                                   
//*  @date Sat May  4 13:50:53 2019 
//*  @cdate Sat May  4 13:50:53 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%
///
///
///


///   pan += +  xic ?
//include "debug"
//debugON()

  chkIn(_dblevel)

proc Foo()
{

  for (i= 0; i < 3 ; i++) {

    pend = pend + Step;

<<"$i $pend \n"

  }


  for (i= 0; i < 3 ; i++) {

    pend +=  Step;

<<"$i $pend \n"

  }


}

proc goo()
{

 pan loc_pend =0;
<<"%V $pend  $loc_pend\n"
  loc_pend = pend;

  loc_pend->info(1)

<<"%V $pend  $loc_pend\n"

 pend->info(1)
 
  for (i= 0; i < 3 ; i++) {

    loc_pend = loc_pend + Step;

<<"$i $loc_pend \n"

  }


  for (i= 0; i < 3 ; i++) {

    loc_pend +=  Step;

<<"$i $loc_pend \n"

  }


}



pan Start = 100;
pan Step = 10;

  chkR(Step,10.0);


pan pend;


  pend = Start + Step;


<<"%V $Start $Step $pend \n"



 pan pendB =0;
<<"%V $pend  $pendB\n"
  pendB = pend;

  pend->info(1)
  pendB->info(1)

<<"%V $pend  $pendB\n"

  chkR(pend,pendB)

  for (i= 0; i < 3 ; i++) {

    pend = pend + Step;

<<"$i $pend \n"

  }

  chkR(pend,140.0)

  for (i= 0; i < 3 ; i++) {

    pend +=  Step;

<<"$i $pend \n"

  }

  chkR(pend,170.0)

  Foo()

  goo()


  chkOut()
