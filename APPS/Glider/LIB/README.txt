///

  glider task apps
  These are the procedures to follow to asl code to be compiled via
  g++/gcc. Asl scripts use C like syntax and can produce C++ classes.
  The C++ syntax is a subset of C++. 

  The makefile here produces a Glide object defined in glide.h to construct
  a DLL containing glide task calculation and display modules
  the Asl scripts can be run via asl and/or compiled via cpp
  and called by asl  on a command line  with parameters.
  See the run_glide bash script.
  
  The cpp interface and C call interface are placed in the beginning and
  end of the asl scripts and guarded by a define CPP
  Development of routines and display should be done via ASL
  and then the makefile can be used to compile the scripts via
  g++ and to produce a DLL library.

  The compiled code is run using asl  via a command line or bash script
  which will open the DLL and call a C routine which runs a Glide class method.

  asl uses the -s option to run the commands
  First set up an Svar to contain command line args
   open this Dll glide, open the plot Dll
   and run the asl function glidertask (sa)  with the command line args
   
#run glide
#echo "bash args" $*
asl  -s 'Svar z=_clarg[1:-1:1]; Str sa="$z";   opendll("glide"); glidertask(sa); exit(0); ' $*


 Other major applications would follow the same model (see Wex app).


