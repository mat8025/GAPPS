//
//  BUG:  foo(); not parsed??
//

chkIn()
cmplx twf;

// twf= {23,56};
<<"%V$twf\n"
//cmplx awf= {23,45}
//<<"%V$awf\n"
 <<"%V$twf\n"

twf->Set(47,79.0)
<<"%V$twf\n"

twf->Set(80,45.0);
<<" should be {80,45} \n"
<<"%V$twf\n"

tr = twf->getReal()
ti = twf->getImag()


chkR(80,tr)
chkR(45,ti)

chkOut()
////