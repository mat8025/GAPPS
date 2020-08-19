
A= ofr("txt2edit")


  while (1) {

    S=readline(A)

    if (checkEOF(A)) {
   // <<"reached EOF\n"
        break;
    }

// ts=spat(S,"::",1)
// ws=spat(spat(S,"::",1),",",-1)
//<<"static int $ws \(Svarg *s\);\n"

<<"static int $(spat(spat(S,'::',1),',',-1)) \(Svarg *s\);\n"

  }