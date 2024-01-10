///
///
///

FilterDebugMode(ALLOW_ALL_)

mode = getFilterDebugMode()

<<"%V $mode \n"

allowDB("spe,gscom,parse")

mode = getFilterDebugMode()

<<"%V $mode \n"

 filterFuncDebug(ALLOWALL_,"xxx"); 