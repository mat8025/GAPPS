///
///
///

// replacing Svar use in parsing and XIC
// with fixed length string filed holder
// to reduce number of alloc/free ops


// use
// asl -cwl fixmleak.asl  500 >  mhog9
//  as test

//initial nums
//1340 9821 3640773 3643892 84 240849 -3119 -8481

a = 3640773; // total alloced


// current -- use of FLsvar instead of Svar - wherever possible
// i.e. arbitary length string not needed (or likely )
// scope - var index
//1226 10173 1649135 1651902 88 105644 -2767 -8947
//1112 10059 1646903 1649784 84 105370 -2881 -8947
//1112 10059 1645863 1648744 84 105217 -2881 -8947
//1112 10059 1173675 1176556 84 72033 -2881 -8947
//1112 10059 761451 764332 84 43113 -2881 -8947

float b= 761451;

pc_rd  = 100 - (b/(1.0*a) * 100.0);

<<"reduced memuse by $pc_rd\n"

