

S=!!"wc /usr/local/GASP/gasp/SI/spe/*.cpp"

// TBF -- some extra lines (2) added why?

//<<"%(1,,,\n)$S\n"

nl = Caz(S)

//<<"$nl\n"

C= Split(S[0])

//<<"$C[0] $C[3]\n"

C= Split(S[1])

//<<"1 $C[0] $C[3]\n"

C= Split(S[nl-10])

//<<"$C[0] $C[3]\n"


int IWC[nl][2]
int tnl = 0;
for (k = 0; k < nl ; k++) {
 C= Split(S[k])
 if (!(C[3] @= "")) { 
//<<"$k $C[0] $C[3]\n"
  IWC[k][0] = k
  IWC[k][1] = atoi(C[0])
  tnl++
}
}

//<<"$tnl \n"

dnl = Caz(IWC)
//<<"sz $dnl\n"

dnb = Cab(IWC)
//<<"%V$dnb[0] $dnb[1]\n"

//<<"////////////\n"

// want to trim array

//Redimn(IWC,99,2)

//YWC = IWC[0:tnl-1][::]
//YWC = resize(IWC,tnl,2)



IWC->Resize(tnl,2)

dnl = Caz(IWC)
//<<"sz $dnl\n"

dnb = Cab(IWC)
//<<"%V$dnb[0] $dnb[1]\n"


//<<"%(2,, ,\n)$YWC\n"

WI= msortcol(IWC,1)


//<<"%(2,, ,\n)$WI\n"

 for (i=0; i < tnl ; i++) {
   k = WI[i][0]
   <<"$S[k]\n"
  }

//<<"Sorted to size!!\n"