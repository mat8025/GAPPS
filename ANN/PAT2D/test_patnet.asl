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

int nlets = 26;
//int ntoks = 10;
int ntoks = 5;

//////////////////////////////////
proc showCRT()
{
 char ce = 65;
 int j = 0;
 int k = 0;
 for (i=1 ; i<=nlets; i++) {
<<"%c$ce %d% $Opc[j:j+ntoks-1] \n";

   j += ntoks;
   for (m=0;m< 20;m++) {
//<<"%6.2f$Output[k:k+25] \n";
   k += nlets;
   }
   ce++;
 }
}

int tsttoks = 7;
proc showCR()
{
 char ce = 'A'
 int j = 0;
 int k = 0;
 for (i=1 ; i<=nlets; i++) {
<<"%c$ce %d% $Opc[j:j+tsttoks-1] \n";

   j += tsttoks;
   for (m=0;m< 11;m++) {
//<<"%6.2f$Output[k:k+25] \n";
   k += nlets;
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

 A=ofr("alptrip.dat")
Input=rdata(A,FLOAT_);
cf(A)

<<" $(Caz(Input)) $(Cab(Input)) \n"

A=ofr("alptrop.dat")
Target=rdata(A,FLOAT_);
cf(A)


Output = Target;  // use to see actual net output per pattern

 ok =readNet(N,fname)

<<" net is $ok\n"


narch = getNetArch(N);
<<"$narch\n"
nin = narch[3];

if (!ok) {
  <<"bad net file\n"
  exit()
}

Nid = getNetId(N)

<<"$Nid \n"

//ans=iread()

int Opc[1000];  // each pattern correct?
float Rms[];

setnetinframes(N,32,1);// should be done in training
   
nc = testNet(N, Input, Target, 1, Output,Opc);

nstats = get_net_ss(N);

<<"%V$nstats"
ntrpats = Caz(Input)/ nin;
setNetPats(N,ntrpats)
Npats = getNetPats(N);

<<"%V $Npats\n"


<<"correct $nc  $(nc/(1.0*Npats)*100) \n"
rms = nstats[1];
Rms[0] = nstats[1];

pc = (nc*1.0)/Npats * 100
  
//showCR();

///////////////////////

if (Graphic) {
 include "net_g"

include "gevent.asl";
     eventWait();

 wp =0;

while (1) {


	   
// <<"$ev_woname $ev_woid  \n"

          if (ev_woid == pat_wo) {
            wp = atoi(woGetValue(pat_wo));
	    }

      sWo(pcorr_wo,@value,Opc[wp],@redraw);
      net_display(wp++,Input,Target);

  if ( wp >= Npats) { 
         break;
    }
               eventWait();
//  ans=iread()
//  if (ans @= "g")
//    break;
}
}
showCRT();


exit();


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
setnetPats(N,ntstpats)

Npats = getNetPats(N);


<<"%V $Npats\n"
//ans=iread();

Output = TargetTst;  // use to see actual net output per pattern

nc = testNet(N, InputTst, TargetTst, 1, Output,Opc);

nstats = get_net_ss(N);

<<"%V$nstats\n"
<<"%V$Npats\n"

<<"correct $nc  $(nc/(1.0*Npats)*100) \n"

showCR();


if (Graphic) {
wp  =0;
while (1) {

     eventWait();
	if (ev_woid == pat_wo) {
            wp = atoi(woGetValue(pat_wo));
	    }
      sWo(pcorr_wo,@value,Opc[wp],@redraw)
      net_display(wp++, InputTst, TargetTst)

      if ( wp > Npats) { 
          wp = 1 
      }
  
}

//net_show_result();
}