ITOC - tasks    

GASP 3.2.0

  ASL 

 ( Compiler version restarted Nov 2004 )

 ASL is a scripting language that  will generate and manipulate vectors, arrays and matices. 
 The vector and matrix operations are carried out "internally"  via function calls to C++, DLL libraries.

 When a script is run  the interpreter asl  reads in the source lines and parses the script into statements
 with an initial classification. Then asl begins execution of the script. Each statement is parsed (recursive descent)
 and compiled  during execution.

 Thus for each statement a set of opcode instructions with data are stored in the statement structure.
 As the script continues to run any statement that is subsequently executed uses those "compiled" opcode instructions 
 and data.
 When the program exits the compiled instructions with embedded data  are written to a file with the extension .axe 
 extension - when this file is loaded and run via a command e.g.
 asl prog.axe
 the compiled instructions are loaded and the statement execution order is generated and the program execution
 begins. [ when the original script is used - it will by default look for an executable file and execute that
 unless the source script file has been updated]

 Testing comprises of running a script via the  interpreter 
 - which on  first pass categorizes statements and then compiles to opcode
 instructions which are then written to an "executable" file -- prog.axe. 
 We then test the .axe file by running  ->>>     asl prog.axe arg1 arg2 ...
 The test programs are indicated together with their arguments ( and ranges).

 FWD  - first working date
 VCCD - verified code correct date
 

 ///////////////////////////////////////////////////////////////////////////////////////////////

 ASL Component        TID start-date      FWD       VCCD       test-prg(s)   

 Simple expression     1  01/11/04        31/12/04   x/x/x     sexp
 While loop            2  01/11/04        15/12/04   x/x/x     while0
 For loop              3  15/11/04        2/1/05     x/x/x     for0
 Do LoopUntil/While    4  x/x/x 	x/x/x	     x/x/x     do { ...} while ( a < b)
 If expression         5  15/11/04       3/1/05     x/x/x     if0 N ( where N is <1 , 1, & >1)
 Function calling      6  01/12/04    4/1/05	x/x/x	   func     y = foo()           
 Function calling      7  01/12/04    4/1/05	x/x/x	   y = foo(a,b)           
 Procedure Calling     8  10/12/04    4/1/05	x/x/x  proc0	   poo()           
 Procedure Calling     9  10/12/04    4/1/05	x/x/x	 proc1	   y = poo(a) 
 Procedure Calling     10 10/12/04    4/1/05	x/x/x	 proc3	   y = poo(a) * noo(b)                    
 Reference/value args  11 20/12/04    6/1/05	x/x/x		proc_refarg,proc_valarg poo(&a)
 Procedure Calling     12 x/x/x        x/x/x	 x/x/x		x proc4   y = poo(poo(a))           
 Declare               13 26/12/04     26/12/04  x/x/x           factd.axe
 Executable/binary     14 25/12/04     26/12/04  x/x/x while2->while2.axe 
 command line args     15 28/12/04     27/12/04  x/x/x while2.axe
 DLL lib call          16 28/12/04	x/x/x       x/x/x cbrt
 String arg            17 28/12/04      3/1/05   x/x/x  string0
 Argument exp         18  x/x/x    x/x/x	x/x/x	   y = poo(a++)       
 Argument exp         19  x/x/x    x/x/x	x/x/x	   y = poo(a * b, Sin(x))       
 Argument arrays      20  x/x/x    x/x/x	x/x/x	   Fft(R,I,n)
 Post/pre inc/dec     21  3/1/05
 Procedure Recursion  22 6/1/05      22/1/05	x/x/x     fact,factap
 Break-While          23 10/12/04    4/1/05     x/x/x	  while_break
 Continue-While       24 10/12/04    4/1/05     x/x/x	  while_continue
 Vector Ops           25 4/1/05    5/1/05	x/x/x	  vexp
 NestedIfProcReturn   26  x/x/x    x/x/x	x/x/x	          
 OOP -CMF             27 30/1/05   8/2/05        x/x/x     oop
 OOP -OAarray         28 16/2/05  19/2/05        x/x/x       oa
 OOP -MH              29 9/2/05   16/2/05        x/x/x       mh
 Pan                  30 1/2/05    x/x/x         x/x/x     pan
 xgs->asl             31 25/2/05     x/x/x         x/x/x   gasl
 SubscriptedArrays    32 26/2/05     x/x/x         x/x/x
 include src file     33 1/3/05      1/3/05      x/x/x     include_proc
 LHsubscript         34 12/3/05     14/3/05     x/x/x     lsarraysubs
 subscriptexp        35 17/3/05     17/3/05       x/x/x    subscriptex
 funcsubscrip        36 25/3/05     x/x/x       x/x/x    funcsubscript

///////////////////////////////////////////////////////////////////////////////////////////////
/// ELSE TO DO 

SubScript Rewrite - faster vector version


N.B.   Check Function calling with subscripted arrays - that local copies made when necessary
   to prevent overwriting subset in other args using same vector
   ? always do this - rather than in function body !!  ?


  strings
  number constants
  string parameter expansion 
  Sprint
  Scommand




  once-only code
  goto - label

  OOP - name-mangeling

  Pan number type -   Check arbitary precision

  Variable member functions

  ns = scat(w1,w2,...)
  versus
  ns = w1->scat(w2,...)

  define statements


  forever - for (;;)

  IC->indent

  use compiled/code parsing to tidy/indent original src code

  Threads - sort out scope/recursion issues

  profile-ing code



  Embedded version --- strip out parsing code - just use IC code and fixed libs??

///////////////////////////////////////////////////////////////////////////////////////////////////////////

  Description of method and stuff remaining to code/fix 

 For loop                declare in the init statement ?

 Do LoopUntil/While    not coded

 Function calling      auto DLL call is not dealt with in opcode execution - but if OpenDll is used will work
                       (have auto DLL - writen to Xic statement ??)


 Procedure Calling     if there is return value it is pushed onto stack - subsequent opera calls will pop results off for
                        calculation


 reference/value args  - works in interpreter opcode not in opcode executable

 Declare                int k = 0 -- in exe file ends up as int generic variable rather than plain int

 Executable/binary(axe file)

                     currently (4/1/05) runs simple statements, while ,if,for 
                     references siv's via slot -need to verify via name - since siv creation via hash
                     function can be order dependent
                     eost eost_id and lstack fst_id - statement ids are used to link ptrs to loop statements
                     since we save as binary the statements contents - not the "memory image" of statements and ptrs to
                     statements


