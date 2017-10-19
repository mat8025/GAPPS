//
//  BUG:  foo(); not parsed??
//

checkIn()
cmplx twf;
// twf= {23,56};
<<"%V$twf\n"
//cmplx awf= {23,45}
//<<"%V$awf\n"
 <<"%V$twf\n"
twf->SetV(47,79.0)
<<"%V$twf\n"

twf->SetV(80,45.0);
<<" should be {80,45} \n"
<<"%V$twf\n"

tr = twf->getReal()
ti = twf->getImag()


checkFnum(80,tr)
checkFnum(45,ti)

checkOut()
////