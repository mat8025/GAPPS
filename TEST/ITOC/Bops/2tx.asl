///
///
///


//!!"ls /home/mark/gapps/TEST "

chdir("/home/mark/gapps/TEST/XASL/ShmIPC")

where= _clarg[1];

//!!"pwd "

<<"$where\n"
chdir("$where")

//!!"pwd"

