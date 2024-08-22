/* 
 *  @script iproc.asl                                                   
 * 
 *  @comment test indirect call pr proc ()                              
 *  @release Boron                                                      
 *  @vers 1.5 B Boron [asl 5.87 : B Fr]                                 
 *  @date 03/14/2024 07:31:49                                           
 *  @cdate 1/1/2011                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


//----------------<v_&_v>-------------------------//;                  

#include "debug"

  if (_dblevel >0) {

  debugON();

  }

  chkIn (_dblevel);
  db_allow  =1;
  chkT(1)

//wdb=DBaction((DBSTEP_|DBSTRACE_),ON_)

//wdb=DBaction((DBSTEP_),ON_)


//  Svar animals = split("Owl,Wolf,Bear,Fox,Crow,RedHawk,Magpie",44)

 Svar animals = { "Owl","Wolf","Bear","Fox","Crow","RedHawk","Magpie" }
 //animals.pinfo()

<<" $animals \n"

 <<" $animals[3] \n"





 chkStr(animals[6],"Magpie")
 chkStr(animals[0],"Owl")
  chkStr(animals[1],"Wolf")

 bird = animals[4]

<<"%V $bird \n"

   chkStr(bird,"Crow")

//wdb=DBaction((DBSTEP_|DBSTRACE_),ON_)
  Svar birds = splitViaDel("Owl,Crow,RedHawk,Magpie,Nightingale",44)

  birds.pinfo()
  ans=ask("OK",1)
  
 chkStr(birds[0],"Owl")

 chkStr(birds[2],"RedHawk")

 bird = birds[3]

<<"%V $bird \n"

  chkStr(bird,"Magpie")



  just_once = 0;

  LD_libs = 0;
//=======================//

  int Wolf (int k)
  {
    w= k * 7;

    return w;
   }

  //EP=====================//

 int Bear (int k)
  {
    w= k * 9;

    return w;
   }

  //EP=====================//

 int Owl (int k)
  {
    w= k * 22;

    return w;
   }



 int Crow (int k)
  {
    w= k * 91;

    return w;
   }


 int Magpie (int k)
  {
    int  w= k * 57

    return w;
   }

  //EP=====================//

 int Nightingale (int k)
  {
    int  w= k * 83

    return w;
   }

  //EP=====================//


 int Fox (int k)
  {
    w= k * 28;

    return w;
   }

 int RedHawk (int k)
  {
    w= k * 80;

    return w;
   }
//===============================
 makeproctable ("Owl,Fox,...")

//================================


int K = 4;

if (db_allow) {
 allowDB("spe_proc,parse")
}

  wc = Wolf(80);

  <<" after direct call of Wolf returns $wc \n";

  wc = Fox(2);

  <<" after direct call of Fox returns $wc \n";
K= 5
  cbname = "Fox"

<<"indirect call of $cbname\n"


  wc = $cbname(3);  


  <<" after indirect call of Fox returns $wc \n";


  cbname = "Wolf"






  wc = $cbname(5);  

  <<" after Indirect call of Wolf returns $wc \n";



  wc = Bear(80);

  <<" after direct call of Bear returns $wc \n";

   chkN(wc,720)

   cbname = "Bear"

  wc = $cbname(5);  

    chkN(wc,45)



   for (i = 0 ; i < 5; i++) {

    if (i == 0) {
       cbname = "2"
    }
    else if (i < 3) {
    <<" call Bear\n"
      cbname = "Bear"
    }
    else {
    <<" call Wolf\n"    
       cbname = "Wolf"
    }

    wc = $cbname(5);  
<<"%V $wc  $cbname \n"

ans=ask("[$i] after Indirect call of $cbname returns $wc \n",0);

   }


   wc = Owl( 371)

<<" Owl  says $wc \n"

  cbname = "Owl"

   wc = $cbname(371);  

<<" Owl  says  = $wc \n"

   x = 6; y = 7;

   wc = $cbname(6);  

<<" Owl  says  = $wc \n"


  cbname = "Crow"

   wcf = $cbname(13);  

<<" Crow says  = $wcf \n"

//Svar animals = {"Owl,Wolf,Bear,Fox,Crow,RedHawk,Magpie"}

  birds.pinfo()

  nf= Caz(birds)



   for (i = 0; i < nf; i++) {

    cbname = birds[i]
    if (cbname != "") {
    bcall = $cbname(5);  // iproc (cbname)
<<"%V [$i]   $cbname  rets $bcall \n"
    }
    }



   chkOut(1)


/*
    CPP version has to construct a  table of ptrs to funcs (procs)
    int *pf(int)
    then use hash of name of str to index the table and
    execute the function

    the translation of asl script  has to say which  procs/funcs are addes to this
    table

    and then the iproc statement  bcall = $cbname(5);  
    translates to bcall =  (pf * )lookupfunptr(cbname) (arg)


    makefuncptrtable ("Owl,Magpie,RedHawk, ...)
    all those functions need same form (signature)  int *pf(int) 







*/
