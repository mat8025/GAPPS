setdebug(1,"trace")

float f_amt = 1.0;

aans = i_read("amt %3.2f$f_amt ?: ")


sz = Caz(aans);
<<"%V $sz\n"

ab = Cab(aans);
<<"%V $ab\n"


if (!(aans @="") ) {
<<"should be scalar!! %V $f_amt $aans\n"    
    f_amt = atof(aans);
    <<"should be scalar!! %V $f_amt\n"    
  }



exit()

aans = i_read("amt %3.2f$f_amt ?: ")


if (!(aans @="") ) {
<<"should be scalar!! %V $f_amt $aans\n"    
    f_amt = atof(aans);
    <<"should be scalar!! %V $f_amt\n"    
  }



while (1) {

aans = i_read("amt %3.2f$f_amt ?: ")


if (!(aans @="") ) {



<<"should be scalar!! %V $f_amt $aans\n"    
    f_amt = atof(aans);
    <<"should be scalar!! %V $f_amt\n"    
  }


if (f_amt < 0) {
  break;
}

}


// bugs
// svar aans comes back as array? > than sz 1
// atof delivers array is aans is only sz of 1
// declared scalar is promoted to array

// compiled version is OK
//