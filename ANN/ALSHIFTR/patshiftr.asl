///
///  test ann on simple 2d block patterns  -- A B C, ... drawn with straight lines
///  training to  detect the amount to shift left and down 
///  if works can be used to used shifited input (focused) to the pat2d net
///


envdebug()

Graphic = 0;

ok=opendll("ann");

str avers;

avers = annversion();

<<"version is $avers\n"

proc usage()
{

 <<"pat2d - use neural-net to build XOR gate : example prog\n"
 <<" arguments are <argname> range default value :\n" 
 <<" [eta 0.2 (0-1)] \n"
 <<" [theta 0.2 (0-1)] \n"
 <<" [alpha 0.9 (0-1)] \n"
 <<" [act  LOGISTIC (LOGISTIC|HYPERBOLIC|SINE) \n" 
 <<" [type dca (sff|dca)] \n"
 <<" [range 01] \n" 
<<" e.g. asl  -X pat2d.asl eta 0.2 theta 0.2 alpha 0.9 act HYPERBOLIC type sff hidden1 1 hidden2 2 \n"

  stop!

}

int NBS = 100; // sweeps at one train call

proc Rtrain()
{

do_train = 1;
last_nc = 0;
extend_train = 1;
ns = 0;

 rs = (utime() % 787)
 rs = randnetwts(N,rs);
 <<"random seed $rs \n"

while (do_train) {

  pit = (!(ns % 1000));

  nc= train_net(N, Input, Target, NBS, Output, Opc);

  nc /= NBS;

  if (nc > last_nc) {
    if (nc >= (Npats-2)) {
     bell()
     sleep(0.1);
     }
   last_nc = nc;
  }
  
 net_sweeps = getNetSweeps(N)
 ss = getNetSS(N)
 rms = ss[1];
 Rms[ns] = rms;


<<"\r$ma $(memused()) %V$ns  $nc $ss[0] $rms  "
fflush();


if ( rms < 0.05) {
    if (nc == nip_pats) {
      break
   }
 }

 if (ns > nsweeps) {
 if (extend_train && (nc == (Npats-4))) {
     nsweeps += 10000;
     extend_train = 0;
  }
  else 
  break;
 }

 if (((ns % rshaken) == 0) && (nc < 233)) {
    <<"random shake @ $ns !\n"
   // randNetWts(N,8,2);
  //   break;
 }

 ns += NBS;

}
//===================================


<<"OPC: \n %(16,, ,\n)$Opc \n";


  nc=trainNet(N, Input, Target, 1);

  pc =  (nc*1.0)/npats * 100.0

<<"done train pat2d - %V $ns  $nc $rms $pc\n"

 ok= saveNet(N,"net.wts")

/{
if (nc >= (Npats-4)) {
 PrgFn= ofw("Progress_$ma");
 <<"Progress_$ma ?\n";
<<[PrgFn]"==$ma $nc ===================\n";
 char ce = 65;
 int j = 0;
 for (i=1 ; i<=26; i++) {
//<<[PrgFn]"\n %(5,, ,\n)$Opc \n";
<<[PrgFn]"%c$ce %d% $Opc[j:j+4] \n";
   j += 5;
   ce++;
 }
<<[PrgFn]"=============================\n";
  //goon = iread("again?\n");
  cf(PrgFn);
}
/}
  nc =testNet(N, Input, Target, 1); 

  pc = (nc*1.0)/npats * 100.0;
  
<<"test pat2d - %V   $nc $pc\n"

 ok= saveNet(N,"net_tst.wts")

}

//=========================================


# args
na = argc()

if (na < 1)   usage()


int do_print = 0;

float Rms[1000+] ; //  contains rms error per sweep

int Npats = 260;
<<"$Npats \n"

//float Input[Npats*25];  // 5 x 5 matrix

//<<"%(5,, ,\n)$Input \n";

 N= getNet();

 <<"Net is $N \n"
//ans=iread();

 layers = 3;
 nin = 100;
 nout = 20;  // what shifts left/right/up/down to focus on the pattern 

<<"%V $layers $nin $nout \n"

//float Target[Npats*26];  // for each pat input which pat is active

<<" TARGETS \n"

int n_first_hid = 9;
int n_second_hid = 0;

act = "LOGISTIC"

float eta = 0.1;
float alpha = 0.9;
float theta = 0.95;

ntype = "sff"

int nsweeps = 10000;
int rshaken = 20000;


cla = 1
<<"%V$na \n"

while (cla <= na) {

    //  FIXME cla++ should inc after array index eval
    //  arg = _clarg[cla++]

      arg = _clarg[cla] ; cla++;
      val = _clarg[cla] ; cla++;

//<<"$cla $arg $val \n"

     if (arg @= "act") {
       act= val
     }

     if (arg @= "rs") {
       rs=val
     }

     if (arg @= "type") {
       ntype=val
     }

     if (arg @= "act") {
       act=val
     }

     if (arg @= "eta") {
       eta=val
     }

     if (arg @= "range") {
       adjust_range = val
     }

     if (arg @= "scale") {
       do_scale = 1
       scale = val
     }

     if (arg @= "alpha") {
          alpha=val
     }

     if (arg @= "hidden1") {
       n_first_hid=atoi(val)
       <<"%V$n_first_hid\n"
     }
     if (arg @= "nih1") {
       n_first_hid=atoi(val)
       <<"%V$n_first_hid\n"
     }

     if ( (arg @= "hidden2")   || (arg @= "nih2")  ) {
          n_second_hid=atoi(val)
       <<"%V$n_second_hid\n"	  
     }

     if (arg @= "theta") {
          theta= atof(val)
     }

     if (arg @= "nsweeps") {
          nsweeps = atoi(val);
     }

     if (arg @= "rshaken") {
          rshaken = val
     }

     if (arg @= "print") {
     
          do_print=atoi(val)
       
     }

     if (arg @= "wts") {
          set_wts=atoi(val);
     }
}

<<"%V $n_first_hid  $do_print \n"


if (n_first_hid > 0) {
 layers = 3
}

if (n_first_hid > 0 && n_second_hid > 0) {
  layers = 4
}

<<"arch layers $layers fhid $n_first_hid shid $n_second_hid \n"

ok= setNetArch(N,layers,nin,nout,n_first_hid,n_second_hid);

if (! ok) {
<<"arch setup failure \n"
     exit()
}

<<"net type $ntype \n"
 setNetType(N,ntype);

 setNetAct(N,act);
<<"activation type $act \n"

ok=setNetNodes(N);

if (! ok) {
<<"arch node setup failure \n"
exit_si()
}

ok = setNetConn(N)

if (! ok) {
<<"connection setup failure \n"
ff=set_si_error(1)
ff=exit_si()
}
else {
<<"connection setup ok \n"
}

 rs = 8;
 rs = randnetwts(N,rs);
 <<"random seed $rs \n"

ans=iread("proceed?")
if (ans @= "q") {
 exit()
 }


ntargs = Npats;
nip_pats = ntargs;

//include "patprep.asl"


A=ofr("shifttrip.dat")
Input=rdata(A,FLOAT_);
cf(A)

<<" $(Caz(Input)) $(Cab(Input)) \n"

A=ofr("shifttrop.dat")
Target=rdata(A,FLOAT_);
cf(A)

Output = Target;  // use to see actual net output per pattern

int Opc[Npats];  // each pattern correct?


<<" $(Npats * nout )  $(Caz(Target)) $(Cab(Target)) \n"


 ans=iread()
if (ans @= "q") {
  exit()
 }


//<<"%6.1f %(10,, ,\n)$Input\n"


 npats=setNetPats(N,nip_pats)

<<"$npats \n"

 ret = setNetLearn(N,eta,alpha,theta)

<<"eta $eta $ret \n"

nr =setNetRetrys(N,1,3); // if pattern not correct -- retry this input # times

<<"$nr \n"

theta = getNetTheta(N);
<<"%V$theta \n"

alpha = getNetAlpha(N);
<<"%V$alpha \n"

int ns = 0;
int nc = 0;

nc = testNet(N, Input, Target, 1);

nc = testNet(N, Input, Target, 1, Output,Opc);

ns++;
<<"first sweep %V$ns  correct $nc \n"

ss = get_net_ss(N);

rms = ss[1];
Rms[ns] = rms;

<<"%V $ss $rms \n"


set_net_debug(0);


p = 0


float nts = 1;
int wp = 1 

int pit;
int ma = 0;


ans=iread("proceed?")
 if (ans @= "q") {
  exit()
 }
 
int n_success =0;

while (1) {

Rtrain()

ma++
<<"[${ma}] %V $nc \n"

if (nc >= (Npats-2)) {
 ok= saveNet(N,"net_${ma}.wts")
}
 if (nc == Npats) {
 n_success++;
<<" SUCCESS! @ the $ma attempt %V $n_success\n"

   if (n_success == 2) {
     break;
    }
  }
  
 }


exit();



/{
/*
   this tries to translate the letter pattern located in 10x10
   to a 7x6 matrix just containing the letter

   train on block letters in 4 diff positions
   and test on letter in different position from test (or mix of positions)

   // rotation ??

   try read wts and test
*/
/}




