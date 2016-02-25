# xor- problem - test of asl interface  of ann library routines

opendll("ann")

ascii W[60]

float Input[8]
float Target[4]

#char Target[20]
#char Target[4][2]


float Rms[1000+]  //  contains rms error per sweep

# procs

proc usage()
{

 <<"xor - use neural-net to build XOR gate : example prog\n"
 <<" arguments are <argname> range default value :\n" 
 <<" [eta 0.2 (0-1)] \n"
 <<" [theta 0.2 (0-1)] \n"
 <<" [alpha 0.9 (0-1)] \n"
 <<" [act  LOGISTIC (LOGISTIC|HYPERBOLIC|SINE) \n" 
 <<" [type sff (sff|dca)] \n"
 <<" [range 01] \n" 
 stop!
}



# args
na = argc()

if (na < 1)   usage()

<<"arg 0 $_clarg[0] \n"
<<"arg 1 $_clarg[1] \n"
<<"arg 2 $_clarg[2] \n"


N= get_net()

<<"Net $N \n"

adjust_range = 0
do_scale = 0

# design net

layers = 3
nin = 2
nout = 1
int n_first_hid = 2
int n_second_hid = 0
rs = 7

act = "LOGISTIC"
float eta = 0.2
float alpha = 0.9
float theta = 0.9

ntype = "sff"

int nsweeps = 8000;

cla = 1
<<"%V$na \n"

while (cla <= na) {

    //  FIXME cla++ should inc after array index eval
    //  arg = _clarg[cla++]

      arg = _clarg[cla] ; cla++
      val = _clarg[cla] ; cla++

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

     if (arg @= "hidden2") {
          n_second_hid=atoi(val)
       <<"%V$n_second_hid\n"	  
     }

     if (arg @= "theta") {
          theta=val
     }

     if (arg @= "nsweeps") {
          nsweeps=val
     }

}

# get net descriptor
//set_net_debug(0)


# set up architecture


if (n_first_hid > 0) {
 layers = 3
}

if (n_first_hid > 0 && n_second_hid > 0) {
  layers = 4
}

<<"arch layers $layers fhid $n_first_hid shid $n_second_hid \n"

ok=setNetArch(N,layers,nin,nout,n_first_hid,n_second_hid)

if (! ok) {
<<"arch setup failure \n"
     exit()
}


//iread()

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

rs = 8
rs = set_net_wts(N,rs)

<<"random seed $rs \n"

# defaults
# set up teaching specs

# learning parameters

# learning exit pars

# inputs
Input[0] = 0
Input[1] = 0

Input[2] = 0
Input[3] = 1

Input[4] = 1
Input[5] = 0

Input[6] = 1
Input[7] = 1


ninputs = 8

if (adjust_range) {
 for (ni = 0 ; ni < ninputs ; ni++) {
   Input[ni] *= 2 ;
   Input[ni] -= 1 ;
 }
 }

if (do_scale) {
 for (ni = 0 ; ni < ninputs ; ni++) {
 Input[ni] *= scale
 }

}

# targets


// ALWAYS
Target[0] = 1
Target[1] = 1
Target[2] = 1
Target[3] = 1

// NEVER
Target[0] = 0
Target[1] = 0
Target[2] = 0
Target[3] = 0

//  XOR
Target[0] = 0
Target[1] = 1
Target[2] = 1
Target[3] = 0



#{
Target[0] = 1
 Target[1] = 0
Target[2] = 1
 Target[3] = 1
Target[4] = 1
 Target[5] = 1
Target[6] = 1
 Target[7] = 0


for ( i = 0 ; i < 4 ; i++) {
Target[i][0] = 1;
Target[i][1] = 0;
}

for ( i = 1 ; i < 3 ; i++) {
Target[i][1] = 1
}
#}


ntargs = 4



if (adjust_range) {
 for (ni = 0 ; ni < ntargs ; ni++) {
 Target[ni] = Target[ni] * 2 -1
 }
}




npats=set_net_pats(N,4)

<<"$npats \n"


# eta (learn rate) - alpha (momentum)  - theta ( bias)

 ret = setNetLearn(N,eta,alpha,theta)

<<"eta $eta $ret \n"




theta = get_net_theta(N)
<<"theta $theta \n"

alpha = get_net_alpha(N)
<<"alpha $alpha \n"

//nc = train_net(N, &Input[0], &Target[0], 1)

  nc = trainNet(N, Input, Target, 1)

//print_net(N, 1,&Input[0], &Target[0])

 print_net(N, 1,Input, Target)
 print_net(N, 2,Input, Target)


set_net_debug(0)

int wid = -1


Graphic = CheckGwm()

  if (Graphic) {

    include "xor_g"

  }

<<"%V$wid \n"


ns = 1
p = 0
do_train = 1

float nts = 1
int wp = 1 

int pit;

while (do_train) {

  pit = (!(ns % 1000));

//nc =train_net(N, &Input[0], &Target[0], 1)

 // nc= train_net(N, Input, Target, 1)

 nc= train_net(N, Input, Target, 1);

 

 if (pit) {
/{
   print_net(N, 0,&Input[0], &Target[0])
   print_net(N, 1,&Input[0], &Target[0])
   print_net(N, 2,&Input[0], &Target[0])
   print_net(N, 3,&Input[0], &Target[0])
/}
 }

net_sweeps = getNetSweeps(N)
ss = get_net_ss(N)
rms = sqrt( ss/ 4)
Rms[ns] = rms

  if (rms > 10) {
<<"%V$rms \n"
//i_read()
  si_pause(3)
  }

//nc = getNetNC()
  if ((ns % 10) == 0) {
<<"%V$ns  $nc $ss $rms\n"
 }

// if ((rms < 0.1) && (nc == 4)) {
//   break
// }

   ns++

  if (wid > 0) {
      net_display(wp++)
      if ( wp > npats) { 
          wp = 1 
      }
  }


 if ( rms < 0.1) {

   if (nc == 4) {
      break
   }
    
 }

 if (rms > 0.1) {
 if ((ns % 200) == 0) {
    <<"random shake !\n"
    randNetWts(N,1,4)
 }
 }

 if (ns > nsweeps) {
  break
 }


}


//  nc =train_net(N, &Input[0], &Target[0], 1)
  nc =train_net(N, Input, Target, 1)

  pc = nc/npats * 100

<<"done xor - $nc $rms\n"

 ok= save_net(N,"xor_net.wts")

 if (wid > 0) {

# show results
# show net arch - wts - hidden units

       net_show_result()

 }


# save debug file - by causing at least one error

set_si_error(1)

stop!

