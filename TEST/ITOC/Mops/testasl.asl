// test asl and compiler

ntest = 0
/////////////////////////////////// BASIC OPS //////////////////////////////////////

!!" asl basic_ops.asl > testoutput  "
ntest++

// check this passes!!

// !!!! if basics fail warn/ask before going on to rest of testsuite
////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////// DECLARE //////////////////////////////////////

!!" asl declare.asl  >> testoutput "
ntest++

!!"tail -2 testoutput "

/////////////////////////////////////////////////////////////////////////////////



////////////////////////////////  EXPRESSION ///////////////////////////////////

!!" asl sexp.asl 10 >> testoutput "

ntest++

!!"tail -2 testoutput "

////////////////////////////////  IF ///////////////////////////////////


!!" asl if0.asl 10 >> testoutput"

ntest++

!!"tail -2 testoutput "

///////////////////////////// FOR ////////////////////////////////////

!!" asl for0.asl 12 16  >> testoutput "

ntest++

!!"tail -2 testoutput "



///////////////////////////// WHILE ////////////////////////////////////

!!" asl while0.asl 10 >> testoutput "

ntest++

!!"tail -2 testoutput "

///////////////////////////// LH SUBSC RANGE ////////////////////////////////////

!!" asl lharraysubsrange.asl >> testoutput "

ntest++


!!"tail -2 testoutput "




///////////////////////////// FUNC /////////////////////////////////////////
!!" asl func0.asl  >> testoutput "

ntest++

!!"tail -2 testoutput "


///////////////////////////// PROC /////////////////////////////////////////

!!" asl procarg.asl  >> testoutput "

ntest++

!!"tail -2 testoutput "

!!" asl procret0.asl 1 >> testoutput "

ntest++

!!"tail -2 testoutput "




////////////////////////////////  RECURSION ///////////////////////////////////



!!" asl fact.asl  8 >> testoutput "

ntest++

!!"tail -2 testoutput "



/////////////////////////////////////////////////////////////////////////////////


!!" asl xyassign.asl  >> testoutput "
ntest++

!!"tail -2 testoutput "


////////////////////////////////// SVAR //////////////////////////////////////////

!!" asl svar.asl string operations are not always easy  >> testoutput "
ntest++

!!"tail -2 testoutput "



//////////////////////////////////////////////////////////////////////////////////

////////////////////////////////// CLASS //////////////////////////////////////////

!!" asl class.asl  >> testoutput "
ntest++

!!"tail -2 testoutput "



//////////////////////////////////// IC  VERSIONS ///////////////////////////////////

!!" ./declare  >> testoutput "
ntest++

!!"tail -2 testoutput "

!!" ./sexp 15 >> testoutput "
ntest++

!!"tail -2 testoutput "

!!" ./if0 12 >> testoutput "
ntest++
!!"tail -2 testoutput "

!!" ./for0 12 19 >> testoutput "
ntest++
!!"tail -2 testoutput "

!!" ./while0 10 >> testoutput "
ntest++
!!"tail -2 testoutput "

!!" ./lharraysubsrange >> testoutput "
ntest++
!!"tail -2 testoutput "

!!" ./func0  >> testoutput "
ntest++
!!"tail -2 testoutput "

!!" ./procret0 1 >> testoutput "
ntest++
!!"tail -2 testoutput "

!!" ./procarg >> testoutput "
ntest++
!!"tail -2 testoutput "

!!" ./fact  10 >> testoutput "
ntest++
!!"tail -2 testoutput "

!!" ./xyassign >> testoutput "
ntest++
!!"tail -2 testoutput "

!!" ./svar  string operations are not always easy >> testoutput "
ntest++
!!"tail -2 testoutput "

!!" ./class >> testoutput "
ntest++
!!"tail -2 testoutput "

vers = get_version()
<<" $vers \n"

<<"test suite $(get_version()) asl_verify_count $ntest\n"

STOP("DONE")
