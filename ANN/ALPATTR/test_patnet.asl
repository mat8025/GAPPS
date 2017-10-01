///
/// test patnet
///

// first use  training pats


// then test pats

//setdebug(1)

ok=opendll("ann");

str avers;

avers = annversion();

//////////////////////////////////
proc showCR()
{
 char ce = 65;
 int j = 0;
 int k = 0;
 for (i=1 ; i<=26; i++) {
<<"%c$ce %d% $Opc[j:j+4] \n";

   j += 5;
   for (m=0;m< 5;m++) {
//<<"%6.2f$Output[k:k+25] \n";
   k += 26;
   }
   ce++;
 }
}

//////////////////////////////////

fname = _clarg[1];

<<"version is $avers $fname\n"

N= getNet();

 //<<"Net is $N \n"

// training data

 A=ofr("altptrip.dat")
Input=rdata(A,FLOAT_);
cf(A)

<<" $(Caz(Input)) $(Cab(Input)) \n"

A=ofr("altptrop.dat")
Target=rdata(A,FLOAT_);
cf(A)

Output = Target;  // use to see actual net output per pattern

 ok =readNet(N,fname)

//<<" net is $ok\n"


if (!ok) {
  <<"bad net file\n"
  exit()
}



Nid = getNetId(N)

<<"$Nid \n"


Npats = getNetPats(N);

//<<"%V $Npats\n"

//ans=iread()

int Opc[Npats];  // each pattern correct?
float Rms[];

setnetinframes(N,10);// should be done in training
   
nc = testNet(N, Input, Target, 1, Output,Opc);

nstats = get_net_ss(N);

<<"%V$nstats"

<<"correct $nc \n"
rms = nstats[1];
Rms[0] = nstats[1];

pc = (nc*1.0)/Npats * 100
  
showCR();

///////////////////////










 A=ofr("altptstip.dat")
Input=rdata(A,FLOAT_);
cf(A)

<<" $(Caz(Input)) $(Cab(Input)) \n"

A=ofr("altptstop.dat")
Target=rdata(A,FLOAT_);
cf(A)

Output = Target;  // use to see actual net output per pattern

nc = testNet(N, Input, Target, 1, Output,Opc);

nstats = get_net_ss(N);

<<"%V$nstats"

<<"correct $nc \n"

showCR();


Graphic = CheckGwm()

  if (Graphic) {
    //opendll("plot");
    include "net_g"
  }
  else {
   exit()
  }

 wp =1
 if (wid > 0) {
      net_display(wp++)
      if ( wp > Npats) { 
          wp = 1 
      }
  }


net_show_result();