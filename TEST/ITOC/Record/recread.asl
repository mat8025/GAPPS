/* 
 *  @script recread.asl                                                 
 * 
 *  @comment test read file into record                      
 *  @release Carbon                                                     
 *  @vers 1.4 Be Beryllium [asl 6.16 : C S]                             
 *  @date 05/26/2024 16:13:21                                           
 *  @cdate 1/1/2018                                            
 *  @author Mark Terry                                        
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 



   myScript = getScript();
///
///
///

   chkIn(_dblevel);

   ftfile = "favfoods.csv";

   A=  ofr("favfoods.csv");

   db_allow = 0

   allowDB("array_,rec_,ds_,spe_exp,ic_,para", db_allow);

   db_ask = 0;

   DB_prompt = "continue ? !q to quit"

   Record RF;

   RF.readRecord(A,_RDEL,',');

   if (A == -1) {

     <<" can't open file   \n";

     exit();

     }

  cf(A);

   recinfo = info(RF);

   <<"$recinfo \n";

   RF.pinfo();

   Nrecs = Caz(RF);

   Ncols = Caz(RF,1);

   <<"num of records $Nrecs  num cols $Ncols\n";

   ans=ask(DB_prompt,db_ask);

   <<" $RF[::] \n";

   ans=ask(DB_prompt,db_ask);

   for (i= 0; i < 3; i++) {

     nc = Caz(RF,i);

     <<"<$i> $nc $RF[i] \n";

     }

   <<" $RF[6] \n";

   <<" $RF[7] \n";

   <<" $RF[Nrecs-1] \n";

   <<" $RF[Nrecs-2] \n";

   for (i= 2; i < 10; i++) {

     rval = RF[i];

     <<"$rval \n  $RF[i] \n";

     }

   <<" $RF[::] \n";

   <<"before delete \n";

   recinfo = info(RF);

   <<"$recinfo \n";

   <<" $(info(RF)) \n";

   Nrecs = Caz(RF);

   <<"num of records $Nrecs \n";

   Ncols = Caz(RF,1);

   <<"num of cols $Ncols\n";

   deleteRows(RF,1,-1);

   <<"after delete \n";

   <<" $(info(RF)) \n";

   Nrecs = Caz(RF);

   <<"new num of records $Nrecs \n";

   Ncols = Caz(RF,1);

   <<"new num of cols $Ncols\n";

   <<" $(info(RF)) \n";
//yes=iread("next?")

   <<" $RF[::] \n";

   ans=ask(DB_prompt,db_ask);
   //delete(RF)  ; // realloc of RF does not work for xic

   A=  ofr("favfoods.csv");

   RF.readRecord(A,_RDEL,',');

   cf(A);

   Nrecs = Caz(RF);

   <<"new num of records $Nrecs \n";

   Ncols = Caz(RF,1);

   <<"new num of cols $Ncols\n";

   for (i= 0; i < 3; i++) {

     nc = Caz(RF,i);

     <<"<$i> $nc $RF[i] \n";

     }

   <<" $RF[::] \n";

   ans=ask(DB_prompt,db_ask);

   chkT((nc >0));

   int Testpick[5][2];

   testargs(1,Testpick);
//ans=iread()

   A=  ofr(ftfile);

   A.pinfo();

   if (A == -1) {

     <<" can't open food table $ftfile \n";

     exit();

     }

   Record RF2;

   RF2.readRecord(A,_RDEL,',');

   cf(A);

   Nrecs = Caz(RF2);

   Ncols = Caz(RF2,1);

   <<"num of records $Nrecs  num cols $Ncols\n";

   FL = RF2[2];

   <<" $RF2[2] \n";

   <<" $FL \n";
/*
   for (i= 0; i < 3; i++) {
       nc = Caz(RF2,i);
       FL = RF2[i];
<<"<$i>  $RF2[i] \n";
<<"<$i>  $FL \n";
    }
*/


   chkT((nc >0));

   <<"; ///////////";
/*
for (j = 1; j<=10;j++) {

  vname = "RT$j";

  $vname = RF;

   for (i= 0; i < 3; i++) {
       nc = Caz($vname,i);
       s = $vname[i]
<<"<$i> $nc $s[i] \n";
    }

}

*/

/*
Record RT[2][10];

RT[0][0] = RF[0];
RT[1][0] = RF[1];

<<"RT[0][0] $RT[0][0]\n"
<<"RT[1][0] $RT[1][0]\n"
*/


   chkOut();

//==============\_(^-^)_/==================//
