
//  if we are compiling script  using cpp this will redefine ASL to 0 CPP to 1 and then compile the script
//  if we run asl script -- will not recogonize  __STDC__   so will leave ASL,CPP as is 


#if __STDC__
#undef ASL
#define ASL 0
#undef CPP
#define CPP 1
#endif

