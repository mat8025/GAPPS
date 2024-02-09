//%*********************************************** 
//*  @script testd.asl 
//* 
//*  @comment check our tests chkN,chkS, chkT ...
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Tue Apr 30 07:59:18 2019 
//*  @cdate Tue Apr 30 07:59:18 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%





  chkIn()

  a= 2 +2;

  chkN (a,4);

  chkN(a,3)

  x = 2.0
  y = 3.0;


   chkN(x,2.0)

   chkN(y,2.1)

   pc =chkStage(" pass 2 fail 2")

   pc.pinfo();
   
   chkReset()
   chkN(pc[0],50.0)
   chkT(1)



  chkOut ()
