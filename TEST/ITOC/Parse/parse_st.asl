///
///
///

setDebug(1,"trace");

proc foo( int c)
{
<<"$_proc $_pargc\n"
 b = c;

}
//

 int a = 1;

 float d = 4;
<<"%V$a \n";

 foo (a);
///  these are all invalid

<<"start 6 \n"
^ foo(d)

<<"start ~ \n"
~ foo(d)

<<"start ` \n"

` foo(a)

<<" start with number\n"

5 * foo(a)

<<" start with comma\n"
,foo(a)

<<" start with vdash\n"
|foo(a)



exit()
