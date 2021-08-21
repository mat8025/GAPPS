//%*********************************************** 
//*  @script procstrarg.asl 
//* 
//*  @comment test vector ops 
//*  @release CARBON 
//*  @vers 1.1 H Hydrogen                                                  
//*  @date Wed Apr  3 22:25:24 2019 
//*  @cdate Wed Apr  3 22:25:24 2019 
//*  @author Mark Terry 
//*  @Copyright  RootMeanSquare  2010,2019 --> 
//* 
//***********************************************%


                                                                        
<|Use_=
Demo  of proc str arg
///////////////////////
|>


#include "debug.asl"


if (_dblevel >0) {
   debugON()
      <<"$Use_\n"   
}


chkIn(_dblevel)


void docc (str a2)
{

  do_carts (a2)

}
//=====================


void do_carts (str aprog)
{
  str wprg = aprog;
//!!"pwd"

 aprog->pinfo()
 wprg->pinfo()
<<"run cart vers  $aprog \n"
<<"run cart vers  $wprg \n"
 if (wprg @= "") {
     chkT(0)
 }
  if (aprog @= "") {
     chkT(0)
 }
  if (wprg @= aprog) {
     chkT(1)
 }


}
//===============================

chkT(1)


docc("heythere")

str a1 = "bother"

do_carts(a1)

do_carts("charger")

docc(a1)





chkOut()