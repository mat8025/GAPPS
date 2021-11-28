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

L1.pinfo()


str ww = L1[3];

<<"$ww \n"

ww.pinfo()
aw = L1[4]

<<"$aw \n"

aw.pinfo()

L2 = L1[2:5]

<<"$L2\n"

L2.pinfo()

L3 = L1[8:11]

<<"$L3\n"

L3.pinfo()

 litem = "first"

 n= L3.Insert(0,litem)

<<"insert %V$L3    $n\n"

 n= L3.Insert(3,"the","quick","fox","jumped")

<<"insert %V$L3    $n\n"

exit()

//=================================//

int V[>10] = {0,1,2,3,4,5,6,7,8,9,10};

<<"$V\n"
V.pinfo()


V2= V[2:5];
V.pinfo()

<<"$V2\n"

V2.pinfo()
exit()

