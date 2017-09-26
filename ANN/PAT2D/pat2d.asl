///
///  test ann on simple 2d block patterns  -- V ^ --/ \-- 
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

# args
na = argc()

if (na < 1)   usage()


int do_print = 0;

float Rms[1000+] ; //  contains rms error per sweep

int Npats = 9;
<<"$Npats \n"

float Input[Npats*25];  // 5 x 5 matrix

<<"%(5,, ,\n)$Input \n";

float Target[Npats*Npats];  // for each pat input which pat is active

<<" TARGETS \n"

<<"%(9,, ,\n)$Target \n";



 N= getNet();

 <<"Net is $N \n"


layers = 3;
nin = 25;
nout = Npats;

<<"%V $layers $nin $nout \n"



int n_first_hid = 9;
int n_second_hid = 0;


act = "LOGISTIC"
float eta = 0.1;
float alpha = 0.9;
float theta = 0.95;

ntype = "sff"

int nsweeps = 20000;
int rshaken = nsweeps;


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

ok=setNetArch(N,layers,nin,nout,n_first_hid,n_second_hid);



if (! ok) {
<<"arch setup failure \n"
     exit()
}

<<"net type $ntype \n"
set_net_type(N,ntype)

set_net_act(N,act)
<<"activation type $act \n"

ok=set_net_nodes(N)

if (! ok) {
<<"arch node setup failure \n"
exit_si()
}

ok = set_net_conn(N)

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




ntargs = Npats;
nip_pats = ntargs;

include "patprep.asl"

Input = T;

<<" Input sz $(Caz(Input))\n"

// init of array is all zeros
// each input should trigger  different cell in output vec
int jj = 0
for (k = 0; k < Npats ; k++) {
  jj = (k*Npats) + k ;
  Target[jj] =1;
<<"$jj\n"
}


<<"%6.1f %($Npats,, ,\n)$Target \n"



npats=set_net_pats(N,nip_pats)

<<"$npats \n"

 ret = setNetLearn(N,eta,alpha,theta)

<<"eta $eta $ret \n"


theta = getNetTheta(N)
<<"%V$theta \n"

alpha = get_net_alpha(N)
<<"%V$alpha \n"

int ns = 0;


nc = testNet(N, Input, Target, 1);

ns++;
<<"first sweep %V$ns  correct $nc \n"

ss = get_net_ss(N);
rms = sqrt( ss/ nip_pats);
Rms[ns] = rms;

<<"%V $ss $rms \n"


set_net_debug(0);


p = 0
do_train = 1;

float nts = 1;
int wp = 1 

int pit;



while (do_train) {

  pit = (!(ns % 1000));

  nc= train_net(N, Input, Target, 1);


 net_sweeps = getNetSweeps(N)
 ss = get_net_ss(N)
 rms = sqrt( ss/ nip_pats)
 Rms[ns] = rms;

 

 if (do_print && pit && !Graphic) {
<<"sweep $ns %V$nc $ss $rms \n"
  print_net(N, 0,&Input[0], &Target[0])
  print_net(N, 1,&Input[0], &Target[0])
  print_net(N, 2,&Input[0], &Target[0])
  print_net(N, 3,&Input[0], &Target[0])

  <<"%V$ns  $nc $ss $rms\n"
//ans=iread("goon:")
//if (ans @= "q") {
// exit()
//}
 }


  if ((ns % 50) == 0) {
<<"%V$ns  $nc $ss $rms\n"
 }


if ( rms < 0.1) {
    if (nc == nip_pats) {
      break
   }
 }

 if (ns > nsweeps) {
  break;
 }
 ns++;
}
//===================================


 nc =test_net(N, Input, Target, 1)

  pc = nc/npats * 100

<<"done pat2d - $ns  $nc $rms\n"

 ok= save_net(N,"net.wts")


exit()
