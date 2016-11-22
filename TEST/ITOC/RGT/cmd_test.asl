
setdebug(1)

<<" trying command bkg \n"
jpid = !!&"ps -al > plist"


<<"pid to watch $jpid \n"

jpid = !!&"date  "

jpid = !!&"asl Bops/bops.asl "

<<"pid to watch $jpid \n"


jpid = !!&"asl Stats/Lip/lip.asl "

<<"pid to watch $jpid \n"

jpid = !!&"asl Stats/Lip/lip_sleep.asl "

<<"pid to watch $jpid \n"

jpid = !!&"asl Stats/Lip/lip_crash.asl "

<<"pid to watch $jpid \n"


jpid = !!&"asl Cut/cut.asl "

<<"pid to watch $jpid \n"