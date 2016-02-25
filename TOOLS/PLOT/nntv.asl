#! /usr/local/GASP/bin/asl

// test neural-net retrieval

OpenDll("ann")
OpenDll("plot")
OpenDll("math")
//SetDebug(2,"stderr")
SetNetDebug(0)
SetDebug(0)
fn= $2
A=ofr(fn)

for (i = 0 ; i < 10; i++) {
 hl = getline(A)
 <<"<$i> $hl "
}


R=ReadRecord(A,"type","float")

cf(A)

sz = Caz(R)

<<" %v $sz \n"

<<" ${R[0:7][*]} \n"



//<<" %v $R[0:10][*] \n"

P = R[0::4][*]

<<"\n\n $P[0:3][*] \n"

dim = Cab(P)

<<" $dim \n"

T1 = R[1::4][*]
T2 = R[2::4][*]
T3 = R[3::4][0:14]


dim = Cab(T1)

<<" $dim \n"

dim = Cab(T3)

<<" $dim \n"


T = T1 @< T2 @< T3

dim = Cab(T)

<<" $dim \n"

vfree(T1,T2,T3)

<<" $T[0][*] \n"

# read in vap pattern

fn= $3
A=ofr(fn)

for (i = 0 ; i < 10; i++) {
 hl = getline(A)
 <<"<$i> $hl "
}


R=ReadRecord(A,"type","float","ncols",17)
cf(A)

sz = Caz(R)

T1 = R[1::4][0:15]
T2 = R[2::4][0:15]
T3 = R[3::4][*]

dim = Cab(T1)

<<" $dim \n"

dim = Cab(T3)

<<" $dim \n"

V = T1 @< T2 @< T3


dim = Cab(V)

<<" $dim \n"

vfree(T1,T2,T3)


TV = T @<  V

dim = Cab(TV)

<<" $dim \n"

vfree(T,V)



// T has tem target


n1 = GetNet("temret","dca")
<<" $n1 \n"
// architecture

     SetNetArch(n1,3,16,96,80)
     SetNetConn(n1)
     nseed =RandNetWts(n1,0,0,2)

<<" %v $nseed \n"

    SetNetEta(n1,0.1)

//    SetNetTheta(n1,0.0)

    SetNetPats(n1,10000)

    SetNetAct(n1,"logistic")

    ncyc = 10

// shuffle pats ??
//  use a control vector - which pat_index _ whether to present

    k = 0

    while (1) {

    nc =train_net(n1,P,TV,ncyc)

    ss=GetNetSS(n1)

    ss /= ncyc

    nfs = GetNetFpasses(n1)

<<" %v $ss $nfs $nc\n"

     if ( (ss < 0.5) )
         break

     k++

      if ( (k % 20) == 0) {
         savenet(n1,"tv${k}.net")
      } 
         savenet(n1,"s.net")
         writenet(n1,"w.net")
     }



STOP("DONE")

