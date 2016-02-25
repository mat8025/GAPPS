#! /usr/local/GASP/bin/asl

// test neural-net retrieval

OpenDll("ann","plot","math")

//SetDebug(2,"stderr")
SetNetDebug(0)
SetDebug(0)
fn= $2
// tem pattern file

R=ReadRecord(fn,"type","float","skipheaderlines",10)


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

R=ReadRecord(fn,"type","float","ncols",17,"skipheaderlines",10)

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


// liq pattern file

fn = $4

R=ReadRecord(fn,"type","float","skipheaderlines",10)

sz = Caz(R)

<<" %v $sz \n"
<<" ${R[0:7][*]} \n"

//<<" %v $R[0:10][*] \n"


T1 = R[1::4][*]
T2 = R[2::4][*]
T3 = R[3::4][0:14]


dim = Cab(T1)

<<" $dim \n"

dim = Cab(T3)

<<" $dim \n"

L = T1 @< T2 @< T3

dim = Cab(L)

<<" $dim \n"

vfree(T1,T2,T3)


<<" $L[0][*] \n"


TVL = T @<  V  @< L

dim = Cab(TVL)

<<" $dim \n"

vfree(T,V,L)


n1 = GetNet("temret","dca")
<<" $n1 \n"
// architecture

     SetNetArch(n1,3,16,143,120)
     SetNetConn(n1)
     nseed =RandNetWts(n1,0,0,2)

<<" %v $nseed \n"

    SetNetEta(n1,0.1)

//    SetNetTheta(n1,0.0)

    SetNetPats(n1,11600)

    SetNetAct(n1,"logistic")

    ncyc = 10

// shuffle pats ??
//  use a control vector - which pat_index _ whether to present

    k = 0

    while (1) {

    nc =train_net(n1,P,TVL,ncyc)

    ss=GetNetSS(n1)

    ss /= ncyc

    nfs = GetNetFpasses(n1)

<<" %v $ss $nfs $nc\n"

     if ( (ss < 0.5) )
         break

     k++

      if ( (k % 20) == 0) {
         savenet(n1,"tvl${k}.net")
      } 
         savenet(n1,"s.net")
         writenet(n1,"w.net")
     }


STOP("DONE")

