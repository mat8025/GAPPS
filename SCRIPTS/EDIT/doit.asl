///
///
///


  na = argc()
  for (i = 1; i < na; i++)
  {

<<"cat  $_clarg[i] | asl eddbp > junk.cpp\n"
!!"cat  $_clarg[i] | asl eddbp > junk.cpp "
!!"cp junk.cpp $_clarg[i] "
  }