

#define DBG ~!

#include "tpclass"







chkIn(_dblevel)



void delete_tp(int wt)
//void delete_tp()
{
//int wt = Witp;
int kt = 0;
	          kt = Wtp[wt]->id;
//              <<"$_proc delete $wt $Wtp[kt]->Place \n"
              <<"$_proc delete  $wt $kt \n"


}


int PickTP(str atarg,  int wtp)
{
///
/// 
int ret = -1;

<<"$_proc looking for  $atarg  $wtp\n"
      if (issin(atarg,"ab")) {
           ret =1;
      }
      return ret;
}

Turnpt  Wtp[800]; //

   tp_file = "CUP/bbrief.cup"

A=  ofr(tp_file);


 RF= readRecord(A,@del,',');

  Nrecs = Caz(RF);
  Ncols = Caz(RF,1);

<<"num of records $Nrecs  num cols $Ncols\n";

cf(A);



  A=ofr(tp_file)
  svar Wval;

Ntp =0;
int i = 1;
while (1) {


               nwr = Wval->ReadWords(A,0,',')


     if (nwr == -1) {
 	      break
            }

  Wtp[Ntp]->TPCUPset(Wval);

   Ntp++;



}



  str s1 = "xabx"


    r=PickTP (s1,3);

<<"$s1 $r\n"
    chkN(r,1)
   s2 = "xxx"

    r=PickTP (s2,4);

    chkN(r,-1)

<<"$s2 $r\n"
    r=PickTP ("cab",5);

    chkN(r,1)
<<"cab $r\n"

 int kt = 1;
 
 while (1) {


                wpl = Wtp[kt]->Place;

  ans = query("$wpl input str:")


   delete_tp(i)
   i++;

   r=PickTP (ans,kt);

    
<<"cab $r\n"
   kt++;

 if (ans @= "q") {
    break;
 }

 }


chkOut()









