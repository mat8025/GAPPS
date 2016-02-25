#! /usr/local/GASP/bin/asl

SetPCW("writepic","writeexe")
Setdebug(1)
prog= GetScript()

opendll("math")

int ok = 0
ntest = 0
bad = 0



//   test some basics -- before using testsuite  
// declare

// proc





<<" DoneTest $ntest $ok $bad  \n"


 pcc= (100.0 * ok)/ntest
<<"%-24s: $prog :asl_verify_count %3d $ntest :success %3d $ok %4.1f $pcc\% \n"

// !!!! if basics fail warn/ask before going on to testsuite


STOP!
