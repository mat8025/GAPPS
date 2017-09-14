///
///
///

// func name collsion between libs ??
// both mathlib and spil have script function named foo
//  currently first shared lib loaded wins
// 

setdebug(1);

 f = Sin(0.5)

<<"$f $(typeof(f)) \n"

 a = foo()

<<"$a $(typeof(a)) \n"

// call a function name that does not exist

 b = fop()

<<"$b $(typeof(b)) \n"


 c = foo()

<<"$c $(typeof(c)) \n"

for (i = 0; i < 10 ; i++) {
 c = foo()

<<"[${i}] $c  \n"

}