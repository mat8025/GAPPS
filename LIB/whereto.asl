#! /usr/local/GASP/bin/asl
///

<<"$(getdir())\n"


where = _clarg[1]

chdir("$where")


<<"$(getdir())\n"

<<"$where\n"

!!"ls "