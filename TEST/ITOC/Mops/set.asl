OpenDll("audio","image","plot","math")
SetDebug(1)
SetPCW("writeexe","writepic")



 F=Fgen(20,0,1.5)


 <<" $F \n"
 short S[]

 S = F * 2


 Set(S,"==",6,-4,">",25,25)


 <<" $S \n"


STOP!