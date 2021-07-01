
<|Use_=
step thru args
|>

#include "debug"

if (_dblevel >0) {
   debugON()
   <<"$Use_\n"   
}


#define DBG <<


na = get_argc()

DBG"%v $na\n"

int ac = 1;

chkIn(_dblevel)

while (ac < na) {

    targ = _argv[ac]

    ac++

DBG"%V $ac $targ\n"
}


while (ac < na) {

    targ = _argv[ac]

    ac++

DBG"%V $ac $targ\n"
}

chkT(1)