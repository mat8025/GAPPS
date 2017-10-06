///
/// test patnet
///

// first use  training pats


// then test pats

setdebug(0)

ok=opendll("ann");

str avers;

avers = annversion();

Graphic = CheckGwm()


//////////////////////////////////
proc showCRT()
{
 char ce = 65;
 int j = 0;
 int k = 0;
 for (i=1 ; i<=13; i++) {
<<"%c$ce %d% $Opc[j:j+8] \n";

   j += 11;
   for (m=0;m< 11;m++) {
//<<"%6.2f$Output[k:k+25] \n";
   k += 13;
   }
   ce++;
 }
}


proc showCR()
{
 char ce = 65+13
 int j = 0;
 int k = 0;
 for (i=1 ; i<=13; i++) {
<<"%c$ce %d% $Opc[j:j+8] \n";

   j += 11;
   for (m=0;m< 11;m++) {
//<<"%6.2f$Output[k:k+25] \n";
   k += 13;
   }
   ce++;
 }
}

//////////////////////////////////

fname = _clarg[1];

<<"version is $avers $fname\n"

N= getNet();

<<"Net is $N \n"
if (N == -1) {
<<" no/bad net\n"
exit()
}

// training data

 A=ofr("shifttrip.dat")
Input=rdata(A,FLOAT_);
cf(A)

<<" $(Caz(Input)) $(Cab(Input)) \n"

A=ofr("shifttrop.dat")
Target=rdata(A,FLOAT_);
cf(A)


Output = Target;  // use to see actual net output per pattern

 ok =readNet(N,fname)

<<" net is $ok\n"



if (!ok) {
  <<"bad net file\n"
  exit()
}

Nid = getNetId(N)

<<"$Nid \n"

//ans=iread()

int Opc[1000];  // each pattern correct?
float Rms[];

setnetinframes(N,10,2);// should be done in training
   
nc = testNet(N, Input, Target, 1, Output,Opc);

nstats = get_net_ss(N);

<<"%V$nstats"

Npats = getNetPats(N);

<<"%V $Npats\n"


<<"correct $nc \n"
rms = nstats[1];
Rms[0] = nstats[1];

pc = (nc*1.0)/Npats * 100
  
//showCR();

///////////////////////

if (Graphic) {
 include "net_g"

include "gevent.asl";
     eventWait();

 wp =1

while (1) {

           eventWait();
	   
// <<"$ev_woname $ev_woid  \n"

          if (ev_woid == pat_wo) {
            wp = atoi(woGetValue(pat_wo));
	    }

      net_display(wp++,Input,Target);
<<"$wp $Npats\n"
  if ( wp >= Npats) { 
         break;
    }
//  ans=iread()
//  if (ans @= "g")
//    break;
}
}

showCRT();


<<"DOING TEST \n"


 A=ofr("shifttstip.dat")
InputTst=rdata(A,FLOAT_);
cf(A)


<<" $(Caz(Input)) $(Cab(Input)) \n"

A=ofr("shifttstop.dat")
TargetTst=rdata(A,FLOAT_);
cf(A)

<<"$(Caz(InputTst)) $(Cab(TargetTst)) \n"
narch = getNetArch(N);
<<"$narch\n"
nin = narch[3]
ntstpats = Caz(InputTst)/ nin;
<<"%V$ntstpats\n"
setnetPats(N,143)
Npats = getNetPats(N);

<<"%V $Npats\n"
//ans=iread();

Output = TargetTst;  // use to see actual net output per pattern

nc = testNet(N, InputTst, TargetTst, 1, Output,Opc);

nstats = get_net_ss(N);

<<"%V$nstats\n"

<<"correct $nc  $(nc/(1.0*Npats)*100) \n"

showCR();




if (Graphic) {
wp  =1;
while (1) {

     eventWait();
	if (ev_woid == pat_wo) {
            wp = atoi(woGetValue(pat_wo));
	    }
      net_display(wp++, InputTst, TargetTst)
      if ( wp > Npats) { 
          wp = 1 
      }
  
}

//net_show_result();

}