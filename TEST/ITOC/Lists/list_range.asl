///
///
///
include "debug"

filterfuncdebug(ALLOWALL_,"xxx");

filterfiledebug(ALLOWALL_,"proc_","args_","scope_","class_","hop_");


ws = getScript()

<<"%V $ws\n"

setdebug(1,@trace,@keep,@pline);


L1 = ( "a", "small" , "list" , "1", "2", "3", "4", "5" ,"6" ,"yellow", "green", "blue" ,"indigo", "violet")

L1->info(1)


str ww = L1[3];

<<"$ww \n"

ww->info(1)
aw = L1[4]

<<"$aw \n"

aw->info(1)

L2 = L1[2:5]

<<"$L2\n"

L2->info(1)

L3 = L1[8:11]

<<"$L3\n"

L3->info(1)

 litem = "first"

 n= L3->Insert(0,litem)

<<"insert %V$L3    $n\n"

 n= L3->Insert(3,"the","quick","fox","jumped")

<<"insert %V$L3    $n\n"

exit()

//=================================//

int V[>10] = {0,1,2,3,4,5,6,7,8,9,10};

<<"$V\n"
V->info(1)


V2= V[2:5];
V->info(1)

<<"$V2\n"

V2->info(1)
exit()

