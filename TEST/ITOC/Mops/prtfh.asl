#! /usr/local/GASP/bin/asl

#  raofile station_id FSLspaces(2) cutoffht 0  cldrh(0.94) 1 clear 0 allmonths
#  IR temp estimate ---- cutofftir 223

SetDebug(0)


proc prt_vals( afh)
{

 <<[afh]"\n\n /////////// \n"
 <<[afh]"%v $raof \n"
 <<[afh]"%v $wexp \n"

}

proc wf_vals(afh)
{

 w_file(afh,"\n\n /////////// \n")
 w_file(afh,"%v $raof \n")
 w_file(afh,"%v $wexp \n")
}

raof = "jjj"
wexp = "liq1"

<<" printing to stdout \n"
 prt_vals(1)
<<" writing to stdout \n"
 wf_vals(1)

AF=ofw("settings")
<<"%v $AF \n"


<<" printing to $AF \n"
 prt_vals(AF)
<<" writing to $AF \n"
 wf_vals(AF)

raof = "kkk"
wexp = "liq2"

<<" writing to stdout \n"
 wf_vals(1)

<<" printing to $AF \n"
 prt_vals(AF)
<<" writing to $AF \n"
 wf_vals(AF)

 cf(AF)


STOP("DONE")
