set_debug(1)

Svar Wd

 A= ofr("jest")

<<"$(typeof(Wd)) \n"

 Wd->read(A)

<<"$Wd[::] \n"

 Wd->read(A)

<<"$Wd[::] \n"

 nwr = Wd->read(A)

<<"$nwr $Wd[::] \n"

stop!